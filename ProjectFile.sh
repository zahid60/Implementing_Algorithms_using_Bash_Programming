
fcfs(){
  #-----------------------------------------
echo -n "Enter no. of Process: "
read N
BurstTime=()
WaitingTime=()
TurnAroundTime=()

for i in $(seq 1 1 $N)
do
	
   echo -n "Process $i: "
   read B           #Process Time
   BurstTime+=($B)
          
  
done

echo Burst Time: ${BurstTime[@]}

WaitingTime[0]=0
TurnAroundTime+=${BurstTime[0]}
TotalWaitingTime=0
TotalTurnAroundTime=${TurnAroundTime[0]}
#echo $TotalTurnAroundTime;
#echo $WaitingTime, $TotalWaitingTime
#echo $TurnAroundTime, $TotalTurnAroundTime

for i in $(seq 1 1 $((N-1)))
do

  WaitingTime[$i]=$((${WaitingTime[$((i-1))]} + ${BurstTime[$((i-1))]}))
  TurnAroundTime[$i]=$((${WaitingTime[$i]} + ${BurstTime[$i]}))

TotalWaitingTime=$(($TotalWaitingTime + ${WaitingTime[$i]}))
  TotalTurnAroundTime=$(($TotalTurnAroundTime + ${TurnAroundTime[$i]}))
#echo $TotalTurnAroundTime;
done

AvgWaitingTime=$(($TotalWaitingTime / $N))
AvgTurnAroundTime=$(($TotalTurnAroundTime / $N)) 

echo Average Waiting Time: $AvgWaitingTime
echo Average Turn Around Time: $AvgTurnAroundTime
}


sjf(){
  #-----------------------------------------
echo -n "Enter no. of Process: "
read N
BurstTime=()
WaitingTime=()
TurnAroundTime=()
ProcessID=()

for i in $(seq 1 1 $N)
do
	
   echo -n "Process $i: "
   read B           #Process Time
   BurstTime+=($B)
   ProcessID+=($i)
          
  
done

for ((i = 0; i<($N); i++))
do
      
    for((j = 0; j<($N)-i-1; j++))
    do
      
        if [ ${BurstTime[j]} -gt ${BurstTime[$((j+1))]} ]
        then
            # swap
            temp=${BurstTime[j]}
            BurstTime[$j]=${BurstTime[$((j+1))]}  
            BurstTime[$((j+1))]=$temp

            temp=${ProcessID[j]}
            ProcessID[$j]=${ProcessID[$((j+1))]}  
            ProcessID[$((j+1))]=$temp
            
        fi
    done
done
  
echo Burst Time: ${BurstTime[@]}
echo Process ID: ${ProcessID[@]}

WaitingTime[0]=0
TurnAroundTime+=${BurstTime[0]}
TotalWaitingTime=0
TotalTurnAroundTime=${TurnAroundTime[0]}
#echo $TotalTurnAroundTime;
#echo $WaitingTime, $TotalWaitingTime
#echo $TurnAroundTime, $TotalTurnAroundTime

for i in $(seq 1 1 $((N-1)))
do

  WaitingTime[$i]=$((${WaitingTime[$((i-1))]} + ${BurstTime[$((i-1))]}))
  TurnAroundTime[$i]=$((${WaitingTime[$i]} + ${BurstTime[$i]}))

TotalWaitingTime=$(($TotalWaitingTime + ${WaitingTime[$i]}))
  TotalTurnAroundTime=$(($TotalTurnAroundTime + ${TurnAroundTime[$i]}))
#echo $TotalTurnAroundTime;
done

AvgWaitingTime=$(($TotalWaitingTime / $N))
AvgTurnAroundTime=$(($TotalTurnAroundTime / $N)) 

echo Average Waiting Time: $AvgWaitingTime
echo Average Turn Around Time: $AvgTurnAroundTime
}


