
##
# Auteur Yassine M'CHAAR
# Version 0.1
# Date : mardi 13 Mars 2017
# Description : fichier contenant la class Dir d'une partie de Sudoku



#
# Dir, repertoire de creation de profil(joueur)
# * *Variable*	:
#    - +pseudo+ -> pseudo du joueur
# * *Heritage*	: Aucun lien
#
class Dir


	# * *Description*:
	# 
	# méthode de création d'un repertoire(profil)
	#
	# * *Paramètre*:
	#
	# - +unPseudo+ -> pseudo du joueur 
	#
	# * *Exemple*:
	#
	# unDossier=Dir.creer("Yassine")
	#
	def Dir.creer(unPseudo)
		new(unPseudo)
	end 	
	def initialize(unPseudo)
		Dir.chdir("/Users/mac/Documents/projet-sudoku/projet-sudoku/src/profil")
		if(!Dir.exist?(unPseudo))	
			Dir.mkdir(File.join(Dir.getwd, unPseudo), 0700)		
		end
		
	end 
	# * *Description*:
	# 
	# méthode qui permet de se mettre dans un repertoire(profil) 
	#
	# * *Paramètre*:
	#
	# - +unPseudo+ -> pseudo du joueur 
	#
	# * *Exemple*:
	#
	# dossier.semettreDansProfil("Yassine")
	#
	def semettreDansProfil(unPseudo)
		Dir.chdir("/Users/mac/Documents/projet-sudoku/projet-sudoku/src/profil/#{unPseudo}")
	end 
	# * *Description*:
	# 
	# méthode qui permet de supprimer un repertoire (profil)
	#
	# * *Paramètre*:
	#
	# - +unPseudo+ -> pseudo du joueur 
	#
	# * *Exemple*:
	#
	# profil.supprimerProfil("Yassine")
	#
	def supprimerProfil(unPseudo)
		Dir.chdir("/Users/mac/Documents/projet-sudoku/projet-sudoku/src/profil")
		Dir.rmdir(unPseudo) 
	end

end