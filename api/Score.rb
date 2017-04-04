# Score 
# * *Variable*	:
#    - +score+ ->  le score du joueur


# * *Heritage*	: Aucun lien
#
class Score

	 attr_accessor :score
	 private_class_method :new

	 def Score.creer
	 	new
	 end 
	# Constructeur de la classe  Score
	def initialize 
		@score=0
	end 

	# Méthode qui renvoie le score
	# * [Retourne :]
	# 				Le score
	def getScore
		return @score
	end 


	# Méthode qui modifie le score d'un joueur
	# * [Paramètre :]
	# 				time -> La durée d'une partie
	# 				niveauDifficulte -> la difficulté de la partie
	def setScore(time,niveauDifficulte)
		 @score=(1000*niveauDifficulte)/time
	end 


end 