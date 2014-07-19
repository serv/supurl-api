module Api
  module V0
    class LinksController < ApplicationController
      def show
        @link = Link.find(params[:id])
        render json: @link
      end

      private

        def link_params
          params.require(:status).permit(:title, :href, :comment)
        end
    end
  end
end
