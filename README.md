# bash_tests_cloud_drive for client-server cloud drive.
## What is the purpose of the script: 
1. Creating automatically big number of clients and clone clients. 
2. Filling dirs with files for each base client.
3. "Easy" monitoring using log files. (each log contain program prints)

### Result
![image](https://user-images.githubusercontent.com/70321869/145399182-388ac354-8b2f-4a84-84bd-3b58157f2125.png)


![image](https://user-images.githubusercontent.com/70321869/145399301-4025edab-21b2-4d95-89bd-d55ecc9e9bac.png)


## how its work: 
1. Run the server with the port number.
2. Creating logs folder.
- _for each client:_
3. Open new tracking dir
3. Run client without a key. (Save log in logs)
4. Insert files to the client.
- _for each clone client:_
5. Open new tracking dir
6. Run client with the original client key. (Save log in logs)

#### **ONLY LINUX COMPATIBLE

## How to start:

- Clone tests
```bash
git clone https://github.com/yoavta/bash_tests_cloud_drive.git
```

- copy client.py , server.py (and utils.py if you made one) into the dir.

- Open tests.sh and edit few things

Its all written in the script but you should edit:
1. Port number
2. Working directory
```bash
FROM SCRIPT.SH:
#_________________________________________
# You need to change paths HERE: 

# 1) port number:
port=12475

# 2) directory until the \bash_tests_cloud_drive:
# need to look somthing like: dir=/home/name/university/networks/ex2/bash_tests_cloud_drive
dir=

#_________________________________________
```
Dont forget to save.

- Run the script
```bash
sh script.sh
```
Test more things - deletion, etc'


- Restart

If you want to run again you should:
1. Kill all python proccess. 
```bash
sudo pgrep python3      # will show lists of python process
```

```bash
# the first one is the server, if you kill him all the process will die (lets say that is number is 12345)
sudo kill 12345
sudo pgrep python3     # to check that all the process die.
```
2. Change port.
3. And run again.


## Disclaimer
- Own your responasabilty.
