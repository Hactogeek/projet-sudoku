require './Plateau'
require './Aide'
require './GestionMemento'
require './Sauvegarde'

class Partie
	#@plateau sur lequel on travaille

	# Constructeur d'une partie
	def Partie.nouvelle(difficulte)
		new(difficulte)
	end

	def initialize(difficulte)
		@plateau = Plateau.new()
		@aide = Aide.creer(self)
		@undoRedo = GestionMemento.creer(self)
		@checkPoint = GestionMemento.creer(self)
		@difficulte=difficulte
	end

	#Creer une partie jouable
	def creerPartie()
		@plateau.completeGrille()
		puts @plateau.printOri()
		@plateau.reduireGrille(0,@difficulte) # A modifier si on veut changer le niveau de difficulté 2:facile, 3:moyen, 4:difficile
		@checkPoint.addMemento
	end

	# Méthode qui fait le traitement de fin de partie si la grille est complete
	def finPartie
		if @plateau.complete?
			print("La grille est complete")
		end

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

	#Perso je trouve ça inutile, sachant que la sauvegarde se fait avec la class Sauvegarde.
	#Sauvegarde une partie en créant un fichier txt dont le nom sera nomPartie
	def setSave(nomPartie)
		serialized_array = Marshal.dump(self)
		File.open(nomPartie+".txt", 'wb') {|f| f.write(serialized_array) }
	end

	#nomPartie est le nom du fichier à charger.
	def Partie.loadSave(nomPartie)
		return Marshal.load  File.open(nomPartie+'.txt', 'rb').read
	end

end
