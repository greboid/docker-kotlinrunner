FROM openjdk:12-jdk-alpine
WORKDIR /app
ENV PATH="/opt/gradle/gradle-5.0/bin:/opt/kotlin/kotlinc/bin:${PATH}"
RUN apk add --no-cache zip unzip curl && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /opt/kotlin && \
    curl -s -L "https://github.com/JetBrains/kotlin/releases/download/v1.3.41/kotlin-compiler-1.3.41.zip" -o kotlin.zip && \
    unzip -d /opt/kotlin kotlin.zip && \
    rm kotlin.zip && \
    mkdir /opt/gradle && \
    curl -s -L "https://services.gradle.org/distributions/gradle-5.5.1-bin.zip" -o gradle.zip && \
    unzip -d /opt/gradle gradle.zip && \
    rm gradle.zip
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["java","-jar","build/libs/app.jar"]
