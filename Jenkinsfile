pipeline {
    agent any
    environment {
        access_token = credentials('github_token')
    }
    stages {
        stage('Preparing gradlew') {
            steps {
                sh 'chmod +x gradlew'
            }
        }
        stage('test') {
            steps {
                sh './gradlew test'
            }
        }
        stage('build') {
            steps {
                sh './gradlew build'
            }
        }
        stage('Release') {
            steps {
                sh '''
                    tag=$(git describe --tags)
                    message=$(git for-each-ref refs/tags/$tag --format=\'%(contents)\')
                    name=$(echo "$message" | head -n1)
                    description=$(echo "$message" | tail -n +3)
                    curl \
                        -X POST \
                        -H "Authorization:token $access_token" \
                        https://api.github.com/repos/Eagle-251/becode-caesar-cipher/releases \
                        -d '{"tag_name": "$tag", "target_commitish": "main", "name": "$name", "body": "$description", "draft": false, "prerelease": false}' 
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
