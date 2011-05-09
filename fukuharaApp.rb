# encoding: utf-8
require "sinatra"
require "./fukuhara.rb"
require "erb"

get "/" do
  @groups = Fukuhara.all.map(&:group).uniq
  erb :start
end

#text hochladen

post "/" do
  n = /\n/
  text = (params[:txt]).to_s
  nonebreak_str = text.gsub(n, "")
  line_break = /[。]/  
  new_str = nonebreak_str.gsub(line_break, "。\n")
  new_str.each_line do |sentence|
  Fukuhara.create(:bungo_line => sentence, :group => params[:titel])
  end
 
    redirect "/index/" + text
end

get "/all/index" do
  @sentences = Fukuhara.all

  erb :fukuhara_index
end

get "/edit/:id" do 
  @edit_sentence = Fukuhara.get(params[:id])
  erb :fukuhara_edit
end

#Update
put "/edit/:id" do
  edit_sentence = Fukuhara.get(params[:id])
  edit_sentence.translation = (params[:trans])
  if edit_sentence.save 
    status 201
    redirect "/all/index" 
  else
    status 412
    redirect "/edit/" + edit_sentence.id.to_s
  end
end

get "/index/:eachText" do
  @sentences = Fukuhara.all(:group => params[:eachText])
  erb :fukuhara_index  
end
DataMapper.auto_upgrade!
