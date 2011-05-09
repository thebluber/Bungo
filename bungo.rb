# encoding: utf-8  
def doParse str
 # text = open("fukuhara_ochi.txt").read
  text = str.to_s
  n = /\n/
  nonebreak_str = text.gsub(n, "")

  line_break = /[。]/  
  new_str = nonebreak_str.gsub(line_break, "。\n")
  return new_str  
    puts new_str 
  end 

