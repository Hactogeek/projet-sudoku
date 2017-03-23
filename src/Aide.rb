require './plateau'

class Aide
	def Aide.creer(plateau)
		new(plateau)
	end

	def initialize(plateau)
		@plateau=plateau
	end

	#Place tous les candidats de la case
	def candidatPossible(pos)

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
	def explicationChoix(candidat, pos)

	end

	#Indique si la case à cette position est valide
	def validerCase(pos)

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
