class User < ApplicationRecord
  validates_presence_of :email, :first_name, :last_name
  before_create :set_verification_code

  def set_verification_code
    self.verification_code = SecureRandom.hex(3).upcase
  end

  def reset_verification_code
    set_verification_code
    save
  end

  def verify_email! params
    return false unless verification_code == params[:verification_code].upcase

    self.email_verified = true
    self.verification_code = nil
    save
  end

  def authentication_token expiration:1.year.from_now
    JWT.encode({user_id: id, expiration: expiration.to_i}, Rails.application.secrets.secret_key_base)
  end

  def self.decode_id_from_token token
    JWT.decode(token, Rails.application.secrets.secret_key_base)[0]["user_id"]
  end
end
