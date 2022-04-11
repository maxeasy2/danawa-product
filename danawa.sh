#!/bin/bash -x

pcode=$1
PATH=/python/danawa
PRODUCT_PATH=$PATH/product
SEND_YN="N"

if [ -z $pcode ]; then
    echo "pcode is empty"
    exit 1
fi

if [ -z ${WEBHOOK_URL} ]; then
    echo "WEBHOOK_URL is empty"
    exit 2
fi

if [ ! -e ${PRODUCT_PATH}/$pcode ]; then
    /usr/local/bin/python ${PATH}/DanawaProduct.py $pcode > ${PRODUCT_PATH}/$pcode
    SEND_YN="Y"
else 
    /bin/cp ${PRODUCT_PATH}/$pcode ${PRODUCT_PATH}/$pcode.tmp
    /usr/local/bin/python ${PATH}/DanawaProduct.py $pcode > ${PRODUCT_PATH}/$pcode
    diff_cnt=$(/usr/bin/diff -q ${PRODUCT_PATH}/$pcode ${PRODUCT_PATH}/$pcode.tmp | /usr/bin/wc -l)
    if [ $diff_cnt -ne 0 ]; then
	SEND_YN="Y"
    else
    	SEND_YN="N"
    fi
fi

if [ "${SEND_YN}" == "Y" ]; then
    /usr/bin/curl "${WEBHOOK_URL}$(/bin/cat ${PRODUCT_PATH}/$pcode)"
fi
