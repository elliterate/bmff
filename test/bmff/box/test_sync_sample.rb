# coding: utf-8
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 autoindent:

require_relative '../../minitest_helper'
require 'bmff/box'
require 'stringio'

class TestBMFFBoxSyncSample < Minitest::Test
  def test_parse
    io = StringIO.new("", "r+:ascii-8bit")
    io.extend(BMFF::BinaryAccessor)
    io.write_uint32(0)
    io.write_ascii("stss")
    io.write_uint8(0) # version
    io.write_uint24(0) # flags
    io.write_uint32(3) # entry_count
    3.times do |i|
      io.write_uint32(i) # sample_number
    end
    size = io.pos
    io.pos = 0
    io.write_uint32(size)
    io.pos = 0

    box = BMFF::Box.get_box(io, nil)
    assert_instance_of(BMFF::Box::SyncSample, box)
    assert_equal(size, box.actual_size)
    assert_equal("stss", box.type)
    assert_equal(0, box.version)
    assert_equal(0, box.flags)
    assert_equal(3, box.entry_count)
    assert_equal([0, 1, 2], box.sample_number)
  end
end
