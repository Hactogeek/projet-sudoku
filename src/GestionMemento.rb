class GestionMemento
	#@plateau
	#@undos
	#@redos

	private_class_method :new

	# Constructeur de la classe
	# @param : plateau	
	def GestionMemento.creer(plateau)
		new(plateau)
	end

	def initialize
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

	# Méthode qui permet de sauvegarder un memento.
	# @return : self
	def addMemento()
		@undos.push(@plateau)
		@redos.clear
		return self
	end

	# Méthode qui permet de revenir à l'état précédant la dernière action
	# @return : memento ou nil
	def undo
		if @undos.empty? == false
			dernierMemento = @undos.pop
			@redos.push(dernierMemento)
			return dernierMemento
		end
		return nil
	end

	# Méthode qui permet de revenir à l'état suivant la dernière action
	# @return : memento ou nil
	def redo
		if @redos.empty? == false
			dernierMemento = @redos.pop
			@undos.push(dernierMemento)
			return dernierMemento
		end
		return nil
	end
end
