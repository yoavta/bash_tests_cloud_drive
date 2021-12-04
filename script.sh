#!/bin/bash

create_things () {
  # cp ../../../files/smalltext.txt  smalltext.txt 
  sleep 1
  mkdir dir1
  # sleep 1
  # cp ../../../files/bigtext.txt  dir1/bigtext.txt 
  # sleep 1
  # cp ../../../files/image.jpeg  dir1/image.jpeg
  # sleep 1
  # cp ../../../files/ziped.zip  ziped.zip
  # sleep 1
  # mkdir dir2
  # mkdir dir2/dir3
  # cp ../../../files/music.mp3 dir2/dir3/music.mp3

}

port=12459


# remove dirs
rm -rf  logs
rm -rf  clients

# create dirs 
mkdir logs
mkdir clients


dir=/home/shakedc159/university/networks/ex2/bash_tests_cloud_drive
## run server
sleep 0.2
cd ../server-client-ex2
python3 -u server.py $port >> ../bash_tests_cloud_drive/logs/serverlog &
cd ../bash_tests_cloud_drive
sleep 2



## traverse every client

for i in a b c
## create tracking library

do
  mkdir clients/client$i
  mkdir clients/client$i/client$i

  echo $i
  sleep 0.2
  python3 -u ../server-client-ex2/client.py 127.0.0.1 $port $dir/clients/client$i/client$i 1   >> logs/client$i &
  sleep 1.5
  line=$(head -n 1 logs/client$i)

# function that do things 
  cd clients/client$i/client$i
  create_things
  cd ../../..


  sleep 1

  for j in 1 2
  do
  mkdir clients/client$i/client$i$j
  echo $j
  python3 -u ../server-client-ex2/client.py 127.0.0.1 $port $dir/clients/client$i/client$i$j 1 $line >> logs/client$i$j &
  echo $i
  sleep 1

  done
done


#sudo pgrep python3    
# sudo kil number

#for start:
# sh script.sh
