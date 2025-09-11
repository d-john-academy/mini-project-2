pipeline {
    agent { label 'kubernetes' }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                script {
                    dir('v2') {
                        docker.withRegistry('https://registry-1.docker.io', 'docker-cred') {
                            def customImage = docker.build("djohnacademy/mini-project:${GIT_COMMIT}")
                            customImage.push()
                        }
                    }
                    dir('k8s') {
                        withKubeConfig(
                            caCertificate: "${KUBE_CERT}", 
                            clusterName: 'kubernetes', 
                            contextName: 'kubernetes-admin@kubernetes', 
                            credentialsId: 'my-kube-config-credentials', 
                            namespace: 'ingress-nginx', 
                            restrictKubeConfigAccess: false, 
                            serverUrl: 'https://jump-host:6443'
                        ) {
                            sh 'sed -i "s;djohnacademy/mini-project;djohnacademy/mini-project:${GIT_COMMIT};g" deployment-canary.yaml'
                            sh 'kubectl apply -f deployment-canary.yaml'
                        }
                    }
                }
            }
        }
        stage('Deploy-25') {
            steps {
                script {
                    def userInput = input(
                                        id: 'proceed-approval', 
                                        message: 'Proceed to 25% canary deployment?',
                                        parameters: [string(name: 'reason', defaultValue: '', description: 'Enter "Deploy" to execute 25% canary deployment')]
                                    )
                    if (userInput == 'Deploy') {
                        echo 'Executing canary deployment of 25% traffic...'
                        withKubeConfig(
                            caCertificate: "${KUBE_CERT}", 
                            clusterName: 'kubernetes', 
                            contextName: 'kubernetes-admin@kubernetes', 
                            credentialsId: 'my-kube-config-credentials', 
                            namespace: 'ingress-nginx', 
                            restrictKubeConfigAccess: false, 
                            serverUrl: 'https://jump-host:6443'
                        ) {
                            dir('k8s') {
                                sh 'sed -i \'s;nginx.ingress.kubernetes.io/canary-weight: "0";nginx.ingress.kubernetes.io/canary-weight: "25";g\' service.yaml'
                                sh 'kubectl apply -f service.yaml'
                            }
                        }
                    } 
                    else {
                        echo 'Canary deployment of 25% traffic rejected...'
                    }
                }
            }
        }
        stage('Deploy-50') {
            steps {
                script {
                    def userInput = input(
                                        id: 'proceed-approval', 
                                        message: 'Proceed to 50% canary deployment?',
                                        parameters: [string(name: 'reason', defaultValue: '', description: 'Enter "Deploy" to execute 50% canary deployment')]
                                    )
                    if (userInput == 'Deploy') {
                        echo 'Executing canary deployment of 50% traffic...'
                        withKubeConfig(
                            caCertificate: "${KUBE_CERT}", 
                            clusterName: 'kubernetes', 
                            contextName: 'kubernetes-admin@kubernetes', 
                            credentialsId: 'my-kube-config-credentials', 
                            namespace: 'ingress-nginx', 
                            restrictKubeConfigAccess: false, 
                            serverUrl: 'https://jump-host:6443'
                        ) {
                            dir('k8s') {
                                sh 'sed -i \'s;nginx.ingress.kubernetes.io/canary-weight: "25";nginx.ingress.kubernetes.io/canary-weight: "50";g\' service.yaml'
                                sh 'kubectl apply -f service.yaml'
                            }
                        }
                    } 
                    else {
                        echo 'Canary deployment of 50% traffic rejected...'
                    }
                }
            }
        }
        stage('Deploy-75') {
            steps {
                script {
                    def userInput = input(
                                        id: 'proceed-approval', 
                                        message: 'Proceed to 75% canary deployment?',
                                        parameters: [string(name: 'reason', defaultValue: '', description: 'Enter "Deploy" to execute 75% canary deployment')]
                                    )
                    if (userInput == 'Deploy') {
                        echo 'Executing canary deployment of 75% traffic...'
                        withKubeConfig(
                            caCertificate: "${KUBE_CERT}", 
                            clusterName: 'kubernetes', 
                            contextName: 'kubernetes-admin@kubernetes', 
                            credentialsId: 'my-kube-config-credentials', 
                            namespace: 'ingress-nginx', 
                            restrictKubeConfigAccess: false, 
                            serverUrl: 'https://jump-host:6443'
                        ) {
                            dir('k8s') {
                                sh 'sed -i \'s;nginx.ingress.kubernetes.io/canary-weight: "50";nginx.ingress.kubernetes.io/canary-weight: "75";g\' service.yaml'
                                sh 'kubectl apply -f service.yaml'
                            }
                        }
                    } 
                    else {
                        echo 'Canary deployment of 75% traffic rejected...'
                    }
                }
            }
        }
        stage('Deploy-100') {
            steps {
                script {
                    def userInput = input(
                                        id: 'proceed-approval', 
                                        message: 'Proceed to 100% canary deployment?',
                                        parameters: [string(name: 'reason', defaultValue: '', description: 'Enter "Deploy" to execute 100% canary deployment')]
                                    )
                    if (userInput == 'Deploy') {
                        echo 'Executing canary deployment of 100% traffic...'
                        withKubeConfig(
                            caCertificate: "${KUBE_CERT}", 
                            clusterName: 'kubernetes', 
                            contextName: 'kubernetes-admin@kubernetes', 
                            credentialsId: 'my-kube-config-credentials', 
                            namespace: 'ingress-nginx', 
                            restrictKubeConfigAccess: false, 
                            serverUrl: 'https://jump-host:6443'
                        ) {
                            dir('k8s') {
                                sh 'sed -i \'s;nginx.ingress.kubernetes.io/canary-weight: "75";nginx.ingress.kubernetes.io/canary-weight: "100";g\' service.yaml'
                                sh 'kubectl apply -f service.yaml'
                            }
                        }
                    } 
                    else {
                        echo 'Canary deployment of 100% traffic rejected...'
                    }
                }
            }
        }
        stage('Promote') {
            steps {
                script {
                    def userInput = input(
                                        id: 'proceed-approval', 
                                        message: 'Promote to new version?',
                                        parameters: [string(name: 'reason', defaultValue: '', description: 'Enter "Promote" to Promote')]
                                    )
                    if (userInput == 'Promote') {
                        echo 'Promoting...'
                        withKubeConfig(
                            caCertificate: "${KUBE_CERT}", 
                            clusterName: 'kubernetes', 
                            contextName: 'kubernetes-admin@kubernetes', 
                            credentialsId: 'my-kube-config-credentials', 
                            namespace: 'ingress-nginx', 
                            restrictKubeConfigAccess: false, 
                            serverUrl: 'https://jump-host:6443'
                        ) {
                            dir('k8s') {
                                sh 'sed -E "s;djohnacademy/mini-project.*;djohnacademy/mini-project:${GIT_COMMIT};g" deployment-stable.yaml'
                                sh 'kubectl delete -f deployment-canary.yaml'
                            }
                        }
                    }
                    else {
                        echo 'Promoting rejected...'
                    }
                }
            }
        }
    }
}
