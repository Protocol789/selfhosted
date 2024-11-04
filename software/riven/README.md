# Summary

![alt text](logo.png)

> Riven is a powerful media management and streaming solution designed to integrate with various media servers and third-party services. It automates the process of finding, downloading, and organizing media content, making it instantly available for streaming through your preferred media server.

<!-- Located at https://homepage.zorab.im/ -->

## Configuration 

| Host           | Install | Config         |
| -------------- | ------- | -------------- |
| frontend.server | docker  | docker compose |

[Docker compose](../../docker_compose/riven/compose.yml)

<!-- Config location: /home/daniel/docker/homepage/services.yaml -->

* [ ] docker
* [ ] docker env variables
* [ ] docker volumes
    * [ ] folder bind mounts
    * [ ] native docker volume
    * [ ] side car software
* [ ] Open API


## Steps

### Zurg

[How to run zurg in 5 steps for Plex with Docker][def2]

1. Clone repo
`git clone https://github.com/debridmediamanager/zurg-testing.git`

2. Set apitoken in config.yml
[Real debrid token url](https://real-debrid.com/apitoken)

3. Create mnt folder
`sudo mkdir -p /mnt/zurg`

4. `docker compose up -d` Run docker compose

5. `time ls -1R /mnt/zurg` You're done! If you do edits on your config.yml just do docker compose restart zurg

6. Zurg configuration for Riven from [here][def3]

> When configuring Zurg, ensure that the following settings are included in your config.yaml to maintain proper folder and torrent naming conventions:

> - retain_folder_name_extension (boolean): This setting should be set to true to retain the folder name extension.
>   - Example: retain_folder_name_extension: true

> - retain_rd_torrent_name (boolean): This setting should be set to true to retain the Real-Debrid torrent name.
>   - Example: retain_rd_torrent_name: true

<details>
<summary>output from time</summary>

```
/mnt/zurg:
__all__
anime
movies
shows
__unplayable__
version.txt

/mnt/zurg/__all__:
'Alien Romulus (2024) [2160p] [4K] [WEB] [5.1] [YTS.MX]'
'Alien Romulus 2024 2160p HDR10Plus DV WEBRip 6CH X265 HEVC-PSA'
Alien.romulus.2024.2160p.x265.hdr.5.1-dual-lat-cinecalidad.re
'Alien Romulus (2024) WebDl Rip 2160p H265 10 bit DV HDR10+ ita eng AC3 5.1 sub eng Licdom'
'The Wild Robot (2024) (1080p AMZN WEB-DL x265 10bit EAC3 Atmos 5.1 Ghost)'
'The Wild Robot 2024 2160p HDR10Plus DV WEBRip 6CH X265 HEVC-PSA'
'[ Torrent911.gy ] Deadpool.and.Wolverine.2024.MULTi.VF2.2160p.10bit.4KLight.HDR.WEBRip.x265-Neostark'
'www.Torrenting.com - The Wild Robot 2024 4K WEB-DL HLG H 265 10bit DDP-Robo29'

'/mnt/zurg/__all__/Alien Romulus (2024) [2160p] [4K] [WEB] [5.1] [YTS.MX]':
'Alien.Romulus.2024.2160p.4K.WEB.x265.10bit.AAC5.1-[YTS.MX].mkv'

'/mnt/zurg/__all__/Alien Romulus 2024 2160p HDR10Plus DV WEBRip 6CH X265 HEVC-PSA':
'Alien Romulus 2024 2160p HDR10Plus DV WEBRip 6CH X265 HEVC-PSA.mkv'

/mnt/zurg/__all__/Alien.romulus.2024.2160p.x265.hdr.5.1-dual-lat-cinecalidad.re:
Alien.romulus.2024.2160p.x265.hdr.5.1-dual-lat-cinecalidad.re.mkv

'/mnt/zurg/__all__/Alien Romulus (2024) WebDl Rip 2160p H265 10 bit DV HDR10+ ita eng AC3 5.1 sub eng Licdom':
'Alien Romulus (2024) WebDl Rip 2160p H265 10 bit DV HDR10+ ita eng AC3 5.1 sub eng Licdom.mkv'

'/mnt/zurg/__all__/The Wild Robot (2024) (1080p AMZN WEB-DL x265 10bit EAC3 Atmos 5.1 Ghost)':
'The Wild Robot (2024) (1080p AMZN WEB-DL x265 Ghost).mkv'

'/mnt/zurg/__all__/The Wild Robot 2024 2160p HDR10Plus DV WEBRip 6CH X265 HEVC-PSA':
'The Wild Robot 2024 2160p HDR10Plus DV WEBRip 6CH X265 HEVC-PSA.mkv'

'/mnt/zurg/__all__/[ Torrent911.gy ] Deadpool.and.Wolverine.2024.MULTi.VF2.2160p.10bit.4KLight.HDR.WEBRip.x265-Neostark':
'[ Torrent911.gy ] Deadpool.and.Wolverine.2024.MULTi.VF2.2160p.10bit.4KLight.HDR.WEBRip.x265-Neostark.mkv'

'/mnt/zurg/__all__/www.Torrenting.com - The Wild Robot 2024 4K WEB-DL HLG H 265 10bit DDP-Robo29':
'The Wild Robot 2024 4K WEB-DL HLG H 265 10bit DDP-Robo29.mkv'

/mnt/zurg/anime:

/mnt/zurg/movies:
'Alien Romulus (2024) [2160p] [4K] [WEB] [5.1] [YTS.MX]'
'Alien Romulus 2024 2160p HDR10Plus DV WEBRip 6CH X265 HEVC-PSA'
Alien.romulus.2024.2160p.x265.hdr.5.1-dual-lat-cinecalidad.re
'Alien Romulus (2024) WebDl Rip 2160p H265 10 bit DV HDR10+ ita eng AC3 5.1 sub eng Licdom'
'The Wild Robot (2024) (1080p AMZN WEB-DL x265 10bit EAC3 Atmos 5.1 Ghost)'
'The Wild Robot 2024 2160p HDR10Plus DV WEBRip 6CH X265 HEVC-PSA'
'[ Torrent911.gy ] Deadpool.and.Wolverine.2024.MULTi.VF2.2160p.10bit.4KLight.HDR.WEBRip.x265-Neostark'
'www.Torrenting.com - The Wild Robot 2024 4K WEB-DL HLG H 265 10bit DDP-Robo29'

'/mnt/zurg/movies/Alien Romulus (2024) [2160p] [4K] [WEB] [5.1] [YTS.MX]':
'Alien.Romulus.2024.2160p.4K.WEB.x265.10bit.AAC5.1-[YTS.MX].mkv'

'/mnt/zurg/movies/Alien Romulus 2024 2160p HDR10Plus DV WEBRip 6CH X265 HEVC-PSA':
'Alien Romulus 2024 2160p HDR10Plus DV WEBRip 6CH X265 HEVC-PSA.mkv'

/mnt/zurg/movies/Alien.romulus.2024.2160p.x265.hdr.5.1-dual-lat-cinecalidad.re:
Alien.romulus.2024.2160p.x265.hdr.5.1-dual-lat-cinecalidad.re.mkv

'/mnt/zurg/movies/Alien Romulus (2024) WebDl Rip 2160p H265 10 bit DV HDR10+ ita eng AC3 5.1 sub eng Licdom':
'Alien Romulus (2024) WebDl Rip 2160p H265 10 bit DV HDR10+ ita eng AC3 5.1 sub eng Licdom.mkv'

'/mnt/zurg/movies/The Wild Robot (2024) (1080p AMZN WEB-DL x265 10bit EAC3 Atmos 5.1 Ghost)':
'The Wild Robot (2024) (1080p AMZN WEB-DL x265 Ghost).mkv'

'/mnt/zurg/movies/The Wild Robot 2024 2160p HDR10Plus DV WEBRip 6CH X265 HEVC-PSA':
'The Wild Robot 2024 2160p HDR10Plus DV WEBRip 6CH X265 HEVC-PSA.mkv'

'/mnt/zurg/movies/[ Torrent911.gy ] Deadpool.and.Wolverine.2024.MULTi.VF2.2160p.10bit.4KLight.HDR.WEBRip.x265-Neostark':
'[ Torrent911.gy ] Deadpool.and.Wolverine.2024.MULTi.VF2.2160p.10bit.4KLight.HDR.WEBRip.x265-Neostark.mkv'

'/mnt/zurg/movies/www.Torrenting.com - The Wild Robot 2024 4K WEB-DL HLG H 265 10bit DDP-Robo29':
'The Wild Robot 2024 4K WEB-DL HLG H 265 10bit DDP-Robo29.mkv'

/mnt/zurg/shows:

/mnt/zurg/__unplayable__:

real    0m0.043s
user    0m0.004s
sys     0m0.007s
```
</details>

### FAQ 

#### Docker pull unauthorized

Taken from [here](https://www.patreon.com/posts/guide-to-pulling-105779285)

If you are getting an Unauthorized error when pulling the Docker image, follow this guide.
To pull the docker image, create a personal access token first here (make sure the package read permission is enabled): [Github access tokens](https://github.com/settings/tokens)

And then you can run this command on your terminal:

`docker logout ghcr.io`
`docker login ghcr.io -u username -p accesstoken`

Now you can run:

`docker pull ghcr.io/debridmediamanager/zurg:latest`

### LInks

[Riven Wiki](https://rivenmedia.github.io/wiki/)
[Riven github](https://github.com/rivenmedia/riven)
[Rclone instllation](https://rclone.org/install/#script-installation)


[def]: https://rivenmedia.github.io/wiki/services/symlink/#rclone-required
[def2]: https://github.com/debridmediamanager/zurg-testing?tab=readme-ov-file#how-to-run-zurg-in-5-steps-for-plex-with-docker


### OLD / DEPECARETD


### Install rclone

[rclone][def] install guide

1. Install rclone 
`sudo -v ; curl https://rclone.org/install.sh | sudo bash`

2. Create service config
`sudo nano /etc/systemd/system/rclone.service`

!tip: Update User and Group to user

```text
[Unit]
Description=Rclone Mount Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/rclone mount zurg:__all__ /mnt/zurg --allow-other --dir-cache-time 10s --vfs-cache-mode full --vfs-read-chunk-size 8M --vfs-read-chunk-size-limit 2G --buffer-size 16M --vfs-cache-max-age 150h --vfs-cache-max-size 20G --vfs-fast-fingerprint --uid 1000 --gid 1000
ExecStop=/bin/fusermount -u /mnt/zurg
Restart=always
User=daniel
Group=daniel

[Install]
WantedBy=default.target
```

```bash
sudo systemctl daemon-reload && \
sudo systemctl enable rclone && \
sudo systemctl start rclone
```


[def3]: https://rivenmedia.github.io/wiki/services/symlink/#configuring-zurg-with-riven-symlinks