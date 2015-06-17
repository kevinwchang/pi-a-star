#!/usr/bin/python

import a_star
import time

a_star = a_star.AStar()

for x in range(401):
  a_star.set_motors(x,x)
  time.sleep(0.002)
time.sleep(0.5)
for x in range(401):
  a_star.set_motors(400-x,400-x)
  time.sleep(0.002)

for x in range(401):
  a_star.set_motors(-x,-x)
  time.sleep(0.002)
time.sleep(0.5)
for x in range(401):
  a_star.set_motors(-400+x,-400+x)
  time.sleep(0.002)
