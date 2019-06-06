FROM java:8

ENV FTB_REVELATION_URL https://ftb.forgecdn.net/FTB2/modpacks/FTBRevelation/3_0_1/FTBRevelationServer.zip
ENV DYNMAP_URL https://minecraft.curseforge.com/projects/dynmapforge/files/2645936/download
ENV DYNMAP_JAR Dynmap-3.0-beta-3-forge-1.12.2.jar
ENV DYNMAP_BLOCKSCAN_JAR DynmapBlockScan-3.0-beta-1-forge-1.12.2.jar
ENV CHUNK_PREGEN_URL https://minecraft.curseforge.com/projects/chunkpregenerator/files/2676149/download
ENV CHUNK_PREGEN_JAR Chunk+Pregenerator+V1.12-2.1.jar

RUN curl -SL $FTB_REVELATION_URL -o /tmp/revelation.zip \
    && mkdir -p /opt/minecraft \
    && unzip /tmp/revelation.zip -d /opt/minecraft \
    && curl -SL $DYNMAP_URL -o /opt/minecraft/mods/${DYNMAP_JAR} \
    && curl -SL https://dynmap.us/releases/${DYNMAP_BLOCKSCAN_JAR} -o /opt/minecraft/mods/${DYNMAP_BLOCKSCAN_JAR} \
    && curl -SL $CHUNK_PREGEN_URL -o /opt/minecraft/mods/${CHUNK_PREGEN_JAR} \
    && find /opt/minecraft -name "*.log" -exec rm -f {} \; \
    && rm -rf /opt/minecraft/ops.* /opt/minecraft/whitelist.* /opt/minecraft/logs/* /tmp/*

ADD eula.txt /opt/minecraft/eula.txt
COPY server.properties /opt/minecraft/server.properties

ENV MINECRAFT_VERSION 1.12.2

VOLUME /opt/minecraft/world
VOLUME /opt/minecraft/backups
VOLUME /opt/minecraft/dynmap

EXPOSE 25565
EXPOSE 8123

CMD bash /opt/minecraft/ServerStart.sh
