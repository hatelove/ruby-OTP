require 'rspec'
require 'date'

def given_today(month, day)
  allow(Date).to receive(:today).and_return(Date.new(2000, month, day))
end

def response_should_be(expected)
  response = @holiday.say_hello
  expect(response).to eq(expected)
end

describe 'Holiday' do
  before do
    @holiday = Holiday.new
  end
  it 'is xmas' do
    given_today(12, 25)
    response_should_be('Merry Xmas')
  end

  it 'is not xmas' do
    given_today(11, 25)
    response_should_be('Today is not Xmas')
  end

end

require_relative '../lib/holiday.rb'
