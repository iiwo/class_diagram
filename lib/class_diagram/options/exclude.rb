module ClassDiagram
  module Options
    class Exclude
      DEFAULTS = {}.freeze

      def initialize(options_hash: DEFAULTS)
        self.options_hash = DEFAULTS.merge(Value.to_h(options_hash))
      end

      def match?(path:)
        return false if options_path.nil? || path.nil?

        PathFinder.glob(options_path).intersection(PathFinder.glob(path)).any?
      end

      private

        attr_accessor :options_hash

        def options_path
          options_hash.keys.last.to_s
        end
    end
  end
end
