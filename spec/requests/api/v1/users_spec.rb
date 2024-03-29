require "rails_helper"

describe "User API" do
  let(:first_name) { "Daniel" }
  let(:last_name) { "Rice" }
  let(:email) { "dan@novumopus.com" }

  def sign_up params, count_change
    user_count = User.count
    @mail_deliveries = ActionMailer::Base.deliveries.count
    post "/api/v1/users", params: {user: params}
    expect(User.count).to eq user_count + count_change
    expect(response.status).to eq 200

    @user = User.find_by_email(email)
  end

  context "POST #create" do
    context "when the submission is valid" do
      before do
        sign_up({first_name: first_name, last_name: last_name, email: email}, 1)
      end

      it "creates a user" do
        expect(@user.first_name).to eq first_name
        expect(@user.last_name).to eq last_name
        expect(@user.email).to eq email

        expect(response_body[:user][:id]).to eq @user.id
        expect(response_body[:user][:email]).to eq email
        expect(response_body[:user][:first_name]).to eq first_name
        expect(response_body[:user][:last_name]).to eq last_name
      end

      it "sets email_verified to false until the user verifies" do
        expect(@user.email_verified).to eq false
        expect(response_body[:user][:email_verified]).to eq false
      end

      it "does not send the verification_code to the client, but sets it in the database" do
        expect(@user.verification_code.class).to eq String
        expect(response_body[:user][:verification_code]).to eq nil
      end

      it "creates a web token with a user ID and expiration encoded" do
        decoded_id = User.decode_id_from_token(response_body[:user][:authentication_token])

        expect(decoded_id).to eq @user.id
      end

      it "sends an email with the verification code" do
        last_email = ActionMailer::Base.deliveries.last

        expect(ActionMailer::Base.deliveries.count).to eq @mail_deliveries + 1
        expect(last_email.from).to eq ["no-reply@bristle.work"]
        expect(last_email.to).to eq [email]
        expect(last_email.subject).to eq "Welcome to Bristle!"
        expect(email_body(last_email)).to include @user.verification_code
      end
    end

    context "when the email address is malformed" do
      it "downcases and strips the email address" do
        sign_up({first_name: first_name, last_name: last_name, email: "Dan@NovumOpus.com "}, 1)
        user = User.find_by_first_name(first_name)

        expect(user.email).to eq "dan@novumopus.com"
      end
    end

    context "when the submission is invalid" do
      it "errors when no email is provided" do
        sign_up({first_name: first_name, last_name: last_name}, 0)
  
        expect(response_body[:errors][:email]).to eq(["can't be blank"])
      end
  
      it "errors when no first name is provided" do
        sign_up({email: email, last_name: last_name}, 0)
  
        expect(response_body[:errors][:first_name]).to eq(["can't be blank"])
      end
  
      it "errors when no last name is provided" do
        sign_up({email: email, first_name: first_name}, 0)

        expect(response_body[:errors][:last_name]).to eq(["can't be blank"])
      end

      it "does not send an email" do
        sign_up({email: email, first_name: first_name}, 0)

        expect(ActionMailer::Base.deliveries.count).to eq @mail_deliveries
      end
    end
  end

  context "PUT #update" do
    let(:user) { create(
      :user,
      first_name: first_name,
      last_name: last_name,
      email: email,
      email_verified: false
    ) }

    it "sets email_verified to true and clears the code when it was correct" do
      put(
        "/api/v1/users/#{user.id}",
        headers: { HTTP_AUTHENTICATION_TOKEN: user.authentication_token },
        params: { user: {verification_code: user.verification_code} }
      )
      user.reload

      expect(response.status).to eq 200
      expect(user.email_verified).to eq true
      expect(user.verification_code).to eq nil
      expect(response_body[:user][:email_verified]).to eq true
      expect(response_body[:user][:verification_code]).to eq nil
    end

    it "errors if the code is incorrect" do
      put(
        "/api/v1/users/#{user.id}",
        headers: { HTTP_AUTHENTICATION_TOKEN: user.authentication_token },
        params: { user: {verification_code: "ABC123"} }
      )
      user.reload

      expect(response.status).to eq 200
      expect(user.email_verified).to eq false
      expect(user.verification_code).to_not eq nil
      expect(response_body[:errors][:verification_code]).to eq(["didn't match"])
    end

    it "errors if no authentication token is provided" do
      put "/api/v1/users/#{user.id}", params: {user: {verification_code: user.verification_code}}

      expect(response.status).to eq 401
      expect(response_body[:errors][:authentication]).to eq ["must provide a valid authentication token"]
    end
  end

  context "GET #show" do
    let(:user) { create(:user, first_name: first_name, last_name: last_name, email: email) }
    let(:second_user) { create(:user) }

    it "renders the user when the user is logged in" do
      get(
        "/api/v1/users/#{user.id}",
        headers: { HTTP_AUTHENTICATION_TOKEN: user.authentication_token },
      )

      expect(response.status).to eq 200
      expect(response_body[:user][:id]).to eq user.id
      expect(response_body[:user][:email]).to eq email
      expect(response_body[:user][:email_verified]).to eq true
      expect(response_body[:user][:first_name]).to eq first_name
      expect(response_body[:user][:last_name]).to eq last_name
    end

    it "errors when the current_user ID and the URL ID don't match" do
      get(
        "/api/v1/users/#{user.id}",
        headers: { HTTP_AUTHENTICATION_TOKEN: second_user.authentication_token },
      )

      expect(response.status).to eq 403
      expect(response_body[:errors][:authorization]).to eq ["not allowed to perform this action"]
    end

    it "errors if no authentication token is provided" do
      get "/api/v1/users/#{user.id}", params: {}

      expect(response.status).to eq 401
      expect(response_body[:errors][:authentication]).to eq ["must provide a valid authentication token"]
    end

    it "errors if an invalid authentication token is provided" do
      get "/api/v1/users/#{user.id}", params: {authentication_token: "ABCDEFG"}

      expect(response.status).to eq 401
      expect(response_body[:errors][:authentication]).to eq ["must provide a valid authentication token"]
    end
  end
end
