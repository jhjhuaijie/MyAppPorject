pipeline {
    agent any

    environment {
        IMAGE_NAME = "mycppapp"
        IMAGE_TAG = "v${BUILD_NUMBER}"
        DOCKER_REGISTRY = "your-registry.com/your-repo"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "拉取代码"
                git 'https://github.com/jhjhuaijie/MyAppPorject.git'
            }
        }

        stage('Static Check') {
            steps {
                echo "静态分析"
                sh 'cppcheck --enable=all src'
            }
        }

        stage('Build & Test') {
            steps {
                echo "构建 + 测试"
                sh '''
                mkdir -p build && cd build
                cmake ..
                make -j$(nproc)
                ctest --output-on-failure
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "构建 Docker 镜像"
                sh '''
                docker build -t $IMAGE_NAME:$IMAGE_TAG .
                docker tag $IMAGE_NAME:$IMAGE_TAG $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "推送镜像"
                withCredentials([usernamePassword(credentialsId: 'docker-cred-id', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin $DOCKER_REGISTRY
                    docker push $DOCKER_REGISTRY/$IMAGE_NAME:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "部署（示意）"
            }
        }
    }
}