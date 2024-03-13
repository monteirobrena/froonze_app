class Customer < ApplicationRecord
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  after_validation :set_verified

  def set_verified
    self.verified = 0 if self.errors.details[:email].empty?
  end
end
