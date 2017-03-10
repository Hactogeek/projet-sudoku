class ListeCandidat
	# @tableauCandidat	

	private_class_method :new

	# Constructeur de la classe
	# @return : self
	def Candidat.creer
		new
	end

	def initialize
		@tableauCandidat = Array.new	
		return self
	end

	# Méthode pour ajouter un candidat
	# @param [Fixnum] symbole
	# @return : self	
	def add(symbole)
		@tableauCandidat.push(symbole)
		@tableauCandidat.uniq
		return self
	end

	# Méthode pour supprimer un candidat
	# @param [Fixnum] symbole
	# @return : self
	def remove(symbole)
		@tableauCandidat.delete(symbole)
		return self
	end

	# Méthode qui retourne vrai si le candidat est présent
	# @param [Fixnum] symbole
	# @return : vrai ou faux
	def include?(symbole)
		return @tableauCandidat.include?(symbole)
	end

end



