module API::V1
  class SessionsController < APIController
    skip_before_action :require_login, only: [:create]

    def create
      @current_user = User.find_by_email(session_params[:email])

      if @current_user.blank?
        skip_authorization
        return render json: {errors: {email: ["not found"]}}
      end

      authorize @current_user

      if @current_user.reset_verification_code
        UserMailer.with(user: @current_user).login.deliver_now
        render :create
      else
        render json: {errors: @current_user.errors}
      end
    end

    private

    def session_params
      params.require(:session).permit(:email)
    end
  end
end
