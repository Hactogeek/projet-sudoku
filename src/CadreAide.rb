require 'gtk3'

class CadreAide < Gtk::Table
	@grille
	@sousGrille

	def initialize (grille, sousGrille)
		super(12,8,true)
		@grille = grille
		@sousGrille = sousGrille
		#add( Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "help.png", :width => 432, :heigth => 432)))
		methode1 = Gtk::Button.new(:label =>"Methode du poney", :use_underline => nil, :stock_id => nil)
		methode2 = Gtk::Button.new(:label =>"Methode de dragibus", :use_underline => nil, :stock_id => nil)
		methode2.signal_connect "clicked" do |widget|
			@grille.colorCaseResolvable()
		end
		methode3 = Gtk::Button.new(:label =>"Methode du couscous", :use_underline => nil, :stock_id => nil)
		methode4 = Gtk::Button.new(:label =>"Methode de caribou", :use_underline => nil, :stock_id => nil)
		methode5 = Gtk::Button.new(:label =>"Methode de la methode", :use_underline => nil, :stock_id => nil)

		attach(methode1, 0,8, 0,1)
		attach(methode2, 0,8, 1,2)
		attach(methode3, 0,8, 2,3)
		attach(methode4, 0,8, 3,4)
		attach(methode5, 0,8, 4,5)

		candidatSwitch = Gtk::Switch.new()
		candidatSwitch.signal_connect('state-set') do
			if candidatSwitch.active?
				@sousGrille.setCandidatState(true)
			else
				@sousGrille.setCandidatState(false)
			end
		end
		candidatLabel  = Gtk::Label.new("Activer/Desactiver Candidats :")
		attach(candidatSwitch, 6,8, 11,12)
		attach(candidatLabel , 3,6, 11,12)
	end

	def setAide(titre, listeCase, desc) # à adapté quand on aura remis un label dans le cadre...
		titreFormat = "<span font-weight=\"bold\" size=\"x-large\" foreground=\"#200020\">"+titre+"</span>\n"
		listeCaseFormat = "<span font-style=\"italic\" size=\"large\" >Case:"+ (listeCase.empty? ? "Aucune" : listeCase.to_s) +"</span>\n"
		descFormat = "<span>"+desc+"</span>"
		@cadreAide.set_markup(titreFormat + listeCaseFormat + descFormat )
	end
end