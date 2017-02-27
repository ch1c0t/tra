require_relative 'lib/tra'
Tra.run

child = fork do
  message = [1,2,3]
  p Process.ppid
  5.times { Process.ppid.put message }
  p Tra.next
end

=begin
require 'pry'
binding.pry
p Tra.next
=end
Tra.take(5).each { |message| p message }
child.put [:my, :message, "with\n newlines\n"]


# sloppy patterns' test goes underneath
class A
end

class B
end

As = []
Bs = []

Tra.on A do |message|
  As << message
end

Tra.on B do |message|
  Bs << message
end

fork do
  Process.ppid.put A.new
  Process.ppid.put :asd
  Process.ppid.put B.new
  Process.ppid.put B.new
  Process.ppid.put B.new
  Process.ppid.put A.new
  Process.ppid.put 42
end

sleep 1
p As.size #2
p Bs.size #3
p Tra.take 2
