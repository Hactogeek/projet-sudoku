class GestionMemento
	#@plateau
	#@undos
	#@redos

	private_class_method :new

	def GestionAction.creer(plateau)
		new(plateau)
	end

	def initialize(plateau)
		@undos = Array.new
		@redos = Array.new
		@plateau = plateau
	end

	def canUndo?
		return @undos.empty? == false
	end

	def canRedo?
		return @redos.empty? == false
	end

	def exec(action)
		avant = plateau.etatCourant
		action.exec
		apres = plateau.etatCourant
		@undos.push(AvantApres.creer(avant, apres))
		@redos.clear
	end

	def undo
		if @undos.empty? == false
			dernierMemento = @undos.pop
			dernierMemento.avant.restaurer
			@redos.push(dernierMemento)
		end
	end

	def redo
		if @redos.empty? == false
			dernierMemento = @redos.pop
			dernierMemento.apres.restaurer
			@undos.push(dernierMemento)
		end
	end
end
