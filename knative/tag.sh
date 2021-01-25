#! env /bin/bash

for i in `cat 0192.txt`
do
  echo $i
  #docker tag $i
done
sudo awk '{a=$1;b=$2;system("docker tag "a" "b)}' x.txt
