env.gitrepo = 'https://github.com/jtb75/flaskapp-hw.git'
env.repo = 'harbor.ng20.org/build/flaskapp-hw'
env.registry = 'https://harbor.ng20.org'
env.registryCredential = 'harbor-creds'
env.dockerImage = ''

node ('jenkins-agent'){
        stage('Clone') {
                echo 'Cloning Repo..'
                git gitrepo
                sh """
                sed -i 's/BUILDNUMBER/$BUILD_NUMBER/' Dockerfile
                """
        }
        stage ('Build') {
                container('build') {
                        echo 'Building Image..'
                        script {
                                dockerImage = docker.build repo + ":$BUILD_NUMBER"
                        }
                }
        }
        stage ('Scan') {
                container('build') {
                        echo 'Scan for Compliance and Vulnerabilities..'
                        prismaCloudScanImage ca: '', cert: '', dockerAddress: 'unix:///var/run/docker.sock',
                                image: repo +':$BUILD_NUMBER', key: '',
                                logLevel: 'info', podmanPath: '', project: '',
                                resultsFile: 'prisma-cloud-scan-results.json'
                }
        }
        stage ('Publish') {
                container('build') {
                        echo 'Publish Compliance and Vulnerabilities results..'
                        sh """
                        chmod 666 prisma-cloud-scan-results.json
                        """
                        prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
                }
        }
        stage ('Test') {
                echo 'Running Test Harness..'
                sh """
                sleep 2
                """
        }
        stage ('Push') {
                echo 'Push Image to Registry..'
                /*
                container('build') {
                        script {
                                docker.withRegistry( registry, registryCredential ) {
                                        dockerImage.push()
                                }
                        }
                }
                */
        }
        stage ('Cleanup') {
                container('build') {
                        echo 'Cleaning up Image..'
                        sh """
                        docker rmi $repo:$BUILD_NUMBER
                        """
                }
        }
}
