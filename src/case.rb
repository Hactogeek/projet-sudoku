require './position'

class Case
	# Initialisation de la position d'une case de la grille
	def initialize (posX, posY)
		@position = Position.new(posX, posY)
		@solutionOriginale = "."
		@solutionJoueur = nil
		@candidat = Array.new()
	end

	# Méthode pour la MAJ de la solution originale de la case
	# @param [Fixnum] solOriginale Solution originale de la case
	def setSolutionOriginale(solOriginale)
		@solutionOriginale = solOriginale
	end

	# Méthode pour la MAJ de la solution du joueur de la case
	# @param [Fixnum] solJoueur Solution du joueur pour la case
	def setSolutionJoueur(solJoueur)
		@solutionJoueur = solJoueur
	end

	# Méthode pour la MAJ de la liste des candidats de la case
	# @param [Fixnum] candidat Candiat pour la case
	def setCandidat(candidat)
		@candidat.add(candidat)
	end

	# Méthode qui retourne la solution originale de la case
	# @return (Integer)
	def getSolutionOriginale
		return @solutionOriginale
	end

	# Méthode qui retourne la solution du joueur pour la case
	# @return (Integer)
	def getSolutionJoueur
		return @solutionJoueur
	end

	# Méthode qui retourne la liste des candidats de la case
	# @return (Integer[])
	def setCandidat(candidat)
		return @candidat
	end

	# Méthode qui retourne la position de la case 
	#def getPosition
	#	return @position
	#end

	# Affichage d'une solution de la Case
	def printOri
		return "#{@solutionOriginale}"
	end

	def printJoueur
		return "#{@solutionJoueur}"
	end
end
