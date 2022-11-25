module API::V1
  class UsersController < APIController
    def index
      @user = User.first
      render json: {
        user: {
          id: @user.id,
          authentication_token: @user.encode_json_web_token,
          email: @user.email,
          email_verified: @user.email_verified,
          first_name: @user.first_name,
          last_name: @user.last_name
        }
      }
    end

    def show
      @user = User.find(params[:id])
      render json: {user: @user}
    end

    def create
      @user = User.create create_user_params

      if @user.persisted?
        UserMailer.with(user: @user).verify_email.deliver_now
        render json: {
          user: {
            id: @user.id,
            authentication_token: @user.encode_json_web_token,
            email: @user.email,
            email_verified: @user.email_verified,
            first_name: @user.first_name,
            last_name: @user.last_name
          }
        }
      else
        render json: {errors: @user.errors}
      end
    end

    def update
      @user = User.find(params[:id])

      if verify_email_params.present? && @user.verify_email!(verify_email_params)
        render json: {
          user: {
            id: @user.id,
            email: @user.email,
            email_verified: @user.email_verified,
            first_name: @user.first_name,
            last_name: @user.last_name
          }
        }
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
