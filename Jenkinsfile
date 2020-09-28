node ('jenkins-agent') {
        stage('Build') {
            container('build') {
                echo 'Building Image..'
                sh """
                apk add git
                git clone https://github.com/jtb75/flaskapp-hw.git
                cd flaskapp-hw
                docker build -t webapps/flaskapp-hw:latest .
                docker tag webapps/flaskapp-hw:latest webapps/flaskapp-hw:$BUILD_NUMBER
                """
            }
        }/*
        stage('Scan') {
            container('build') {
                echo 'Scanning Image..'
                prismaCloudScanImage ca: '', cert: '', dockerAddress: 'unix:///var/run/docker.sock', ignoreImageBuildTime: true, image: 'webapps/flaskapp-hw:$BUILD_NUMBER', key: '', logLevel: 'info', podmanPath: '', project: '', resultsFile: 'prisma-cloud-scan-results.json'
            }
        }
        stage ('Publish') {
            container('build') {
                echo 'Publishing Results..'
                sh """chmod 666 prisma-cloud-scan-results.json"""
                prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
            }
        }*/
        stage ('Cleanup') {
            container('build') {
                echo 'Cleaning up Image..'
                sh """
                docker rmi webapps/flaskapp-hw:$BUILD_NUMBER
                docker rmi webapps/flaskapp-hw:latest
                """
            }
        }
}
