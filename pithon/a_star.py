import smbus
import struct

class AStar:
  def __init__(self):
    self.bus = smbus.SMBus(1)

  def set_motors(self, left, right):
    self.bus.write_i2c_block_data(20, 1, [2] + [ord(c) for c in list(struct.pack('hh', left, right))])
    self.wait_for_return

  def wait_for_return(self):
    while 0 == self.bus.read_byte(20):
      pass

