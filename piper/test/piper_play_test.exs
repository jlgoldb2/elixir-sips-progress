defmodule Unix do
  def ps_ax do
    """
PID  TTY      STAT   TIME COMMAND
3799 pts/0    R+     0:00 ps ax
5365 ?        S<     0:00 [kworker/u9:0]
6972 ?        Sl     0:00 mdm
6979 tty7     Ssl+ 138:33 /usr/bin/X :0 -audit 0 -auth /var/lib/mdm/:0.Xauth -noli
7004 ?        S      0:00 dbus-launch 
7005 ?        Ss     0:00 //bin/dbus-daemon --fork --print-pid 5 --print-address 7
    """
  end


  def grep(input, match) do
    lines = String.split(input, "\n")
    Enum.filter(lines, fn(line) -> Regex.match?(match, line) end)
  end
end

defmodule PiperPlayTest do
  use ExUnit.Case

  test "ps_ax outputs some processes" do
    output = """
PID  TTY      STAT   TIME COMMAND
3799 pts/0    R+     0:00 ps ax
5365 ?        S<     0:00 [kworker/u9:0]
6972 ?        Sl     0:00 mdm
6979 tty7     Ssl+ 138:33 /usr/bin/X :0 -audit 0 -auth /var/lib/mdm/:0.Xauth -noli
7004 ?        S      0:00 dbus-launch 
7005 ?        Ss     0:00 //bin/dbus-daemon --fork --print-pid 5 --print-address 7
    """
    assert Unix.ps_ax == output

  end

  test "grep(lines, thing) returns lines that match 'thing'" do
    lines ="""
    jason
    mary
    rubyta
    jason mary
    wildman
    ruby
    wildruby
    rubyman
    """
    output = ["rubyta", "ruby", "wildruby", "rubyman"]
    assert Unix.grep(lines, ~r{ruby}) == output
  end

  test "awk(input, 1) split on whitespace and return 1st column" do
  end

  test "whole pipeline works" do
  end
end