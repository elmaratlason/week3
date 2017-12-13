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
    stage('api-test') {
      echo 'api-test'
      // docker-compose -d up
      // run npm run-script apitest:nowatch
      // docker-compose down
    }
    stage('load-test') {
      echo 'load-test'
      // docker-compose -d up
      // run npm run-script loadtest:nowatch
      // docker-compose down
    }
    stage('Deploy') {
        sh './dockerbuild.sh'
        dir('./provisioning')
        {
            sh "./provision-new-environment.sh"
        }
    }
// færa dockerbuild fyrir framan load-test og api-test
// breyta portum f. application
// 

}
