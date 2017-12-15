node {
    env.NODEJS_HOME = "${'recent node'}"
    checkout scm
    stage('Clean') {
        // Clean files from last build.
        // sh 'git clean -dfxq --e ec2_instance'
        // stop all docker containers
        sh 'docker kill $(docker ps -q) || echo "no running containers"'
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
        echo "UNIT TESTS"
        sh 'npm run test:nowatch'
        junit '**/REPORTS/*.xml'

    }
    stage('Docker Build') {
      echo "DOCKER BUILD"
      // build docker image
      sh './dockerbuild.sh'
    }
    stage('api-test') {
        echo "API-TEST"
      // run apitest with docker-compose on jenkins server
      //dir('./provisioning'){
      //    sh 'export GIT_COMMIT=$(git rev-parse HEAD) && /usr/local/bin/docker-compose up -d'
      //}
      sh 'npm run startpostgres'
      sh 'npm run startserver & npm run apitest:nowatch && sleep 5 && kill %1'
      // dir('./provisioning'){
      //    sh '/usr/local/bin/docker-compose down'
      //
      //}
      // sh 'docker kill $(docker ps -q) || true'
    }
    stage('load-test') {
      echo "LOAD-TEST"
      //dir('./provisioning'){
      //  sh 'export GIT_COMMIT=$(git rev-parse HEAD) && /usr/local/bin/docker-compose up -d'
      //}
      //sh './runserver.sh && run npm run-script loadtest:nowatch'
  //    sh 'npm run startpostgres'
      sh 'npm run startserver & npm run loadtest:nowatch && sleep 5 && kill %1'
    //  dir('./provisioning'){
    //      sh '/usr/local/bin/docker-compose down'
    //  }
    }
    stage('Deploy') {
        echo "DEPLOY"
        dir('./provisioning')
        {
            sh "./provision-new-environment.sh"
        }
    }
}
