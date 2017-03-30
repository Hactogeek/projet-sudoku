##
# Auteur Yassine M'CHAAR
# Version 0.1
# Date : mardi 07 Mars 2017
# Description : fichier contenant la class Joueur d'une partie de Sudoku

load "Dir.rb"

#
# Joueur, un joueur de sudoku
# * *Variable*	:
#    - +pseudo+ -> pseudo du joueur
# * *Heritage*	: Aucun lien
#
class Joueur
	#pseudo du joueur
	@pseudo
	#identifiant du joueur
	@@identifiant=0
	# repertoire (profil)
	#@d

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
		
		#@d=Dir.creer(unPseudo)
		#@d.semettreDansProfil(unPseudo)
		#@d.supprimerProfil(unPseudo)	
	end

	#Créer un dossier ayant comme nom @pseudo. Retourne true si le dossier existe déjà. False sinon, et le créé.
	def creerProfil()
		currentPath=Dir.pwd
		Dir.chdir(currentPath+"/profil")
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
