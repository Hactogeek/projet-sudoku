Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../vues/*.rb'].each {|file| require file }
class Aide
	def Aide.creer(partie)
		new(partie)
	end

	def initialize(partie)
		@partie=partie
	end

	#Place tous les candidats de la case
	# * [Paramètre :]
	# 				position
	def candidatPossible(position)
		@partie.getPlateau().setCaseListeCandidat(position, @partie.getPlateau().candidatPossible(position))
	end

	# Méthode qui retourne la position des cases avec un unique candidat
	def caseResolvable
		listeCase = Array.new()

		@partie.getPlateau().each do |x,y,laCase| 
			if laCase.getCandidat().getListeCandidat().compact().length() == 1
				listeCase.push(Position.new(x,y))
			end
		end

		# print "listeCase", listeCase

		if listeCase.empty?
			return nil 
		end

		return listeCase
	end

	#Place tous les candidats de chaque case du plateau
	def candidatGrille()

	end

	#Resoud la grille
	def resoudre()

	end

	#Le joueur indique en paramètre le symbole candidat de la position
	#si c'est possible, on retourne true. Sinon, on retourne
	#la position du symbole qui indique l'impossibilité de placer le symbole candidat
	# * [Paramètre :]
	# 				candidat
	# 				pos	
	def explicationChoix(candidat, pos)

	end

	# Méthode qui retourne les cases incorrects
	# * [Retourne :]
	# 				tableau de case	
	def verificationGrille
		listeCase = Array.new
		@partie.getPlateau().each { |x,y,kase|
			if kase.getSolutionJoueur != nil
				if kase.getSolutionJoueur != kase.getSolutionOriginale
					listeCase.push(Position.new(x,y))
				end
			end
		}
		return listeCase
	end

	#Indique la position du coup suivant à jouer
	def coupSuivant()
		solution = candidatUnique()
		solutionText = "Candidat Unique"

		if solution != nil
			# return solution
			return [solutionText, solution[rand(solution.length)]]
		end

		solution = caseResolvable()
		solutionText = "Un seul candidat"

		if solution != nil
			# return solution
			return [solutionText, solution[rand(solution.length)]]
		end

		# return solution
		return [solutionText, solution[rand(solution.length)]]
	end

	#Affiche les méthodes de résolution
	def afficherLesMethodesDeResolution

	end

	#Retourne la liste des cases qui ont plusieurs candidats mais une solution unique
	def candidatUnique()
		listeCase = Array.new
		@partie.getPlateau().each do |x,y,laCase|
			if (laCase.getSolutionJoueur() == nil)
				for n in (0...9)
					add = !(@partie.getPlateau.getRegion(x,y).include?(n))

					break if add == false

					if x%3 == 2
						add = (@partie.getPlateau().getLigne(x-1).include?(n)) || (@partie.getPlateau().getLigne(x-2).include?(n))
					elsif x%3 == 1
						add = (@partie.getPlateau().getLigne(x+1).include?(n)) || (@partie.getPlateau().getLigne(x-1).include?(n))
					else
						add = (@partie.getPlateau().getLigne(x+1).include?(n)) || (@partie.getPlateau().getLigne(x+2).include?(n))
					end

					break if add == false

					if x%3 == 2
						add = (@partie.getPlateau().getColonne(x-1).include?(n)) || (@partie.getPlateau().getColonne(x-2).include?(n))
					elsif x%3 == 1
						add = (@partie.getPlateau().getColonne(x+1).include?(n)) || (@partie.getPlateau().getColonne(x-1).include?(n))
					else
						add = (@partie.getPlateau().getColonne(x+1).include?(n)) || (@partie.getPlateau().getColonne(x+2).include?(n))
					end

					if add 
						listeCase.push(Position.new(x,y))
					end
				end
			end
		end

		# print "listeCase", listeCase

		if listeCase.empty?
			return nil 
		end

		return listeCase
	end
	
		# Retourne une liste de case
		def singleBox()
			listeCase = Array.new
			@partie.getPlateau().each do |x,y,laCase|
				if (laCase.getSolutionJoueur() == nil)
					for candidat in laCase.getCandidat().getListeCandidat
						add = true
						ligne = true
						colonne = true

						posX = posX-(x%3)
						posY = posY-(y%3)

						for n in (posX...posX+3)
							for m in (posY...posY+3)
								if @partie.getPlateau.getCase(Position.new(n,m)).getSolutionJoueur() == nil
									if n == x
										if ligne 
											ligne = @partie.getPlateau.getCase(Position.new(n,m)).getCandidat.include?(candidat)
										end
									elsif m == y
										if colonne
											colonne = @partie.getPlateau.getCase(Position.new(n,m)).getCandidat.include?(candidat)
										end
									else
										add = !(@partie.getPlateau.getCase(Position.new(n,m)).getCandidat.include?(candidat))
									end
								end
								break if add == false || (ligne == false && colonne == false)
							end
							break if add == false || (ligne == false && colonne == false)
						end

						if add 
							if ligne

							elsif colonne

							end
						# Supprimer le candidat des autres cases de la ligne ou de la colonne
					end
				end
			end
		end

		# print "listeCase", listeCase

		if listeCase.empty?
			return nil 
		end

		return listeCase
	end
end
