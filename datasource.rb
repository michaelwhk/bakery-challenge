#!/usr/bin/ruby
PRODUCTS = {
"VS5" =>
      { 3 => 6.99,
        5 => 8.99 },
"MB11" =>
      { 2 => 9.95,
        5 => 16.95,
        8 => 24.95
		  },
 "CF" =>
      { 3 => 5.95,
        5 => 9.95,
        9 => 19.99
      }
}

TEST_DATA=[ \
	{total:10,packs:[5,3],numpacks:[2,0]}, \
	{total:14,packs:[8,5,2],numpacks:[1,0,3]}, \
	{total:13,packs:[9,5,3],numpacks:[0,2,1]}, \
	{total:34,packs:[20,16,8,5,2],numpacks:[0,2,0,0,1]}, \
  {total:27,packs:[13,8,5,2],numpacks:[1,1,0,3]}, \
  {total:19,packs:[8,5,2],numpacks:[1,1,3,]}, \
  {total:22,packs:[16,8,5,2],numpacks:[1,0,0,3,]} \
]

VS5_PACK = Array[3,5]
MB11_PACK = Array[2,5,8]
CF_PACK = Array[3,5,9]

# expected result
VS5_RESULT = [0,2]
MB11_RESULT = [3,0,1]
CF_RESULT = [1,2,0]
