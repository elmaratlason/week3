#!/bin/bash
# used to run npm build and create docker image
# Háskólinn í Reykjavík - 2017
# elmar.atlason@gmail.com / elmar14@ru.is

DOCKER_IMAGE="tictactoe"
DOCKER_REPO="elmaratlason"

echo Cleaning...
rm -rf ./dist


if [ -z "$GIT_COMMIT" ]; then
  export GIT_COMMIT=$(git rev-parse HEAD)
  export GIT_URL=$(git config --get remote.origin.url)
fi

# Remove .git from url in order to get https link to repo (assumes https url for GitHub)
export GITHUB_URL=$(echo $GIT_URL | rev | cut -c 5- | rev)

# build app
echo Building app
npm run build

rc=$?
if [[ $rc != 0 ]] ; then
    echo "Build failed with exit code " $rc
    exit $rc
fi

cat > ./build/githash.txt <<_EOF_
$GIT_COMMIT
_EOF_

cat > ./build/static/version.html << _EOF_
<!doctype html>
<head>
   <title>TicTacToe version information</title>
</head>
<body>
   <span>Origin:</span> <span>$GITHUB_URL</span>
   <span>Revision:</span> <span>$GIT_COMMIT</span>
   <p>
   <div><a href="$GITHUB_URL/commits/$GIT_COMMIT">History of current version</a></div>
</body>
_EOF_

cp ./package.json ./build/
cp ./Dockerfile ./build/

cd build

echo Building docker image

# build docker image
docker build -t $DOCKER_REPO/$DOCKER_IMAGE:$GIT_COMMIT .

rc=$?
if [[ $rc != 0 ]] ; then
    echo "Docker build failed " $rc
    exit $rc
fi

# push docker image to docker hub, need to have ./docker/config.json on jenkins, created with docker login
docker push $DOCKER_REPO/$DOCKER_IMAGE:$GIT_COMMIT
rc=$?
if [[ $rc != 0 ]] ; then
   echo "Docker push failed " $rc
   exit $rc
fi

echo "Done"