Priority()
{
  #-----------------------------------------
echo -n "Enter no. of Process: "
read N
BurstTime=()
WaitingTime=()
TurnAroundTime=()
ProcessID=()
PriorityID=()

for i in $(seq 1 1 $N)
do
	
   echo -n "Process $i: "
   read B           #Process Time
   echo -n "Priorty for Process $i: "
   read C
   BurstTime+=($B)
   ProcessID+=($i)
   PriorityID+=($C)
  
done

for ((i = 0; i<($N); i++))
do
      
    for((j = 0; j<($N)-i-1; j++))
    do
      
        if [ ${PriorityID[j]} -gt ${PriorityID[$((j+1))]} ]
        then
            # swap

            temp=${PriorityID[j]}
            PriorityID[$j]=${PriorityID[$((j+1))]}  
            PriorityID[$((j+1))]=$temp

            temp=${BurstTime[j]}
            BurstTime[$j]=${BurstTime[$((j+1))]}  
            BurstTime[$((j+1))]=$temp

            temp=${ProcessID[j]}
            ProcessID[$j]=${ProcessID[$((j+1))]}  
            ProcessID[$((j+1))]=$temp
            
        fi
    done
done
  
echo " "
echo Burst Time: ${BurstTime[@]}
echo Process ID: ${ProcessID[@]}

WaitingTime[0]=0
TurnAroundTime+=${BurstTime[0]}
TotalWaitingTime=0
TotalTurnAroundTime=${TurnAroundTime[0]}
#echo $TotalTurnAroundTime;
#echo $WaitingTime, $TotalWaitingTime
#echo $TurnAroundTime, $TotalTurnAroundTime

for i in $(seq 1 1 $((N-1)))
do

  WaitingTime[$i]=$((${WaitingTime[$((i-1))]} + ${BurstTime[$((i-1))]}))
  TurnAroundTime[$i]=$((${WaitingTime[$i]} + ${BurstTime[$i]}))

TotalWaitingTime=$(($TotalWaitingTime + ${WaitingTime[$i]}))
  TotalTurnAroundTime=$(($TotalTurnAroundTime + ${TurnAroundTime[$i]}))
#echo $TotalTurnAroundTime;
done

AvgWaitingTime=$(($TotalWaitingTime / $N))
AvgTurnAroundTime=$(($TotalTurnAroundTime / $N)) 

echo Average Waiting Time: $AvgWaitingTime
echo Average Turn Around Time: $AvgTurnAroundTime
}



Robin(){
  #............Round Robin Algorithm..................
echo Enter the number of process:
read n
echo Enter the quantum time:
read qt
echo Enter the burst time:
for i in $(seq 1 1 $n)
do 
echo -n Process $i : burst time:
read bt[i]
rbt[i]=${bt[i]}
done
p=$n
pt=0
while [[ $p>0 ]]
do
for i in $(seq 1 1 $n)
do
if [[ ${rbt[i]} -gt 0 ]]
then
if [[ ${rbt[i]} -le $qt ]]
then
pt=$((pt+rbt[i]))
rbt[i]=0
tat[i]=$pt
wt[i]=$((pt-bt[i]))
p=$((p-1))
else
rbt[i]=$((rbt[i]-qt))
pt=$((pt+qt))
fi
fi
done
done
for i in $(seq 1 1 $n)
do
echo proces $i : wating time ${wt[i]} turnaround time ${tat[i]}
done
}

Deadlock()
{
echo -n Enter the number of process:
read n
echo -n Enter the number of resourse type:
read m
declare -A A   #Array for allocation
declare -A AM  #Array for maximum of each resourse type
declare -A NA  #Array for needed of each resourse type
echo Enter the resourse instance in sequence of each type:
for i in $(seq 1 1 $m)
  do
   read MR[i]
done
echo Enter the allocation of each proces and maximum resourse for each type:
for i in $(seq 1 1 $n)
   do
     for j in $(seq 1 1 $m)
       do
         read A[$i,$j]  #allocation of process i for R.type j
         Al[j]=$((A[$i,$j]+Al[j]))
         read AM[$i,$j]  #Maximum of process i for R. type j
         NA[$i,$j]=$((AM[$i,$j]-A[$i,$j])) #Needed of proces i for R.T. j 
     done
    p[i]=1
done

for i in $(seq 1 1 $m)
  do
    AR[i]=$((MR[i]-Al[i]))
done
k=$n
proces=()
while [[ $k -gt 0 ]]
  do
    for i in $(seq 1 1 $n)
      do
       if [[ ${p[i]} -eq 1 ]]
        then
          x=0
          for j in $(seq 1 1 $m)
            do
             if [[ ${NA[$i,$j]}<=${AR[j]} ]]
               then
               x=$((x+1))
               else
               break
               fi
                if [[ $x -eq $m ]]
                  then
                    proces+=($i)
                    k=$((k-1))                  
                    for d in $(seq 1 1 $m)
                      do
                      AR[d]=$((AR[d]+A[$i,$d]))
                      p[i]=0
                     done
                 fi
           done
        fi
   done
done
if [[ $k -le 0 ]]
then 
echo The system is in a safe state. So the sequence of process no. are:
echo ${proces[@]}
else
echo Unsafe $k
fi
}

