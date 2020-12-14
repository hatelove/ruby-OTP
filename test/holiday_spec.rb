require 'rspec'
require 'date'

describe 'Holiday' do
  before do
    # Do nothing
  end

  it 'is xmas' do
    allow(Date).to receive(:today).and_return(Date.new(2000, 12, 25))
    holiday = Holiday.new
    response = holiday.say_hello
    expect(response).to eq('Merry Xmas')
  end
end

require_relative '../lib/holiday.rb'
