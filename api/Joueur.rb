Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../vues/*.rb'].each {|file| require file }
#
# Joueur, un joueur de sudoku
# * *Variable*	:
#    - +pseudo+ -> pseudo du joueur
#    - +tabScore+ -> le tableau du score  du joueur
# * *Heritage*	: Aucun lien
#
class Joueur
	#pseudo du joueur
	@pseudo
	#identifiant du joueur
	@@identifiant=0
	@tabScore
	

	attr_accessor:tabScore
	attr_accessor:d

	attr_reader :pseudo
	private_class_method :new

	# méthode de création d'un joueur
	# * [Paramètre :]
	# 				pseudo
	def Joueur.creer(unPseudo)
		new(unPseudo)
	end
	def initialize(unPseudo)
		@pseudo=unPseudo
		@@identifiant+=1
		@tabScore=Array.new(3){ |i|
			i=0
		}	
		#@d=Dir.creer(unPseudo)

		#@d.semettreDansProfil(unPseudo)
		#@d.supprimerProfil(unPseudo)	
	end
	
	#Créer un dossier ayant comme nom @pseudo. Retourne true si le dossier existe déjà. False sinon, et le créé.
	def creerProfil()
		Dir.chdir(Dir.pwd+"/profil")
		if(Dir.exist?(@pseudo))
			Dir.chdir("../")
		 	return true
		else
			Dir.mkdir(@pseudo)
			Dir.chdir(@pseudo)
			return false
		end
	end

	# méthode qui permet de donner le pseudo du joueur.
	def getPseudo()
		return @pseudo
	end
	
	# méthode qui permet de donner l’identifiant du joueur.
	def getIdentifiant()
		return @@identifiant
	end 

	# méthode permettant d'ajouter un score dans les stats du joueur, ajout seulement si le score est passé en paramètre est meilleur que celui contenu dans le tableau, renvoie true si le score a bien été ajouté dans le tableau
	# * [Paramètre :]
	# 				unScore score à ajouter
	# 				niveauDifficulte niveau de difficulté de la partie où a été réalisé le score
	def ajoutScore(unScore, niveauDifficulte)
		indice=niveauDifficulte-2
		if(@tabScore[indice] < unScore)
			@tabScore[indice]=unScore
		end
	end

	# méthode permettant de donner un score du joueur 
	# * [Paramètre :]
	# 				niveauDifficulte niveau de difficulté de a partie où a été réalisé le score	
	def getScoreJoueur(niveauDifficulte)
		return @tabScore[niveauDifficulte]
	end 

	# methode qui permet de modifier les statistiques du joueur
	# * [Paramètre :]
	# 				oldStat les anciennes statistiques qui sont sauvegardées dans un fichier  
	# 				date date du jour 
	# 				score score du joueur
	def modifierStat(oldStat, date, score)
		@stat= Hash.new() 
		@stat=oldStat
		if(!@stat.value?(score))
			@stat[date]=score
		end 
		
	end 
	
	# methode qui permet d'afficher les statistiques du joueur
	def afficherStat
		 @stat.each{ |key,valeur|
			print key ," => " ,valeur," points \n"

		}
	end 
	
	# méthode d'affichage d'un joueur
	def to_s
		"Joueur : #{@pseudo} "
	end

	# méthode de comparaison d'un joueur
	# * [Paramètre :]
	# 				unJoueur joueur à comparer
	def <=>(unJoueur)
		return self.pseudo==unJoueur.pseudo
	end	

end



