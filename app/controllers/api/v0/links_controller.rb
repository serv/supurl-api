module Api
  module V0
    class LinksController < ApplicationController
      before_action :set_headers

      def show
        @link = Link.find(params[:id])
        render json: @link
      end

      private

        def link_params
          params.require(:status).permit(:title, :href, :comment)
        end

        def set_headers
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
          headers['Access-Control-Request-Method'] = '*'
          headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
        end
    end
  end
end
