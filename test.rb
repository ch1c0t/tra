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
