node {
        def server = Artifactory.server "ArtifactoryDEV"
        def rtMaven = Artifactory.newMavenBuild()
        slackSend "Build Started - ${env.JOB_NAME}-${env.BUILD_NUMBER}"
        stage 'Clone sources'
            git credentialsId: 'gitadmin', url: 'http://192.168.0.84/bizdevxyz/maven.git'

        stage 'Set Environment'
            sh "chmod -R 755 $WORKSPACE/*"
            load "$WORKSPACE/env.groovy"
 
        stage 'Artifactory configuration'
            rtMaven.tool = "maven-3.3.9"
            // Set Artifactory repositories for dependencies resolution and artifacts deployment.
            rtMaven.deployer releaseRepo:'libs-release-local', snapshotRepo:'libs-snapshot-local', server: server
            rtMaven.resolver releaseRepo:'libs-release', snapshotRepo:'libs-snapshot', server: server

        stage 'Maven build'
            def buildInfo = rtMaven.run pom: 'pom.xml', goals: 'clean package'

        stage 'Publish build'
            server.publishBuildInfo buildInfo
        
        stage 'Docker build'
            sh "cp ./target/*.*ar ."
            sh "docker login -u ${env.DB__DOCKERUSER} -p ${env.DB__DOCKERPW} ${env.DB__DOCKERREPO}"
            sh "docker build -t $JOB_NAME $WORKSPACE"
            sh "docker tag $JOB_NAME ${env.DB__DOCKERREPO}/$JOB_NAME:$BUILD_NUMBER"
            sh "export DOCKER_CONTENT_TRUST=1 && docker --debug push ${env.DB__DOCKERREPO}/$JOB_NAME:$BUILD_NUMBER"
            sh "docker rmi ${env.DB__DOCKERREPO}/$JOB_NAME:$BUILD_NUMBER"
            sh "docker rmi $JOB_NAME"
        stage 'Deploy build'
                sh "/var/lib/jenkins/createservice.sh $JOB_NAME $BUILD_NUMBER ${env.DB__APPPORT} ${env.DB__APPURL} ${env.DB__DOCKERREPO} ${env.DB__DOCKERREPLICAS}"       
        stage 'Finalize'
            slackSend "Build Completed - ${env.JOB_NAME}-${env.BUILD_NUMBER}"
    }
