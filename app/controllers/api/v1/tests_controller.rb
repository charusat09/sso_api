module Api
  module V1
    class TestsController < ApplicationController
      before_action :doorkeeper_authorize!

      def index
        render json: { message: 'This is a protected endpoint' }
      end
    end
  end
end
