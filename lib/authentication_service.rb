# frozen_string_literals: true

class AuthenticationService
  attr_reader :profile, :token

  def initialize(profile = nil, token = nil)
    @profile = profile || ProfileDao.new
    @token = token || RasTokenDao.new
  end

  def valid?(account, password)
    password_for_dao = profile.password(account)
    random_code = token.random_token(account)

    valid_password = password_for_dao + random_code
    is_valid = valid_password == password

    if is_valid
      true
    else
      false
    end
  end

end