#!/usr/bin/ruby

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
    max_pack = packs.max
    new_pack = packs - [max_pack]
    return new_pack
  else
    return packs
  end
end

def checkInput(num,code)
  product_pack_list = prePackList(PRODUCTS,code)
  return num >= product_pack_list.min.to_i
end

def prePackList(products,code)
  return products[code].keys.sort { |a, b| b <=> a }
end

def canRollback?(reminder,packs,p,i)
  # rollback conddition
  # can be mod if rollback from last pack
  be_mod_if_rollback = (reminder + packs[i - 1]) % p == 0
  # reminder less than divider and last pack are not times of current pack
  less_and_not_mod_by_last_pack = reminder < p

  if be_mod_if_rollback or less_and_not_mod_by_last_pack
    true
  else
    false
  end
end

def printResult(result, code, packs)
  # note this are order by asc
  sum = 0
  count = 0
  if result
    result.reverse.each_with_index do |r,i|
      count += r * PRODUCTS[code].keys[i]
      sum += r * PRODUCTS[code].values[i]
      puts "#{r} x @#{PRODUCTS[code].keys[i]}, $#{PRODUCTS[code].values[i]}"
    end
    puts "Total: #{count} #{code}, $#{sum.round(2)}"
  else
    print "Oops, it seems your are in a special request we cannot sell it by prepack \n"
  end
end

def validCode?(code)
  arrary_code = PRODUCTS.keys
  if arrary_code.delete(code) != nil
    return true
  else
    return false
  end
end

def optimizeResult(result, pack_list)
  reversed_pack_list = pack_list.reverse!
  result.reverse!.each_with_index do |r,i|
    if r * reversed_pack_list[i] == reversed_pack_list[i + 1]
      result[i] = r - r
      result[i+1] = r * reversed_pack_list[i] / reversed_pack_list[i + 1]
    end
  end
  return result.reverse!
end

def results(num,packs)
  packs = packs.dup
  $num = []
  current_pack_list = packs
  reminder = num
  packs.each_with_index do |p,i|
    cannotRollback = i <= 0 || $num[i - 1] <= 0
    if validMaxPack?(reminder,current_pack_list)
      $num << reminder / p
      current_pack_list = removeMaxPack(current_pack_list)
      reminder = reminder % p
    else
      unless cannotRollback
        if canRollback?(reminder,packs,p,i)
          reminder = reminder + packs[i - 1]
          $num[i - 1] -= 1
        end
      end
      $num << reminder / p    # push number of pack into $num
      reminder = reminder % p
      current_pack_list = removeMaxPack(current_pack_list)
    end
  end
  firstResult = $num
  if reminder > 0
    return false
  else
    return optimizeResult(firstResult, packs)
  end
end


##################### Greedy functions starts ################################

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

def testProduct ()
	is_passed = true
	passed = 0
	error = 0
	TEST_DATA.each do |test|

		r = iniPrePackNew(test[:packs],test[:total])
		is_passed = (r==test[:numpacks]) && is_passed
		if !is_passed
			error+=1
			puts
			puts "---"
			print "Passed: #{is_passed} - Expected: #{test} - ErrorOutput: #{r}"
			puts
		else
			passed+=1
		end
	end
	t=TEST_DATA.count
	puts "Passed: #{passed}/#{t} Error: #{error}/#{t}"
	return is_passed
end


def prePackNew(packs,total,packs_in=[],packs_pop=[])
	packs = packs.dup
	# print packs
	# print total
	# print packs_in
	# print packs_pop
	# puts

   if  total==0
    	return true
	elsif packs.count<1
		if packs_in.count >0
			r=packs_in.pop
			$num_packs[r]-=1
			# pop out the value less than r from packs_pop
			popout=[]
			packs_pop.reverse.each do |p|
				if p<r
					popout.unshift(packs_pop.pop)
				end
			end
			return prePackNew(popout,total+r,packs_in,packs_pop)
		else
			$num_packs={}
			return false
		end
	elsif (total<packs[0])
		p = packs.shift
		packs_pop.push(p)
		return prePackNew(packs,total,packs_in,packs_pop)
	elsif (total>=packs[0])
		if packs_in.nil?
			packs_in=[]
		end
		packs_in.push(packs[0])
		$num_packs[packs[0]]=($num_packs[packs[0]].nil?)?1:($num_packs[packs[0]]+1)
		return prePackNew(packs,total-packs[0],packs_in,packs_pop)
	end
end

def iniPrePackNew (packs,total,packs_in=[],packs_pop=[])
	num_packs_all=[]
	result = false
	packs_itr = packs.dup
	packs.each_index do |i|
		$num_packs={}
		result= prePackNew(packs_itr,total) || result
		num_packs_all.push($num_packs)
		packs_itr.shift
	end
			# complete the results hash and sort it (desendant)
		num_packs_all=num_packs_all.collect do |n|
			packs.each {|p| n.has_key?(p)?0:n[p]=0}
			n.sort{|x,y|y<=>x}.to_h
		end
		# convert hash to array
		num_packs_a=[]
		num_packs_all.each do |n|
    		if n.values.reduce(:+)>0
    			num_packs_a.push(n.values)
    		end
		end
	# print num_packs_all
	# puts
	if result
		# calculate the sum and find record correspond to the minimum of the sum
		return num_packs_a[num_packs_a.map {|i| i.reduce(:+)}.each_with_index.min[1]]
	else
		return false
	end
end
