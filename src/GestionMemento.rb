class GestionMemento
	#@partie
	#@undos
	#@redos

	private_class_method :new

	# Constructeur de la classe
	# * [Paramètre :]
	# 				plateau	
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
	# * [Retourne :]
	# 				booleen	
	def canUndo?
		return @undos.empty? == false
	end

	# Méthode qui retourne vrai si on peut redo, sinon faux
	# * [Retourne :]
	# 				booleen	
	def canRedo?
		return @redos.empty? == false
	end

	# Méthode qui permet de sauvegarder un memento.
	# * [Retourne :]
	# 				self	
	def addMemento()
		plateau = Marshal.dump(@partie.getPlateau())
		@undos.push(plateau)
		@redos.clear
		return self
	end

	# Méthode qui permet de revenir à l'état précédant la dernière action
	# * [Retourne :]
	# 				memento ou nil	
	def undo
		if self.canUndo? then
			dernierMemento = Marshal.dump(@partie.getPlateau())
			@redos.push(dernierMemento)
			plateau = @undos.pop
			plateau = Marshal.load(plateau)
			@partie.setPlateau(plateau)
			print("\n","Undo effectue")
		end
		return nil
	end

	# Méthode qui permet de revenir à l'état suivant la dernière action
	# * [Retourne :]
	# 				memento ou nil	
	def redo
		if self.canRedo? then
			dernierMemento = Marshal.dump(@partie.getPlateau())
			@undos.push(dernierMemento)
			plateau = @redos.pop
			plateau = Marshal.load(plateau)
			@partie.setPlateau(plateau)
			print("\n","Redo effectue")
		end
		return nil
	end
end
