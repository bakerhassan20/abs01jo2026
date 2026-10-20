pipeline{
    agent any
    environment{
        project_name="ABS01JO2026"
        project_user="ABS01"
        php_ver="8.3"
        initial_db_path="database/abs01jo2026.sql"
    }
 stages{
        stage('Deploy to Dev'){
            steps{
                sh '''
                        ssh deploy@${dev_web1} "/home/deploy/scripts/yii2_jenkins_before.sh '${project_name}' '${project_user}' '${php_ver}'"
                        rsync -Wrltv --no-owner --no-group --checksum --delete --exclude-from=${WORKSPACE}/deploy.exclude ${WORKSPACE}/ deploy@${dev_web1}:/mnt/HC_Volume_29843529/${project_name}/
                        ssh deploy@${dev_web1} "/home/deploy/scripts/laravel_jenkins_after83.sh '${project_name}' '${project_user}'"
                '''
            }
        }
    }
}