pipeline {
    agent { label 'dind-ssh-agent' }
    stages {
        stage('Build') {
            steps {
                echo 'Building Image..'
                sh """
                docker build -t flaskapp-hw:latest .
                """
            }
        }
        stage('Scan') {
            steps {
                echo 'Scanning Image..'
                prismaCloudScanImage ca: '',
                cert: '',
                dockerAddress: 'tcp://192.168.1.215:2376',
                ignoreImageBuildTime: true,
                image: 'flaskapp-hw:latest',
                key: '',
                logLevel: 'info',
                podmanPath: '',
                project: '',
                resultsFile: 'prisma-cloud-scan-results.json'
            }
        }
        stage ('Publish') {
            steps {
                echo 'Publishing Results..'
                prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
            }
        }
    }
}
