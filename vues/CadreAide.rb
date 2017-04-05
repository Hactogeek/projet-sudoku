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

		candidatSwitch = Gtk::Switch.new()
		candidatSwitch.signal_connect('state-set') do
			if candidatSwitch.active?
				@sousGrille.setCandidatState(true)
			else
				@sousGrille.setCandidatState(false)
			end
		end
		candidatLabel  = Gtk::Label.new("Activer/Desactiver Candidats : ")
		attach(candidatSwitch, 6,8, 11,12)
		attach(candidatLabel , 3,6, 11,12)

		@labelAide = Gtk::Label.new("")
		attach(@labelAide, 0,8, 1,6)

		@imgEvent=Gtk::EventBox.new
		attach(@imgEvent, 0,8, 2,6)

		@hintButton = Gtk::Button.new(:label =>"Indice", :use_underline => nil, :stock_id => nil)
		@hintButton.signal_connect "clicked" do |widget|
			startHint()
		end
		attach(@hintButton, 3,5 ,0,1)

=begin
		@methode1 = Gtk::Button.new(:label =>"Methode du poney", :use_underline => nil, :stock_id => nil)
		@methode1.signal_connect "clicked" do |widget|
			loadMethode(1)
		end
		@methode2 = Gtk::Button.new(:label =>"Methode de dragibus", :use_underline => nil, :stock_id => nil)
		@methode2.signal_connect "clicked" do |widget|
			loadMethode(2)
		end
		@methode3 = Gtk::Button.new(:label =>"Methode du couscous", :use_underline => nil, :stock_id => nil)
		@methode3.signal_connect "clicked" do |widget|
			loadMethode(3)
		end
		@methode4 = Gtk::Button.new(:label =>"Methode de caribou", :use_underline => nil, :stock_id => nil)
		@methode4.signal_connect "clicked" do |widget|
			loadMethode(4)
		end
		@methode5 = Gtk::Button.new(:label =>"Methode de la methode", :use_underline => nil, :stock_id => nil)
		@methode5.signal_connect "clicked" do |widget|
			loadMethode(5)
		end

		attach(@methode1, 0,8, 0,1)
		attach(@methode2, 0,8, 1,2)
		attach(@methode3, 0,8, 2,3)
		attach(@methode4, 0,8, 3,4)
		attach(@methode5, 0,8, 4,5)
=end
	end

	def startHint()
		pos=@grille.colorCaseSuivant
		if(pos[1]!=nil)
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
					@grille.setCouleurCase(pos[1].getX(), pos[1].getY(), COUL_BLANC)
					cancelHint()
				end
				attach(@finishButton, 6,8 ,0,1)
			end

			@backButton.show
			@backButton.sensitive = false
			@moreButton.show
			@finishButton.show
			@hintButton.hide
			setAideText(pos[0])
		end
	end

	def moreHint(pos)
		@grille.setValeurSurFocus(@grille.getPartie.getPlateau.getCaseOriginale(Position.new(pos[1].getX,pos[1].getY)))
		@grille.resetColorOnAll()
		# @grille.setColorOnValue(widget.label, COUL_VERT)
		@sousGrille.loadAllCandidats()
		@moreButton.sensitive = false
		@learnButton=Gtk::Button.new(:label =>"Apprendre", :use_underline => nil, :stock_id => nil)
		remove(@backButton)
		@learnButton.sensitive = true
		attach(@learnButton, 0,2 ,0,1)
		@learnButton.show
		@learnButton.signal_connect "clicked" do |widget|
			setAideText("Si après avoir placé tous les candidats pour chaque case du sudoku,\n vous voyez qu'une case ne possède qu'un seul candidat.\n Alors ce candidat est la solution de la case")
			if(@img!=nil)
				@imgEvent.remove(@img)
			end
			@img=Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/unSeulCandidat.png", :width => 100, :heigth => 100))
			@imgEvent.add(@img)
			@imgEvent.show_all
			@learnButton.sensitive = false
		end
	end

	def previousHint
		puts("WSH")
	end

	def cancelHint()
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

=begin
	def loadMethode(n)
		case n
		when 1
			# load la première méthode
		when 2
			# deuxième méthode
		when 3
			# etc
		when 4
			# etc
		when 5
			# etc
		else
			return
		end
		@methodeActive = n

		setAideTitre(("Bienvenue dans la méthode "+n.to_s))

		@methode1.hide()
		@methode2.hide()
		@methode3.hide()
		@methode4.hide()
		@methode5.hide()
		@labelAide.show()
		if (@backButton == nil)
			@backButton = Gtk::Button.new(:label =>"Retour", :use_underline => nil, :stock_id => nil)
			@backButton.signal_connect "clicked" do |widget|
				loadMenu()
			end
			attach(@backButton, 0,8 ,0,1)
			@backButton.show()
		else
			@backButton.show()
		end
	end
=end

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
		textFormat = "<span size=\"large\" foreground=\"#200020\">"+text+"</span>\n"
		@labelAide.set_markup(textFormat)
	end
end