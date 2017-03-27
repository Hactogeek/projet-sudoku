require './Plateau'
require './Aide'
require './GestionMemento'
require './Sauvegarde'

class Partie
	#@plateau sur lequel on travaille

	# Constructeur d'une partie
	def Partie.nouvelle()
		new()
	end

	def initialize()
		@plateau = Plateau.new()
		@aide = Aide.creer(@plateau)
		@undoRedo = GestionMemento.creer(self)
		@checkPoint = GestionMemento.creer(self)
	end

	#Creer une partie jouable
	def creerPartie()
		@plateau.completeGrille()
		@plateau.reduireGrille(0)
		@checkPoint.addMemento
	end

	#Retourne le plateau
	def getPlateau()
		return @plateau
	end

	#Retourne le plateau
	def setPlateau(plateau)
		@plateau = plateau
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
		serialized_array = Marshal.dump(@plateau)
		File.open(nomPartie+".txt", 'w') {|f| f.write(serialized_array) }
		#f=File.new(nomPartie+".txt", "w+")
		#f.write(@plateau)
		#f.close
	end

	#nomPartie est le nom du fichier à charger.
	def loadSave(nomPartie)
		#f=File.open(nomPartie+".txt", "r")
		@plateau=Marshal.load File.read(nomPartie+".txt")
	end

end
