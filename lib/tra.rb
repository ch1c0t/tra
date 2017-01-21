require 'forwardable'
require 'socket'

require_relative 'tra/mailbox'
require_relative 'tra/fork'

module Tra
  QUEUE = Queue.new

  DIRECTORY = "/tmp/tra"
  FILE = -> pid { "#{DIRECTORY}/#{pid}" }

  class << self
    def enumerator
      @enumerator ||= Enumerator.new do |y|
        loop { y << QUEUE.pop }
      end
    end

    extend Forwardable
    delegate [:next, :take] => :enumerator

    def run
      Mailbox.receive

      patch_Object_shamelessly
      patch_Integer_shamelessly
    end

    private
      def patch_Object_shamelessly
        Object.prepend Fork
      end

      def patch_Integer_shamelessly
        Integer.class_eval do
          def put message
            message = Marshal.dump message
            Socket.unix(FILE[self]).write "#{message.size}:#{message}"
          end
        end
      end
  end
end
