class Symbole
	# @symbole	

	private_class_method :new

	# Constructeur de la classe
	# @return : self
	def Symbole.creer
		new
	end

	def initialize
		@symbole = nil
		return self
	end

	# Méthode pour ajouter un symbole
	# @param [Fixnum] symbole
	# @return : self	
	def add(symbole)
		@symbole = symbole
		return self
	end

	# Méthode pour supprimer un symbole
	# @param [Fixnum] symbole
	# @return : self
	def remove(symbole)
		@symbole = nil
		return self
	end

	# Méthode qui retourne vrai si le candidat est présent
	# @param [Fixnum] symbole
	# @return : vrai ou faux
	def getSymbole
		return @symbole
	end

	# Les méthodes de classe
	class << self
		
		# Méthode qui permet de placer un symbole sur une case
		# @param plateau plateau
		# @param position pos
		# @param [Fixnum] symbole
		# @return symbole
		def placerSymbole(plateau, pos, symbole)
			symboleCase = plateau.getCaseJoueur(pos)
			if symboleCase == nil then
				symboleCase = Symbole.creer
			end
			symboleCase.add(symbole)
			plateau.setCaseJoueur(pos, symboleCase)
			return symboleCase
		end 

		# Méthode qui permet d'enlever un symbole d'une case
		# @param plateau plateau
		# @param position pos
		# @param [Fixnum] symbole
		# @return symbole
		def retirerSymbole(plateau, pos, symbole)
			symboleCase = plateau.getCaseJoueur(pos)
			if symboleCase != nil then
				symboleCase.remove(symbole)
				plateau.setCaseJoueur(pos, symboleCase)
			end
			return symboleCase
		end

	end
end



