require 'rspec'
require_relative '../lib/loads'

describe 'Authentication' do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end
  it 'should be valid' do
    profile = FakeProfile.new
    token = FakeToken.new
    authentication = AuthenticationService.new(profile, token)
    is_valid = authentication.valid?('joey', '91000000')
    expect(is_valid).to be(true)
  end

end

class FakeToken < RasTokenDao
  def random_token(account)
    return '000000'
  end
end

class FakeProfile < ProfileDao
  def password(account)
    if account == 'joey'
      return '91'
    end
    return ''
  end
end