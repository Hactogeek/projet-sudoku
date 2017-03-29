require 'gtk3'


class Boutons < Gtk::Box
	@grille
	@stylo = true
	@sousGrille


	def new(grille, sousGrille)
		initialize(grille, sousGrille)
	end

	def initialize(grille, sousGrille)
		super(:horizontal, 11)
		set_homogeneous(true)

		@grille = grille
		@sousGrille = sousGrille

		override_background_color(:normal, Gdk::RGBA::new(0.3,0.3,0.3,1.0))

		for i in 1..9
			btn = Gtk::Button.new(:label => i.to_s(), :use_underline => nil, :stock_id => nil)
			btn.signal_connect "clicked" do |widget|
				if (@stylo)
					@grille.setValeurSurFocus(widget.label)
					@grille.resetColorOnAll()
					@grille.setColorOnValue(widget.label, COUL_VERT)
					@sousGrille.loadAllCandidats()
				else
					@sousGrille.setCandidatSurFocus(widget.label)
				end
			end
			add(btn)
		end
		setCouleurBoutons("#4169E1")

		#quand le bouton "stylo" est clique, passe en mode "crayon", et inversement
		btn = Gtk::Button.new(:label => "Craie", :use_underline => nil, :stock_id => nil)
		btn.signal_connect "clicked" do |widget|
			if(@stylo)
				widget.set_label("Stylo")
				setCouleurBoutons("#a2a2a2")
				@stylo = false	

			else
				widget.set_label("Craie")	
				setCouleurBoutons("#900090")
				@stylo = true
			end

		end

		add(btn)

		btn = Gtk::Button.new(:label => "Gommer", :use_underline => nil, :stock_id => nil)
		btn.signal_connect "clicked" do |widget|
			@grille.setValeurSurFocus("")
		end
		#add(btn)
	end

	def setCouleurSurFocus(couleur) # change couleur du focus
		if (@focus)
			@focus.override_background_color(:normal, couleur)
		end
	end

	def resetCouleurSurFocus() # change couleur du focus
		if (@focus)
			@focus.override_background_color(:normal, COUL_BLANC)
		end
	end

	def setCouleurBoutons(couleur) # change couleur du focus
		for i in 2..10
			text = children()[children().size()-i].label
			children()[children().size()-i].children()[0].set_markup("<span foreground=\"#{couleur}\">#{text}</span>")
		end
	end

end