function kp { kill $(lsof -t -i:$1); }

function rnm() { rm -rf **/node_modules; }
