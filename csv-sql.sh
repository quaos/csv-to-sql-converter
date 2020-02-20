#!/bin/sh

fname=$1
sed 's/\s*,*\s*$//g' $fname > tmp.csv
op=$(echo $fname | sed -E 's/\.([^\.]+)$//')
# cut -d"." -f 1)
opfile="$op.sql"
op="\`$op\`"
columns=$(head -n 1 tmp.csv | sed 's/,/`,`/g' | tr -d "\r\n")
columns="\`$columns\`"
tail -n +2 tmp.csv | while read l ; do
  values=$(echo $l | sed 's/,/\",\"/g' | tr -d "\r\n")
  values="\"$values\""
  echo "INSERT INTO $op($columns) VALUES ($values);"
done > $opfile
rm tmp.csv
