#!/bin/sh
if [ -z "$PROBCLI" ]; then
	echo "PROBCLI needs to be set"
	exit
fi
${PROBCLI} -h -v > cache.txt

pref_opts=$(cat cache.txt \
			| grep '^\s\{1,\}[A-Z]\w*\s\{1,\}=\s' \
			| awk '{print $1}')

opts=$(cat cache.txt \
		| grep '^\s\{1,\}\-\{1,\}\w' \
		| awk '{ print $1 }')
rm cache.txt &> /dev/null

opts=$(echo $opts | sed -e "s/\n/ /g")
pref_opts=$(echo $pref_opts | sed -e "s/\n/ /g")
version=$($PROBCLI --version | grep VERSION | cut -c 11-)
date=`date "+%Y-%m-%d"`

sed -e "s/%{version}/${version}/g" \
    -e "s/%{date}/${date}/g" \
    -e "s/%{opts}/\"${opts}\"/g" \
		-e "s/%{pref_opts}/\"${pref_opts}\"/g" \
		completion.template > prob_completion.sh
