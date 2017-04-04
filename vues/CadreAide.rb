require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class CadreAide < Gtk::Table
	@grille
	@sousGrille
	@labelAide
	@methode1
	@methode2
	@methode3
	@methode4
	@methode5
	@backButton


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

	end

	def loadMenu()
		@labelAide.hide()
		@backButton.hide()
		@methode1.show()
		@methode2.show()
		@methode3.show()
		@methode4.show()
		@methode5.show()
	end

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

	# Méthode qui set le titre de l'aide	
	# * [Paramètre :]
	# 				titre => le titre de l'aide
	def setAideTitre(titre)
		titreFormat = "<span font-weight=\"bold\" size=\"x-large\" foreground=\"#200020\">"+titre+"</span>\n"
		@labelAide.set_markup(titreFormat)
	end
end