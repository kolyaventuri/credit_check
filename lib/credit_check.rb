require './lib/Card'

card_number = "4929735477250543"

valid = false

card = Card.new(card_number)

valid = card.valid?

if(valid)
  puts "The number is valid!"
else
  puts "The number is invalid!"
end

# Your Luhn Algorithm Here

# Output
## If it is valid, print "The number is valid!"
## If it is invalid, print "The number is invalid!"
