#!/bin/sh -l

# Leaving this as an example of how to write back out outputs
# time=$(date)
# echo "::set-output name=time::$time"

git clone https://github.com/enygma/fetch-team-avatars.git
cd fetch-team-avatars
/usr/local/bin/composer install

# Run the command to get the org data
php ./run.php --GH_TOKEN=$1 --GH_USER=$3 --GH_TEAM_URL=$4 > out.txt

# cat out.txt

# A bit of config
git config --global user.email "$5"
git config --global user.name "$3"

# Now we clone the target repo, make the updates and commit
git clone "https://$3:$1@github.com/$2" tmp
cd tmp
git checkout $5

# Perform the replacement
echo "Replacement"
sed -i "s/<TEAM>/$(sed -e 's/[\&/]/\\&/g' -e 's/$/\\n/' ../out.txt | tr -d '\n')/g" README.md
cat README.md

# Commit and push!
git add README.md; git commit -m'Team avatar update'; git push origin $5
