module API::V1
  class UsersController < APIController
    def show
      @user = User.find(params[:id])
      render json: {user: @user}
    end

    def create
      @user = User.create user_params

      if @user.persisted?
        render json: {
          user: {
            id: @user.id,
            email: @user.email,
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
