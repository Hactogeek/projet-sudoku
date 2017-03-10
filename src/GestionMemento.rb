class GestionMemento
	#@plateau
	#@undos
	#@redos

	private_class_method :new

	# Constructeur de la classe
	# @param : plateau	
	def GestionAction.creer(plateau)
		new(plateau)
	end

	def initialize(plateau)
		@undos = Array.new
		@redos = Array.new
		@plateau = plateau
		return self
	end

	# Méthode qui retourne vrai si on peut undo, sinon faux
	# @return : vrai ou faux
	def canUndo?
		return @undos.empty? == false
	end

	# Méthode qui retourne vrai si on peut redo, sinon faux
	# @return : vrai ou faux
	def canRedo?
		return @redos.empty? == false
	end

	# Méthode qui permet d'executer une action placée en paramètre, elle gère également la sauvegarde de l'état precedant et suivant l'action dans le memento.
	# @param action : action a executer
	# @return : self
	def exec(action)
		avant = plateau.etatCourant
		action.exec
		apres = plateau.etatCourant
		@undos.push(AvantApres.creer(avant, apres))
		@redos.clear
		return self
	end

	# Méthode qui permet de revenir à l'état précédant la dernière action
	# @return : self
	def undo
		if @undos.empty? == false
			dernierMemento = @undos.pop
			dernierMemento.avant.restaurer
			@redos.push(dernierMemento)
		end
		return self
	end

	# Méthode qui permet de revenir à l'état suivant la dernière action
	# @return : self
	def redo
		if @redos.empty? == false
			dernierMemento = @redos.pop
			dernierMemento.apres.restaurer
			@undos.push(dernierMemento)
		end
		return self
	end
end
