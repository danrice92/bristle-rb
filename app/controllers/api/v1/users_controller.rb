module API::V1
  class UsersController < APIController
    skip_before_action :require_login, only: [:create]

    def create
      @current_user = User.create create_user_params
      authorize @current_user

      if @current_user.persisted?
        UserMailer.with(user: @current_user).verify_email.deliver_now
        render :create
      else
        render json: {errors: @current_user.errors}
      end
    end

    def show
      @user = authorize User.find(params[:id])
      render :show
    end

    def update
      @user = authorize User.find(params[:id])

      if verify_email_params.present? && @user.verify_email!(verify_email_params)
        render :show
      else
        render json: {errors: {verification_code: ["didn't match"]}}
      end
    end

    private

    def create_user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email
      )
    end

    def verify_email_params
      params.require(:user).permit(:verification_code)
    end
  end
end
