#!/bin/bash

dtrace -q -n syscall::entry'/pid == $1/{ @num[probefunc] = count(); }'
