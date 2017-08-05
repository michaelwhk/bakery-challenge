#!/usr/bin/ruby
require './func'
require './datasource'
# print "\n>Please input how many do you want. You can only input number, all symbols will be removed\n"
# qty = gets
# remove characters or symbols
# qty = qty.gsub!(/\D/, "").to_i

# user feedback display for number input
# puts "You input: #{qty}"

#
# print "\n>Please input item code.\n"
# code = gets
# remove enter and make upper case
# code.upcase!.chomp!

# user feedback display for number input
# puts "You input: #{code}\n"

code = "MB11"
total = 14
# packs = [5,3]
packs = [8,5,2]
# packs = [9,5,3]
# print "divmod = #{divmod(total,packs)} \n"
print "moddiv = #{lastModResult(total,packs)} \n"
print "validMaxPack? = #{validMaxPack?(total,packs)} \n"
# print "removeMaxPack = #{removeMaxPack(packs)} \n"
puts "------result-------"
# print "#{removeMaxPack([5,2])}"
results(total,packs)
print "#{$num}"



# if checkInput(qty, code)
#   #if qty is enought
#   # list = packOptions(@products,code)
#   # puts validPack?(qty,list)
#   # packResult(qty,list,code)
#   # tryPrepackList(list, qty, code)
#   # puts "#{qty} x #{code} = $#{$sum.round(2)}"
# else
#   puts "please buy more"
# end




# list = packOptions(@products,code)
# tryPrepackList(list, 20, code)
