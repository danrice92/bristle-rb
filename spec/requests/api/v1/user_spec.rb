require "rails_helper"

describe "User API" do
  context "POST #create" do
    let(:first_name) { "Daniel" }
    let(:last_name) { "Rice" }
    let(:email) { "dan@novumopus.com" }
    let(:user_params) { {user: {first_name: first_name, last_name: last_name, email: email}} }

    it "creates a user with a verification code when the correct credentials are provided" do
      expect do
        post "/api/v1/users", params: user_params
      end.to change { User.count }.by 1

      user = User.find_by_email(email)
      response_body = JSON.parse(response.body).with_indifferent_access

      expect(response_body[:id]).to eq user.id
      expect(response_body[:first_name]).to eq first_name
      expect(response_body[:last_name]).to eq last_name
      expect(response_body[:email]).to eq email

      expect(user.verification_code).to_not be_nil
    end

    it "errors when no email is provided" do
      expect do
        post "/api/v1/users", params: {user: {first_name: first_name, last_name: last_name}}
      end.to_not change { User.count }

      response_body = JSON.parse(response.body).with_indifferent_access

      expect(response_body[:email]).to eq(["can't be blank"])
    end
  end
end
