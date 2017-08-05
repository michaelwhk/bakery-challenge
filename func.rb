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
  # if packs.count > 1
    if lastModResult(total,packs) > 0
      return false
    else lastModResult(total,packs) == 0
      return true
    end
  # else
  #   if total % packs.first  > 0
  #     return false
  #   else total % packs.first  == 0
  #     return true
  #   end
  # end
end

# def onlySmaillPack?(total, packs)
#   if total % packs.first > 0 && total % packs[1] == 0
#     return true
#   end
# end

# def rollBackModdiv(r, packs)
#   maxPack = packs.max
#   packs.map do |p|
#     q, r = r.divmod p
#     if p == maxPack
#       r = r + p
#     else
#       r
#     end
#   end
#   if r ==0
#     return true
#   else
#     return false
#   end
#   #code
# end

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



def results(num,packs)
  currentPackList = packs
  reminder = num
  nextPackList = removeMaxPack(currentPackList)
  nextReminder = reminder % packs.max
  # print ">1 packs = #{currentPackList}, reminder = #{reminder} \n"
  packs.each_with_index do |p,i|
    if validMaxPack?(reminder,currentPackList)
      # 能被当前 pack list 中所有数正好除尽
      # print "current pack is @#{p}, x #{reminder / p} \n"
      $num << reminder / p
      print ">2 packs = #{currentPackList}, reminder = #{reminder} in TRUE\n"
      currentPackList = removeMaxPack(currentPackList)
      reminder = reminder % p
      print ">2 after reminder = #{reminder} in TRUE \n"
    else
      # 如果不能被除尽, 一次所有数
      # print ">3 before reminder = #{reminder}, last pack: #{packs[i - 1]} p: #{p}  !\n"

      # 借位后正好能除尽，条件为非第一位数，前一位能借位

      # 保证不是第一位或者上一位能够借位
      # 借位逻辑
      unless (i <= 0) || ($num[i - 1] <= 0)
        if (reminder + packs[i - 1]) % p == 0
          reminder = reminder + packs[i - 1]
          $num[i - 1] -= 1

        # 前一位可以借位
        elsif reminder < p   #余数小于除数则需要从上一位补位 roll back last pack num
          reminder = reminder + packs[i - 1]
          $num[i - 1] -= 1
        end
      end

      # 当前 Pack 的个数注入到数组中
      $num << reminder / p
      # print ">3 packs = #{currentPackList}\n"
      reminder = reminder % p
      currentPackList = removeMaxPack(currentPackList)
      # print ">3 after reminder = #{reminder} \n"
    # else
    end
  end
end

=begin  older version
def checkInput(num,code)
  product_pack_list = packOptions(@products,code)
  return num >= product_pack_list.min.to_i
end

def packOptions(products,code)
  return products[code].keys
end

def tryPrepackList(list,total,code)
  # puts "called"
  if list.count > 1
    descList = list.sort!{|x,y| y<=>x}
    # print "descList: #{descList}, total: #{total} \n"
    # more that biggest pack number
    bigger_amount = total / descList.first
    reminder_of_bigger_pack = total % descList.first

    if reminder_of_bigger_pack > 0
      # reminder & descList[1] == 0
      if reminder_of_bigger_pack % descList[1] == 0
        small_amount = reminder_of_bigger_pack / descList[1]
        printIfExist(bigger_amount, descList.first, code)
        # puts "#{bigger_amount} x @#{descList.first} | 1"
        printIfExist(small_amount, descList[1], code)
        # puts "#{small_amount} x @#{descList[1]} | 2"
        return true
      else
      # reminder & descList[1] != 0 and need to process
        # remove first element
        new_list = descList - [descList.first]
        # deduce bigger amount
        new_total = total % descList.first
        if tryPrepackList(new_list,new_total,code)   # new_list = [5,2], new_total =
          printIfExist(bigger_amount, descList.first, code)
          # puts "#{bigger_amount} x @#{descList.first} | 3"
        else
          # roll back a the first element and recalculate total
          new_total = total
          tryPrepackList(new_list,new_total,code)
        end
      end

    elsif reminder_of_bigger_pack == 0
      # print "#{descList}\n"
      printIfExist(bigger_amount, descList.first, code)
      # puts "#{bigger_amount} x #{descList.first} | 4"
    end

  elsif list.count == 1
    if total % list.first == 0
      printIfExist(total / list.first, list.first, code)
      # puts "#{total / list.first} x @#{list.first} | 5"
      return true
    else total % list.first != 0
      return false
    end
  end
end


def printIfExist(amount, packs, code)
  price = @products[code][packs]
  if amount > 0
    subtotal = amount * price
    $sum += subtotal
    puts "#{amount} x @#{packs} $#{@products[code][packs]}"
  end
end

=end
