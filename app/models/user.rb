class User < ApplicationRecord
  validates_presence_of :email, :first_name, :last_name
  before_create :set_verification_code

  def set_verification_code
    self.verification_code = SecureRandom.hex(3).upcase
  end

  def encode_json_web_token expiration:1.year.from_now
    payload = {user_id: id, expiration: expiration.to_i}
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def decode_json_web_token token
    JWT.decode(token, Rails.application.secrets.secret_key_base)
  end
end
