#!/usr/bin/ruby
# 3 @ $6.99 5 @ $8.99
VS5_PACK = Array[3,5]
# 2 @ $9.95 5 @ $16.95 8 @ $24.95
MB11_PACK = Array[2,5,8]
# 3 @ $5.95 5 @ $9.95 9 @ $16.99
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

# 10 VS5 $17.98
#   2 x 5 $8.99
#puts testPrepack([0,2],VS5_PACK,10)

# 14 MB11 $54.8
#   1 x 8 $24.95
#   3 x 2 $9.95
#puts testPrepack([3,0,1],MB11_PACK,14)

#  13 CF $25.85
#   2 x 5 $9.95
#   1 x 3 $5.95
#puts testPrepack([1,2,0],CF_PACK,13)


def tryPrePack(packs,total)
  packs = packs.dup
  if (packs.count<1)
    return false
  elsif (total==packs[-1])
		$num_packs[packs[-1].to_s]+=1
		return true
  elsif (total<packs[-1])
    packs.pop(1)
    return prePack(packs,total)
	elsif (total>packs[-1])
	  $num_packs[packs[-1].to_s] +=1
	  return tryPrePack(packs,total-packs[-1])
  end
end


def prePack(packs,total)
  packs = packs.dup
	if (packs.count<1)
    return false
   else
    packs.each {|i| $num_packs[i.to_s]=0}
    result = tryPrePack(packs,total)
    if result==false
     $num_packs[packs[-1].to_s]=0
     packs.pop(1)
     return prePack(packs,total)
    else
     return true
    end
   end
end

$num_packs={}
puts prePack(VS5_PACK,10)
puts $num_packs
puts "Test Success:"+testPrepack($num_packs.values,VS5_PACK,10).to_s


$num_packs={}
puts prePack(MB11_PACK,14)
puts $num_packs
puts "Test Success:"+testPrepack($num_packs.values,MB11_PACK,14).to_s

$num_packs={}
puts prePack(CF_PACK,13)
puts $num_packs
puts "Test Success:"+testPrepack($num_packs.values,CF_PACK,13).to_s
