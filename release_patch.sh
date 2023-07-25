version=$1

if [ $# != 1 ]; then
	echo "Usage: `basename "$0"` <version>"
    echo "<version> refers to the version (X.XX.XX) that should be released."
    echo "An orphan branch patch/X.XX.XX is created and only the patch of the sources is committed."
    echo "After executing the script, please check that everything is correct and push the encrypted branch to the server of choice."
	exit
else
	version=$1
fi	

# create new branch without history
git checkout --orphan patch/${version}

# create patch for current version with respect to original sources
../../patch/create_patch.sh cclm-sp_2.0/src/cclm cclm
# remove modified sources
rm -r cclm
# remove original sources and create place holder
rm -r cclm-sp_2.0*
echo "This is just a placeholder for the original sources from https://www.clm-community.eu/wiki/wg-suptech/cosmo-clm/starter-package/files/" > cclm-sp_2.0.tgz

# commit encrypted sources
git add .
git commit -m "Release encryted version ${version}."

# switch back to normal working branch
git switch master

# if everything worked nicely, please push the branch encrypted/${version} to the server of choice