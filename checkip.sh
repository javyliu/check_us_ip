#/bin/bash
#脚本用法:checkip.sh <要检查的日志名(如web_access.log.2013-02-13)>
#By Tyler Wang
#2013-03-14
#


listfile=US-20130314.txt
checkfile=tmp_ip${1##*.}.txt
#web 访问充值
#charge_type="web"
#awk '$7~/\/pay\/index\.jsp/{print $1}' $1|sort -u > $checkfile
#touch 访问充值
charge_type="touch"
awk '{print $1}' $1|sort -u > $checkfile
#wap 访问充值
#charge_type="wap"
#awk '$7~/\/wml\/charge\.jsp/{print $1}' $1|sort -u > $checkfile
resultfile=result-${1##*/}.txt
touch $resultfile
echo ${1##*.}
i=0
j=0
while read line
do
  #checkip=`echo $line|awk '{print $1}'`
  checkip=$line
  result=`java -cp checkip.jar pip.CheckIPInList $listfile $checkip`

  case $result in
    0)
      echo "$checkip">>$resultfile
      let i=$i+1
      echo "$i $checkip"
      ;;
    1)
      let j=$j+1
      #echo "不符条件的第 $j 条IP记录"
      ;;
    *)
      ;;
  esac

done < $checkfile

echo "${1##*.}共有 $i 个美国IP访问$charge_type充值"

#脚本结束
