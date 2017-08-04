#!/usr/bin/ruby
VS5_PACK = Array[3,5]
MB11_PACK = Array[2,5,8]
CF_PACK = Array[3,5,9]

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

puts testPrepack([0,2],VS5_PACK,10)
puts testPrepack([3,0,1],MB11_PACK,14)
puts testPrepack([1,2,0],CF_PACK,13)
