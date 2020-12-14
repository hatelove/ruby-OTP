require 'rspec'

describe 'Holiday' do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  it 'is xmas' do
    holiday = Holiday.new
    response = holiday.say_hello
    expect(response).to eq('Merry Xmas')
  end
end

require_relative '../lib/holiday.rb'
