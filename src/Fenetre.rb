require 'gtk3'
require './Generateur.rb'
require './CadreAide.rb'
require './Boutons.rb'
require './Grille.rb'
require './SousGrille.rb'

class Fenetre < Gtk::Window 
	@cadreAide
	@boutons
	@sousGrille
	@grille
	@generateur

	def initialize ()
		super
		signal_connect "destroy" do
			Gtk.main_quit
		end

		# Property
		set_title "Sudoku Pre-Alpha Ultimate Premium Professional Familial Exclusive Edition (Version d'Evaluation)"
		set_default_size 670, 480

		#=====================================#
		# Initialisation des classe interface #
		#=====================================#

	    @generateur = Generateur.new
		@grille = Grille.new
		@cadreAide = CadreAide.new
		@boutons = Boutons.new(@grille) 
		@sousGrille = SousGrille.new(@grille)

		#==========#
		# Niveau 1 #
		#==========#

		vboxMain = Gtk::Box.new(:vertical, 0) # Menu + Table pour Grille, Aide et bouton
	    add(vboxMain)

		#=========================#  Note: Menu = Groupe de MenuItem une fois définie un submenu d'un autres MenuItem qui sert de titre
		# Creation Menu (à finir) #  Exemple:  Fichier [Menu: (Nouveau, Sauvegarder, ...)]
		#=========================#  Voir si on nomme les MenuItem "MI" pour faire plus propre

	    menuBar = Gtk::MenuBar.new # Barre du menu
	    menuBar.override_background_color(:normal, Gdk::RGBA::new(0.95,0.95,0.95,1.0))

	    # Menu Fichier
	    fileMenuItem = Gtk::MenuItem.new(:label => "Fichier", :use_underline => false) # Item Fichier
	    fileMenu = Gtk::Menu.new() # Menu de Fichier
	    fileMenuItem.set_submenu(fileMenu)

	        # Nouveau
	        nouveauMenuItem = Gtk::MenuItem.new(:label => "Nouveau", :use_underline => false)
	        nouveauMenuItem.signal_connect "activate" do
                setAide("Bouton nouveau", [], "Permet de créer un nouveau fichier")
            end
	        fileMenu.append(nouveauMenuItem)
	        
	        # Sauvegarder
	        sauvergarderMenuItem = Gtk::MenuItem.new(:label => "Sauvegarder", :use_underline => false)
	        fileMenu.append(sauvergarderMenuItem)

	        # Fermer
	        fermerMenuItem = Gtk::MenuItem.new(:label => "Fermer", :use_underline => false)
            fermerMenuItem.signal_connect "activate" do
                Gtk.main_quit
            end
            fileMenu.add(fermerMenuItem)

        # Menu Option
	    menuBar.append(fileMenuItem)	
		

		#==========#
		# Niveau 2 #
		#==========#

	    vboxMain.pack_start(menuBar,:expand => false, :fill => false, :padding => 0)
	    tableMain = Gtk::Table.new(10, 10)
	    vboxMain.pack_start(tableMain,:expand => true, :fill => true, :padding => 0)
	   

		#==========#
		# Niveau 3 #
		#==========#

		tableMain.attach(@sousGrille, 0,5,0,8) # Support Grille (background + sous grille + grille)
		tableMain.attach(@cadreAide , 5,9,0,8) # Aide
		tableMain.attach(@boutons   , 0,9,8,9) # Boutons

		#==========================#
		# Remplissage de la grille #
		#==========================#

	    @generateur.make_valid
	    @generateur.each { |x,y,val|  
	    	@grille.setCaseValeur(x+1,y+1,val)
	    }

	    @grille.testCouleur()
	    @grille.setCouleurCase(8,8, COUL_BLEU)
	    show_all
	    Gtk.main
	end

end