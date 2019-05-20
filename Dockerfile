FROM java:8

ENV FTB_ULTIMATE_URL https://ftb.forgecdn.net/FTB2/modpacks/FTBUltimateReloaded/1_6_0/FTBUltimateReloadedServer.zip
ENV DYNMAP_URL https://minecraft.curseforge.com/projects/dynmapforge/files/2645936/download
ENV DYNMAP_JAR Dynmap-3.0-beta-3-forge-1.12.2.jar

RUN curl -SL $FTB_ULTIMATE_URL -o /tmp/ultimate.zip \
    && mkdir -p /opt/minecraft \
    && unzip /tmp/ultimate.zip -d /opt/minecraft \
    && curl -SL $DYNMAP_URL -o /opt/minecraft/mods/${DYNMAP_JAR} \
    && find /opt/minecraft -name "*.log" -exec rm -f {} \; \
    && rm -rf /opt/minecraft/ops.* /opt/minecraft/whitelist.* /opt/minecraft/logs/* /tmp/*

ADD eula.txt /opt/minecraft/eula.txt

ENV MINECRAFT_VERSION 1.12.2
ENV MINECRAFT_OPTS -server -Xms2048m -Xmx3072m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
ENV MINECRAFT_STARTUP_JAR FTBserver-1.12.2-14.23.5.2836-universal.jar

VOLUME /opt/minecraft/world

EXPOSE 25565
EXPOSE 8123

CMD bash /opt/minecraft/ServerStart.sh
