#!/bin/bash


VERSION_FILE=VERSION

if [ ! -f "$VERSION_FILE" ]; then
    echo "File $VERSION_FILE not exists."
    exit;
fi

VERSION=$(head -n 1 ${VERSION_FILE})
OLD_VERION=${VERSION}
NEW_VERSION=$(./version.sh $VERSION bug)
TAG="v${NEW_VERSION}"


echo "Neuer Build von $OLD_VERION zu $NEW_VERSION durchführen? (ja/nein)"
read WEITER

if ! [[ $WEITER == "ja" || $WEITER == "j" || $WEITER == "JA" || $WEITER == "J" ]]; then
    echo "Release abgebrochen"
    exit;
fi
echo $NEW_VERSION > $VERSION_FILE
echo $NEW_VERSION > VERSION

git add . 
git commit -m "build: ${TAG}"
git tag $TAG 
git push origin --tags
git push

echo "Build Version $TAG !"



