node {
        stage('Clone') {
                echo 'Cloning Repo..'
                sh """
                git clone https://github.com/jtb75/flaskapp-hw.git
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
        stage ('Cleanup') {
                echo 'Cleaning up Image..'
                sh """
                docker rmi flaskapp-hw:$BUILD_NUMBER
                """
        }
}
