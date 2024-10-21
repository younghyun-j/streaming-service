FROM gradle:7.4.0-jdk17 AS build

# 작업 디렉토리 설정
WORKDIR /build

# 스프링 프로젝트 복사
COPY . /build
RUN gradle clean build

FROM eclipse-temurin:21-jdk-alpine

ARG JAR_FILE=/build/libs/*-SNAPSHOT.jar
COPY ${JAR_FILE} steaming-service.jar

# Spring profile을 설정하여 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "-Duser.timezone=Asia/Seoul", "/steaming-service.jar"]