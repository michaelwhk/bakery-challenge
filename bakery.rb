#!/usr/bin/ruby
require './func'
require './datasource'

print "\n> Please input how many do you want. You can only input number, all symbols will be removed\n"
qty = gets
# lmite only numbers
qty = qty.gsub!(/\D/, "").to_i

# user feedback display for number input
puts "You were input: #{qty}"
puts "> Please input item code."
code = gets
# remove enter and make upper case
code.upcase!.chomp!

if validCode?(code)
  puts "You were input: #{code}"
  total = qty
  packList = prePackList(@products,code)
  puts "------result-------"
  if checkInput(total, code)
    # if qty is enought
    if results(total,packList)
      printResult(optimizeResult(packList),code, packList)
      # puts "#{optimizeResult(packs)}"
    else
      print "Oops, it seems your are in a special request we cannot sell it by prepack \n"
    end
  else
    puts "Please buy more"
  end
else
  puts "> Not a valid code, Please try again"
end
