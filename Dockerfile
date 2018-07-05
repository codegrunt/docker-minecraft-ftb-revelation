FROM java:8

ENV FTB_INFINITY_URL https://media.forgecdn.net/files/2484/486/FTBInfinityServer_3.0.2.zip
ENV DYNMAP_URL https://minecraft.curseforge.com/projects/dynmapforge/files/2307078/download
ENV DYNMAP_JAR Dynmap-2.3-forge-1.7.10.jar

RUN curl -SL $FTB_INFINITY_URL -o /tmp/infinity.zip \
    && mkdir -p /opt/minecraft \
    && unzip /tmp/infinity.zip -d /opt/minecraft \
    && curl -SL $DYNMAP_URL -o /opt/minecraft/mods/${DYNMAP_JAR} \
    && find /opt/minecraft -name "*.log" -exec rm -f {} \; \
    && rm -rf /opt/minecraft/ops.* /opt/minecraft/whitelist.* /opt/minecraft/logs/* /tmp/*

ADD eula.txt /opt/minecraft/eula.txt

ENV MINECRAFT_VERSION 1.7.10
ENV MINECRAFT_OPTS -server -Xms2048m -Xmx3072m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
ENV MINECRAFT_STARTUP_JAR FTBServer-1.7.10-1614.jar

VOLUME /opt/minecraft/world

EXPOSE 25565
EXPOSE 8123

CMD bash /opt/minecraft/ServerStart.sh
