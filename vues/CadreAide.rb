require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class CadreAide < Gtk::Table
	@grille
	@sousGrille
	@labelAide
	@backButton
	@moreButton
	@hintButton
	@finishButton

	def initialize (grille, sousGrille)
		super(12,8,true)
		@grille = grille
		@sousGrille = sousGrille
		@grille.setCadreAide(self)

		# candidatSwitch = Gtk::Switch.new()
		# candidatSwitch.signal_connect('state-set') do
		# 	if candidatSwitch.active?
		# 		@sousGrille.setCandidatState(true)
		# 	else
		# 		@sousGrille.setCandidatState(false)
		# 	end
		# end
		# candidatLabel  = Gtk::Label.new("Activer/Desactiver Candidats : ")
		# attach(candidatSwitch, 6,8, 11,12)
		# attach(candidatLabel , 3,6, 11,12)

		@labelAide = Gtk::Label.new("")
		attach(@labelAide, 0,8, 1,3)

		@imgEvent=Gtk::EventBox.new
		attach(@imgEvent, 0,8, 3,10)

		@hintButton = Gtk::Button.new(:label =>"Indice", :use_underline => nil, :stock_id => nil)
		@hintButton.signal_connect "clicked" do |widget|
			startHint()
		end
		attach(@hintButton, 3,5 ,0,1)
	end

	def startHint()
		pos=@grille.getPartie.getAide.coupSuivant
		if(pos[0]!=0)
			if(pos[0]==1 || pos[0]==3)
				setAideText("Regardez ce que vous pouvez faire dans cette région.")
				region=@grille.getPartie.getPlateau.getCaseRegion(pos[1].getX,pos[1].getY)
				region.each do |x|
					@grille.setCouleurCase(x.getPosition.getX, x.getPosition.getY, COUL_ORANGE)
				end
			elsif(pos[0]==2)
				setAideText("Il serait utile d'écrire les candidats pour chaque case.")
			end

			if(@backButton == nil || !@backButton.no_show_all?)
				@backButton = Gtk::Button.new(:label =>"Retour", :use_underline => nil, :stock_id => nil)
				@backButton.signal_connect "clicked" do |widget|
					previousHint()
				end
				attach(@backButton, 0,2 ,0,1)

				@moreButton = Gtk::Button.new(:label =>"Suivant", :use_underline => nil, :stock_id => nil)
				@moreButton.signal_connect "clicked" do |widget|
					moreHint(pos)
				end
				attach(@moreButton, 3,5 ,0,1)

				@finishButton = Gtk::Button.new(:label =>"Finir", :use_underline => nil, :stock_id => nil)
				@finishButton.signal_connect "clicked" do |widget|
					cancelHint()
				end
				attach(@finishButton, 6,8 ,0,1)
			end

			@backButton.show
			@backButton.sensitive = false
			@moreButton.show
			@finishButton.show
			@hintButton.hide
		end
	end

	def moreHint(pos)
		if(pos[0]==1 || pos[0]==3)
			setAideText("Regardez cette case.")
			@grille.resetColorOnAll
			@grille.setFocus(@grille.children[80-(9*pos[1].getY+pos[1].getX)])
			@grille.setCouleurCase(pos[1].getX, pos[1].getY, COUL_ORANGE)
			remove(@moreButton)
			@moreButton2 = Gtk::Button.new(:label =>"Suivant", :use_underline => nil, :stock_id => nil)
			attach(@moreButton2, 3,5 ,0,1)
			@moreButton2.signal_connect "clicked" do |widget|
				moreHint2(pos)
			end
			@moreButton2.show
		elsif(pos[0]==2)
			setAideText("Voilà, ça va aller mieux comme ça.")
			#puts("CANDIDAT? : " + @grille.getPartie.getPlateau.getCase(Position.new(2,3)).getCandidat.getListeCandidat.to_s)
			@sousGrille.loadAllCandidats
			@moreButton.sensitive = false
		end
	end

	def moreHint2(pos)
		if(pos[0]==1 || pos[1]==3)
			setAideText("Voici la solution")
			@grille.setValeurSurFocus(@grille.getPartie.getPlateau.getCaseOriginale(Position.new(pos[1].getX,pos[1].getY)))
			@sousGrille.loadCandidatsCase(pos[1].getX,pos[1].getY)


			@moreButton.sensitive = false
			@learnButton=Gtk::Button.new(:label =>"Apprendre", :use_underline => nil, :stock_id => nil)
			remove(@backButton)
			@learnButton.sensitive = true
			attach(@learnButton, 0,2 ,0,1)
			@learnButton.show
			@learnButton.signal_connect "clicked" do |widget|
				if(@img!=nil)
					@imgEvent.remove(@img)
				end
				if(pos[0]==1)
					setAideText("En regardant attentivement la grille, vous pouvez remarquer\nque le 8 ne peut être posé qu'à un seul endroit dans la région 6.")
					begin
						@img=Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/hiddenSingle.png", :width => 100, :heigth => 100))
					rescue
						img=Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "./vues/hiddenSingle.png", :width => 100, :heigth => 100))
					end
				elsif(pos[0]==3)
					setAideText("Si après avoir placé tous les candidats pour chaque case du sudoku,\n vous voyez qu'une case ne possède qu'un seul candidat.\n Alors ce candidat est la solution de la case")
					begin
						@img=Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/unSeulCandidat.png", :width => 100, :heigth => 100))
					rescue
						img=Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "./vues/unSeulCandidat.png", :width => 100, :heigth => 100))
					end
				end
				@imgEvent.add(@img)
				@imgEvent.show_all
				@learnButton.sensitive = false
			end
		end
		remove(@moreButton2)
		attach(@moreButton, 3,5 ,0,1)
		@moreButton.show
	end

	def cancelHint()
		@grille.resetColorOnAll()
		@imgEvent.hide
		@backButton.hide()
		@moreButton.hide()
		@finishButton.hide()
		@hintButton.show()
		@labelAide.set_text("")
		if(@learnButton != nil)
			remove(@learnButton)
		end
	end

	# Méthode qui set l'aide	
	# * [Paramètre :]
	# 				titre => le titre de l'aide
	# 				listeCase => la liste des cases
	# 				desc =>  la description de l'aide
	def setAide(titre, listeCase, desc)
		titreFormat = "<span font-weight=\"bold\" size=\"x-large\" foreground=\"#200020\">"+titre+"</span>\n"
		listeCaseFormat = "<span font-style=\"italic\" size=\"large\" >Case:"+ (listeCase.empty? ? "Aucune" : listeCase.to_s) +"</span>\n"
		descFormat = "<span>"+desc+"</span>"
		@labelAide.set_markup(titreFormat + listeCaseFormat + descFormat )
	end

	# Méthode qui défini un texte dans l'aide	
	# * [Paramètre :]
	# 				text => texte de l'aide
	def setAideText(text)
		textFormat = "<span size=\"large\" foreground=\"#200020\">"+text.to_s+"</span>\n"
		@labelAide.set_markup(textFormat)
	end
end