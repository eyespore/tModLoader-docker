

- tMod的github：https://github.com/tModLoader/tModLoader/releases
- 此项目的dockerhub：https://hub.docker.com/r/pineclone/tmodloader

# eyespore/tModLoader-docer

> 通过docker部署tmodloader服务

此项目构建的docker镜像已经上传到dockerhub，如果希望通过dockerhub拉取镜像直接部署请移步[pineclone/tmodloader](https://hub.docker.com/r/pineclone/tmodloader)

您也可以直接使用此项目部署tmodloader服务，使用步骤：

```bash
git clone git@github.com:eyespore/tModLoader-docker.git  # 克隆项目到本地
cd tModLoader-docker/  # 进入项目目录

docker compose up -d  # 启动服务
docker compose exec tmodloader ./start-tModLoaderServer.sh  # 启动服务
```

compose配置如下：

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
      - ./data:/root/.local/share/Terraria/tModLoader  # 此目录存储世界、模组数据
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

如何添加模组：进入游戏后点击
【创意工坊】->【模组整合包】->【将启用模组生成为新的整合包】->【导出完整整合包】

![image](https://github.com/user-attachments/assets/fb5e56f8-c846-4ed2-bcf8-fb39a8d8ad7c)

![image](https://github.com/user-attachments/assets/afa0b82b-6fd8-491a-99fd-3320748eb1fe)

![image](https://github.com/user-attachments/assets/4884d81d-c511-4339-a07b-8f001d8c642a)

将压缩好的Mods目录发送到运行docker的机器上：

```bash
scp .\Mods.zip pineclone@localhost:/home/pineclone/tModLoader-docker/data/
```

```bash
cd ~/tModLoader-docker/data/
sudo rm -r Mods  # 直接将原先的Mods目录删除
unzip Mods.zip  # 解压压缩包
```
