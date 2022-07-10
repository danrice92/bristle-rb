module API::V1
  class UsersController < APIController
    def create
      @user = User.create user_params

      if @user.persisted?
        render json: @user.as_json
      else
        render json: @user.errors
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
