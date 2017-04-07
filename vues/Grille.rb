require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }


class Grille < Gtk::Table
	attr_reader :colorFocus, :colorEquals, :colorError, :colorNeutral, :colorTextOriginal, :colorTextPlayer

	def initialize (partie, joueur)
		super(9, 9, true)
		set_margin_left(1)
		@partie = partie
		@nbAide=0
		@joueur=joueur
		loadStyle()
	end

	def setCaseValeur(x, y, valeur)

		#children()[81 - ((x)+((y-1)*9))].children[0].set_markup("<span size=\"x-large\" font-weight=\"bold\">#{valeur}</span>")
	end

	def setValeurSurFocus(valeur) # Mettre en place systeme focus quand click sur Case
		if (@focus)
			i = 80 - children().index(@focus)
			pos = Position.new(i%9,i/9)
			#print("\n", i, " : x=",i/9, " y=", i%9)
			if (@partie.getPlateau().getCaseJoueur(pos) != valeur) && (@partie.getPlateau().getCase(pos).getOriginaleGrille == false)
				#Sauvegarde du plateau dans le undoRedo
				@partie.getUndoRedo().addMemento

				@partie.getPlateau().setCaseJoueur(pos,valeur)
				valeur = @partie.getPlateau().getCaseJoueur(pos)
				@focus.children().first().set_markup("<span size=\"x-large\" foreground=\"#{@colorTextPlayer}\" font-weight=\"bold\">#{valeur}</span>")

				if(@partie.getPlateau.complete?)
					score=0
					if(@partie.getTimer.elapsed==0)
						score=(1000*@partie.getDifficulte)/@partie.getTimer.getTime-@nbAide*10
						#puts("SCORE : " + ((1000*@partie.getDifficulte)/@partie.getTimer.getTime).to_i.to_s)
						#Ajout du score au profil joueur
						@joueur.ajoutScore([Time.now.strftime("%d %B %Y"), score.to_i])
						Sauvegarde.saveJoueur(@joueur,@joueur.getPseudo)
					end
					FinJeu.new(score)
					# @cadreAide.setAide("Félicitations! Vous avez résolu le sudoku.")
					# @cadreAide 
				end
				return
			end

			if (@partie.getPlateau().getCaseJoueur(pos) == valeur) && (@partie.getPlateau().getCase(pos).getOriginaleGrille == false) # Supprime la valeur
				#Sauvegarde du plateau dans le undoRedo
				@partie.getUndoRedo().addMemento
				
				@partie.getPlateau().setCaseJoueur(pos,nil)
				valeur = @partie.getPlateau().getCaseJoueur(pos)
				@focus.children().first().set_markup("<span size=\"x-large\" foreground=\"#{@colorTextPlayer}\" font-weight=\"bold\">#{valeur}</span>")
				return
			end
		end
	end

	def incNbAide(i)
		@nbAide+=i
	end

	def setCouleurSurFocus() # change couleur du focus
		if (@focus)
			css=<<-EOT
			#cell{background: #{@colorFocus};}
			EOT
			css_provider = Gtk::CssProvider.new
			css_provider.load :data=>css
			@focus.style_context.add_provider css_provider,GLib::MAXUINT
		end
	end

	def setColorOnValue(value)
		if (value == "")
			return
		end
		for i in 0..self.children().size()-1
			if (self.children()[i].children().first().text == value)
				css=<<-EOT
				#cell{background: #{@colorEquals};}
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
			#cell{background: #{@colorNeutral};}
			EOT
			css_provider = Gtk::CssProvider.new
			css_provider.load :data=>css
			self.children()[i].style_context.add_provider css_provider,GLib::MAXUINT
		end
		setCouleurSurFocus()
	end

	def colorCaseResolvable()
		casesResolvable = @partie.getAide().caseResolvable()
		casesResolvable.each{ |pos|
			setCouleurAideCase(pos.getX(), pos.getY())
		}
	end

	def colorCaseIncorrect()
		listePos = @partie.getAide().verificationGrille
		if listePos.empty?
			print("\nIl n'y a pas d'erreur dans la grille")	
		else
			listePos.each { |pos|
				setCouleurCase(pos.getX(), pos.getY(), @colorError)
			}
		end

	end

	# Méthode qui color les cases pour la technique interactions entre régions
	def colorInteractionsRegions
		listePos = @partie.getAide().interactionsEntreRegions
		if listePos.empty?
			print("\nLa technique n'est pas possible ici")	
		else
			listePos.each { |pos|
				setCouleurCase(pos.getX(), pos.getY(), @colorError)
			}
		end
	end

	def colorCaseSuivant
		resetCouleurSurFocus()
		pos=@partie.getAide.coupSuivant
		if(pos[1]==nil)
			print("\nIl n'y a pas de coup suivant.")
		else
			a=80-(9*pos[1].getY+pos[1].getX)
			@focus=children[a]
			setCouleurAideCase(pos[1].getX(), pos[1].getY())
		end
		return pos
	end		

	def resetCouleurSurFocus() # change couleur du focus
		if (@focus) 
			css=<<-EOT
			#cell{background: #{@colorNeutral};}
			EOT
			css_provider = Gtk::CssProvider.new
			css_provider.load :data=>css
			@focus.style_context.add_provider css_provider,GLib::MAXUINT
		end
	end

	def setCouleurCase(x, y, couleur)
		css=<<-EOT
		#cell{background: #{couleur};}
		EOT
		css_provider = Gtk::CssProvider.new
		css_provider.load :data=>css
		self.children()[81 - ((x+1)+((y)*9))].style_context.add_provider css_provider,GLib::MAXUINT
	end

	def setCouleurAideCase(x, y)
		css=<<-EOT
		#cell{background: #{@colorAide};}
		EOT
		css_provider = Gtk::CssProvider.new
		css_provider.load :data=>css
		self.children()[81 - ((x+1)+((y)*9))].style_context.add_provider css_provider,GLib::MAXUINT
	end


	def getCoordFocus()
		if (@focus == nil)
			return
		end
		i = 80 - children().index(@focus)
		return Position.new(i%9,i/9)
	end

	def setCoordFocus()
		@focus
	end

	def rafraichirGrille()
		@partie.getPlateau().each { |x,y,val|
			#print(x , " " , y)  
			
			if(@partie.getPlateau().getCase(Position.new(x,y)).getOriginaleGrille == false)
				children()[81 - ((x+1)+((y)*9))].children().first().set_markup("<span size=\"x-large\" foreground=\"#{@colorTextPlayer}\" font-weight=\"bold\">#{val.getSolutionJoueur}</span>")
			else
				children()[81 - ((x+1)+((y)*9))].children().first().set_markup("<span size=\"x-large\" foreground=\"#{@colorTextOriginal}\" font-weight=\"bold\">#{val.getSolutionJoueur}</span>")
			end
		}
	end

	def remplirGrille()
		children().clear()
		@partie.getPlateau().each { |x,y,val|
			btn = Gtk::Button.new()
			btn.signal_connect "clicked" do |widget|
				resetCouleurSurFocus()
				@focus = widget
				resetColorOnAll()
				setColorOnValue(widget.children().first().text)
				setCouleurSurFocus()
			end
			attach(btn, y, y+1, x, x+1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 1,0)
			btn.add(Gtk::Label.new().set_markup("<span size=\"x-large\" foreground=\"#{@colorTextOriginal}\" font-weight=\"bold\">#{val.getSolutionJoueur}</span>"))
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
		loadStyle
		resetColorOnAll
		rafraichirGrille
	end

	def setCadreAide(cadreAide)
		@cadreAide = cadreAide
	end

	def setColorStyle(colorFocus, colorEquals, colorError, colorNeutral, colorTextOriginal, colorTextPlayer) # on définira après pour dissocier les thèmes
		@colorFocus = colorFocus
		@colorEquals = colorEquals
		@colorError = colorError
		@colorNeutral = colorNeutral
		@colorTextOriginal = colorTextOriginal
		@colorTextPlayer = colorTextPlayer
		resetColorOnAll
		rafraichirGrille
	end

	def loadStyle()
		if(@joueur!=nil)
			@colorFocus = @joueur.getPreferences().colorFocus
			@colorEquals = @joueur.getPreferences().colorEquals
			@colorError = @joueur.getPreferences().colorError
			@colorAide = @joueur.getPreferences().colorAide
			@colorNeutral = @joueur.getPreferences().colorNeutral
			@colorTextOriginal = @joueur.getPreferences().colorTextOriginal
			@colorTextPlayer = @joueur.getPreferences().colorTextPlayer
		else
			@colorFocus = "#EFC42E"
			@colorEquals = "#FFEC81"
			@colorError = "#FF6060"
			@colorAide = "#FFA749"
			@colorNeutral = "#FFFFFF"
			@colorTextOriginal ="#000000"
			@colorTextPlayer = "#4169E1"
		end

	end
	def setCadreImportation(cadreImportation)
		@cadreImportation = cadreImportation
	end

	def setFocus(focus)
		@focus=focus
	end
end
