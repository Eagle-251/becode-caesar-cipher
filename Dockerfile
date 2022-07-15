FROM gradle:7.3.3-jdk11-alpine
WORKDIR /app
ADD --chown=gradle:gradle . /app

RUN gradle build --stacktrace
 
