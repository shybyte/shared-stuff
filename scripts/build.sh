BASE_DIR=`dirname $0`
SOURCE=$BASE_DIR/../app
TARGET=$BASE_DIR/../target
LIB=$SOURCE/lib

echo "Make Dirs ..."
mkdir $TARGET
mkdir $TARGET/js
mkdir $TARGET/css

echo "Copy stuff..."
cp -r $SOURCE/img $TARGET
cp    $LIB/bootstrap/img/* $TARGET/img
cp -r $SOURCE/partials $TARGET
cp $SOURCE/index.html $TARGET

echo "Compress javascripts..."
JS=$SOURCE/js
JSG=$SOURCE/js/gen
java -jar $BASE_DIR/buildtools/closure-compiler.jar $JSG/utils.js $JS/remote-storage-utils.js $JSG/models.js $JSG/services.js \
 $JSG/app-controllers.js $JSG/friends-controllers.js $JSG/my-stuff-controllers.js $JSG/friends-stuff-controllers.js  $JS/controllers.js \
 $JS/directives.js $JS/filters.js $JSG/account-controllers.js $JS/app.js --js_output_file $TARGET/js/shared-stuff.min.js

echo "Combine javascripts..."
cat $LIB/jquery.min.js $LIB/underscore.min.js $LIB/angular/angular.min.js $LIB/bootstrap/js/bootstrap.min.js $LIB/remoteStorage.js $TARGET/js/shared-stuff.min.js >$TARGET/js/shared-stuff-with-libs.min.js

echo "Minimize CSS..."
CSS=$SOURCE/css
java -jar $BASE_DIR/buildtools/closure-stylesheets.jar $CSS/app.css > $TARGET/css/app.min.css

echo "Combine css..."
cat $LIB/bootstrap/css/bootstrap.min.css  $TARGET/css/app.min.css  >$TARGET/css/app-with-libs.min.css