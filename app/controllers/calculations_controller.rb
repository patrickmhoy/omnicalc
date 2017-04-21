class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    #\n \t \r and spaces

    @word_count = @text.split.count

    @character_count_with_spaces = @text.strip.length

    @character_count_without_spaces = @text.gsub("\n","").gsub(" ","").gsub("\t","").gsub("\r","").length

    @occurrences = @text.downcase.gsub(/[^a-z0-9\s]/i, "").split.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    @monthly_rate = (@apr/12)/100
    @num_payments = @years*12
    @monthly_payment = (@monthly_rate)/(1-(1+@monthly_rate)**(-@num_payments))*@principal

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @starting - @ending
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.sort.first

    @maximum = @numbers.sort.last

    @range = (@numbers.sort.last) - (@numbers.sort.first)

    if @numbers.count.odd?
        middle = (@numbers.count-1)/2
      @median = @numbers.sort[middle]

    else
      first=(@numbers.count/2)-1
      second=(@numbers.count/2)
      @median = (@numbers.sort[first]+@numbers.sort[second])/2

end

    @sum = @numbers.sum

    @mean = (@numbers.sum)/(@numbers.count)

#variance

    squares = []

    @numbers.each do |num|

      num_squared = num**2

      squares.push(num_squared)

    end

    @variance = (squares.sum/@numbers.count)-(@mean**2)

    @standard_deviation = @variance**(0.5)

    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h}
    @mode = @numbers.max_by { |v| freq[v]}

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
