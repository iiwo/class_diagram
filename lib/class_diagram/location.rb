# frozen_string_literal: true

module ClassDiagram
  # source location/path
  class Location
    attr_reader :path

    EXCLUDED_PATHS = %w[app/models app/jobs].freeze

    def initialize(path:)
      @path = path.to_s
    end

    def skip?
      EXCLUDED_PATHS.any? do |excluded_path|
        path.include?(excluded_path)
      end
    end

    def project?
      path.start_with?(Dir.getwd)
    end
  end
end
