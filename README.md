

- tMod的github：https://github.com/tModLoader/tModLoader/releases
- 此项目的dockerhub：https://hub.docker.com/r/pineclone/tmodloader

镜像基于`mcr.microsoft.com/dotnet/sdk:9.0`构建，拉取镜像：镜像的标签与tMod的发布版本号相同

```bash
docker pull pineclone/tmodloader:tagname
```

运行镜像来直接启动一个tMod服务器

```bash
docker run --name tmodloader -it -p 7777:7777 pineclone/tmodloader:latest
```

如果你希望持久存储数据，那么挂载`/root/.local/share/Terraria/tModLoader`目录即可：

```bash
docker run --name tmodloader -it -p 7777:7777 \
  -v ./data:/root/.local/share/Terraria/tModLoader \
  pineclone/tmodloader:latest
```

挂载的`tModLoader`目录结构如下：

```
tModLoader
├── Mods
│   └── enabled.json
├── Worlds
└── favorites.json
```

- Mods：模组目录，如果需要添加mod请将mod文件加入这个目录下
- Worlds：世界目录，服务器创建的世界将会保存到此处

```bash
docker container stop tmodloader  # 停止服务器
docker container start tmodloader  # 重启服务器
```

长期部署推荐使用compose：

```yaml
version: "3.8"
services:
  tmodloader:
    image: pineclone/tmodloader:latest
    container_name: tmodloader
    stdin_open: true
    tty: true
    entrypoint: /bin/bash
    ports:
      - 7777:7777
    volumes:
      - ./data:/root/.local/share/Terraria/tModLoader
```

```bash
docker compose up -d  # 启动容器
docker compose exec tmodloader ./start-tModLoaderServer.sh  # 启动服务
```

如何添加mod：进入游戏后点击

```
创意工坊 -> 模组整合包 -> 将已启用的模组生成为新的整合包
-> 导出完整的整合包
```

将整合包目录下Mods目录内的所有文件拷贝到`./data/Mods`目录下，重载后就能看到模组列表了