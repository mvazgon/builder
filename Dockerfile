FROM jenkins/jenkins:lts-jdk17
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG="${JENKINS_HOME}/casc_configs"

USER jenkins

COPY configfile/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/bin/jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
RUN mkdir $JENKINS_HOME/casc_configs
RUN /usr/bin/chown jenkins: $JENKINS_HOME/casc_configs -R

USER jenkins