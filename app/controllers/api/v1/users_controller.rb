module API::V1
  class UsersController < APIController
    def create
      user = User.new(create_user_params)

      begin
        if user.save
          render json: {user: user}, status: :created
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

    def respond_with_errors error_hash
      errors = error_hash.flat_map do |key, error_array|
        error_array.map { |error| "#{key.capitalize} #{error}" }
      end
      render json: {errors: errors}, status: :unprocessable_entity
    end
  end
end
