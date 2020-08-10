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
        stage ('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'harbor_cred', passwordVariable: 'HARBOR_PW', usernameVariable: 'HARBOR_USER')]) {
                    echo 'Pushing Image to Registry..'
                    sh """
                    docker tag webapps/flaskapp-hw:latest 192.168.1.211:80/webapps/flaskapp-hw:$BUILD_NUMBER
                    docker tag webapps/flaskapp-hw:latest 192.168.1.211:80/webapps/flaskapp-hw:latest
                    docker login --username ${HARBOR_USER} --password ${HARBOR_PW} 192.168.1.211:80
                    docker push 192.168.1.211:80/webapps/flaskapp-hw:$BUILD_NUMBER
                    docker push 192.168.1.211:80/webapps/flaskapp-hw:latest
                    """
                }
            }
        }
        stage ('Cleanup') {
            steps {
                echo 'Cleaning up Image..'
                sh """
                docker rmi 192.168.1.211:80/webapps/flaskapp-hw:$BUILD_NUMBER
                docker rmi 192.168.1.211:80/webapps/flaskapp-hw:latest
                docker rmi webapps/flaskapp-hw:latest
                """
            }
        }
    }
}
