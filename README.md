# docker-multiple-sites

Running all sites:

    $ docker-compose up

Running single site:

    $ docker-compose up site2

Accessing sites:

 - site 1 -> http://localhost:8001/site1, http://site1.dev*
 - site 2 -> http://localhost:8001/site2, http://site2.dev*
 - site 3 -> http://localhost:8002/site3, http://site3.dev*



\* For firendly-urls you need to add following lines to /etc/hosts

    127.0.0.1   site1.dev
    127.0.0.1   site2.dev
    127.0.0.1   site3.dev
