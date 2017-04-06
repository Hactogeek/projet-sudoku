class ListeCandidat
	# @tableauCandidat	

	private_class_method :new

	# Constructeur de la classe
	# * [Retourne :]
	# 				self	
	def ListeCandidat.creer
		new
	end

	def initialize
		@tableauCandidat = Array.new(9)	
		return self
	end

	# Méthode pour ajouter un candidat
	# * [Paramètre :]
	# 				symbole	
	# * [Retourne :]
	# 				self		
	def add(symbole)
		@tableauCandidat.insert(symbole, symbole)
		# @tableauCandidat.uniq
		return self
	end

	# Méthode pour supprimer un candidat
	# * [Paramètre :]
	# 				symbole	
	# * [Retourne :]
	# 				self
	def remove(symbole)
		if(self.include?(symbole))
			@tableauCandidat.delete(symbole)
			#@tableauCandidat.insert(symbole, nil)
		end
		return self
	end

	# Méthode qui retourne vrai si le candidat est présent
	# * [Paramètre :]
	# 				symbole	
	# * [Retourne :]
	# 				booleen
	def include?(symbole)
		return @tableauCandidat.include?(symbole)
	end

	# Méthode qui retourne le tableau des candidats
	# * [Retourne :]
	# 				Array
	def getListeCandidat
		return @tableauCandidat
	end

	# Méthode qui retourne vrai si il n'y a pas de candidat dans la liste
	# * [Retourne :]
	#				boolean
	def empty?
		return @tableauCandidat.compact.empty?
		
	end

	# Les méthodes de classe
	class << self
		
		# Méthode qui permet de placer un candidat sur une case
		# * [Paramètre :]
		# 				plateau plateau
		# 				position pos
		# 				symbole	
		# * [Retourne :]
		# 				listeCandidat
		def placerCandidat(plateau, pos, symbole)
			listeCandidat = plateau.getCaseListeCandidat(pos)
			if listeCandidat == nil then
				listeCandidat = Candidat.creer
			end
			listeCandidat.add(symbole)
			plateau.setCaseListeCandidat(pos, listeCandidat)
			return listeCandidat
		end 

		# Méthode qui permet d'enlever un candidat d'une case
		# * [Paramètre :]
		# 				plateau plateau
		# 				position pos
		# 				symbole	
		# * [Retourne :]
		# 				listeCandidat
		def retirerCandidat(plateau, pos, symbole)
			listeCandidat = plateau.getCaseListeCandidat(pos)
			if listeCandidat != nil then
				listeCandidat.remove(symbole)
				plateau.setCaseListeCandidat(pos, listeCandidat)
			end
			return listeCandidat
		end

	end
end

liste = ListeCandidat.creer()



