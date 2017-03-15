require './plateau'

class Partie
	#@plateau sur lequel on travaille

	# Constructeur d'une partie
	def Partie.nouvelle()
		new()
	end

	def initialize()
		@plateau = Plateau.new()
	end

	def creerPartie()
		@plateau.completeGrille()
	end

	def getPlateau()
		return @plateau
	end

	def afficherPlateau()
		print @plateau
	end

	def setSave(nomPartie)
		f=File.new(nomPartie+".txt", "w+")
		f.write(@plateau)
		f.close
	end

	#nomPartie est le nom du fichier à charger.
	def loadSave(nomPartie)
		f=File.open(nomPartie+".txt", "r")
		@plateau=f.read
		f.close
	end

end