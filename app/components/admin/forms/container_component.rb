module Admin
  module Forms
    class ContainerComponent < ApplicationComponent
      renders_one :button_group

      attr_reader :title, :description

      def initialize(title, description)
        @title = title
        @description = description
      end
    end
  end
end
