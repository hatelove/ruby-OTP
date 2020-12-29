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

RSpec::Matchers.define :message_matcher do |account, status|
  match { |message| message.include?(account) && message.include?(status) }
end

def when_invalid(account)
  given_password(account, '91')
  given_otp('000000')
  @authentication.valid?(account, 'wrong password')
end

def should_notify(account, status)
  expect(@notification).to have_received(:save)
                             .with(message_matcher(account, status))
                             .once
end

describe 'Authentication' do
  before do
    @profile = double
    @token = double
    @notification = spy
    @authentication = AuthenticationService.new(@profile, @token, @notification)
  end

  describe '#valid' do
    context 'when valid' do
      it 'should return true' do
        given_password('joey', '91')
        given_otp('000000')
        should_be_valid('joey', '91000000')
      end
    end

    context 'when invalid' do
      it 'should return false' do
        given_password('joey', '91')
        given_otp('000000')
        should_be_invalid('joey', 'wrong password')
      end

      it 'should notify user' do
        when_invalid('joey')
        should_notify('joey', 'login failed')
      end
    end
  end

end

