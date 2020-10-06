#!/bin/sh

# Variable
url=$1
filePrefix=$2
start=$3
end=$4
fileSurfix=$5
storageDir=$6
mode=$7

check()
{
    if [ "$url" == "" ]; then
        echo "=  Format : download.sh [url] [prefix] [start] [end] [surfix] [video|pic]"
        echo "Example: ./download.sh http://www.baidu.com/img/ baidu_resultlogo@ 0 2 png dir2"
        echo "Example: ./download.sh http://www.baidu.com/img/ '' 0 2 png dir1"
    	exit
	else 
		echo "========================================================="
        echo "=  Format : download.sh [url] [prefix] [start] [end] [surfix] [video|pic]"
		echo "=  Url    : [$url]"
		echo "=  Files  : $filePrefix[$start-$end].$fileSurfix"
		echo "========================================================="
    fi
}

download()
{
	check
	echo
	echo "Downloading ..."
	# targetFile=$url$filePrefix$i.$fileSurfix
	targetDir=`pwd`/$storageDir/

	if [ ! -d $targetDir ]; then
		echo "Target dir: "$targetDir
		mkdir -p $targetDir
	fi 

	
	#len=`expr ${#end} \* 10`
	#eval echo `echo {$start..$end}`
	if [ "$mode" == "video" ]; then
		arr=`seq -f "%0${#end}g" $start $end`
	else 
		arr=`seq $start $end`
	fi

	for i in $arr
	#for i in `seq -f "%0${#end}g" $start $end`
	#for i in `seq $start $end`
	do
		targetFile=$targetDir$filePrefix$i.$fileSurfix
		targetUrl=$url$targetFile
		#echo $targetFile
		if [ ! -f $targetFile ]; then
			#echo $targetFile
			#wget -P $targetDir $url$filePrefix$i.$fileSurfix
			echo "Download $targetFile `wget -q -P $targetDir $url$filePrefix$i.$fileSurfix`"
		fi
	done
	statusReport
}

statusReport()
{
	# Check
	total=0
	rm  $targetDir/FileList
	rm  $targetDir/missList
	#for i in `seq $start $end`
	for i in `seq -f "%0${#end}g" $start $end`
	do
		targetFile=$targetDir$filePrefix$i.$fileSurfix
		if [ -f $targetFile ]; then
			total=$[$total+1]	
			successlog $targetFile
		else
			faillog "$url$filePrefix$i.$fileSurfix"
		fi
	done
	
	all=`expr $end - $start + 1`
	# mv $filePrefix*.$fileSurfix $targetDir
	echo "All: $all Total download: $total Files Dir:$targetDir"
}

successlog()
{
	echo "file '$1'" >> $targetDir/FileList
}

faillog()
{
	echo $1 >> $targetDir/missList
}

download

