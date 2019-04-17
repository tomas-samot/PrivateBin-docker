
# I am not sure if this works anymore.
____

# PrivateBin Docker
Dockerfile to setup [PrivateBin](https://github.com/PrivateBin/PrivateBin) and [Certbot](https://certbot.eff.org/)
inside a [Docker](https://www.docker.com) container.

___

# Useage
Replace `example.com` with the domain you wish to use. (Dockerfile and `cert.sh` before building)

### Build with the below command
`docker build PrivateBin-docker -t privatebin`

### Docker Run Command
`sudo docker run -p 80:80 -p 443:443 -i -d -t --name PrivateBin -h example.com privatebin`

### Read and Run `cert.sh`
`docker exec -i PrivateBin bash -c "cd / && bash cert.sh"`

### Add to Cron
Remember to choose a different time

`22 2 * * * docker exec -i PrivateBin bash -c "certbot renew --post-hook 'service apache2 stop'"`

`22 1 * * * docker start PrivateBin`

###### Please note that stopping and starting apache2 might not be necessary. I will be testing this in 3 months time when my certificate expires.
___

## [Certbot Documentation](https://certbot.eff.org/docs/using.html)
## [PrivateBin Documentation](https://github.com/PrivateBin/PrivateBin/wiki)
## [Docker Documentation](https://docs.docker.com/)
