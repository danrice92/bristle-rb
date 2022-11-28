module API::V1
  class APIController < ApplicationController
    include Pundit::Authorization
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    before_action :require_login
    after_action :verify_authorized

    def require_login
      if params[:authentication_token]
        current_user
      else
        user_not_authenticated
      end
    end

    def current_user
      return @current_user if @current_user.present?

      begin
        user_id = User.decode_id_from_token(params[:authentication_token]) 
        @current_user = User.find(user_id)
      rescue
        user_not_authenticated
      end
    end

    def clean_email email
      email&.downcase&.strip
    end

    private

    def user_not_authenticated
      render json: {errors: {authentication: ["must provide a valid authentication token"]}}, status: 401
    end

    def user_not_authorized
      render json: {errors: {authorization: ["not allowed to perform this action"]}}, status: 403
    end
  end
end
