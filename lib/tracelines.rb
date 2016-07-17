#!/usr/bin/env ruby
#   Copyright (C) 2007, 2008, 2009, 2010, 2014
#   Rocky Bernstein <rockyb@rubyforge.net>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
#    02110-1301 USA.

module TraceLineNumbers

  def self.lnums_for_str src
    name = "#{Time.new.to_i}_#{rand(2**31)}"
    iseq = RubyVM::InstructionSequence.compile(src, name)
    lines = {}
    iseq.disasm.each_line{|line|
      if /^\d+ (\w+)\s+.+\(\s*(\d+)\)$/ =~ line
        insn = $1
        lineno = $2.to_i
        next unless insn == 'trace'
        lines[lineno] = true
        # p [lineno, line]
      end
    }
    lines.keys
  end

  # Return an array of lines numbers that could be
  # stopped at given a file name of a Ruby program.
  def lnums_for_file(file)
    lnums_for_str(File.read(file))
  end
  module_function :lnums_for_file

  # Return an array of lines numbers that could be
  # stopped at given a string array.
  def lnums_for_str_array(string_array, newline='', uniq=true)
    lnums_for_str(string_array.join(newline))
  end
  module_function :lnums_for_str_array
end

if __FILE__ == $0
  SCRIPT_LINES__ = {} unless defined? SCRIPT_LINES__
  # test_file = '../test/rcov-bug.rb'
  test_file = '../test/lnum-data/begin1.rb'
  if  File.exists?(test_file)
    puts TraceLineNumbers.lnums_for_file(test_file).inspect
    load(test_file, 0) # for later
  end
  puts TraceLineNumbers.lnums_for_file(__FILE__).inspect
  unless SCRIPT_LINES__.empty?
    key = SCRIPT_LINES__.keys.first
    puts key
    puts SCRIPT_LINES__[key]
    puts TraceLineNumbers.lnums_for_str_array(SCRIPT_LINES__[key]).inspect
  end
end
