require './case'

class Plateau
	# Constructeur du plateau de jeu
	# @return (self)
	def initialize
		# Taille de la grille
		@base = 3
      	@size = @base*@base
		
		# Création de la grille
		@grid = Array.new(@size) do |i|
			Array.new(@size) do |j| 
				Case.new(i , j)
			end
		end

      return self
	end

	# Méthode qui retourne la solution de la case
	# @param [Fixnum] posX La position X de la case
	# @param [Fixnum] posY La position Y de la case
	# @return (Solution)
	def getCase(posX, posY)
		return @grid[posX][posY].getSolution
	end

	# Méthode pour la MAJ de la solution de la case
	# @param [Fixnum] posX La position X de la case
	# @param [Fixnum] posY La position Y de la case
	# @param [Fixnum] valeur La valeur de la case
	# @return (self)
	def setCase(posX, posY, valeur)
		@grid[posX][posY].setSolution(valeur)
		return self
	end

	# Méthode pour le parcours de la grille du plateau
	# @yield [x, y, val] la position et la valeur courante
	# @return (self)
	def each
		@size.times do |y|
			@size.times do |x|
				yield x, y, @grid[x][y]
			end
		end
		return self
	end

	# Affichage propre de la grille du Plateau
	# @return (String)
	def to_s
		res  = ""
		@size.times do |x|
			res += "\n" if x>0 && x%@base == 0
			@size.times do |y|
				res += " " if y>0 && y%@base == 0
				res += @grid[x][y].to_s
			end
			res += "\n"
		end
      return res
	end
end

plateau = Plateau.new()

plateau.setCase(1,0,1)
plateau.setCase(8,8,2)

print "\n -> ", plateau.getCase(8,8)

print "\n",plateau