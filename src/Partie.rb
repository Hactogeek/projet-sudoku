require './Plateau'
require './Aide'
require './GestionMemento'

class Partie
	#@plateau sur lequel on travaille

	# Constructeur d'une partie
	def Partie.nouvelle()
		new()
	end

	def initialize()
		@plateau = Plateau.new()
		@aide = Aide.creer(@plateau)
		@undoRedo = GestionMemento.creer(@plateau)
		@checkPoint = GestionMemento.creer(@plateau)
	end

	#Creer une partie jouable
	def creerPartie()
		@plateau.completeGrille()
		puts @plateau.printOri()
		@plateau.reduireGrille(0)
	end

	#Retourne le plateau
	def getPlateau()
		return @plateau
	end

	#Affiche le plateau (thank's Captain Obvious)
	def afficherPlateau()
		print @plateau
	end

	def getUndoRedo()
		return @undoRedo
	end

	def getCheckPoint()
		return @checkPoint
	end

	def getAide()
		return @aide
	end

	#Sauvegarde une partie en créant un fichier txt dont le nom sera nomPartie
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
