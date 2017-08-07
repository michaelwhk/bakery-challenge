#!/usr/bin/ruby

def testPrepack (nums,packs,total)
  # if the member of nums and packs mismatched
  if nums.count != packs.count
    return false
  else
    cal_total = 0
    packs.each_index {|i| cal_total+=nums[i]*packs[i]}
    return cal_total==total
  end
end

# puts testPrepack([0,2],VS5_PACK,10)
# puts testPrepack([3,0,1],MB11_PACK,14)
# puts testPrepack([1,2,0],CF_PACK,13)


# TEST
def testBakery ()
	is_passed = true
	passed = 0
	error = 0
	TEST_DATA.each do |test|

		r= results(test[:total],test[:packs])
		is_passed = (r==test[:numpacks]) && is_passed
		if !is_passed
			error+=1
			puts
			puts "--- Error on Loop Bakery ---"
			print "Passed: #{is_passed} - Expected: #{test} - ErrorOutput: #{r}"
			puts
		else
			passed+=1
		end
	end
	t=TEST_DATA.count
  puts "--- Test result for Loop Bakery ---"
	puts "Passed: #{passed}/#{t} Error: #{error}/#{t}"
	return is_passed
end

def testGreedy ()
	is_passed = true
	passed = 0
	error = 0
	TEST_DATA.each do |test|

		r = iniPrePackNew(test[:packs],test[:total])
		is_passed = (r==test[:numpacks]) && is_passed
		if !is_passed
			error+=1
			puts
			puts "--- Error on Greedy Bakery ---"
			print "Passed: #{is_passed} - Expected: #{test} - ErrorOutput: #{r}"
			puts
		else
			passed+=1
		end
	end
	t=TEST_DATA.count
  puts "--- result Test for Greedy Bakery ---"
	puts "Passed: #{passed}/#{t} Error: #{error}/#{t}"
	return is_passed
end
