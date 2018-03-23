# docker-arch-suite

Service-oriented suite with all containers based on one Arch Linux.

--

Firstly add following lines to /etc/hosts for friendly urls

    127.0.1.1   site1.test
    127.0.1.1   site2.test
    127.0.1.1   site3.test

Then create network and start proxy service:

    $ docker network create nginxproxy_default
    $ docker-compose -f docker-proxy.yml up

Now you have following options:

- Start whole bundle

      $ docker-compose -f docker-common.yml up

- Start site 1

      $ docker-compose -f docker-common.yml -f php5/src/site1/docker-compose.yml up site1

- Start site 2

      $ docker-compose -f docker-common.yml -f php7/src/site2/docker-compose.yml up site2

- Start site 3

      $ docker-compose -f docker-common.yml -f php7/src/site3/docker-compose.yml up site3

---

Sites are accessible at following urls:

 - site 1 -> http://site1.test
 - site 2 -> http://site2.test
 - site 3 -> http://site3.test

## Permissions

### Fixing

Set .env variables according to result of `id -u` and `id -g`.

### Story

Handling permissions with docker shared volumes is quite complicated (see https://github.com/moby/moby/issues/7198). I was trying different approaches: namespaces, mounting /etc/password and few others ways. Unfortunately all of them was primitive workarounds which did not meet base requirements. But finally I found a good one! [fixuid](https://github.com/boxboat/fixuid/tree/master/docker) comes to rescue and solves all problems without complicated configuration.