module API::V1
  class UsersController < APIController
    def create
      user = User.new(create_user_params)

      begin
        if user.save
          response.status = :created
          render json: {user: user}
        else
          respond_with_errors(user.errors.messages)
        end
      rescue ActiveRecord::RecordNotUnique
        user.errors.add(:email, "is already taken")
        respond_with_errors(user.errors.messages)
      end
    end

    private

    def create_user_params
      params.require(:user).permit(:email)
    end

    def respond_with_errors errors
      response.status = :unprocessable_entity
      render json: {user: {errors: errors}}
    end
  end
end
