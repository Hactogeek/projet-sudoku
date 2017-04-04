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
		tabCase = Array.new()

		@partie.getPlateau().each do |x,y,laCase| 
			if laCase.getCandidat().getListeCandidat().compact().length() == 1
				tabCase.push(Position.new(x,y))
			end
		end

		return tabCase
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

					break if add = false

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
		return listeCase
	end
	
	
	# Méthode qui applique la technique Interactions entre régions
	# @return listePosistion
	def interactionsEntreRegions
		listePos = Array.new
		@partie.getPlateau
		symbole = 0
		region = nil
		
		# Pour chaque ligne
		for y in (0...9)
			
			# On récupère la ligne en trois partie
			ligne1 = getLigneRegion(0, y)
			ligne2 = getLigneRegion(3, y)
			ligne2 = getLigneRegion(6, y)
			
			# Pour chaque symbole	
			for symbole in (0...9)

				# On test pour les 3 configurations possibles sur la ligne
				if(Aide.listeContientCandidat(ligne1, symbole) == false && Aide.listeContientCandidat(ligne2, symbole) == false	&& Aide.listeContientCandidat(ligne3, symbole) == true)
					#symbole => symbole a enlever
					#ligne3 => ligne ou ce trouve forcement le symbole
					
					region = getCaseRegion(x/3,y/3)
					#enlever la ligne3 dans la region
					ligne3.each { |kase|
						region.delete(kase)
					}
					#region où il faut enlever les candidats
					
					

				elsif(Aide.listeContientCandidat(ligne1, symbole) == true && Aide.listeContientCandidat(ligne2, symbole) == false && Aide.listeContientCandidat(ligne3, symbole) == false)

				elsif(Aide.listeContientCandidat(ligne1, symbole) == false && Aide.listeContientCandidat(ligne2, symbole) == true && Aide.listeContientCandidat(ligne3, symbole) == false)

				end
			end
		end

		# Pour chaque colonne
		# TODO faire la même chose que au dessus



		# On recupere les postions
		if region != nil
			region.each { |kase|
				listePos.push(kase.getPosition())
			}
		end
		return listePos
	end


	# Méthode qui indique si la liste de case contient le candidat
	# @param candidat
	# @return boolean
	def self.listeContientCandidat(listeCase, candidat)
		listeCase.each { |kase|
			if ((kase.getSolutionJoueur() == nil && kase.getCandidat().include?(candidat) == true) || (kase.getSolutionJoueur() == candidat - 1))
				return true
			end
		}

		return false
	end
end
