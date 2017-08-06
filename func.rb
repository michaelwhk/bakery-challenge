#!/usr/bin/ruby

# Result recorder
$num = []

TEST_DATA=[ \
	{total:10,packs:[5,3],numpacks:[2,0]}, \
	{total:14,packs:[8,5,2],numpacks:[1,0,3]}, \
	{total:13,packs:[9,5,3],numpacks:[0,2,1]}, \
	{total:34,packs:[20,16,8,5,2],numpacks:[0,2,0,0,1]}, \
{total:27,packs:[13,8,5,2],numpacks:[1,1,0,3]}, \
{total:19,packs:[8,5,2],numpacks:[1,1,3]} \
]
def testProduct ()
	is_passed = true
	TEST_DATA.each do |test|

		r= results(test[:total],test[:packs])
		is_passed = (r==test[:numpacks]) && is_passed
		if !is_passed
			puts
			puts "---"
			print "#{test}-#{is_passed}-#{r}"
			puts
		end
	end
	return is_passed
end

def lastModResult(r, packs)
  packs.map do |p|
    q, r = r.divmod p
    r
  end
  return r
end

# check if pack list can be assigned without pack roll back
def validMaxPack?(total, packs)
  # packlist in array or not
  if lastModResult(total,packs) > 0
    return false
  else lastModResult(total,packs) == 0
    return true
  end
end

def removeMaxPack(packs)
  # remove max pack in pack list
  if packs.count > 1
    maxPack = packs.max
    newPack = packs - [maxPack]
    return newPack
  else
    return packs
  end
end

def checkInput(num,code)
  product_pack_list = prePackList(@products,code)
  return num >= product_pack_list.min.to_i
end

def prePackList(products,code)
  return products[code].keys.sort { |a, b| b <=> a }
end

def canRollback?(reminder,packs,p,i)
  #余数小于除数则需要从上一位补位 roll back last pack num
  # rollback conddition
  # can be mod if rollback from last pack
  beModIfRollBack = (reminder + packs[i - 1]) % p == 0
  # reminder less than divider and last pack are not times of current pack
  lessAndNotModByLastPack = reminder < p

  if beModIfRollBack or lessAndNotModByLastPack
    true
  else
    false
  end
end

def printResult(result, code, packs)
  result = optimizeResult(packs)
  sum = 0
  count = 0
  result.reverse!.each_with_index do |r,i|
    count += r * @products[code].keys[i]
    sum += r * @products[code].values[i]
    puts "#{r} x @#{@products[code].keys[i]}, $#{@products[code].values[i]}"
  end
  puts "Total: #{count} #{code}, $#{sum.round(2)}"
end

def validCode?(code)
  arraryCode = @products.keys
  if arraryCode.delete(code) != nil
    return true
  else
    return false
  end
end

def optimizeResult(result = $num, packList)
  reversedPackList = packList.reverse!
  result.reverse!.each_with_index do |r,i|
    if r * reversedPackList[i] == reversedPackList[i + 1]
      result[i] = r - r
      result[i+1] = r * reversedPackList[i] / reversedPackList[i + 1]
    end
  end
  return result
  #code
end

def results(num,packs)
  currentPackList = packs
  reminder = num
  packs.each_with_index do |p,i|
    cannotRollback = i <= 0 || $num[i - 1] <= 0
    if validMaxPack?(reminder,currentPackList)
      $num << reminder / p
      currentPackList = removeMaxPack(currentPackList)
      reminder = reminder % p
    else
      unless cannotRollback
        if canRollback?(reminder,packs,p,i)
          puts "runs here"
          reminder = reminder + packs[i - 1]
          $num[i - 1] -= 1
        end
      end
      $num << reminder / p    # push number of pack into $num
      reminder = reminder % p
      currentPackList = removeMaxPack(currentPackList)
    end
  end
  # $num = optimizeResult(packs)
  # final reminder if it could use prepack or not
  return reminder.zero?
end
