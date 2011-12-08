class Client < ActiveRecord::Base

  default_value_for :app_id do random_string(24) end

  default_value_for :app_secret do random_string(48) end

  def self.authenticate(app_id, app_secret)
    where(["app_id = ? AND app_secret = ?", app_id, app_secret]).first
  end

  def self.random_string(length)
    raise ArgumentError, "length must be dividable by 4" unless (length % 4).zero?
    Base64.urlsafe_encode64(SecureRandom.random_bytes(length/4*3))
  end
end
