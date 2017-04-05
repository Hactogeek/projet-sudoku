# Dir, repertoire de creation de profil(joueur)
# * *Variable*	:
#    - +pseudo+ -> pseudo du joueur
# * *Heritage*	: Aucun lien
#
class Dir
	# méthode de création d'un repertoire(profil)
	#
	# * [Paramètre :]
	# 				un pseudo	 
	def Dir.creer(unPseudo)
		new(unPseudo)
	end 	

	def initialize(unPseudo)
		#Dir.chdir("/Users/mac/Documents/projet-sudoku/projet-sudoku/src/profil")
		Dir.chdir("profil")
		if(!Dir.exist?(unPseudo))	
			Dir.mkdir(unPseudo)
		end
		Dir.chdir("../")
	end 

	# méthode qui permet de se mettre dans un repertoire(profil) 
	# * [Paramètre :]
	# 				pseudo
	def semettreDansProfil(unPseudo)
		Dir.chdir("profil/#{unPseudo}")
	end 

	# méthode qui permet de supprimer un repertoire (profil)
	# * [Paramètre :]
	# 				pseudo	
	def supprimerProfil(unPseudo)
		Dir.chdir("profil")
		Dir.rmdir(unPseudo)
		Dir.chdir("../")
	end

end