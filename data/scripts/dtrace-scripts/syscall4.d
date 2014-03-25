#!/usr/sbin/dtrace -s

syscall:::entry
/execname == "htop"/
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
/execname == "htop"/
{
  self->on = timestamp;
}

sched:::off-cpu
/self->on/
{
  @["- total -"] = sum(timestamp - self->on);
  self->on = 0;
}
