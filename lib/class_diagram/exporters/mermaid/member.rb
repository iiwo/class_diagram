# frozen_string_literal: true

module ClassDiagram
  module Exporters
    class Member
      def initialize(member_hash:, options: ClassDiagram::Options::Diagram.new)
        @member_hash = member_hash
        @options = options
      end

      def export
        from_name = @member_hash[:name]

        return "    #{from_name}" if @member_hash[:elements].none? && @options.filters[:orphans]

        @member_hash[:elements].map do |element_hash|
          "    #{from_name} --> #{element_hash[:name]}" if from_name != element_hash[:name]
        end.compact.uniq.join("\n")
      end
    end
  end
end
