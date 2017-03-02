class Position
	# Initialisation de la position d'une case
	def initialize(posX, posY)
		@positionX, @positionY = posX, posY
	end

	# Méthode qui retroune la position en abscisse d'une case
	def getX
		return @positionX
	end

	# Méthode qui retorune la position en ordonnée d'une case
	def getY
		return @positionY
	end

	def to_s
		"#{@positionX}/#{@positionY}"
	end
end