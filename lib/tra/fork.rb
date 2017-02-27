module Tra
  module Fork
    def fork
      super { QUEUE.clear; PATTERNS.clear; Mailbox.receive; yield }
    end
  end
end
