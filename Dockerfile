FROM tomcat:9.0.104-jdk21-corretto
COPY target/java-web-app*.war /usr/local/tomcat/webapps/java-web-app.war
