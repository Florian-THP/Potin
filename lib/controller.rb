require 'sinatra'
require 'gossip'

class ApplicationController < Sinatra::Base


  post '/gossips/save/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/:id' do
    Gossip.all # Charge tous les potins
    id = params['id'].to_i
    gossip = Gossip.find(id)
    erb :show, locals: { gossip: gossip, id: id } 
  end

  get '/gossips/:id/edit/' do
    id = params['id'].to_i
    gossip = Gossip.find(id)
    erb :edit, locals: { gossip: gossip, id: id } 
  end
  
  
  get '/gossip/new/' do
    erb :new_gossip
  end
  
  post '/gossips/modif/:id' do
    id = params['id'].to_i
    auteur = params['gossip_author']
    text = params['gossip_content']
    Gossip.update(id, auteur, text) # Appelle la méthode update
    redirect "/gossips/#{id}"        # Rediriger vers la page du potin modifié
  end

  post '/gossips/:id/comentaire/edit' do
    id = params['id'].to_i
    comment = params['commentaire']  # Récupère le commentaire
    Gossip.commentaire(id, comment)  # Passe l'id et le commentaire à la méthode
    redirect "/gossips/#{id}"  # Redirige vers la page du potin pour voir le commentaire ajouté
  end
  
  
  
end