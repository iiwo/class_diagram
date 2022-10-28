# frozen_string_literal: true

module ClassDiagram
  module Exporters
    module Mermaid
      class Diagram
        def initialize(members:, options: ClassDiagram::Options::Diagram.new)
          @members = members
          @options = options
        end

        def export
          rows = ['graph LR'] + @members.map do |member_hash|
            Member.new(member_hash: member_hash, options: @options).export
          end.compact.uniq
          rows.join("\n").gsub(/[\n]+/, "\n")
        end
      end
    end
  end
end
