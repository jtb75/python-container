env.gitrepo = 'https://github.com/jtb75/flaskapp-hw.git'
env.repo = 'harbor.ng20.org/build/flaskapp-hw'
env.registry = 'https://harbor.ng20.org'
env.registryCredential = 'harbor-creds'
env.dockerImage = ''


node ('jenkins-agent'){
                echo 'Cloning Repo..'
                git gitrepo
                sh """
                sed -i 's/BUILDNUMBER/$BUILD_NUMBER/' Dockerfile
                """
        }
        stage ('Build') {
                echo 'Building Image..'
                sh """
                cd flaskapp-hw
                docker build -t flaskapp-hw:$BUILD_NUMBER .
                cd ..
                rm -fr flaskapp-hw
                """
        }
        stage ('Scan') {
                echo 'Scan for Compliance and Vulnerabilities..'
                prismaCloudScanImage ca: '', cert: '',
                        dockerAddress: 'unix:///var/run/docker.sock',
                        ignoreImageBuildTime: true,
                        image: 'flaskapp-hw:$BUILD_NUMBER',
                        key: '',
                        logLevel: 'info',
                        podmanPath: '',
                        project: '',
                        resultsFile: 'prisma-cloud-scan-results.json'
                prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
                sh """
                rm prisma-cloud-scan-results.json
                """
        }
        stage ('Test') {
                echo 'Running Test Harness..'
                sh """
                sleep 2
                """
        }
        stage ('Push') {
                echo 'Push Image to Registry..'
                sh """
                sleep 2
                """
        }
        stage ('Cleanup') {
                echo 'Cleaning up Image..'
                sh """
                docker rmi flaskapp-hw:$BUILD_NUMBER
                """
        }
}
