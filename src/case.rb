require './position'

class Case
	# Initialisation de la position d'une case de la grille
	def initialize (posX, posY)
		@position = Position.new(posX, posY)
		@solutionOriginale = "."
		@solutionJoueur = "."
		@candidat = Array.new()
	end

	# Méthode pour la MAJ de la solution originale de la case
	def setSolutionOriginale(solOriginale)
		@solutionOriginale = solOriginale
	end

	# Méthode pour la MAJ de la solution du joueur de la case
	def setSolutionJoueur(solJoueur)
		@solutionJoueur = solJoueur
	end

	# Méthode pour la MAJ de la liste des candidats de la case
	def setCandidat(candidat)
		@candidat.add(candidat)
	end

	# Méthode qui retourne la solution originale de la case
	def getSolutionOriginale
		return @solutionOriginale
	end

	# Méthode qui retourne la solution du joueur de la case
	def getSolutionJoueur
		return @solutionJoueur
	end

	# Méthode qui retourne la liste des candidats de la case
	def setCandidat(candidat)
		return @candidat
	end

	# Méthode qui retourne la position de la case 
	#def getPosition
	#	return @position
	#end

	# Affichage d'une solution de la Case
	def to_s
		return "#{@solutionOriginale}"
	end
end
