#!/usr/sbin/dtrace -s

/*
 Valid to see which system calls were being executed most frequently
*/

syscall:::entry
/execname == "vi"/
{
  self->ts = vtimestamp;
}

syscall:::return
/self->ts/
{
  @[probefunc] = sum(vtimestamp - self->ts);
  @["- all syscall -"] = sum(vtimestamp - self->ts);
  self->ts = 0;
}
sched:::on-cpu
/execname == "vi"/
{
  self->on = timestamp;
}

sched:::off-cpu
/self->on/
{
  @["- total -"] = sum(timestamp - self->on);
  self->on = 0;
}
