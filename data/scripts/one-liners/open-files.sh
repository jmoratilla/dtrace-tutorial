#!/bin/bash

dtrace -q -n syscall::open:entry'/execname == "vi"/{ printf("%-16s%-16s\n", execname,copyinstr(arg0)); }'
