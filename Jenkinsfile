node{
    
    def mavenHome, mavenCMD, docker, tag, dockerHubUser, containerName, httpPort = ""
    
    stage('Prepare Environment'){
        echo 'Initialize Environment'
        mavenHome = "/opt/maven" name: 'maven' , type: 'maven'
        mavenCMD = "${mavenHome}/bin/mvn"
        tag="latest"
	dockerHubUser="silversword34"
	containerName="nodejs-asi-insurance"
	httpPort="80"
    }
    
    stage('Maven Build'){
        sh "${mavenCMD} clean package"        
    }
    
    stage('Docker Image Build'){
        echo 'Creating Docker image'
        sh "docker build -t $dockerHubUser/$containerName:$tag --pull --no-cache ."
    }
	
    stage('Docker Image Scan'){
        echo 'Scanning Docker image for vulnerbilities'
        sh "docker build -t ${dockerHubUser}/insure-me:${tag} ."
    }   
	
    stage('Publishing Image to DockerHub'){
        echo 'Pushing the docker image to DockerHub'
        withCredentials([usernamePassword(credentialsId: 'dockerHubAccount', usernameVariable: 'dockerUser', passwordVariable: 'dockerPassword')]) {
			sh "docker login -u $dockerUser -p $dockerPassword"
			sh "docker push $dockerUser/$containerName:$tag"
			echo "Image push complete"
        } 
    }    
	
	stage('Docker Container Deployment'){
		sh "docker rm $containerName -f"
		sh "docker pull $dockerHubUser/$containerName:$tag"
		sh "docker run -d --rm -p $httpPort:$httpPort --name $containerName $dockerHubUser/$containerName:$tag"
		echo "Application started on port: ${httpPort} (http)"
	}
}



