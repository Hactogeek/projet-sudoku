# Timer, le chronomètre du Sudoku
# * *Variable*	:
#    - +accumulated+ ->  Le temps accumulé  (seconde)
#    - +elapsed+ -> Le temps écoulé entre t0 et t1
#	 - +start+ -> Variable du temps

# * *Heritage*	: Aucun lien
#

class Timer

	#Le temps accumulé  (seconde)
	@accumulated
	#Le temps écoulé entre t0 et t1
	@elapsed
	#Variable du temps
	@start
	#Temps du timer
	@time

	attr_reader :accumulated, :elapsed

	# Méthode  d'initialisation et de lancement du timer
	# * [Paramètre :]
	# 				secStart le temps de l'initialisation que l'on souhaite pour l'amorçage du Timer en seconde
	def start (secStart)
		@accumulated = secStart
		@elapsed = 0
		@start = Time.now
	end


	# Méthode de pause du timer
	def stop
		if(@elapsed!=nil)
			@elapsed = Time.now - @start
			@accumulated += @elapsed
		end
	end


	# Méthode de remise à zero du Timer
	def reset
		@accumulated = 0
		@elapsed = 0
		@start = Time.now
	end


	#  Méthode qui permet d'ajouter un nombre de seconde de "pénalité"
	def penalite (s)
		@accumulated = @accumulated+s
	end


	#  Méthode qui calcule le temps passé et le renvoie
	def tick
		@elapsed = Time.now - @start
		time=@accumulated+@elapsed
		h = sprintf('%02i', (time.to_i / 3600))
		m = sprintf('%02i', ((time.to_i % 3600) / 60))
		s = sprintf('%02i', (time.to_i % 60))
		newtime = "#{h}:#{m}:#{s}"
	end

	def getTime
		@elapsed = Time.now - @start
		time=@accumulated+@elapsed
		return time
	end

	#  Méthode qui renvoie accumulated
	def getAccumulated
		return @accumulated
	end

	# Méthode qui donne la date du jour 
	def donnerDate
		time = Time.now
		time.strftime("%d %B %Y")
	end 

end #Fin de la classe Timer



	######TEST#######
	# watch = Timer.new

	# watch.start(0)
	# while (sleep 0.2) do
	#   puts watch.tick
	# end