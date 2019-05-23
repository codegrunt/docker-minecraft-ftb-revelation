FROM java:8

ENV FTB_REVELATION_URL https://www.feed-the-beast.com/projects/ftb-revelation/files/2712063
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

ENV MINECRAFT_VERSION 1.12.2
ENV MINECRAFT_OPTS -server -Xms2048m -Xmx4096m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
ENV MINECRAFT_STARTUP_JAR FTBserver-1.12.2-14.23.5.2836-universal.jar

VOLUME /opt/minecraft/world

EXPOSE 25565
EXPOSE 8123

CMD bash /opt/minecraft/ServerStart.sh
