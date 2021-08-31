require "rails_helper"

describe "/user" do
  let(:email) { "newaccount@example.com" }

  context "POST #create" do
    it "allows the user to create an account by providing their email" do
      post "/api/v1/users", params: {user: {email: email}}
      user = User.find_by_email(email)

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:created)
      expect(response.body).to eq({user: user}.to_json)
    end

    it "responds with an error if the email already exists" do
      post "/api/v1/users", params: {user: {email: email}}
      post "/api/v1/users", params: {user: {email: email}}

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eq({user: {errors: {email: ["is already taken"]}}}.to_json)
    end
    
    it "responds with an error if no email is provided" do
      post "/api/v1/users", params: {user: {email: ""}}

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eq({user: {errors: {email: ["can't be blank"]}}}.to_json)
    end
  end
end
