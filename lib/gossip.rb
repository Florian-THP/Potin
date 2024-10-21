require 'csv'
class Gossip
  attr_accessor :author, :content, :comments
  @@all_gossips = []
  def initialize(auteur, text, comments = [])
    @author = auteur
    @content = text
    @comments = comments  # Charge les commentaires
  end
  

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content, @comments.join("|")]  
    end
  end
  

  def self.all
    @@all_gossips = []  
    CSV.read("./db/gossip.csv").each do |csv_line|
      comments = csv_line[2] ? csv_line[2].split("|") : []  # Récupère les commentaires
      @@all_gossips << Gossip.new(csv_line[0], csv_line[1], comments)  # Passe les commentaires au constructeur
    end
    return @@all_gossips
  end
  
  
  def self.find(id)
    lien = @@all_gossips[id]
    return lien
  end

  def self.update(id, auteur, text, comments = [])
    gossip_update = @@all_gossips[id]         # recup le potin avec son id
    gossip_update.author = auteur           
    gossip_update.content = text               
    gossip_update.comments = comments 
    # Sauvegarder tous les potins dans le fichier CSV
    CSV.open("./db/gossip.csv", "wb") do |csv| 
      @@all_gossips.each do |gossip|     # Écrire chaque potin
        csv << [gossip.author, gossip.content, gossip.comments.join("|")]
      end
    end
  end

  
  def self.commentaire(id, commentaire)
    gossip_commentaire = @@all_gossips[id]         # récupère le potin avec son id
    gossip_commentaire.comments << commentaire       # ajoute le commentaire

    # Met à jour le potin avec les nouveaux commentaires
    update(id, gossip_commentaire.author, gossip_commentaire.content, gossip_commentaire.comments)
  end
  
end




