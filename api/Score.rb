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

	# * *Description*:
	#
	# méthode permettant de donner le score d'un joueur
	# * *Paramètre*: Aucun
	#
	# * *Exemple*:
	#
	# unScore.getScore
	#
	def getScore
		return @score
	end 

	# * *Description*:
	#
	# méthode permettant de modifier le score d'un joueur
	# * *Paramètre*: 
	# - +time+ -> le temps d'une partie
	# - +niveauDifficulte+ -> niveau de difficulté de la partie où a été réalisé le score
	# * *Exemple*:
	#
	# unScore.setScore
	#
	def setScore(time,niveauDifficulte)
		 @score=(1000*niveauDifficulte)/time
	end 


end 