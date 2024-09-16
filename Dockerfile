FROM mcr.microsoft.com/dotnet/sdk:9.0
COPY ./tmodloader /srv/tmodloader
WORKDIR /srv/tmodloader/
RUN chmod u+x start-tModLoaderServer.sh start-tModLoader.sh
# 加载dotnet缓存
RUN bash ./LaunchUtils/ScriptCaller.sh || true
RUN mkdir -p /root/.local/share/Terraria/tModLoader/Mods
EXPOSE 7777
ENTRYPOINT ["./start-tModLoaderServer.sh", "-modpath", "/root/.local/share/Terraria/tModLoader/Mods"]
