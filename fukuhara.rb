# encoding: utf-8
require "rubygems"
require "dm-core"
require "dm-migrations"
DataMapper.setup(:default, "sqlite:fukuhara.db")

class Fukuhara 
  include DataMapper::Resource
    
    property :id, Serial
    property :bungo_line, String, :unique => true
    property :translation, String
    property :group, String 

  def self.load_text(text, titel)
    nonebreak_str = text.gsub("\n", "")
    line_break = /[。]/  
    new_str = nonebreak_str.gsub(line_break, "。\n")
    new_str.each_line do |sentence|
      Fukuhara.create(:bungo_line => sentence, :group => titel)
    end
  end
end      


DataMapper.auto_upgrade!
