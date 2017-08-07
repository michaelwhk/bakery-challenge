#!/usr/bin/ruby
require_relative 'func/func'
require_relative './datasource'

# print "min_packs_num=#{iniPrePackNew([25,16,8,5,2],27)}\n"
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
  pack_list = prePackList(PRODUCTS,code)
  puts "------result-------"
  if checkInput(total, code)
      printResult(iniPrePackNew(pack_list,total),code,pack_list)
  else
      puts "Please buy more"
  end
else
  puts "> Not a valid code, Please try again"
end
