module ClassDiagram
  module Options
    class Value
      def self.to_h(value)
        return {} if value.nil?

        if value.is_a?(Hash)
          value
        else
          { value => nil }
        end
      end
    end
  end
end
