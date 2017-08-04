require './func'

print "\n>Please input how many do you want. You can only input number, all symbols will be removed\n"
qty = gets
# remove characters or symbols
qty = qty.gsub!(/\D/, "")

# user feedback display for number input
puts "You input: #{qty}"

#
print "\n>Please input item code.\n"
code = gets
# remove enter and make upper case
code.upcase!.chomp!

list = packOptions(@products,code)
# keys = packOptions(@products,code)
tryPrepackList(list, 20, code)
# new_list = list - [8]
# print "#{new_list}"
# new_list = new_list - [5]
# print "#{new_list.first}"

# result = show(croissant,"package").keys
# qty = gets
# double = qty.to_i*2

# puts "You got #{qty}, and double is #{double}, thanks"
# puts vegemite_scroll["package"][3]
# puts vegemite_scroll.keys
# puts states['MD']
# puts status
