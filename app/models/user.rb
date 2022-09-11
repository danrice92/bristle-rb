class User < ApplicationRecord
  validates_presence_of :email
  before_create :set_verification_code

  def set_verification_code
    self.verification_code = SecureRandom.uuid
  end
end
