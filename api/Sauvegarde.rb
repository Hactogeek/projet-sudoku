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
	def self.loadPartie nomPartie
		return Marshal.load  File.open(nomPartie + '.txt', 'rb').read
	end

	# Méthode qui sauvegarde une partie
	# * [Paramètre :]
	# 				La partie
	# 				Le nom de la partie 
	def Sauvegarde.savePartie(partie, nomPartie)
		serialized_array = Marshal.dump(partie)
		File.open(nomPartie+".txt", 'wb') {|f| f.write(serialized_array) }
	end

	# Méthode qui charge un profil de joueur
	# * [Paramètre :]
	# 				Le nom du joueur
	def Sauvegarde.saveJoueur(joueur, nomJoueur)
		serialized_array = Marshal.dump(joueur)
		File.open(nomJoueur+".txt", 'wb') {|f| f.write(serialized_array) }
	end

	# Méthode qui sauvegarde un profil
	def self.loadJoueur nomJoueur 
		return Marshal.load  File.open(nomJoueur + '.txt', 'rb').read
	end
end
