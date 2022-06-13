# frozen_string_literal: true

module ClassDiagram
  module Formatters
    class HTML
      def initialize(options: {})
        @options = options
      end

      def format(diagram_data:)
        self.diagram_data = diagram_data
        html_wrapped_data
      end

      def file_extension
        'html'
      end

      private

        attr_accessor :diagram_data

        # TODO: extract
        def html_wrapped_data
          <<~HTML
            <!DOCTYPE html>
            <html lang="en">
            <head>
              <meta charset="utf-8">
            </head>
            <body>
              <div class="mermaid">
                #{diagram_data}
              </div>
             <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
             <script>mermaid.initialize({startOnLoad:true});
            </script>
            </body>
            </html>
          HTML
        end
    end
  end
end
