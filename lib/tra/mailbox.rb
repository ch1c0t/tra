module Tra
  module Mailbox
    def self.receive
      Dir.mkdir DIRECTORY unless Dir.exist? DIRECTORY
      file = FILE[Process.pid]

      Thread.new do
        Socket.unix_server_loop file do |socket|
          QUEUE << (Marshal.load socket.gets)
        end
      end

      sleep 0.01 until File.exist? file
    end
  end
end
