# encoding: utf-8
require "rubygems"
require "dm-core"
require "dm-migrations"
DataMapper.setup(:default, "sqlite:///home/jiayi/Dokumente/web/fukuhara.db")

class Fukuhara 
  include DataMapper::Resource
    
    property :id, Serial, :unique => true
    property :bungo_line, String, :unique => true
    property :translation, String
    property :group, String 
end      


