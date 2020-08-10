pipeline {
    agent { label 'dind-ssh-agent' }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh """
                docker build -t python:latest .
                """
            }
        }
        stage('Scan') {
            steps {
                prismaCloudScanImage ca: '',
                cert: '',
                dockerAddress: 'tcp://192.168.1.215:2376',
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
