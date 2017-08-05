#!/usr/bin/ruby
require './func'
require './datasource'

print "\n>Please input how many do you want. You can only input number, all symbols will be removed\n"
qty = gets
# lmite only numbers
qty = qty.gsub!(/\D/, "").to_i

# user feedback display for number input
puts "You input: #{qty}"

#
# print "\n>Please input item code.\n"
# code = gets
# remove enter and make upper case
# code.upcase!.chomp!

# user feedback display for number input
# puts "You input: #{code}\n"

code = "MB11"
total = qty

# packs = [8,5,2]
# packs = [9,5,3]
totalPackList = packOptions(@products,code)
packs = [5,3]
# print "moddiv = #{lastModResult(total,packs)} \n"
# print "validMaxPack? = #{validMaxPack?(total,packs)} \n"
# print "removeMaxPack = #{removeMaxPack(packs)} \n"
puts "------result-------"
if checkInput(qty, code)
  # if qty is enought
  if results(total,packs)
    print "> #{$num}\n"
  else
    print "Oops, it seems your are in a special request we cannot sell it by prepack \n"
  end

else
  puts "please buy more"
end




# list = packOptions(@products,code)
# tryPrepackList(list, 20, code)
