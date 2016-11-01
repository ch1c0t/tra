module Tra
  module Mailbox
    class << self
      def receive
        Dir.mkdir DIRECTORY unless Dir.exist? DIRECTORY
        file = FILE[Process.pid]

        Thread.new do
          Socket.unix_server_loop file do |socket|
            QUEUE << (Marshal.load socket.read size_of_message_from socket)
          end
        end

        sleep 0.01 until File.exist? file
      end

      private
        def size_of_message_from socket
          size = String.new

          while digit = socket.read(1)
            break if digit == ?:
            size << digit
          end

          size.to_i
        end
    end
  end
end
