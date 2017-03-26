class GestionMemento
	#@partie
	#@undos
	#@redos

	private_class_method :new

	# Constructeur de la classe
	# @param : plateau	
	def GestionMemento.creer(partie)
		new(partie)
	end

	def initialize(partie)
		@undos = Array.new
		@redos = Array.new
		@partie = partie
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
		plateau = Marshal.dump(@partie.getPlateau())
		@undos.push(plateau)
		@redos.clear
		return self
	end

	# Méthode qui permet de revenir à l'état précédant la dernière action
	# @return : memento ou nil
	def undo
		if self.canUndo? then
			dernierMemento = @undos.pop
			@redos.push(dernierMemento)
			dernierMemento = Marshal.load(dernierMemento)
			@partie.setPlateau(dernierMemento)
			print("\n","Undo effectue")
		end
		return nil
	end

	# Méthode qui permet de revenir à l'état suivant la dernière action
	# @return : memento ou nil
	def redo
		if self.canRedo? then
			dernierMemento = @redos.pop
			@undos.push(dernierMemento)
			dernierMemento = Marshal.load(dernierMemento)
			@partie.setPlateau(dernierMemento)
			print("\n","Redo effectue")
		end
		return nil
	end
end
