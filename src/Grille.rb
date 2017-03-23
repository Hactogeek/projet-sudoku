require 'gtk3'

COUL_BLEU   = Gdk::RGBA::new(0.4,0.7,1.0,1.0)
COUL_ROUGE  = Gdk::RGBA::new(1.0,0.4,0.4,1.0)
COUL_VERT   = Gdk::RGBA::new(0.5,0.9,0.3,1.0)
COUL_JAUNE  = Gdk::RGBA::new(1.0,0.9,0.3,1.0)
COUL_JAUNE_PALE  = Gdk::RGBA::new(1.0,0.9,0.3,0.4)
COUL_VIOLET = Gdk::RGBA::new(0.7,0.4,0.8,1.0)
COUL_BLANC  = Gdk::RGBA::new(1.0,1.0,1.0,1.0)



class Grille < Gtk::Table
	@focus # case actuellement selectionné

	def initialize ()
		super(9, 9, true)
		set_margin_left(1)

		#==========================#
		# Remplissage de la grille #
		#==========================#
	    @generateur = Generateur.new
	    @generateur.make_valid
	    remplirGrille()
	end

	def setCaseValeur(x, y, valeur)

		#children()[81 - ((x)+((y-1)*9))].children[0].set_markup("<span size=\"x-large\" font-weight=\"bold\">#{valeur}</span>")
	end

	def setValeurSurFocus(valeur) # Mettre en place systeme focus quand click sur Case
		if (@focus)
			@focus.children().first().set_markup("<span size=\"x-large\" font-weight=\"bold\">#{valeur}</span>")
		end
	end

	def setCouleurSurFocus(couleur) # change couleur du focus
		if (@focus)
			css=<<-EOT
	   		#cell{
	      	background: #{COUL_BLEU};
	    	}
	    	EOT
	    	css_provider = Gtk::CssProvider.new
	    	css_provider.load :data=>css
			@focus.style_context.add_provider css_provider,GLib::MAXUINT
		end
		
	end

	def setColorOnValue(value, couleur)
		for i in 0..self.children().size()-1
			if (self.children()[i].children().first().text == value)
				self.children()[i].override_background_color(:normal, couleur)
			end
		end
	end

	def resetColorOnAll()
		for i in 0..self.children().size()-1
			css=<<-EOT
	   		#cell{
	      	background: #{COUL_BLANC};
	    	}
	    	EOT
	    	css_provider = Gtk::CssProvider.new
	    	css_provider.load :data=>css
			self.children()[i].style_context.add_provider css_provider,GLib::MAXUINT
		end
	end

	def resetCouleurSurFocus() # change couleur du focus
		if (@focus)
			css=<<-EOT
	   		#cell{
	      	background: #{COUL_BLANC};
	    	}
	    	EOT
	    	css_provider = Gtk::CssProvider.new
	    	css_provider.load :data=>css
			@focus.style_context.add_provider css_provider,GLib::MAXUINT
		end
	end

	def setCouleurCase(x, y, couleur)
		children()[81 - ((x)+((y-1)*9))].override_background_color(:normal, couleur)
	end

	def rafraichirGrille()
		@generateur.each { |x,y,val|
			print(x , " " , y)  
			children()[81 - ((x+1)+((y)*9))].children().first().set_markup("<span size=\"x-large\" font-weight=\"bold\">#{val}</span>")
	    }
	end

	def remplirGrille()
		@generateur.each { |x,y,val|  
			btn = Gtk::Button.new()
			btn.override_background_color(:normal, COUL_BLANC)
			btn.signal_connect "clicked" do |widget|
				resetCouleurSurFocus()
				@focus = widget
				resetColorOnAll()
				setColorOnValue(widget.children().first().text, COUL_JAUNE_PALE)
				setCouleurSurFocus(COUL_JAUNE)
			end
			resetColorOnAll()
			attach(btn, y, y+1, x, x+1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 1,1)
			btn.add(Gtk::Label.new().set_markup("<span size=\"x-large\" font-weight=\"bold\">#{val}</span>"))
			btn.set_size_request(46,46)
			btn.set_name "cell"
	    }
	end
end