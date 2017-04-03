require './Plateau'

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
end
