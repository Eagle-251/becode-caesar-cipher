pipeline {
    agent any

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
                withCredentials([string(credentialsId: 'bba8700c-29d5-452d-861c-6cedb2bbc2cd', variable: 'gh_token')]) {
                    sh 'tag=$(git describe --tags)'
                    sh 'message="$(git for-each-ref refs/tags/$tag --format=\'%(contents)\')"'
                    sh 'name=$(echo "$message" | head -n1)'
                    sh 'description=$(echo "$message" | tail -n +3)'
                    sh 'release=$(curl -XPOST -H "Authorization:token $gh_token" --data \'{"tag_name": "$tag", "target_commitish": "main", "name": "$name", "body": "$description", "draft": false, "prerelease": false}\' "https://api.github.com/repos/Eagle-251/becode-caesar-cipher/releases)"'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
