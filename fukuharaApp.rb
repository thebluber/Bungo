# encoding: utf-8
require "sinatra"
require "./fukuhara.rb"
require "erb"

get "/" do
  redirect "/group"
end

get "/group" do
  @groups = Fukuhara.all.map(&:group).uniq
  erb :start
end

#text hochladen

post "/group" do
  text = params[:txt] 
  titel = params[:titel]
  Fukuhara.load_text(text, titel)
  redirect "/index/" + titel 
end

get "/group/:titel" do
  @sentences = Fukuhara.all(:group => params[:titel])
  erb :fukuhara_index  
end

get "/sentence" do
  @sentences = Fukuhara.all
  erb :fukuhara_index
end

get "/sentence/:id/edit" do 
  @edit_sentence = Fukuhara.get(params[:id])
  erb :fukuhara_edit
end

#Update
put "/sentence/:id/edit" do
  edit_sentence = Fukuhara.get(params[:id])
  edit_sentence.translation = (params[:trans])
  if edit_sentence.save 
    status 201
    redirect to "/group/#{edit_sentence.group}" 
  else
    status 412
    redirect to "/sentence/#{edit_sentence.id}/edit"
  end
end

