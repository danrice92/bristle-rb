require "rails_helper"

describe "Session API" do 
  context "POST #create" do
    let(:user) { create(:user, first_name: "Daniel", last_name: "Rice", email: "dan@novumopus.com") }

    it "sends an authentication token" do
      post "/api/v1/sessions", params: {session: {email: user.email}}
      expect(response.status).to eq 200

      decoded_id = User.decode_id_from_token(response_body[:user][:authentication_token])
      expect(decoded_id).to eq user.id
    end

    it "sends an email with the new verification code" do
      original_verification_code = user.verification_code
      mail_deliveries = ActionMailer::Base.deliveries.count

      post "/api/v1/sessions", params: {session: {email: user.email}}
      user.reload
      last_email = ActionMailer::Base.deliveries.last

      expect(response.status).to eq 200
      expect(user.verification_code).to_not eq original_verification_code
      expect(ActionMailer::Base.deliveries.count).to eq mail_deliveries + 1
      expect(last_email.from).to eq ["no-reply@bristle.work"]
      expect(last_email.to).to eq [user.email]
      expect(last_email.subject).to eq "Bristle login attempt"
      expect(email_body(last_email)).to include user.verification_code
    end

    it "errors when a user with the email was not found" do
      post "/api/v1/sessions", params: {session: {email: "nope@nope.com"}}

      expect(response.status).to eq 200
      expect(response_body[:errors][:email]).to eq ["not found"]
    end
  end
end
