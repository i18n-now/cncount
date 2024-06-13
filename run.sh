#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

date=20240601

pip install -r requirements.txt -U &
mkdir -p tmp
cd tmp

wget "https://drive.usercontent.google.com/download?id=1TMKu1FpTr6kcjWXWlQHX7YJsMfhhcVKp&export=download&authuser=0&confirm=t&uuid=58216655-7238-4304-9334-2857da994e53&at=APZUnTU7L97qQOXzqwdn2IU1sHCP%3A1718239291619" -O new2016zh.zip
wget "https://drive.usercontent.google.com/download?id=1_vgGQZpfSxN_Ng9iTAvE7hM3Z7NVwXP2&export=download&authuser=0&confirm=t&uuid=2bf55676-8b13-45f2-aa9a-8a0538cc2d1e&at=APZUnTUoazNq5KVLnVQ2JJNuhLDa%3A1718239414654" -O baike2018qa.zip
wget "https://drive.usercontent.google.com/download?id=1u2yW_XohbYL2YAK6Bzc5XrngHstQTf0v&export=download&authuser=0&confirm=t&uuid=fb6888c5-4540-4130-a4f5-778e34c538b7&at=APZUnTXxkWDahANGKxAN0BYFINcF%3A1718239476427" -O webtext2019zh.zip
find *.zip | xargs -I {} bash -c "unzip -o '{}' && rm '{}'"

to=wiki.$date.xml.bz2
url=https://dumps.wikimedia.org/zhwiki/$date/zhwiki-$date-pages-articles.xml.bz2

wget -c $url -O $to

wait
txtcn_wiki $to
../count.py wiki.$date.txt.zd
