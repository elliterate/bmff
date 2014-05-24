# coding: utf-8
# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 autoindent:

require_relative '../../minitest_helper'
require 'bmff/box'
require 'stringio'

class TestBMFFBoxSampleAuxiliaryInformationOffsets < MiniTest::Unit::TestCase
  def test_parse_v0_flags_0
    io = StringIO.new("", "r+:ascii-8bit")
    io.extend(BMFF::BinaryAccessor)
    io.write_uint32(0)
    io.write_ascii("saio")
    io.write_uint8(0) # version
    io.write_uint24(0) # flags
    io.write_uint32(3) # entry_count
    3.times do |i|
      io.write_uint32(i) # offset
    end
    size = io.pos
    io.pos = 0
    io.write_uint32(size)
    io.pos = 0

    box = BMFF::Box.get_box(io, nil)
    assert_instance_of(BMFF::Box::SampleAuxiliaryInformationOffsets, box)
    assert_equal(size, box.actual_size)
    assert_equal("saio", box.type)
    assert_equal(0, box.version)
    assert_equal(0, box.flags)
    assert_nil(box.aux_info_type)
    assert_nil(box.aux_info_type_parameter)
    assert_equal(3, box.entry_count)
    assert_equal([0, 1, 2], box.offsets)
  end

  def test_parse_v0_flags_1
    io = StringIO.new("", "r+:ascii-8bit")
    io.extend(BMFF::BinaryAccessor)
    io.write_uint32(0)
    io.write_ascii("saio")
    io.write_uint8(0) # version
    io.write_uint24(1) # flags
    io.write_uint32(1) # aux_info_type
    io.write_uint32(2) # aux_info_type_parameter
    io.write_uint32(3) # entry_count
    3.times do |i|
      io.write_uint32(i) # offset
    end
    size = io.pos
    io.pos = 0
    io.write_uint32(size)
    io.pos = 0

    box = BMFF::Box.get_box(io, nil)
    assert_instance_of(BMFF::Box::SampleAuxiliaryInformationOffsets, box)
    assert_equal(size, box.actual_size)
    assert_equal("saio", box.type)
    assert_equal(0, box.version)
    assert_equal(1, box.flags)
    assert_equal(1, box.aux_info_type)
    assert_equal(2, box.aux_info_type_parameter)
    assert_equal(3, box.entry_count)
    assert_equal([0, 1, 2], box.offsets)
  end

  def test_parse_v1_flags_0
    io = StringIO.new("", "r+:ascii-8bit")
    io.extend(BMFF::BinaryAccessor)
    io.write_uint32(0)
    io.write_ascii("saio")
    io.write_uint8(1) # version
    io.write_uint24(0) # flags
    io.write_uint32(3) # entry_count
    3.times do |i|
      io.write_uint64(i) # offset
    end
    size = io.pos
    io.pos = 0
    io.write_uint32(size)
    io.pos = 0

    box = BMFF::Box.get_box(io, nil)
    assert_instance_of(BMFF::Box::SampleAuxiliaryInformationOffsets, box)
    assert_equal(size, box.actual_size)
    assert_equal("saio", box.type)
    assert_equal(1, box.version)
    assert_equal(0, box.flags)
    assert_nil(box.aux_info_type)
    assert_nil(box.aux_info_type_parameter)
    assert_equal(3, box.entry_count)
    assert_equal([0, 1, 2], box.offsets)
  end
end