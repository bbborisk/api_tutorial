class AccessToken < ApplicationRecord
  belongs_to :user
  validates :token, presence: true, uniqueness: true
  after_initialize :generate_token

  private

  def generate_token
      loop do
        #iz nekog razloga radi samo prvi uslov
        break if token.present? # && AccessToken.exists?(token: token)
        self.token = SecureRandom.hex(10)
      end
  end
end
