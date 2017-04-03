Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../vues/*.rb'].each {|file| require file }

class Case
	# Initialisation de la position d'une case de la grille
	def initialize (position)
		@position = position
		@solutionOriginale = "."
		@solutionJoueur = nil
		@candidat = ListeCandidat.creer()
		@originale = false
	end

	################################################################################
	#### 								SETTERS									####
	################################################################################

	# Méthode pour la MAJ de la solution originale de la case
	# * [Paramètre :]
	# 				[Fixnum]solOriginale Solution originale de la case
	def setSolutionOriginale(solOriginale)
		@solutionOriginale = solOriginale
	end

	# Méthode pour la MAJ de la solution du joueur de la case
	# * [Paramètre :]
	# 				[Fixnum]solJoueur Solution du joueur pour la case
	def setSolutionJoueur(solJoueur)
		if !@originale then
			@solutionJoueur = solJoueur
		end
		@candidat = ListeCandidat.creer()
	end

	# # OK
	# # Méthode pour la MAJ de la liste des candidats de la case
	# * [Paramètre :]
	# 				[Fixnum]candidat Candiat pour la case
	#--
	# def setListeCandidat(candidat)
	# 	@candidat = candidat
	# end
	#++

	def setOriginale(originale)
		@originale = originale
	end

	################################################################################
	#### 								GETTERS									####
	################################################################################

	# Méthode qui retourne si une case est originale du puzzle
	# * [Retourne :]
	# 				booleen
	def getOriginaleGrille
		return @originale
	end

	# Méthode qui retourne la solution originale de la case
	# * [Retourne :]
	# 				Integer
	def getSolutionOriginale
		return @solutionOriginale
	end

	# Méthode qui retourne la solution du joueur pour la case
	# * [Retourne :]
	# 				Integer
	def getSolutionJoueur
		return @solutionJoueur
	end

	# OK
	# Méthode qui retourne la liste des candidats de la case
	# * [Retourne :]
	# 				Candidat
	def getCandidat()
		return @candidat
	end

	# Méthode qui retourne la position de la case
	# * [Retourne :]
	# 				Position
	def getPosition()
		return @position
	end

	#--
	# Méthode qui retourne la position de la case 
	#def getPosition
	#	return @position
	#end
	#--

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
