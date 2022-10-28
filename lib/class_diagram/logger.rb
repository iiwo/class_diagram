# frozen_string_literal: true

module ClassDiagram
  class Logger
    class << self
      def debug(message)
        puts message if ENV['DEBUG']
      end
    end
  end
end
