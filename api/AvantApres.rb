class AvantApres
	# Classe qui permet de stocker deux elements
	# @avant
	# @apres

	private_class_method :new

	# Constucteur de la classe
	# * [Paramètre avant:]
	# 				l'etat precedant
	#
	# * [Paramètre apres :]
	# 				l'etat suivant
	def AvantApres.creer(avant, apres)
		new(avant, apres)
	end

	def initialize(avant, apres)
		@avant = avant;
		@apres = apres;
		return self
	end
		
end
