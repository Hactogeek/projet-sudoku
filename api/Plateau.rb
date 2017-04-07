Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../vues/*.rb'].each {|file| require file }

class Plateau
	# Constructeur du plateau de jeu
	# * [Retourne :]
	# 				self	
	def initialize
		# Taille de la grille
		@base = 3
		@size = @base*@base
		
		# Création de la grille
		@grid = Array.new(@size) do |i|
			Array.new(@size) do |j| 
				Case.new(Position.new(i, j))
			end
		end

		return self
	end

	################################################################################
	#### 								SETTERS									####
	################################################################################
	

	# Méthode pour la MAJ de la solution du joueur pour la case
	# * [Paramètre :]
	# 				position La position de la case
	#
	# * [Retourne :]
	# 				self	
	def setCaseJoueur(position, valeur)
		# Ajout de la solution du joueur
		@grid[position.getX()][position.getY()].setSolutionJoueur(valeur)
		return self
	end

	# --
	# # OK
	# # Méthode pour la MAJ de la liste des candidats de la case
	# # @param [Position] position La position de la case
	# # @param [Candidat] candidat La liste des candidats de la case
	# def setCaseListeCandidat(position, candidat)
	# 	@grid[position.getX][position.getY].setListeCandidat(candidat)
	# 	return self
	# end
	# ++

	# Méthode pour la MAJ de la solution originale de la case 
	# * [Paramètre :]
	# 				position La position de la case
	# 				valeur La valeur de la case
	#
	# * [Retourne :]
	# 				self	
	def setCaseSolutionOriginale(position, valeur)
		@grid[position.getX][position.getY].setSolutionOriginale(valeur)
		return self
	end

	def setCaseOriginale(position, originale)
		@grid[position.getX][position.getY].setOriginale(originale)
	end

	################################################################################
	#### 								GETTERS									####
	################################################################################
	
	# Méthode qui retourne la solution du joueur pour la case	
	# * [Paramètre :]
	# 				position La position de la case
	#
	# * [Retourne :]
	# 				SolutionJoueur	
	def getCaseJoueur(position)
		return @grid[position.getX][position.getY].getSolutionJoueur
	end

	def getCase(position)
		return @grid[position.getX][position.getY]
	end

	# OK
	# Méthode qui retourne la liste des candidats pour la case
	# * [Paramètre :]
	# 				position La position de la case
	#
	# * [Retourne :]
	# 				candidat	
	def getCaseListeCandidat(position)
		return @grid[position.getX][position.getY].getListeCandidat
	end

	# Méthode qui retourne la solution orignale de la case 
	# * [Paramètre :]
	# 				position La position de la case
	#
	# * [Retourne :]
	# 				SolutionOriginale	
	def getCaseOriginale(position)
		return @grid[position.getX][position.getY].getSolutionOriginale
	end

	# Méthode qui retourne un tableau des valeurs d'une ligne spécifié
	# * [Paramètre :]
	# 				ligne La ligne qu'il faut retourner 0-8
	#
	# * [Retourne :]
	# 				ArrayFixnum	
	def getLigne(ligne)
		tableauRetour = Array.new()
		for n in (0...9)
			tableauRetour.insert(n, @grid[ligne][n])
		end
		return tableauRetour#.map(&:getSolutionJoueur)
	end

	# Méthode qui retourne un tableau des valeurs d'une colonne spécifié
	# * [Paramètre :]
	# 				colonne La colonne qu'il faut retourner 0-8
	#
	# * [Retourne :]
	# 				ArrayFixnum	
	def getColonne(colonne)
		tableauRetour = Array.new()
		for n in (0...9)
			tableauRetour.insert(n, @grid[n][colonne])
		end
		return tableauRetour#.map(&:getSolutionJoueur)
	end

	# Méthode qui retourne un tableau des valeurs d'une region spécifié
	# * [Paramètre :]
	# 				region La region qu'il faut retourner 1-9
	#
	# * [Retourne :]
	# 				ArrayFixnum	
	def getRegion(posX, posY)
		tableauRetour = Array.new()
	
		posX = posX-(posX%3)
		posY = posY-(posY%3)

		for n in (posX...posX+3)
			for m in (posY...posY+3)
				tableauRetour.insert(n, @grid[n][m])
			end
		end
		return tableauRetour#.map(&:getSolutionJoueur)
	end


	# Méthode qui retourne un tableau des cases d'une region spécifié
	# * [Paramètre :]
	# 				x La colonne (0-8)
	#				y La ligne  (0-8)
	#
	# * [Retourne :]
	# 				listeCase	
	def getCaseRegion(posX, posY)
		listeCase = Array.new()
		posX++
		posY++

		posX = posX-(posX%3)
		posY = posY-(posY%3)

		for n in (posX...posX+3)
			for m in (posY...posY+3)
						listeCase.push(@grid[n][m])
			end
		end

		return listeCase
	end



	# Méthode qui retourne un tableau les cases d'une ligne dans une région spécifié
	# * [Paramètre :]
	# 				x La colonne (0-8)
	#				y La ligne  (0-8)
	#
	# * [Retourne :]
	# 				listeCase	
	def getLigneRegion(x, y)
		listeCase = Array.new
		if y < 3
			deb = 0
			fin = 3	
		elsif y < 6
			deb = 3
			fin = 6
		else
			deb = 6
			fin = 9
		end
		for n in (deb...fin)
			listeCase.push(@grid[x][n])
		end
		
		return listeCase
	end
	
	# Méthode qui retourne un tableau les cases d'une ligne sauf les cases de la région spécifié
	# * [Paramètre :]
	# 				x La colonne (0-8)
	#				y La ligne  (0-8)
	#
	# * [Retourne :]
	# 				listeCase	
	def getLigneAutreRegion(x, y)
		listeCase = Array.new
		if y < 3
			ligne1 = getLigneRegion(x, 3)
			ligne2 = getLigneRegion(x, 6)
		elsif y < 6
			ligne1 = getLigneRegion(x, 0)
			ligne2 = getLigneRegion(x, 6)
		else
			ligne1 = getLigneRegion(x, 0)
			ligne2 = getLigneRegion(x, 3)
		end
		ligne1.each { |kase|
			listeCase.push(kase)
		}
		ligne2.each { |kase|
			listeCase.push(kase)
		}
		
		return listeCase
	end

	# Méthode qui retourne un tableau des cases d'une colonne dans une région spécifié
	# * [Paramètre :]
	# 				x La colonne (0-8)
	#				y La ligne  (0-8)
	#
	# * [Retourne :]
	# 				listeCase	
	def getColonneRegion(x, y)
		listeCase = Array.new
		if x < 3
			deb = 0
			fin = 3	
		elsif x < 6
			deb = 3
			fin = 6
		else
			deb = 6
			fin = 9
		end
		for n in (deb...fin)
			listeCase.push(@grid[n][y])
		end
		
		return listeCase
	end	

	# Méthode qui retourne un tableau des cases d'une colonne dans une région spécifié
	# * [Paramètre :]
	# 				x La colonne (0-8)
	#				y La ligne  (0-8)
	#
	# * [Retourne :]
	# 				listeCase	
	def getColonneAutreRegion(x, y)
		listeCase = Array.new
		if x < 3
			colonne1 = getColonneRegion(3, y)
			colonne2 = getColonneRegion(6, y)
		elsif x < 6
			colonne1 = getColonneRegion(0, y)
			colonne2 = getColonneRegion(6, y)
		else
			colonne1 = getColonneRegion(0, y)
			colonne2 = getColonneRegion(3, y)

		end
		colonne1.each { |kase|
			listeCase.push(kase)
		}
		colonne2.each { |kase|
			listeCase.push(kase)
		}
		
		return listeCase
	end	

	# Méthode qui vérifie si un chiffre est sur une ligne
	# * [Paramètre :]
	# 				chiffre Le chiffre
	# 				ligne La ligne 
	#
	# * [Retourne :]
	# 				booleen	
	def absentLigne(chiffre, ligne)
		tableauLigne = self.getLigne(ligne)
		return !tableauLigne.compact.map(&:getSolutionJoueur).include?(chiffre)
	end

	# Méthode qui vérifie si un chiffre est dans une colonne
	# * [Paramètre :]
	# 				chiffre Le chiffre
	# 				ligne La ligne 
	#
	# * [Retourne :]
	# 				booleen
	def absentColonne(chiffre, colonne)
		tableauColonne = self.getColonne(colonne)
		return !tableauColonne.compact.map(&:getSolutionJoueur).include?(chiffre)
	end

	# Méthode qui vérifie si un chiffre est dans une région
	# * [Paramètre :]
	# 				chiffre Le chiffre
	# 				ligne La ligne
	#
	# * [Retourne :]
	# 				booleen	
	def absentRegion(chiffre, posX, posY)
		tableauRegion = self.getRegion(posX,posY)
		return !tableauRegion.compact.map(&:getSolutionJoueur).include?(chiffre)
	end

	# Méthode qui retourne les listes des candidats pour une case
	# * [Paramètre :]
	# 				position La position de la case
	#
	# * [Retourne :]
	# 				ListeCandidat
	def candidatPossible(position)
		tabCandidatPossible = ListeCandidat.creer()
		# tableauRetour = Array.new(9)

		for i in (1..9)
			if(absentLigne(i,position.getX) && absentColonne(i, position.getY) && absentRegion(i, position.getX, position.getY))
				tabCandidatPossible.add(i)
			end
		end

		# print "\n Candidat en #{position.getX+1},#{position.getY+1}:", tabCandidatPossible.getListeCandidat, @grid[position.getX][position.getY].getListeCandidat().getListeCandidat,"\n"
		return tabCandidatPossible
	end

	# Méthode qui enleve pour la region, colonne, ligne de la position
	# * [Paramètre :]
	# 				position La position de la case
	#				symbole le symbole à retirer des candidats
	def enleverCandidat(position, symbole)
		ligne = getLigne(position.getX())	
		colonne = getColonne(position.getY())
		region = getCaseRegion(position.getX(),position.getY())
		ligne.each{ |kase|
			kase.getCandidat().remove(symbole)
		}
		colonne.each{ |kase|
			kase.getCandidat().remove(symbole)
		}
		region.each{ |kase|
			kase.getCandidat().remove(symbole)
		}
	end

	# Méthode qui retourne les listes des candidats impossibles pour une case
	# * [Paramètre :]
	# 				position La position de la case
	#
	# * [Retourne :]
	# 				ListeCandidat
	def candidatImpossible(position)
		tabCandidatImpossible = ListeCandidat.creer()

		for i in (1...9)
			if(!absentLigne(i,position.getX) && !absentColonne(i, position.getY) && !absentRegion(i, position.getX, position.getY))
				tabCandidatImpossible.add(i);
				# tableauRetour.insert(i,i)
			end
		end

		return tabCandidatImpossible
	end

	# Méthode pour générer une grille complete aléatoirement
	# * [Retourne :]
	# 				self	
	def completeGrille
		pattern = Array.new(@size){|i| i+1}.shuffle
		@size.times do |y|
			@size.times do |x|
				setCaseSolutionOriginale(Position.new(x, y), pattern[x])
				setCaseOriginale(Position.new(x, y), true)
				setCaseJoueur(Position.new(x, y), pattern[x])
			end
			@base.times{|i| pattern.push pattern.shift}
			pattern.push pattern.shift if @base - (y % @base) == 1
		end
		return self
	end

    # Méthode pour savoir si une grille est valide
    # * [Paramètre :]
	# 				fixnum position
	#
	# * [Retourne :]
	# 				booleen
	def valideGrille(position)
		if (position == @size * @size)
			return true
		end

		x = position/9
		y = position%9

		if (@grid[x][y].getSolutionJoueur !=  nil)
			return valideGrille(position+1)
		end

		@size.times do |k|
			if(absentLigne(k+1, x) && absentColonne(k+1, y) && absentRegion(k+1, x, y))
				setCaseJoueur(Position.new(x,y), k+1)

				if valideGrille(position+1)
					setCaseJoueur(Position.new(x,y), nil)
					return true
				end
			end
		end
		setCaseJoueur(Position.new(x,y), nil)

		return false
	end

    # Méthode qui vérifie si il y a au moins deux occurence d'un symbole dans un tableau
	# * [Retourne :]
	# 				booleen
	def deuxOccurenceTab?(tab)
		occurence = false
		for i in (0...9)
			if tab[i] != nil
				kase1 = tab[i]
			else
				kase1 = nil
			end
			for j in (0...9)
				if tab[j] != nil
					kase2= tab[j]
				else
					kase2 = nil
				end
				if (i != j) && kase1 == kase2 && kase1 != nil
					return true
				end	
			end

		end

		return false
	end

        # Méthode qui vérifie si la grille est correct
	# * [Retourne :]
	# 				booleen	
	def correctGrille?
		self.each { |x,y,kase|
			ligne = getLigne(y).compact.map(&:getSolutionJoueur)
			colonne = getColonne(x).compact.map(&:getSolutionJoueur)
			region = getRegion(x/3, y/3).compact.map(&:getSolutionJoueur)
			if deuxOccurenceTab?(ligne) || deuxOccurenceTab?(colonne) || deuxOccurenceTab?(region)
				return false
			end
		}
		return true
	end

	# Méthode qui vérifie si les candidats sont corrects
	# * [Retourne :]
	# 				booleen	
	def correctCandidat?
		self.each { |x,y,kase|
			if (kase.getCandidat().include?(kase.getSolutionOriginale) == false) && kase.getSolutionJoueur == nil
				return false
			end
		}
		return true
	end

     # Méthode qui vérifie si toutes les cases de la grilles sont remplies
	# * [Retourne :]
	# 				booleen	
	def plein?
		pleine = true
		self.each { |x,y,kase|
			if  kase.getSolutionJoueur == nil
				pleine = false
			end
		}
		return pleine
	end

	# Méthode qui vérifie si il y a des candidats dans la grille
	# * [Retourne :]
	# 				booleen	
	def aucunCandidat?
		self.each { |x,y,kase|
			if  kase.getCandidat().empty? == false
				return false
			end
		}
		return true
	end

    # Méthode qui vérifie si la grille est complète et correct
	# * [Paramètre :]
	# 				symbole
	#
	# * [Retourne :]
	# 				booleen	
	def complete?
		complete = false
		if self.plein? && self.correctGrille?
			complete = true
		end
		return complete
	end

    # Méthode pour réduire une grille en la gardant jouable
	# * [Retourne :]
	# 				self	
	def reduireGrille (position, niveauDifficulte)

		listeCase = Array.new()

		@size.times do |y|
			@size.times do |x|
				listeCase.insert(y*9+x, @grid[x][y])
			end
		end

		listeCase.shuffle!

		for uneCase in listeCase
			setCaseJoueur(uneCase.getPosition, nil)
			setCaseOriginale(uneCase.getPosition, false)

			if(candidatPossible(uneCase.getPosition).getListeCandidat().compact.count > niveauDifficulte)
				setCaseJoueur(uneCase.getPosition, getCaseOriginale(uneCase.getPosition))
				setCaseOriginale(uneCase.getPosition, true)
			end
		end

		return self
	end

	# Importe et résout la grille passé en paramètre
	def importerGrille
		if !self.correctGrille?
			return false
		end
		@size.times do |x|
			@size.times do |y|
				if @grid[x][y].getSolutionJoueur() != nil
					@grid[x][y].setSolutionOriginale(@grid[x][y].getSolutionJoueur())
					@grid[x][y].setOriginale(true)
				end
			end
		end

		print "\n", self
		print self.printOri
		# print self.correctGrille?
		return resoudreGrilleImporter()
	end

	def resoudreGrilleImporter
		grille = Array.new()
		# Convertir la grille en chaine de caractère
		@size.times do |x|
			@size.times do |y|
				if @grid[x][y].getSolutionJoueur() == nil
					grille << 0
				else 
					grille << @grid[x][y].getSolutionJoueur()
				end
			end
		end

		grille = [grille.join]

		# grille = ["000050000007604500090070080020010090805907401040080030050040060009503800000020000"]
		
		grille.map{|a|(i=a=~/0/)?(v=*?1..?9).fill{|j|v-=[a[j+i-k=i%9],a[k+j*=9],a[j%26+i-i%3-i%27+k]]}+v.map{|k|grille.<<$`<<k<<$'}:p(a)}

		grille = grille.pop

		#print grille
		
		grille.split("").map(&:to_i)

		@size.times do |x|
			@size.times do |y|
				@grid[x][y].setSolutionOriginale(grille[x*9+y])
			end
		end
		# print "\n", self
		# print self.printOri
		return true
	end

	# Méthode pour le parcours de la grille du plateau
	# @yield [x, y, val] la position et la valeur courante
	#
	# * [Retourne :]
	# 				self	
	def each
		@size.times do |y|
			@size.times do |x|
				yield x, y, @grid[x][y]
			end
		end
		return self
	end

	# Affichage propre de la grille du Plateau
	# * [Retourne :]
	# 				string
	def to_s
		res  = ""
		@size.times do |x|
			res += "\n" if x>0 && x % @base == 0
			@size.times do |y|
				res += " " if y>0 && y % @base == 0
				res += @grid[x][y].printJoueur
				#res+= @grid[x][y].printOri
			end
			res += "\n"
		end
		return res
	end

	# Affichage propre des valeurs originale de la grille du Plateau
	# * [Retourne :]
	# 				string	
	def printOri
		res  = ""
		@size.times do |x|
			res += "\n" if x>0 && x % @base == 0
			@size.times do |y|
				res += " " if y>0 && y % @base == 0
				res+= @grid[x][y].printOri
			end
			res += "\n"
		end
		return res
	end
end

#=begin 
#plateau = Plateau.new

#plateau.completeGrille



#plateau.reduireGrille(0)
