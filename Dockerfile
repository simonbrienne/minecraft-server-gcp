FROM itzg/minecraft-server:latest

# Set variables
ENV EULA=TRUE
ENV MODE=creative
ENV MOTD="Nomis IT Serveur"
ENV ALLOW_NETHER=true
ENV MAX_PLAYERS=50
ENV INIT_MEMORY=1G
ENV MAX_MEMORY=4G

EXPOSE 25565