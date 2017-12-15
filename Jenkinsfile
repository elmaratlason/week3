node {
  env.NODEJS_HOME = "${'recent node'}"
  checkout scm
  stage('Clean') {
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
  stage('API- and Load-Test') {
    echo "LOAD-TEST"
    sh 'npm run startpostgres'
    sh 'npm run startserver & npm run apitest:nowatch && npm run loadtest:nowatch && sleep 5 && kill %1'
  }
  stage('Deploy') {
    echo "DEPLOY"
    dir('./provisioning'){
        sh "./provision-new-environment.sh"
    }
  }
}
