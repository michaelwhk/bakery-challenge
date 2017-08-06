#!/usr/bin/ruby

# Result recorder
$num = []

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
  lessAndNotModByLastPack = reminder < p && (packs[i-1] % p != 0)

  if beModIfRollBack or lessAndNotModByLastPack
    true
  else
    false
  end
end

def printResult(result = $num, code)
  sum = 0
  count = 0
  result.reverse!.each_with_index do |r,i|
    count += r
    sum += r * @products[code].values[i]
    puts "#{r} x @#{@products[code].keys[i]}, $#{@products[code].values[i]}"
  end
  puts "Total: #{count}, #{sum}"
end


def results(num,packs)
  currentPackList = packs
  reminder = num

  packs.each_with_index do |p,i|

    cannotRollback = i <= 0 || $num[i - 1] <= 0

    if validMaxPack?(reminder,currentPackList)
      # 能被当前 pack list 中所有数正好除尽
      $num << reminder / p
      # print ">2 packs = #{currentPackList}, reminder = #{reminder} in TRUE\n"
      currentPackList = removeMaxPack(currentPackList)
      reminder = reminder % p
      # print ">2 after reminder = #{reminder} in TRUE \n"
    else
      unless cannotRollback
        if canRollback?(reminder,packs,p,i)
          reminder = reminder + packs[i - 1]
          $num[i - 1] -= 1
        end
      end
      $num << reminder / p    # 当前 Pack 的个数注入到数组中
      reminder = reminder % p
      currentPackList = removeMaxPack(currentPackList)
    end
  end
  # final reminder if it could use prepack or not
  return reminder.zero?
end
