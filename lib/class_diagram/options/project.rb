module ClassDiagram
  module Options
    class Project < Group
      DEFAULTS = {
        scopes: [
          './**/*.rb': {}
        ],
        include: [
          {
            './**/*.rb': {}
          }
        ]
      }.freeze

      def initialize(options_hash: DEFAULTS)
        super
      end
    end
  end
end
