# frozen_string_literal: true

module ClassDiagram
  class PathFinder
    class << self
      attr_accessor :glob_cache

      def glob(path)
        self.glob_cache ||= {}
        normalized_path = normalize(path)

        glob_cache[normalized_path] || glob_cache[normalized_path] = Dir.glob(normalized_path)
      end

      def normalize(path)
        ::File.expand_path(path)
      end
    end
  end
end
