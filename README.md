# docker-multiple-sites

Running all sites:

    $ docker-compose -f common-services.yml up

Running single site:

    php5.6/src/site1$ docker-compose up

Accessing sites:

 - site 1 -> localhost:8001/site1
 - site 2 -> localhost:8001/site2
 - site 3 -> localhost:8002/site3
