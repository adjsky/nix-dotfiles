export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"

function kp { kill $(lsof -t -i:$1); }

function rnm() { rm -rf **/node_modules; }
