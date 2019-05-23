docker-minecraft-ftb-revelation
=============================

Minecraft FTB revelation server with dynmap and chunk pregeneration included.

To run the server:

  docker run -itd -v "$pwd/data:/opt/minecraft/world" -p "25565:25565" -p "8123:8123" talannvor/ftb-revelation-server

For Synology NAS do the following:
  Add a volume
  Use this volume when starting the container and mount it to /opt/minecraft/world
  Check the ports, usually "automatic" is a good idea
  Start the container
  Go to "Details" to check which ports are used:
    container 25565 is the Minecraft port
    container 8123 is DynMap
