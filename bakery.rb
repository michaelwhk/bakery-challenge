#!/usr/bin/ruby
require './func'
@products = {
"VS5" =>
      { 3 => 6.99,
        5 => 8.99 },
"MB11" =>
      { 2 => 9.95,
        5 => 16.95,
        8 => 24.95,
        13 => 39.99
		  },
 "CF" =>
      { 3 => 5.95,
        5 => 9.95,
        9 => 19.99
      }
}

print "\n>Please input how many do you want. You can only input number, all symbols will be removed\n"
qty = gets
# remove characters or symbols
qty = qty.gsub!(/\D/, "").to_i

# user feedback display for number input
puts "You input: #{qty}"

#
print "\n>Please input item code.\n"
code = gets
# remove enter and make upper case
code.upcase!.chomp!

# user feedback display for number input
puts "You input: #{code}\n"


if checkInput(qty, code)
  #if qty is enought
  list = packOptions(@products,code)
  tryPrepackList(list, qty, code)
  puts "#{qty} x #{code} = $#{$sum.round(2)}"
else
  puts "please buy more"
end




# list = packOptions(@products,code)
# tryPrepackList(list, 20, code)
