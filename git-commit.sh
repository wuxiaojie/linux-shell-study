die_msg() { echo ERROR: $@>&2; exit -1; }

! [ -e "$1" ] && die_msg Only accept an existing directory or file  as parameter

cd $1 &>/dev/null || die_msg $0 cannot switch to working directory $1 


FLAG=$(git status -s)
git status -s |while read line
do
        file=$(echo "$line" | awk '{print $2}')
       # echo "$file"
        if echo "$line" | grep -q "^\?" || echo "$line" | grep -q "^M" 
        then
        #       echo "need add $file"
                git add --force $file
                continue
        fi
        if echo "$line" | grep -q "^\!" 
        then
                #echo "need delete $file"
                git rm  --force $file
                continue
        fi
done


COMMENT=${2:-this is new upate}


if [ -n "$FLAG" ]
then
   git commit --author='author <name@mailserver>' -a -m "$COMMENT" &>/dev/null || die_msg $0 git committion failed
else 
   echo Noting has been updated!
fi
