module API::V1
  class APIController < ApplicationController
    before_action :require_login

    def user_not_authorized
      render json: {errors: {authorization: ["not allowed to perform this action"]}}, status: 403
    end
  end
end
