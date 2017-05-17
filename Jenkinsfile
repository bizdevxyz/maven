node {
        stage "Prepare environment"
          checkout scm
          docker.image('node').inside {
            stage "Checkout and build deps"
                sh "env"

            stage "Test and validate"
                sh "pwd"
          }
}
