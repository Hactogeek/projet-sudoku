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
		@grille.incNbAide(1)
		pos=@grille.getPartie.getAide.coupSuivant
		#puts("StartHINT : " + pos[0].to_s)
		if(pos[0]!=0)
			if(pos[0]==1 || pos[0]==3 || pos[0]==4)
				i=getPos(pos)[0]
				j=getPos(pos)[1]
				if(pos[0]==3)
					if(pos[1][2]==0)
						setAideText("Regardez ce que vous pouvez faire dans cette région.")
						aColorer=@grille.getPartie.getPlateau.getCaseRegion(i,j)
					elsif(pos[1][2]==1)
						setAideText("Regardez ce que vous pouvez faire dans cette ligne.")
						aColorer=@grille.getPartie.getPlateau.getLigne(i)
					else
						setAideText("Regardez ce que vous pouvez faire dans cette colonne.")
						aColorer=@grille.getPartie.getPlateau.getColonne(j)
					end
				else
					setAideText("Regardez ce que vous pouvez faire dans cette région.")
					aColorer=@grille.getPartie.getPlateau.getCaseRegion(i,j)
				end
				aColorer.each do |x|
					@grille.setCouleurAideCase(x.getPosition.getX, x.getPosition.getY)
				end
			elsif(pos[0]==2)
				setAideText("Soit vous n'avez pas mis de candidats, soit il y en qui sont faux")
			elsif(pos[0]==5)
				setAideText("REGION INTERACTION")
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
		if(pos[0]==1 || pos[0]==3 || pos[0]==4)
			setAideText("Regardez cette case.")
			@grille.resetColorOnAll
			i=getPos(pos)[0]
			j=getPos(pos)[1]
			@grille.setFocus(@grille.children[80-(9*j+i)])
			@grille.setCouleurAideCase(i, j)
			remove(@moreButton)
			@moreButton2 = Gtk::Button.new(:label =>"Suivant", :use_underline => nil, :stock_id => nil)
			attach(@moreButton2, 3,5 ,0,1)
			#puts("morehint : " + pos[0].to_s)
			@moreButton2.signal_connect "clicked" do |widget|
				moreHint2(pos)
			end
			@moreButton2.show
		elsif(pos[0]==2)
			@grille.getPartie.getUndoRedo.addMemento
			setAideText("Voilà, ça va aller mieux comme ça.")
			#puts("CANDIDAT? : " + @grille.getPartie.getPlateau.getCase(Position.new(2,3)).getCandidat.getListeCandidat.to_s)
			#print "ok1"
			@sousGrille.setTest(true)
			@sousGrille.loadAllCandidats
			@grille.rafraichirGrille
			#print "ok2"
			@moreButton.sensitive = false
		elsif(pos[0]==5)
			setAideText("INTERACTION ENTRE REGION!")
		end
	end

	def moreHint2(pos)
		if(pos[0]==1 || pos[0]==3 || pos[0]==4)
			if(pos[0]==1)
				methode="Chiffre caché"
			elsif(pos[0]==3)
				methode="Candidat unique"
			elsif(pos[0]==3)
				methode="Un seul candidat"
			end
				
			setAideText("Voici la solution trouvée grâce à la méthode :\n" + methode)
			#puts("morehint2 : " + pos[0].to_s)
			i=getPos(pos)[0]
			j=getPos(pos)[1]
			soluce=@grille.getPartie.getPlateau.getCaseOriginale(Position.new(i,j))
			@grille.setValeurSurFocus(soluce)
			@grille.getPartie.getPlateau.enleverCandidat(getPos(pos)[2], soluce)
			@sousGrille.rafraichirGrille


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
					setAideText("Un candidat n'est pas toujours seul dans une ligne, mais il peut être unique!")
					begin
						@img=Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/candidatUnique.png", :width => 100, :heigth => 100))
					rescue
						img=Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "./vues/candidatUnique.png", :width => 100, :heigth => 100))
					end
				elsif(pos[0]==4)
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

	def getPos(pos)
		#puts("getPOS : " + pos[0].to_s)
		if(pos[0]==3)
			a=pos[1][0]
			i=pos[1][0].getX
			j=pos[1][0].getY
		else
			a=pos[1]
			i=pos[1].getX
			j=pos[1].getY
		end
		return i,j,a
	end
end