mapipeline {
    agent { label 'dind-ssh-agent' }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh """
                mkdir myproj
                cd myproj
                echo 'FROM python:3.5.1' > Dockerfile
                echo 'LABEL project="DevImages"' >> Dockerfile
                docker build -t python:latest .
                """
            }
        }
    }
}
