pipeline {
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
        stage('Scan') {
            steps {
                prismaCloudScanImage ca: '',
                cert: '',
                dockerAddress: 'unix:///var/run/docker.sock',
                ignoreImageBuildTime: true,
                image: 'python:latest',
                key: '',
                logLevel: 'info',
                podmanPath: '',
                project: '',
                resultsFile: 'prisma-cloud-scan-results.json'
            }
        }
        stage ('Publish') {
            steps {
                prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
            }
        }
    }
}
