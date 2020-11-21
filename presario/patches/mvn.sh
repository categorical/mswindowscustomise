#!/bin/bash

executable=/cygdrive/d/programs/maven/bin/mvn

confpath=$HOME/.m2/settings.xml
confpathw=$(cygpath -w "$confpath")

exec "$executable" -s "$confpathw" "$@"

