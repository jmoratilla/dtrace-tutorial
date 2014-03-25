#!/usr/sbin/dtrace -s

syscall:::entry
/execname == "htop"/
{ 
  @[probefunc] = count();
}
