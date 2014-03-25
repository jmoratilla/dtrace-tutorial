#!/usr/sbin/dtrace -s

syscall:::entry
/execname == "htop"/
{
  self->ts = vtimestamp;
}

syscall:::return
/self->ts/
{
  @[probefunc] = quantize(vtimestamp - self->ts);
  self->ts = 0;
}
