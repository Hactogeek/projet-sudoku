require 'gtk3'

class Boutons < Gtk::Box
	@grille
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
				@grille.setValeurSurFocus(widget.label)
				@grille.resetColorOnAll()
				@grille.setColorOnValue(widget.label, COUL_VERT)
				@sousGrille.loadAllCandidats()
			end
			add(btn)
		end
		btn = Gtk::Button.new(:label => "Stylo", :use_underline => nil, :stock_id => nil)
		btn.signal_connect "clicked" do |widget|

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

end