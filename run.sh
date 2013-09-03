if [ ! -n "$WERCKER_ZOOKEEPER_TARBALL" ]; then
  error 'Please specify the url of the zookeeper tarball'
  exit 1
fi
export TMP1=$(basename $WERCKER_ZOOKEEPER_TARBALL)
export WERCKER_ZOOKEEPER_FILENAME=${TMP1%.tar.gz}
if [ ! -f $WERCKER_CACHE_DIR/$WERCKER_ZOOKEEPER_FILENAME/bin/zkServer.sh ]; then
  debug '$WERCKER_ZOOKEEPER_FILENAME/bin/zkServer.sh not found in cache directory, will download it'
  cd /tmp
  rm -f zookeeper*
  wget -0 $WERCKER_ZOOKEEPER_FILENAME.tar.gz $WERCKER_ZOOKEEPER_TARBALL || fail 'unable to download from $WERCKER_ZOOKEEPER_TARBALL'
  tar -zxvf $WERCKER_ZOOKEEPER_FILENAME.tar.gz
  mv $WERCKER_ZOOKEEPER_FILENAME/conf/zoo_sample.cfg $WERCKER_ZOOKEEPER_FILENAME/conf/zoo.cfg
  cp -r $WERCKER_ZOOKEEPER_FILENAME $WERCKER_CACHE_DIR/
  cd -
  debug '$WERCKER_ZOOKEEPER_FILENAME added to cache successfully'
else
  debug '$WERCKER_ZOOKEEPER_FILENAME found in cache directory'
fi

debug 'Starting: $WERCKER_CACHE_DIR/$WERCKER_ZOOKEEPER_FILENAME/bin/zkServer.sh start'
$WERCKER_CACHE_DIR/$WERCKER_ZOOKEEPER_FILENAME/bin/zkServer.sh start
exec 6<>/dev/tcp/localhost/2181