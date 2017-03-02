require './position'

class Case
	# Initialisation de la position d'une case de la grille
	def initialize (posX, posY)
		@position = Position.new(posX, posY)
		@solution = "."
	end

	# Initialisation d'une case de la grille
	#def initialize (posX, posY, sol, ori)
	#	self posX posY
	#	@solution, @original = sol, ori
	#end

	# Méthode pour la MAJ de l'original de la case
	#def setOriginal(ori)
	#	@original = ori
	#end

	# Méthode qui retourne true si une cas est originale, false si elle ne l'est pas 
	#def estCaseOriginal?
	#	return @original
	#end

	# Méthode pour la MAJ de la solution de la case
	def setSolution(sol)
		@solution = sol
	end

	# Méthode qui retourne la solution de la case
	def getSolution
		return @solution
	end

	# Méthode qui retourne la position de la case 
	#def getPosition
	#	return @position
	#end

	# Affichage d'une solution de la Case
	def to_s
		return "#{@solution}"
	end
end

class CaseJoueur < Case

end

#case2 = Case.new(0,1)
#case1 = Case.new(1, true, 0, 0)

#puts case1.getSolution

#print "Position : ", case1.getPosition, "\n"
#print "Position : ", case2.getPosition, "\n"