load "Dir.rb"

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

	
	# * *Description*:
	# 
	# méthode de création d'un joueur
	#
	# * *Paramètre*:
	#
	# - +unPseudo+ -> pseudo du joueur 
	#
	# * *Exemple*:
	#
	# unJoueur=Joueur.creer("Yassine")
	#
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



	# * *Description*:
	# 
	# méthode qui permet de donner le pseudo du joueur.
	#
	# * *Exemple*:
	#
	# Joueur.getPseudo()
	#
	def getPseudo()
		return @pseudo
	end
	
	# * *Description*:
	# 
	# méthode qui permet de donner l’identifiant du joueur.
	#
	# * *Exemple*:
	#
	# Joueur.getIdentifiant()
	#
	def getIdentifiant()
		return @@identifiant
	end 

	# * *Description*:
	#
	# méthode permettant d'ajouter un score dans les stats du joueur, ajout seulement si le score est passé en paramètre est meilleur que celui contenu dans le tableau, renvoie true si le score a bien été ajouté dans le tableau
	#
	# * *Paramètre*:
	#
	# - +unScore+ -> score à ajouter
	# - +niveauDifficulte+ -> niveau de difficulté de la partie où a été réalisé le score
	#
	# * *Exemple*:
	#
	# unJoueur.ajoutScrore(score,2)
	#
	def ajoutScore(unScore, niveauDifficulte)
		indice=niveauDifficulte-2
		if(@tabScore[indice] < unScore)
			@tabScore[indice]=unScore
		end
	end
	# * *Description*:
	#
	# méthode permettant de donner un score du joueur 
	# * *Paramètre*:
	#
	# - +niveauDifficulte+ -> niveau de difficulté de la partie où a été réalisé le score
	#
	# * *Exemple*:
	#
	# unJoueur.getScoreJoueur(2)
	#
	def getScoreJoueur(niveauDifficulte)
		return @tabScore[niveauDifficulte]
	end 

	# * *Description*:
	# 
	# méthode d'affichage d'un joueur
	#
	# * *Exemple*:
	#
	# unJoueur.to_s
	# puts unJoueur
	#
	def to_s
		"Joueur : #{@pseudo} "
	end
	
	# * *Description*:
	# 
	# méthode de comparaison d'un joueur
	#
	# * *Paramètre*:
	#
	# - +unJoueur+ -> joueur à comparer
	#
	# * *Exemple*:
	#
	# unJoueur > unAutreJoueur
	# unJoueur == unAutreJoueur
	# unJoueur <= unAutreJoueur
	#
	def <=>(unJoueur)
		return self.pseudo==unJoueur.pseudo
	end	

end


#j= Joueur.creer("modira")

#d = Dir.creer(j.getPseudo())
#d.semettreDansProfil(j.getPseudo())


