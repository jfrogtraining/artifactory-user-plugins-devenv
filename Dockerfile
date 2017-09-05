From java:8
WORKDIR /data
ARG artbranch
RUN git clone https://github.com/jfrogtraining/artifactory-user-plugins-devenv.git --branch=$artbranch && \
    git clone https://github.com/JFrogDev/artifactory-user-plugins.git --branch='testindocker'
ARG artifactoryVersion
ARG Build_NUMBER
ARG pluginName
WORKDIR /data/artifactory-user-plugins-devenv
ADD local-store/artifactory.lic local-store/
RUN ./gradlew prepareArtPro -PartifactoryVersion=$artifactoryVersion -PBuild_NUMBER=$Build_NUMBER 

CMD ["/bin/bash", "-c", "sleep(30) && ./gradlew workOnPlugin -DpluginName=$pluginName && sleep(30) && ./gradlew startArtPro && ./gradlew test"]
