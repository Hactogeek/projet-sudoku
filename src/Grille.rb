require 'gtk3'

COUL_BLEU   = Gdk::RGBA::new(0.4,0.7,1.0,1.0)
COUL_ROUGE  = Gdk::RGBA::new(1.0,0.4,0.4,1.0)
COUL_VERT   = Gdk::RGBA::new(0.5,0.9,0.3,1.0)
COUL_JAUNE  = Gdk::RGBA::new(1.0,0.9,0.3,1.0)
COUL_VIOLET = Gdk::RGBA::new(0.7,0.4,0.8,1.0)

class Grille < Gtk::Table
	@focus # case actuellement selectionné

	def initialize ()
		super(9, 9, true)
		set_margin_left(1)
		for i in 0..8
			for y in 0..8
				attach(Gtk::EventBox.new(), y, y+1, i, i+1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 1,1)
				children().first().add(Gtk::Label.new().set_markup("<span font-weight=\"bold\">#{y+1}</span>"))
				children().first().set_size_request(46,46)
			end
		end
	end

	def setCaseValeur(x, y, valeur)
		children()[81 - ((x)+((y-1)*9))].children[0].set_markup("<span size=\"x-large\" font-weight=\"bold\">#{valeur}</span>")
	end

	def setValeurSurFocus(valeur) # Mettre en place systeme focus quand click sur Case
		children()[1].children[0].set_markup("<span size=\"x-large\" font-weight=\"bold\">#{valeur}</span>")
	end

	def setCouleurCase(x, y, couleur)
		children()[81 - ((x)+((y-1)*9))].override_background_color(:normal, couleur)
	end

	def testCouleur()
		children()[76].override_background_color(:normal, COUL_VIOLET)
	    children()[11].override_background_color(:normal, COUL_JAUNE)
	    children()[49].override_background_color(:normal, COUL_BLEU)
	    children()[52].override_background_color(:normal, COUL_ROUGE)
	    children()[37].override_background_color(:normal, COUL_VERT)	    
	    children()[38].override_background_color(:normal, COUL_VIOLET)	
	    children()[42].override_background_color(:normal, COUL_VERT)    
	    children()[45].override_background_color(:normal, COUL_JAUNE)
	    children()[25].override_background_color(:normal, COUL_ROUGE)	    
	    children()[67].override_background_color(:normal, COUL_BLEU)
	end
end