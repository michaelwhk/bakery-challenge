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
  product_pack_list = packOptions(@products,code)
  return num >= product_pack_list.min.to_i
end

def packOptions(products,code)
  return products[code].keys
end


def results(num,packs)
  currentPackList = packs
  reminder = num
  packs.each_with_index do |p,i|
    if validMaxPack?(reminder,currentPackList)
      # 能被当前 pack list 中所有数正好除尽
      $num << reminder / p
      # print ">2 packs = #{currentPackList}, reminder = #{reminder} in TRUE\n"
      currentPackList = removeMaxPack(currentPackList)
      reminder = reminder % p
      # print ">2 after reminder = #{reminder} in TRUE \n"
    else
      # 保证不是第一位或者上一位能够借位
      # 借位逻辑
      unless (i <= 0) || ($num[i - 1] <= 0)
        if (reminder + packs[i - 1]) % p == 0
          reminder = reminder + packs[i - 1]
          $num[i - 1] -= 1
        elsif reminder < p   #余数小于除数则需要从上一位补位 roll back last pack num
          reminder = reminder + packs[i - 1]
          $num[i - 1] -= 1
        end
      end

      $num << reminder / p    # 当前 Pack 的个数注入到数组中
      reminder = reminder % p
      currentPackList = removeMaxPack(currentPackList)
    end
  end

  # if it could use prepack or not
  if reminder > 0
    return false
  else
    return true
  end
end
