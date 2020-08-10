pipeline {
    agent { label 'dind-ssh-agent' }
    stages {
        stage('Build') {
            steps {
                echo 'Building Image..'
                sh """
                docker build -t webapps/flaskapp-hw:latest .
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
                image: 'webapps/flaskapp-hw:latest',
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
        stage ('Push Embedded Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'harbor_cred', passwordVariable: 'HARBOR_PW', usernameVariable: 'HARBOR_USER')]) {
                    echo 'Pushing..'
                    sh """
                    docker login --username ${HARBOR_USER} --password ${HARBOR_PW} 192.168.1.211:80
                    """
                }
            }
        }
        stage ('Cleanup') {
            steps {
                echo 'Cleaning up Image..'
                sh """
                docker rmi webapps/flaskapp-hw:latest
                """
            }
        }
    }
}
