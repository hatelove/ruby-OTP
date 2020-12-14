require 'rspec'
require_relative '../lib/loads'

def given_password(account, password)
  allow(@profile).to receive(:password).with(account).and_return(password)
end

def given_otp(otp)
  allow(@token).to receive(:random_token).and_return(otp)
end

def should_be_valid(account, password)
  is_valid = @authentication.valid?(account, password)
  expect(is_valid).to be(true)
end

def should_be_invalid(account, password)
  is_valid = @authentication.valid?(account, password)
  expect(is_valid).to be(false)
end

describe 'Authentication' do
  before do
    @profile = double
    @token = double
    @authentication = AuthenticationService.new(@profile, @token)
  end

  it 'should be valid' do
    given_password('joey', '91')
    given_otp('000000')
    should_be_valid('joey', '91000000')
  end

  it 'should be invalid' do
    given_password('joey', '91')
    given_otp('000000')
    should_be_invalid('joey', 'wrong password')
  end

end

