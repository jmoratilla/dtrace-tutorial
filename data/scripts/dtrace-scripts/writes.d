#!/usr/sbin/dtrace -s

syscall::write:entry
{
  @numwrites[execname] = count();
}
