class Card

  attr_reader :number

  def initialize(card_number)
    @number = card_number
    @digits = card_number.split("") # Split into character array
    @digits.map! { |digit| digit.to_i } # Map each character, turning them into integers.
                                        # I'm letting this be destructive because the digits
                                        # array has to be integers.
  end

  def double_digits(digit_array=@digits)
    # Map every other (odd index) digit from R2L
    # to be 2x its value (part 1 of the Luhn algorithm)

    digit_array.reverse! # Reverse in place so we can go R2L easily
    digit_array.map!.with_index do | digit, index | # Map everything in place
      if(index % 2 == 1)
          digit * 2
      else
        digit
      end
    end

    digit_array.reverse # Put back to normal
  end

  def sum_over_10(digit_array=@digits)
    # Iterate over the digit array and sum every
    # digit 10 or greater
    digit_array.map do | value |
      if value > 9
        value - 9 # [10-18] - 9 == [1, 9] (same as summing 2 digits)
      else
        value
      end
    end
  end

  def sum_array(digit_array=@digits)
    digit_array.reduce(0, :+) # Sum the entire digit array
  end

  def valid?(has_check_digit=false)
    doubled = double_digits # Double every other digit
    summed_over_10 = sum_over_10(doubled) # Sum digits over 10 (Nomenclature...)
    summed_array = sum_array(summed_over_10) # Sum the final array

    summed_array % 10 == 0
  end

end
