#!/usr/bin/sh
file_num=2
filepath=/resource/records
getpercent(){
#percent=`df /resource -h | grep -v Filesystem| awk 'NR==2{print int($5)}'`
percent=`df /resource -h | grep -v Filesystem| awk '{print int($5)}'`
#echo "22222222222222222222222"
}

getpercent
#循环判断分区使用率是否超过70%
while [ $percent -ge 50 ]
do
      #echo "111111111111111111111"
      total_file_num=`ls $filepath -l | grep -e ".mkv" -e ".mp4" | wc -l` # 统计目录文件的个数
      if [ $file_num -ge $total_file_num ];then
            echo "您要删除的文件数目太多!"
            break;
      else
         #   cd $filepath && ls $filepath -ltr | grep -v 'total' | grep -e ".mkv" -e ".mp4" | awk '{print $9}' | head -n $file_num | xargs -I %% sh -c "rm -r %%; /usr/local/sbin/lonbon-conference/records/deleterecored.sh %%"   
            cd $filepath && ls $filepath -ltr | grep -v 'total' | grep -e ".mkv" -e ".mp4" | awk '{print $9}' | head -n $file_num |\
		 xargs -I %% mysql -uroot lb_record -s -e "update conference set is_del=1 where id=(select c_id from conference_videos where filename='%%');"
            cd $filepath && ls $filepath -ltr | grep -v 'total' | grep -e ".mkv" -e ".mp4" | awk '{print $9}' | head -n $file_num |\
		 xargs -I %% rm -rf %% 
      fi
      getpercent
done 

#清理 buff/cache 1

echo "开始清除缓存"
sync;sync;sync #写入硬盘，防止数据丢失
sleep 10 #延迟10秒
echo 3 > /proc/sys/vm/drop_caches

#清理日志
#find /usr/local/ -mtime +7 -name "*.log" -exec rm -rf {} \;

#清理 core

total_file_num1=`ls /usr/local/sbin/lonbon-conference/bin/ -l | grep "core-lonbon-conferen" | wc -l`  # 统计目录文件的个数
if [ $total_file_num1 -gt 3 ];then
cd /usr/local/sbin/lonbon-conference/bin && ls ./ -ltr | grep -v 'total' | grep "core-lonbon-conferen" | awk '{print $9}' | head -n $[total_file_num1-3] | xargs rm -rf    

fi



echo "deleterecordsfile end... time is $(date)" >> /usr/local/sbin/lonbon-conference/log/mcu_log.txt
