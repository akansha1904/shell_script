#!/bin/bash

#script for all four inputs and validate the input 


COMP_NAME=( INGESTOR JOINER WRANGLER VALIDATOR )
SCALE_MEASURE=( MID HIGH LOW )
VIEW_OPTION=( AUCTION BID )
COUNT_NUMBER=( 1 2 3 4 5 6 7 8 9 )

read -p "Enter Component: " COMPname
if [[ " ${COMP_NAME[*]} " =~ " ${COMPname} " ]]; then
    echo " Valid component: $COMPname selected "
fi

if [[ ! " ${COMP_NAME[*]} " =~ " ${COMPname} " ]]; then
    echo " invalid component: blehh"

   read -p "Try again: " COMPname
    
fi

read -p "Enter View option: " View
 if [[ " ${VIEW_OPTION[*]} " =~ " ${View} " ]]; then
    echo " Valid component: $View selected "
fi

if [[ ! " ${VIEW_OPTION[*]} " =~ " ${View} " ]]; then
    echo " invalid component: blehh"
     read -p "Try again: " View

fi

echo "Enter the scale measure:"
select Scale  in "${SCALE_MEASURE[@]}"; do
if [[ "${SCALE_MEASURE[*]}" == *"$Scale"* ]]; then
echo "$Scale"
break
else
echo "bleh-invalid scale measure"  
fi
done

echo "Enter the count number:"
select Count  in "${COUNT_NUMBER[@]}"; do
if [[ "${COUNT_NUMBER[*]}" == *"$Count"* ]]; then
echo "$Count"
break
else
echo "bleh-invalid count name"  
fi
done


#alter the file line
if [ "$View" == "AUCTION" ]; then
if cat sig.conf | grep -n -v "vdopiasample-bid" | grep -n -q "$COMPname" ; then
A=$( cat sig.conf | grep -n -v  "vdopiasample-bid" | grep  "$COMPname" | awk  -F ':' '{print $1}')
B=$( cat sig.conf | grep -n -v  "vdopiasample-bid" | grep  "$COMPname" | awk  -F ';' '{print $2}')
C=$( cat sig.conf | grep -n -v  "vdopiasample-bid" | grep  "$COMPname" | awk  -F '=' '{print $2}')

set -x
sed -i "${A}s/${B}/${Scale}/" sig.conf
sed -i "${A}s/${C}/${Count}/" sig.conf
set +x
echo "file changed"
else
echo "not matched"
fi

else
if cat sig.conf | grep -n  "vdopiasample-bid" | grep -n -q "$COMPname " ; then

A=$( cat sig.conf | grep -n   "vdopiasample-bid" | grep  "$COMPname" | awk  -F ':' '{print $1}')
B=$( cat sig.conf | grep -n   "vdopiasample-bid" | grep  "$COMPname" | awk  -F ';' '{print $2}')
C=$( cat sig.confi | grep -n   "vdopiasample-bid" | grep   "$COMPname" | awk  -F '=' '{print $2}')

sed -i "${A}s/${B}/${Scale}/" sig.conf
sed -i "${A}s/${C}/${Count}/" sig.conf
echo "file changed"
else
echo "not matched"
fi
fi


cat sig.conf







