#!/bin/bash

# HOW TO START:
# 1) change the your paths bellow
# 2) chose port bellow
# 3) open terminal in the file folder
# 4) copy cpython files to the dir.
# 5) run: "sh script.sh"

# AFTER EVERY TRY: (not that scary)
# if you finish and want to kill the process:
# 1) sudo pgrep python3  -  will show lists of python process
# 2) the first one is the server, if you kill him all the process will die (lets say that is number is 12345)
# 3) sudo kil 12345
# 4) sudo pgrep python3 - to check that all the process die.
# 5) change the port if you want and start again.


#_________________________________________
# You need to change paths HERE: 

# 1) port number:
port=12576

# 2) directory until the \bash_tests_cloud_drive:
# need to look somthing like: dir=/home/name/university/networks/ex2/bash_tests_cloud_drive
dir=/home/name/university/networks/ex2/bash_tests_cloud_drive

#_________________________________________




# if you want you can change the files inserted at the beggining of the program
# by insert "#" in the beggining of the line
# you can add more things and actions and checng sleep time

create_things () {
  cp ../../../files/smalltext.txt  smalltext.txt 
  sleep 1
  mkdir dir1
  sleep 1
  cp ../../../files/bigtext.txt  dir1/bigtext.txt 
  sleep 1
  cp ../../../files/image.jpeg  dir1/image.jpeg
  sleep 1
  cp ../../../files/ziped.zip  ziped.zip
  sleep 1
  mkdir dir2
  mkdir dir2/dir3
  cp ../../../files/music.mp3 dir2/dir3/music.mp3
}


# remove dirs
rm -rf  logs
rm -rf  clients

# create dirs 
mkdir logs
mkdir clients

## run server
sleep 0.2
# cd ../server-client-ex2
python3 -u server.py $port >> logs/serverlog.log &
# cd ../bash_tests_cloud_drive
sleep 2

echo""
echo Let the magic begin!!!

line=''



# traverse every client
# you can run more or less clients by changing the numbers after "in"

echo "___________________________________________________________"
for i in a b c

do
  echo ""
  echo creating client $i.
  ## create tracking library
  mkdir clients/client$i
  mkdir clients/client$i/client$i

  ## run first client
  sleep 0.2
  python3 -u client.py 127.0.0.1 $port $dir/clients/client$i/client$i 1   >> logs/client$i.log &
  echo wating for $i key.
  sleep 7
  line=$(tail -1 logs/serverlog.log)

  if [ -z "$line" ]
  then
      echo "didnt find key - exit"
      exit 1
  else
        echo client $i key given : $line
  fi


  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# function that do things 
  cd clients/client$i/client$i
  echo inserting files in clients/client$i/client$i
  create_things
  cd ../../..
  sleep 1

  ## run clone clients
  # you can run more or less clone clients by changing the numbers after "in"
  for j in 1 2 3
  do
  sleep 4
  echo ""
  echo creating client $i$j clone of client $i.
  echo key for creating : $line
  mkdir clients/client$i/client$i$j
  python3 -u client.py 127.0.0.1 $port $dir/clients/client$i/client$i$j 1 $line>> logs/client$i$j.log &
  sleep 1

  done
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""
echo "___________________________________________________________"
done

echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "|All files and dirs created, check that everything synchronized."
echo "                  |created by Yoav Tamir|"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
