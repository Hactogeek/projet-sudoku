require 'gtk3'
require './Position.rb'
require './Plateau.rb'
require './Partie.rb'

COUL_BLEU   = Gdk::RGBA::new(0.4,0.7,1.0,1.0)
COUL_ROUGE  = Gdk::RGBA::new(1.0,0.4,0.4,1.0)
COUL_VERT   = Gdk::RGBA::new(0.5,0.9,0.3,1.0)
COUL_JAUNE  = Gdk::RGBA::new(1.0,0.9,0.3,1.0)
COUL_JAUNE_PALE  = Gdk::RGBA::new(1.0,0.9,0.3,0.4)
COUL_VIOLET = Gdk::RGBA::new(0.7,0.4,0.8,1.0)
COUL_BLANC  = Gdk::RGBA::new(1.0,1.0,1.0,1.0)


class Grille < Gtk::Table
	@focus # case actuellement selectionné
	@partie

	def initialize (partie)
		super(9, 9, true)
		set_margin_left(1)

		#==========================#
		# Remplissage de la grille #
		#==========================#
	    @partie = partie
	    @partie.creerPartie()
	    remplirGrille()
	end

	def setCaseValeur(x, y, valeur)

		#children()[81 - ((x)+((y-1)*9))].children[0].set_markup("<span size=\"x-large\" font-weight=\"bold\">#{valeur}</span>")
	end

	def setValeurSurFocus(valeur) # Mettre en place systeme focus quand click sur Case
		if (@focus)
			#Sauvegarde du plateau dans le undoRedo
			@partie.getUndoRedo().addMemento

			i = 80 - children().index(@focus)
			pos = Position.new(i%9,i/9)
			print("\n", i, " : x=",i/9, " y=", i%9)
			@partie.getPlateau().setCaseJoueur(pos,valeur)
			valeur = @partie.getPlateau().getCaseJoueur(pos)
			@focus.children().first().set_markup("<span size=\"x-large\" font-weight=\"bold\">#{valeur}</span>")

		end
	end

	def setCouleurSurFocus(couleur) # change couleur du focus
		if (@focus)
			css=<<-EOT
	   		#cell{
	      	background: #{COUL_JAUNE};
	    	}
	    	EOT
	    	css_provider = Gtk::CssProvider.new
	    	css_provider.load :data=>css
			@focus.style_context.add_provider css_provider,GLib::MAXUINT
		end
		
	end

	def setColorOnValue(value, couleur)
		if (value == "")
			return
		end
		for i in 0..self.children().size()-1
			if (self.children()[i].children().first().text == value)
				css=<<-EOT
		   		#cell{
		      	background: #{COUL_JAUNE_PALE};
		    	}
		    	EOT
		    	css_provider = Gtk::CssProvider.new
		    	css_provider.load :data=>css
				self.children()[i].style_context.add_provider css_provider,GLib::MAXUINT
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
		@partie.getPlateau().each { |x,y,val|
			print(x , " " , y)  
			
			children()[81 - ((x+1)+((y)*9))].children().first().set_markup("<span size=\"x-large\" font-weight=\"bold\">#{val.getSolutionJoueur}</span>")
	    }
	end

	def remplirGrille()
		@partie.getPlateau().each { |x,y,val|
			btn = Gtk::Button.new()
			btn.override_background_color(:normal, COUL_BLANC)
			btn.signal_connect "clicked" do |widget|
				resetCouleurSurFocus()
				@focus = widget
				resetColorOnAll()
				setColorOnValue(widget.children().first().text, COUL_JAUNE_PALE)
				setCouleurSurFocus(COUL_JAUNE)
			end
			attach(btn, y, y+1, x, x+1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 1,1)
			btn.add(Gtk::Label.new().set_markup("<span size=\"x-large\" font-weight=\"bold\">#{val.getSolutionJoueur}</span>"))
			btn.set_size_request(46,46)
			btn.set_name "cell"
	    }
	   	resetColorOnAll()
	end

	def getPartie()
		return @partie
	end

	def setPartie(partie)
		@partie=partie
	end
end
