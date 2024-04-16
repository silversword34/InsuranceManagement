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
    
    stage('Docker Image Build'){
        echo 'Creating Docker image'
        sh "docker build -t $dockerHubUser/$containerName:$tag --pull --no-cache ."
    }
	
    stage('Docker Image Scan'){
        echo 'Scanning Docker image for vulnerbilities'
        sh "docker build -t ${dockerHubUser}/${containerName}:${tag} ."
    }   
	
    stage('Publishing Image to DockerHub'){
        echo 'Pushing the docker image to DockerHub'
        {
			sh "docker login -u $dockerHubUser -p $dockerHubPwd"
			sh "docker push $dockerHubUser/$containerName:$tag"
			echo "Image push complete"
        } 
    }    
	
	stage('Docker Container Deployment'){
		sh "docker rm $containerName -f"
		sh "docker pull $dockerHubUser/$containerName:$tag"
		sh "docker run -d --rm -p $httpPort:1982 --name $containerName $dockerHubUser/$containerName:$tag"
		echo "Application started on port: ${httpPort} (http)"
	}
}



