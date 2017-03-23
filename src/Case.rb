require './Position'

class Case
	# Initialisation de la position d'une case de la grille
	def initialize (position)
		@position = position
		@solutionOriginale = "."
		@solutionJoueur = nil
		@candidat = nil
		@originale = false
	end

	################################################################################
	#### 								SETTERS									####
	################################################################################

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

	# OK
	# Méthode pour la MAJ de la liste des candidats de la case
	# @param [Fixnum] candidat Candiat pour la case
	def setListeCandidat(candidat)
		@candidat = candidat
	end

	def setOriginale(originale)
		@originale = originale
	end

	################################################################################
	#### 								GETTERS									####
	################################################################################

	# Méthode qui retourne si une case est originale du puzzle
	# @return boolean
	def getOriginaleGrille
		return @originale
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

	# OK
	# Méthode qui retourne la liste des candidats de la case
	# @return [Candidat]
	def getListeCandidat()
		return @candidat
	end

	# Méthode qui retourne la position de la case
	# @return Position
	def getPosition()
		return @position
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
		if @solutionJoueur == nil
			return "0"
		end
		return "#{@solutionJoueur}"
	end
end
