node{
    
    def mavenHome, mavenCMD, docker, tag, WORKSPACE, dockerHubUser, dockerHubPwd, containerName, httpPort = ""
    
    stage('Prepare Environment'){
        echo 'Initialize Environment'
	mavenHome="/opt/maven"
        mavenCMD = "${mavenHome}/bin/mvn"
        tag= "latest"
	WORKSPACE= "/home/ubuntu/NodeJS"
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
        }
    }

    dir("${env.WORKSPACE}/aQA"){
        sh "pwd"
    }

    stage('Docker Image Build'){
        echo 'Creating Docker image'
        sh "docker build -t ${dockerHubUser}/${containerName}:${tag} --pull --no-cache ."
    }

    stage('Docker Image Scan'){
        echo 'Scanning Docker image for vulnerbilities'
        sh "docker build -t ${dockerHubUser}/${containerName}:${tag} ."
    } 

    stage('Publishing Image to DockerHub'){
        echo 'Pushing the docker image to DockerHub'
	sh "docker login -u ${dockerHubUser} -p ${dockerHubPwd}"
	sh "docker push ${dockerHubUser}/${containerName}:${tag}"
	echo "Image push complete"
    }   

    stage('Docker Container Deployment'){
        echo 'Docker Container Deployment is starting ...'
	sh "docker rm $containerName -f"
	sh "docker pull $dockerHubUser/$containerName:$tag"
	sh "docker run --name $containerName -p $httpPort:1982 -d $dockerHubUser/$containerName:$tag"
	echo "Application started on port: ${httpPort} (http)"
	}

}

