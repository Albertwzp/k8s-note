## count cpu number
```shell
cat /proc/cpuinfo | grep name | sort | uniq       //cpu model
lscpu |grep '^CPU(s):'
cat /proc/cpuinfo |grep 'physical id' |sort|uniq  //physic
cat /proc/cpuinfo |grep 'core id' |sort|uniq      //core
cat /proc/cpuinfo |grep 'processor' |sort|uniq    //logic core
