module Tra
  module Fork
    def fork
      super { QUEUE.clear; Mailbox.receive; yield }
    end
  end
end
