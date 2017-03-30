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

	#Retourne la liste des cases qui ont un candidat unique
	def candidatsUniques()

	end
end
