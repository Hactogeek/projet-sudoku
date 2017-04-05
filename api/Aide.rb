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

	#Retourne la liste des cases qui ont plusieurs candidats mais une solution unique
	def candidatUnique()
		listeCase = Array.new
		@partie.getPlateau().each do |x,y,laCase|
			if (laCase.getSolutionJoueur() == nil)
				for n in (0...9)
					add = !(@partie.getPlateau.getRegion(x,y).include?(n))

					break if add == false

					if x%3 == 2
						add = !(@partie.getPlateau().getLigne(x-1).include?(n)) || (@partie.getPlateau().getLigne(x-2).include?(n))
					elsif x%3 == 1
						add = !(@partie.getPlateau().getLigne(x+1).include?(n)) || (@partie.getPlateau().getLigne(x-1).include?(n))
					else
						add = !(@partie.getPlateau().getLigne(x+1).include?(n)) || (@partie.getPlateau().getLigne(x+2).include?(n))
					end

					break if add == false

					if x%3 == 2
						add = !(@partie.getPlateau().getColonne(x-1).include?(n)) || (@partie.getPlateau().getColonne(x-2).include?(n))
					elsif x%3 == 1
						add = !(@partie.getPlateau().getColonne(x+1).include?(n)) || (@partie.getPlateau().getColonne(x-1).include?(n))
					else
						add = !(@partie.getPlateau().getColonne(x+1).include?(n)) || (@partie.getPlateau().getColonne(x+2).include?(n))
					end

					if add 
						listeCase.push(Position.new(x,y))
					end
				end
			end
		end

		# print "\n\tlisteCase", listeCase

		if listeCase.empty?
			return nil 
		end

		return listeCase
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
		return ["Pas de méthode pour t'aider !", nil]
	end

	#Affiche les méthodes de résolution
	def afficherLesMethodesDeResolution

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
	
	
	# Méthode qui applique la technique Interactions entre régions
	# @return listePosistion
	def interactionsEntreRegions
		listePos = Array.new
		
		# Pour chaque case
		for x in (0...9)
			for y in (0...9)
				# Pour chaque symbole	
				for symbole in (0...9)	
					# On test pour la ligne	
					lignePresent, ligneAbsent, region, regionEnlever = getLigneInteractionsEntreRegions(x, y)
					if testInteractionsEntreRegions(symbole, lignePresent, ligneAbsent, region, regionEnlever)
						print("\n Symbole :"+symbole.to_s)

						lignePresent.each { |kase|
							pos = kase.getPosition()
							print("\n x="+pos.getX.to_s+", y="+pos.getY.to_s)
							listePos.push(pos)
						}
						return listePos
					end
					# On test pour la colonne
					colonnePresent, colonneAbsent, region, regionEnlever = getColonneInteractionsEntreRegions(x, y)
					if testInteractionsEntreRegions(symbole, colonnePresent, colonneAbsent, region, regionEnlever)
						print("\n Symbole :"+symbole.to_s)

						colonnePresent.each { |kase|
							pos = kase.getPosition()
							print("\n x="+pos.getX.to_s+", y="+pos.getY.to_s)
							listePos.push(pos)
						}
						return listePos
					end
				end
			end
		end	
		
		return listePos
	end

	def testInteractionsEntreRegions(symbole, listePresent, listeAbsent, region, regionEnlever)
			
		return ((Aide.listeContientCandidatSymbole(listeAbsent, symbole) == false) &&
			(Aide.listeContientSymbole(region, symbole) == false) &&
			(Aide.listeContientCandidat(listePresent, symbole) == true) &&
			(Aide.listeContientCandidat(regionEnlever, symbole) == true))
			
	end

	# Méthode qui retourne les donnees necessaire à la methode interactionsEntreRegions
	# @return lignePresent, ligneAbsent, region, regionEnlever
	def getColonneInteractionsEntreRegions(x, y)
		colonnePresent = @partie.getPlateau().getColonneRegion(x,y)
		colonneAbsent = @partie.getPlateau().getColonneAutreRegion(x,y)
		region = @partie.getPlateau().getCaseRegion(x,y)
		
		regionEnlever = Array.new
		
		region.each { |kase|
			regionEnlever.push(kase)
		}
		colonnePresent.each { |kase|
			regionEnlever.delete(kase)
		}
		return colonnePresent, colonneAbsent, region, regionEnlever
	end

	# Méthode qui retourne les donnees necessaire à la methode interactionsEntreRegions
	# @return lignePresent, ligneAbsent, region, regionEnlever
	def getLigneInteractionsEntreRegions(x, y)
		lignePresent = @partie.getPlateau().getLigneRegion(x,y)
		ligneAbsent = @partie.getPlateau().getLigneAutreRegion(x,y)
		region = @partie.getPlateau().getCaseRegion(x,y)
		
		regionEnlever = Array.new
		
		region.each { |kase|
			regionEnlever.push(kase)
		}
		lignePresent.each { |kase|
			regionEnlever.delete(kase)
		}
		return lignePresent, ligneAbsent, region, regionEnlever
	end

	# Méthode qui indique si la liste de case contient le candidat
	# @param candidat
	# @return boolean
	def self.listeContientCandidat(listeCase, candidat)
		listeCase.each { |kase|
			if ((kase.getSolutionJoueur() == nil && kase.getCandidat().include?(candidat) == true) )
				return true
			end
		}

		return false
	end

	def self.listeContientCandidatSymbole(listeCase, candidat)
		listeCase.each { |kase|
			if ((kase.getSolutionJoueur() == nil && kase.getCandidat().include?(candidat) == true) || (kase.getSolutionJoueur() == candidat ))
				return true
			end
		}

		return false
	end

	# Méthode qui indique si la liste de case contient le symbole
	# @param symbole
	# @return boolean
	def self.listeContientSymbole(listeCase, symbole)
		listeCase.each { |kase|
			if (kase.getSolutionJoueur() == symbole )
				return true
			end
		}

		return false
	end
end
