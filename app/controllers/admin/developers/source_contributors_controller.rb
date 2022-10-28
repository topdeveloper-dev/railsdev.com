module Admin
  module Developers
    class SourceContributorsController < ApplicationController
      def create
        set_developer_source_contributor(true)
        redirect_back_or_to root_path, allow_other_host: false
      end

      def destroy
        set_developer_source_contributor(false)
        redirect_back_or_to root_path, allow_other_host: false
      end

      private

      def set_developer_source_contributor(source_contributor)
        developer = Developer.find(params[:developer_id])
        developer.source_contributor = source_contributor
        developer.save!(touch: false)
      end
    end
  end
end
