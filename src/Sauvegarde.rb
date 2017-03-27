load "Joueur.rb"
load "Partie.rb"

class Sauvegarde
	#@jeu : la partie
	#@dateSave
	def Sauvegarde.creer()
		new()
	end

	def initialize
		@jeu=Partie.nouvelle()
	end

	def loadPartie(nomJoueur, nomPartie)
		#loadProfil(nomJoueur)
		@jeu=Marshal.load  File.open(nomPartie+'.txt', 'rb').read
		return @jeu
	end

	#Sauvegarde dans le dossier du profil correspondant.
	def savePartie(nomJoueur, partie, nomPartie)
		#loadProfil(nomJoueur)
		@jeu=partie
		serialized_array = Marshal.dump(@jeu)
		File.open(nomPartie+".txt", 'wb') {|f| f.write(serialized_array) }
		#partie.setSave(nomPartie)
	end

	#Permet de rentrer dans le répertoire du profil
	def loadProfil(nomJoueur)
		Dir.creer(nomJoueur).semettreDansProfil(nomJoueur)
	end

	#Permet d'enregistrer un profil
	def saveProfil()
		Dir.creer(nomJoueur).semettreDansProfil(nomJoueur)
	end
end
