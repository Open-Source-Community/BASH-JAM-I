#!/bin/bash


touch data3
rm data3


if [[ $1 == "-p" ]]
then
	youtube-dl --flat-playlist -j "${2}" | jq ".title" >> data3
	readarray list < data3

elif [[ $1 == "-s" ]]
then
	youtube-dl  -j "${2}" | jq ".title" >> data3
	list=$(cat data3)
fi


replace() {
	i=$1
	for (( d=0; d<${#i}; d++ ))
	do
		if [[ ${i:${d}:1} == "-" ]] || [[ ${i:$d:1} == "," ]]
		then
			artist=${i:1:$d-1}
			song=${i:$d+1}
			break
		fi
	done
	for (( d=0; d<${#song}; d++ ))
	do
		if [[ ${song:${d}:1} == "(" ]] || [[ ${song:${d}:1} == "[" ]]
		then
			song=${song:0:$d-1}
			break
		elif [[ ${song:${d}:1} == '"' ]] 
			then
				song=${song:0:$d}
		fi
	done
	payload=$( echo "${song} ${artist}" | tr ' ' + )



}


get_lyrcis() {
	touch temp
	rm temp
	touch html2
	rm html2
	link="https://search.azlyrics.com/search.php?q=${1}"
	#echo $link
	wget --user-agent="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" "$link" -q -O temp

	line=($(cat temp | grep '<tr><td class="text-left visitedlyr"'))
	link2=${line[3]:43}
	wget --user-agent="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" ${link2:1:${#link2}-3} -q -O html2


	readarray html < html2
	rm html2
	comment="<!-- Usage of azlyrics.com content by any third-party lyrics provider is prohibited by our licensing agreement. Sorry about that. -->"
	for li in "${html[@]}"
	do
		if [[ ${li::133} == $comment ]]
		then
			start=1
			continue
		elif [[ $li == '<br>' ]] && [[ $start -eq 1 ]]
		then
			continue
		elif [[ ${li::6} == '</div>' ]] && [[ $start -eq 1 ]]
		then
			start=0
			break
		fi
		if [[ $start -eq 1 ]]
		then  
			echo $li | sed -r 's/<br>//g'
		fi
	done	
}






youtube() {
	if [[ $1 == "-p" ]]
	then
		for i in "${list[@]}"
		do
			replace "${i}"
			echo "       ${song}"
			get_lyrcis ${payload:1}
			echo "-------------------------"
		done

	else
		song=$list
		replace "${song}"
		echo "       ${song}"
		#echo ${payload:1}
		get_lyrcis ${payload:1}
	fi

}


youtube $1

