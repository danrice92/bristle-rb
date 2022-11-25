require "rails_helper"

describe "User API" do
  context "POST #create" do
    let(:first_name) { "Daniel" }
    let(:last_name) { "Rice" }
    let(:email) { "dan@novumopus.com" }
    let(:correct_user_params) { {first_name: first_name, last_name: last_name, email: email} }

    def sign_up params, count_change
      user_count = User.count
      post "/api/v1/users", params: {user: params}
      expect(User.count).to eq user_count + count_change

      @user = User.find_by_email(email)
      @response_body = JSON.parse(response.body).with_indifferent_access[:user]
    end

    it "creates a user when the correct credentials are provided" do
      sign_up(correct_user_params, 1)

      expect(@response_body[:id]).to eq @user.id
      expect(@response_body[:first_name]).to eq first_name
      expect(@response_body[:last_name]).to eq last_name
      expect(@response_body[:email]).to eq email
    end

    it "sets email_verified to false until the user verifies" do
      sign_up(correct_user_params, 1)

      expect(@response_body[:email_verified]).to eq false
    end

    it "does not send the verification_code to the client" do
      sign_up(correct_user_params, 1)

      expect(@response_body[:verification_code]).to eq nil
    end

    it "creates a web token with a user ID and expiration encoded" do
      sign_up(correct_user_params, 1)
      decoded_token = @user.decode_json_web_token(@response_body[:authentication_token])[0].with_indifferent_access

      expect(decoded_token[:user_id]).to eq @user.id
      expect(Time.at(decoded_token[:expiration]).month).to eq Time.now.month
      expect(Time.at(decoded_token[:expiration]).day).to eq Time.now.day
      expect(Time.at(decoded_token[:expiration]).year).to eq Time.now.year + 1
    end
    end

    it "errors when no email is provided" do
      sign_up({first_name: first_name, last_name: last_name}, 0)
      response_body = JSON.parse(response.body).with_indifferent_access

      expect(response_body[:errors][:email]).to eq(["can't be blank"])
    end

    it "errors when no first name is provided" do
      sign_up({email: email, last_name: last_name}, 0)
      response_body = JSON.parse(response.body).with_indifferent_access

      expect(response_body[:errors][:first_name]).to eq(["can't be blank"])
    end

    it "errors when no last name is provided" do
      sign_up({email: email, first_name: first_name}, 0)
      response_body = JSON.parse(response.body).with_indifferent_access

      expect(response_body[:errors][:last_name]).to eq(["can't be blank"])
    end
  end
end
