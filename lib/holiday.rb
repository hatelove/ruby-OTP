require 'date'

class Holiday

  def say_hello
    today = Date.today

    if today.mon == 12 && today.mday == 25
      return 'Merry Xmas'
    end

    'Today is not Xmas'
  end

end