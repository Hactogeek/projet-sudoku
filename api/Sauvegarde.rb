Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../vues/*.rb'].each {|file| require file }

class Sauvegarde
	#@jeu : la partie
	#@dateSave
	def Sauvegarde.creer()
		new()
	end

	def initialize
	end

	# Méthode qui charge une partie
	# * [Paramètre :]
	# 				Le nom de la partie
	#
	# * [Retourne :]
	# 				La partie
	def Sauvegarde.loadPartie(nomPartie)
		@jeu=Marshal.load  File.open(nomPartie + '.txt', 'rb').read
		return @jeu
	end

	# Méthode qui sauvegarde une partie
	# * [Paramètre :]
	# 				La partie
	# 				Le nom de la partie 
	def Sauvegarde.savePartie(partie, nomPartie)
		@jeu=partie
		serialized_array = Marshal.dump(@jeu)
		File.open(nomPartie+".txt", 'wb') {|f| f.write(serialized_array) }
	end

	# Méthode qui charge un profil de joueur
	# * [Paramètre :]
	# 				Le nom du joueur
	def loadProfil(nomJoueur)
		Dir.creer(nomJoueur).semettreDansProfil(nomJoueur)
	end

	# Méthode qui sauvegarde un profil
	def saveProfil()
		Dir.creer(nomJoueur).semettreDansProfil(nomJoueur)
	end
end
