FROM jenkins/jenkins:lts

USER root

RUN apt update && apt install docker.io mc -y

#RUN jenkins-plugin-cli --plugins docker git gitlab-plugin pipeline-stage-step pipeline-build-step

RUN usermod -aG docker jenkins

USER jenkins