mft(){
echo Enter avilable memory size:
read ms
echo Enter the block size:
read bs 
echo Enter the number of proces:
read n 
for i in $(seq 1 1 $n)
do
echo Requred memory for proces $i :
read rm[i]
al[i]=0
done

f=$((ms/bs))
s=$f
echo no. of avilable block in memory: $f
Ef=$((ms-((f*bs))))
echo proces  memory_Requred  allocation  Internal Frag.
k=0
Ifr=0
i=1
while [[ $f>0 && $i<=$n ]]
do
#echo $i  rm[i]
if [[ ${rm[i]}<=$bs ]]
then
echo $i  ${rm[i]}  YES   $((bs-rm[i]))
Ifr=$((Ifr+bs-rm[i]))
al[f]=1
((k++))
((f--))
else
echo $i  ${rm[i]} NO   ......
fi
((i++))
done
echo memory id full. Remaing Process cannot be accomodated
echo Total Internal fragmentation is $Ifr
#for i in $(seq 1 1 $s)
#do
#if [[ ${al[i]}==0 ]
#then
Ef=$((Ef+((s-k))*300))

#fi
#done
echo External fragmentation: $Ef
}

mvt()
{
  echo Enter avilable memory size:
read ms
tm=$ms
al=()
alm=()
k='y' 
m=0
i=1
j=1
while [[ $j -eq 1 ]]
do
echo -n Enter memory required for process $i "(in Bytes)":
read mr
if [[ $ms -ge $mr ]]
then 
echo Memory is allocated for Process $i
al+=($i)
alm+=($mr)
ms=$((ms-mr))
m=$((m+1))
fi
read -rN1 -p "Do you want to continue(y/n): " k; 
echo 
if [ "$k" != 'y' ];
then
j=0
break
fi
i=$((i+1))
done
echo Memory is Full
echo Total Memory Available was: $tm
echo PROCESS ———MEMORY-ALLOCATED
for i in $(seq 0 1 $((m-1)))
do
echo ${al[i]} ————————— ${alm[i]}
done
echo Total Memory Allocated is: $((tm-ms))
echo Total External Fragmentation is: $ms
}





p=1
t=0
while [ $p ]
do 
echo "1-CPU ALGORITHMS"
echo "2-Banker’s Algorithm and Deadlock Avoidance"
echo "3-Simulating the MFT and MVT Memory Management Techniques."
echo "4-Exit."
echo -n "Please Enter Your Choice: "
read s 
echo " "
echo " "
k=0
case $s in
1) 
echo "***CPU ALGORITHMS***"
#echo  " "
echo "1-First Served Scheduling Algorithm"
echo "2-Sortest Job First Sheduling Algorithm"
echo "3-Priority Scheduling Algorithm "
echo "4-Round Robin Scheduling Algorithm"
echo -n "Please Enter Your Choice: "
read e 
echo " "
if [ $e -eq 1 ]
then
fcfs
echo -n "Enter any key:"
read y 
clear
echo ""
elif [ $e -eq 2 ]
then
sjf
echo -n "Enter any key:"
read y 
clear
echo ""
elif [ $e -eq 3 ]
then
Priority
echo -n "Enter any key:"
read y 
clear
echo ""
elif [ $e -eq 4 ]
then
Robin
echo -n "Enter any key:"
read y 
clear
echo ""
else
each "Enter a valid serial number !!!"
fi
;;

2)
echo "***Banker’s Algorithm and Deadlock Avoidance***"
Deadlock
each ""
;;
3)
echo "***Simulating the MFT and MVT Memory Management Techniques.***"
#echo  " "
echo "1-MFT Memory Management Techniques"
echo "2-MVT Memory Management Techniques"

echo -n "Please Enter Your Choice: "
read q
echo " "
echo " "
if [ $q -eq 1 ]
then
mft 
echo -n "Enter any key:"
read y 
clear
echo ""
elif [ $q -eq 2 ]
then
mvt 
echo -n "Enter any key:"
read y 
clear
echo ""
else 
each "Enter a valid serial number !!!"
fi

;;
4)
t=1
;;
*)
echo "Enter a valid serial number !!!"
esac

if [ $t -eq 1 ]
then
break
fi

done

