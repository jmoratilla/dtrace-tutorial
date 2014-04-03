#!/bin/bash

for i in `find / -maxdepth 1 -type d | xargs`
do
  `find $i -ls` 2>&1 /dev/null
done

