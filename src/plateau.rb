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

	################################################################################
	#### 							GETTERS										####
	################################################################################

	# Méthode pour la MAJ de la solution du joueur pour la case
	# @param [Fixnum] posX La position X de la case
	# @param [Fixnum] posY La position Y de la case
	# @return (self)
	def setCaseJoueur(position, valeur)
		@grid[position.getX][position.getY].setSolutionJoueur(valeur)
		return self
	end

	# OK
	# Méthode pour la MAJ de la liste des candidats de la case
	# @param [Position] position La position de la case
	# @param [Candidat] candidat La liste des candidats de la case
	def setCaseListeCandidat(position, candidat)
		@grid[position.getX][position.getY].setListeCandidat(candidat)
		return self
	end

	# Méthode pour la MAJ de la solution originale de la case 
	# @param [Fixnum] posX La position X de la case
	# @param [Fixnum] posY La position Y de la case
	# @param [Fixnum] valeur La valeur de la case
	# @return (self)
	def setCaseOriginale(position, valeur)
		@grid[position.getX][position.getY].setSolutionOriginale(valeur)
		return self
	end

	################################################################################
	#### 							SETTERS										####
	################################################################################

	# Méthode qui retourne la solution orignale de la case 
	# @param [Fixnum] posX La position X de la case
	# @param [Fixnum] posY La position Y de la case
	# @return (SolutionOriginale)
	def getCaseOriginale(position)
		return @grid[position.getX][position.getY].getSolutionOriginale
	end
	
	# Méthode qui retourne la solution du joueur pour la case	
	# @param [Fixnum] posX La position X de la case
	# @param [Fixnum] posY La position Y de la case
	# @return (SolutionJoueur)
	def getCaseJoueur(position)
		return @grid[position.getX][position.getY].getSolutionJoueur
	end

	# OK
	# Méthode qui retourne la liste des candidats pour la case
	# @param [Position] position La position de la case
	# @return [Candidat]
	def getCaseListeCandidat(position)
		return @grid[position.getX][position.getY].getListeCandidat
	end

	# Méthode qui retourne un tableau des valeurs d'une ligne spécifié
	# @param [Fixnum] ligne La ligne qu'il faut retourner 0-8
	# @return 
	def getLigne(ligne)
		tableauRetour = Array.new()
		for n in (0...9)
			tableauRetour.insert(n, @grid[ligne][n].getSolutionJoueur)
		end
		return tableauRetour
	end

	# Méthode qui retourne un tableau des valeurs d'une colonne spécifié
	# @param [Fixnum] colonne La colonne qu'il faut retourner 0-8
	# @return 
	def getColonne(colonne)
		tableauRetour = Array.new()
		for n in (0...9)
			tableauRetour.insert(n, @grid[n][colonne].getSolutionJoueur)
		end	
		return tableauRetour
	end

	# Méthode qui retourne un tableau des valeurs d'une region spécifié
	# @param [Fixnum] region La region qu'il faut retourner 1-9
	# @return 
	def getRegion(region)
		tableauRetour = Array.new()
		i = 0
		case region
		when 1
			for n in (0...3)
				for m in (0...3)
					tableauRetour.insert(i, @grid[n][m].getSolutionJoueur)
					i = i + 1
				end
			end
		when 2
			for n in (0...3)
				for m in (3...6)
					tableauRetour.insert(i, @grid[n][m].getSolutionJoueur)
					i = i + 1
				end
			end
		when 3
			for n in (0...3)
				for m in (6...9)
					tableauRetour.insert(i, @grid[n][m].getSolutionJoueur)
					i = i + 1
				end
			end
		when 4
			for n in (3...6)
				for m in (0...3)
					tableauRetour.insert(i, @grid[n][m].getSolutionJoueur)
					i = i + 1
				end
			end
		when 5
			for n in (3...6)
				for m in (3...6)
					tableauRetour.insert(i, @grid[n][m].getSolutionJoueur)
					i = i + 1
				end
			end
		when 6
			for n in (3...6)
				for m in (6...9)
					tableauRetour.insert(i, @grid[n][m].getSolutionJoueur)
					i = i + 1
				end
			end
		when 7
			for n in (6...9)
				for m in (0...3)
					tableauRetour.insert(i, @grid[n][m].getSolutionJoueur)
					i = i + 1
				end
			end
		when 8
			for n in (6...9)
				for m in (3...6)
					tableauRetour.insert(i, @grid[n][m].getSolutionJoueur)
					i = i + 1
				end
			end
		when 9
			for n in (6...9)
				for m in (6...9)
					tableauRetour.insert(i, @grid[n][m].getSolutionJoueur)
					i = i + 1
				end
			end
		end
		return tableauRetour
	end

	# Méthode qui vérifie si un chiffre est sur une ligne
	# @param chiffre Le chiffre
	# @param ligne La ligne 
	# @return boolean
	def absentLigne(chiffre, ligne)
		tableauLigne = self.getLigne(ligne)
		#print tableauLigne
		return !tableauLigne.include?(chiffre)
	end

	# Méthode qui vérifie si un chiffre est dans une colonne
	# @param chiffre Le chiffre
	# @param ligne La ligne 
	# @return boolean
	def absentColonne(chiffre, colonne)
		tableauColonne = self.getColonne(colonne)
		#print tableauColonne
		return !tableauColonne.include?(chiffre)
	end

	# Méthode qui vérifie si un chiffre est dans une région
	# @param chiffre Le chiffre
	# @param ligne La ligne 
	# @return boolean
	def absentRegion(chiffre, region)
		tableauRegion = self.getRegion(region)
		#print tableauRegion
		return !tableauRegion.include?(chiffre)
	end

	# def candidatPossible(posX, posY)
	# 	tableauRetour = Array.new(9)

	# 	if(posX <=2 && posY<=2)
	# 		region = 1
	# 	elsif(posX <= 2 && posY >= 3 && posY <= 5)
	# 		region = 2
	# 	elsif(posX <= 2 && posY >= 6)
	# 		region = 3
	# 	elsif(posX >= 3 && posX <= 5 && posY <= 2)
	# 		region = 4
	# 	elsif(posX >= 3 && posX <= 5 && posY >= 3 && posY <= 5)
	# 		region = 5
	# 	elsif(posX >= 3 && posX <= 5 && posY >= 6)
	# 		region = 6
	# 	elsif()
	# 		region = 7
	# 	elsif()
	# 		region = 8
	# 	elsif()
	# 		region = 9

	# 	for i in (0...9)
	# 		if(absentLigne(i,posX) && absentColonne(i, poY))
	# 			tableauRetour.insert(i,i)
	# 		end
	# 	end
	# 	return tableauRetour
	# end

	# def candidatImpossible(posX, posY)

	# end

	# Méthode pour générer une grille complete aléatoirement
	def completeGrille
		pattern = Array.new(@size){|i| i+1}.shuffle
		@size.times do |y|
			@size.times do |x|
      			setCaseOriginale(x, y, pattern[x])
    		end
    		@base.times{|i| pattern.push pattern.shift}
    		pattern.push pattern.shift if @base - (y % @base) == 1
  		end
      	self
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
			res += "\n" if x>0 && x % @base == 0
			@size.times do |y|
				res += " " if y>0 && y % @base == 0
				# res += @grid[x][y].printJoueur
				res+= @grid[x][y].printOri
			end
			res += "\n"
		end
      return res
	end
end

plateau = Plateau.new()

plateau.completeGrille()

#plateau.setCaseJoueur(1,0,1)
#plateau.setCaseJoueur(8,8,2)


print "\n", plateau

puts plateau.absentRegion(1,1)
puts plateau.absentLigne(1,1)
puts plateau.absentColonne(1,0)
