require './Plateau'

class Aide
	def Aide.creer(plateau)
		new(plateau)
	end

	def initialize(plateau)
		@plateau=plateau
	end

	#Place tous les candidats de la case
	def candidatPossible(position)
		@plateau.setCaseListeCandidat(position, @plateau.candidatPossible(position))
	end

	# Méthode qui retourne la position des cases avec un unique candidat
	def caseResolvable
		tabCase = Array.new()

		@plateau.each do |x,y,laCase| 
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
	def explicationChoix(candidat, pos)

	end

	#Indique si la case à cette position est valide
	def verificationGrille
		listePos = @plateau.caseIncorrect
		if listePos.empty?
			print("\nIl n'y a pas d'erreur dans la grille")	
		else
			print("\nVoici la ou les cases erronées :")
			listePos.each { |pos|
				print("\n\tcase x = "+pos.getX+", y = "+pos.getY)
			}
		end
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
