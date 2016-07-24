module Snapstats
  module Report
    class Manager

      def initialize type
        case type
        when :main
          @report = Main.new(db: Snapstats.redis)
        when :user
          @report = User.new(db: Snapstats.redis)
        when :performance
          @report = Performance.new(db: Snapstats.redis)
        end
      end

      def call
        @report
      end

    end
  end
end
