module Snapstats
  module Helpers
    module Redis
  
      def mkey name
        "snaps:#{name}"
      end

      def mtime name
        "snaps:#{Time.now.to_i}:#{name}"
      end

      def mday name
        current_day = Date.current.strftime('%Y%m%d')
        "snaps:#{current_day}:#{name}"
      end
      
    end
  end
end