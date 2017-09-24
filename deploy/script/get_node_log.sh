#! /bin/bash
set -e
source ./blockchain_nodes_conf_util.sh
source ./common_lib.sh

CLUSTER_BIGCHAIN_COUNT=`get_cluster_nodes_num`
[ $CLUSTER_BIGCHAIN_COUNT -eq 0 ] && {
    echo -e "[ERROR] blockchain_nodes num is 0"
    exit 1
}

echo -e "[INFO]=======get node log======="
for (( i=0; i<$CLUSTER_BIGCHAIN_COUNT; i++ ));
do
    fab set_host:$i get_node_log
done

cd ../log/node_log/

for file in ./*
do
    if test -f $file
    then
        tar -zxvf $file
        cd $file
        grep $1 *
        cd ..
        rm $file
    fi
done

cd ./../../script/
echo -e "[INFO]=======get node log end======="
echo -e ""

exit 0
