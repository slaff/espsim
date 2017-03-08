If you don't have 32 bit one possibility is to use 32 bit docker container. 
To create such a container run the following command

  docker build -t="32bit/esp-sim" .

In order to run it do the following

  docker run -it "32bit/esp-sim" /bin/bash


The simluation code is locate at /roor/espsim.
