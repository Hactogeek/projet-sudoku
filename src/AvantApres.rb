class AvantApres

	#@avant
	#@apres

	private_class_method :new

	def AvantApres.creer(avant, apres)
		new(avant, apres)
	end

	def initialize(avant, apres)
		@avant = avant;
		@apres = apres;
	end
		
end
