node {
    checkout scm
    stage('Clean') {
        // Clean files from last build.
        // sh 'git clean -dfxq --e ec2_instance'
    }
    stage('Setup') {
        // Prefer yarn over npm.
        sh 'yarn install || npm install'
        dir('client')
        {
            sh 'yarn install || npm install'
        }
    }
    stage('Test') {
        sh 'npm run test:nowatch'
    }
    stage('Docker Build') {
      echo DockerBuild
      sh './dockerbuild.sh'
    }
    stage('api-test') {
      echo 'api-test'
      sh 'export GIT_COMMIT=$(git rev-parse HEAD)'
      sh '/usr/local/bin/docker-compose -f /var/lib/jenkins/workspace/hgop/provisioning/docker-compose.yml up -d'
      sh 'run npm run-script apitest:nowatch'
      sh '/usr/local/bin/docker-compose down'
    }
    stage('load-test') {
      echo 'load-test'
      sh '/usr/local/bin/docker-compose -d up'
      sh 'run npm run-script loadtest:nowatch'
      sh '/usr/local/bin/docker-compose down'
    }
    stage('Deploy') {
        dir('./provisioning')
        {
            sh "./provision-new-environment.sh"
        }
    }
// færa dockerbuild fyrir framan load-test og api-test
// breyta portum f. application
//

}
