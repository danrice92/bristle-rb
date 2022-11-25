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
      @user = User.create user_params

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

    private

    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email
      )
    end
  end
end
