module ClassDiagram
  module Options
    class Node
      DEFAULTS = {
        class: { include: ['*'] },
        module: { include: ['*'] }
      }.freeze

      def initialize(options_hash: DEFAULTS)
        # File.fnmatch("foo*", "food")
        self.options_hash = DEFAULTS.merge(Value.to_h(options_hash))
      end

      def match?(path:)
        return false if options_path.nil? || path.nil?

        PathFinder.glob(options_path).intersection(PathFinder.glob(path)).any?
      end

      def follow?
        options_hash.values.last[:follow] != false
      end

      def max_depth
        options_hash.values.last[:max_depth] || MAX_DEPTH
      end

      def options_path
        options_hash.keys.last.to_s
      end

      def to_h
        options_hash
      end

      private

        attr_accessor :options_hash
    end
  end
end
