node{
    
    def mavenHome="/opt/maven", mavenCMD, docker, tag, dockerHubUser, dockerHubPwd, containerName, httpPort = ""
    
    stage('Prepare Environment'){
        echo 'Initialize Environment'
        mavenCMD = "${mavenHome}/bin/mvn"
        tag= "latest"
	dockerHubUser = "silversword34"
	dockerHubPwd = "Docker.2023"    
	containerName = "nodejs-asi-insurance"
	httpPort = "80"
    }

    stage('Code Checkout'){
        try{
            checkout scm
        }
        catch(Exception e){
            echo 'Exception occured in Git Code Checkout Stage'
            currentBuild.result = "FAILURE"
            //emailext body: '''Dear All,
            //The Jenkins job ${JOB_NAME} has been failed. Request you to please have a look at it immediately by clicking on the below link. 
            //${BUILD_URL}''', subject: 'Job ${JOB_NAME} ${BUILD_NUMBER} is failed', to: 'jenkins@gmail.com'
        }
    }

}

