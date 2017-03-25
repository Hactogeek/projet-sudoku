require 'gtk3'
require './CadreAide.rb'
require './Boutons.rb'
require './Grille.rb'
require './SousGrille.rb'

class Fenetre < Gtk::Window 
	@cadreAide
	@boutons
	@sousGrille
	@grille

	def initialize ()
		super
		signal_connect "destroy" do
			Gtk.main_quit
		end


		# Property
		set_title "ku"
	#	set_default_size 670, 480
	#	set_default_size 670, 600
		set_resizable(false)


		#=====================================#
		# Initialisation des classe interface #
		#=====================================#
		@partie = Partie.nouvelle

		
		@grille = Grille.new(@partie)
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
                #setAide("Bouton nouveau", [], "Permet de créer un nouveau fichier")
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


		# Menu Checkpoint
	    checkpointMenuItem = Gtk::MenuItem.new(:label => "Checkpoint", :use_underline => false) # Item Checkpoint
	    checkpointMenu = Gtk::Menu.new() # Menu de checkpoint
	    checkpointMenuItem.set_submenu(checkpointMenu)

		    # Undo
		    undoMenuItem = Gtk::MenuItem.new(:label => "Undo", :use_underline => false)
		    undoMenuItem.signal_connect "activate" do
			@partie.getUndoRedo().undo
			@grille.rafraichirGrille
			print("\n","Undo effectue")
		    end
		    checkpointMenu.append(undoMenuItem)
		    
		    # Redo
		    redoMenuItem = Gtk::MenuItem.new(:label => "Redo", :use_underline => false)
		    redoMenuItem.signal_connect "activate" do
			@partie.getUndoRedo().redo
			@grille.rafraichirGrille
			print("\n","Redo effectue")
		    end
		    checkpointMenu.append(redoMenuItem)


		    # Placer checkpoint
		    placerCPMenuItem = Gtk::MenuItem.new(:label => "Placer un Checkpoint", :use_underline => false)
		    placerCPMenuItem.signal_connect "activate" do
			@grille.rafraichirGrille
			print("\n","actualisation de la grille effectue")
		    end
		    checkpointMenu.append(placerCPMenuItem)

			# revenir checkpoint
		    revenirCPMenuItem = Gtk::MenuItem.new(:label => "Revenir au Checkpoint", :use_underline => false)
		    checkpointMenu.append(revenirCPMenuItem)


		# Menu User
	    userMenuItem = Gtk::MenuItem.new(:label => "Utilisateur", :use_underline => false) # Item Checkpoint
	    userMenu = Gtk::Menu.new() # Menu de checkpoint
	    userMenuItem.set_submenu(userMenu)

		    # se connecter user
		    connecterMenuItem = Gtk::MenuItem.new(:label => "Se connecter", :use_underline => false)
		    userMenu.append(connecterMenuItem)
		    
		    # creer compte
		    creerCompteMenuItem = Gtk::MenuItem.new(:label => "Créer compte", :use_underline => false)
		    userMenu.append(creerCompteMenuItem)


        # Barre des menus 
	    menuBar.append(fileMenuItem)	
	    menuBar.append(checkpointMenuItem)
	    menuBar.append(userMenuItem)
		

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

	    show_all	
	    Gtk.main
	end

end
