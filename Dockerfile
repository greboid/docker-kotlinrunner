FROM openjdk:11-jdk
WORKDIR /app
ENV PATH="/opt/gradle/gradle-5.0/bin:/opt/kotlin/kotlinc/bin:${PATH}"
RUN apt-get -q -y update && \
    apt-get -q -y install ca-certificates curl zip unzip --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /opt/kotlin && \
    curl -s -L "https://github.com/JetBrains/kotlin/releases/download/v1.3.10/kotlin-compiler-1.3.10.zip" -o kotlin.zip && \
    unzip -d /opt/kotlin kotlin.zip && \
    rm kotlin.zip && \
    mkdir /opt/gradle && \
    curl -s -L "https://services.gradle.org/distributions/gradle-5.0-bin.zip" -o gradle.zip && \
    unzip -d /opt/gradle gradle.zip && \
    rm gradle.zip
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["java","-jar","build/libs/app.jar"]
