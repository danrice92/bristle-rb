json.user do
  json.partial! "api/v1/users/user", user: @user || @current_user
end
