json.user do
  json.partial! "api/v1/users/user", user: @current_user
  json.authentication_token @current_user.encode_json_web_token
end
