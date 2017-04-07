require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Fenetre < Gtk::Window 
	def initialize (partie)
		super(Gtk::WindowType::TOPLEVEL)
		signal_connect "delete_event" do
			ConfirmQuit.new(@partie, self, 1)
		end

		# Property
		set_title "Ku"
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)

		#=====================================#
		# Initialisation des classe interface #
		#=====================================#
		@partie = partie
		@grille = Grille.new(@partie)
		@sousGrille = SousGrille.new(@grille)
		@cadreAide = CadreAide.new(@grille, @sousGrille)
		@boutons = Boutons.new(@grille, @sousGrille) 

		#==========================#
		# Remplissage de la grille #
		#==========================#
		if(@partie.estVide?)
			@partie.creerPartie
		end
		@grille.remplirGrille

		#==========#
		# Niveau 1 #
		#==========#

		vboxMain = Gtk::Box.new(:vertical, 0) # Menu + Table pour Grille, Aide et bouton
		add(vboxMain)

		#=========================#  Note: Menu = Groupe de MenuItem une fois définie un submenu d'un autres MenuItem qui sert de titre
		# Creation Menu 		  #  Exemple:  Fichier [Menu: (Nouveau, Sauvegarder, ...)]
		#=========================#  Voir si on nomme les MenuItem "MI" pour faire plus propre

	    menuBar = Gtk::MenuBar.new # Barre du menu
	    menuBar.override_background_color(:normal, Gdk::RGBA::new(0.95,0.95,0.95,1.0))

	    # Menu Fichier
	    fileMenuItem = Gtk::MenuItem.new(:label => "Fichier", :use_underline => false) # Item Fichier
	    fileMenu = Gtk::Menu.new() # Menu de Fichier
	    fileMenuItem.set_submenu(fileMenu)

        # Sauvegarder
        sauvergarderMenuItem = Gtk::MenuItem.new(:label => "Sauvegarder", :use_underline => false)
        sauvergarderMenuItem.signal_connect "activate" do
        	@partie.stopTemps
        	Sauvegarde.savePartie(@partie,"partie1")
        end
        fileMenu.append(sauvergarderMenuItem)

        # Charger
        chargerMenuItem = Gtk::MenuItem.new(:label => "Charger", :use_underline => false)
        chargerMenuItem.signal_connect "activate" do
        	chargement
        end
        fileMenu.append(chargerMenuItem)

        # Quitter
        quitterMenuItem = Gtk::MenuItem.new(:label => "Quitter", :use_underline => false)
        quitterMenuItem.signal_connect "activate" do
        	ConfirmQuit.new(@partie, self, 0)
        end
        fileMenu.add(quitterMenuItem)

##################################
		# Menu Checkpoint
	    checkpointMenuItem = Gtk::MenuItem.new(:label => "Checkpoint", :use_underline => false) # Item Checkpoint
	    checkpointMenu = Gtk::Menu.new() # Menu de checkpoint
	    checkpointMenuItem.set_submenu(checkpointMenu)

	    # Undo
	    undoMenuItem = Gtk::MenuItem.new(:label => "Undo", :use_underline => false)
	    undoMenuItem.signal_connect "activate" do
	    	@partie.getUndoRedo().undo
	    	@grille.rafraichirGrille
	    	@sousGrille.refreshAllCandidats()
			# @sousGrille.loadAllCandidats
		end
		checkpointMenu.append(undoMenuItem)

	    # Redo
	    redoMenuItem = Gtk::MenuItem.new(:label => "Redo", :use_underline => false)
	    redoMenuItem.signal_connect "activate" do
	    	@partie.getUndoRedo().redo
	    	@grille.rafraichirGrille
	    	@sousGrille.loadAllCandidats
	    end
	    checkpointMenu.append(redoMenuItem)


	    # Placer checkpoint
	    placerCPMenuItem = Gtk::MenuItem.new(:label => "Placer un Checkpoint", :use_underline => false)
	    placerCPMenuItem.signal_connect "activate" do
	    	@partie.getCheckPoint().addMemento()
	    end
	    checkpointMenu.append(placerCPMenuItem)

	    # undo checkpoint
	    undoCPMenuItem = Gtk::MenuItem.new(:label => "Undo Checkpoint", :use_underline => false)
	    undoCPMenuItem.signal_connect "activate" do
	    	@partie.getCheckPoint().undo
	    	@grille.rafraichirGrille
	    end
	    checkpointMenu.append(undoCPMenuItem)

	    # redo checkpoint
	    redoCPMenuItem = Gtk::MenuItem.new(:label => "Redo Checkpoint", :use_underline => false)
	    redoCPMenuItem.signal_connect "activate" do
	    	@partie.getCheckPoint().redo
	    	@grille.rafraichirGrille
	    end
	    checkpointMenu.append(redoCPMenuItem)

##################################
		# Menu Aide
		aideMenuItem = Gtk::MenuItem.new(:label => "Aides", :use_underline => false)
		aideMenu = Gtk::Menu.new()
		aideMenuItem.set_submenu(aideMenu)

	    # Candidat possible
	    candidatPossibleMenuItem = Gtk::MenuItem.new(:label => "Candidat possible", :use_underline => false)
	    candidatPossibleMenuItem.signal_connect "activate" do

	    end
	    aideMenu.append(candidatPossibleMenuItem)

	    # verification grille
	    verificationGrilleMenuItem = Gtk::MenuItem.new(:label => "Verifier la grille", :use_underline => false)
	    verificationGrilleMenuItem.signal_connect "activate" do
	    	@grille.colorCaseIncorrect()
	    end
	    aideMenu.append(verificationGrilleMenuItem)

	    # resoudre
	    resoudreGrilleMenuItem = Gtk::MenuItem.new(:label => "Resoudre la grille", :use_underline => false)
	    resoudreGrilleMenuItem.signal_connect "activate" do
	    	@partie.getAide().resoudre()
	    	@grille.rafraichirGrille
	    end
	    aideMenu.append(resoudreGrilleMenuItem)

	    # etatInitial
	    initialGrilleMenuItem = Gtk::MenuItem.new(:label => "Grille initiale", :use_underline => false)
	    initialGrilleMenuItem.signal_connect "activate" do
	    	@partie.getAide().etatInitial
	    	@grille.rafraichirGrille			
	    end
	    aideMenu.append(initialGrilleMenuItem)


	    #############################################################################
	    ###############Rajouter la même chose chose qu'au dessus#####################
	    #############################################################################

	    # Menu Fichier
	    optionMenuItem = Gtk::MenuItem.new(:label => "Options", :use_underline => false) # Item Fichier
	    optionMenu = Gtk::Menu.new() # Menu de Fichier
	    optionMenuItem.set_submenu(optionMenu)

        # Paramètres
        parametresMenuItem = Gtk::MenuItem.new(:label => "Paramètres", :use_underline => false)
        parametresMenuItem.signal_connect "activate" do
        	newWindow = Parametres.new(@grille, @sousGrille, @partie)
        end
        optionMenu.add(parametresMenuItem)

        # Barre des menus 
        menuBar.append(fileMenuItem)	
        menuBar.append(checkpointMenuItem)
	    #menuBar.append(userMenuItem)
	    menuBar.append(aideMenuItem)
	    menuBar.append(optionMenuItem)

		#==========#
		# Niveau 2 #
		#==========#
		vboxMain.pack_start(menuBar,:expand => false, :fill => false, :padding => 0)
		tableMain = Gtk::Table.new(10, 10)
		vboxMain.pack_start(tableMain,:expand => true, :fill => true, :padding => 0)

		#==========#
		# Niveau 3 #
		#==========#
		@time = Gtk::Box.new(:vertical, 0)
		@time.add(Gtk::Label.new("Temps : "))
		tempsLabel=Gtk::Label.new("00:00:00")
		@time.add(tempsLabel)
		@partie.lanceTemps(0)
		@timer=Timer.new
		@timer.start(@partie.getTimer.getAccumulated)

		Thread.new do
			while (sleep 0.2) do
				tempsLabel.set_markup(@timer.tick)
			end
		end

		tableMain.attach(@time, 0,9,0,1)
		tableMain.attach(@sousGrille, 0,5,1,9) # Support Grille (background + sous grille + grille)
		tableMain.attach(@cadreAide , 5,9,1,9) # Aide
		tableMain.attach(@boutons   , 0,9,9,10) # Boutons

		show_all
	end

	def chargement
		@partie=Sauvegarde.loadPartie("partie1")
		@partie.lanceTemps(@partie.getTimer.getAccumulated)
		@timer.start(@partie.getTimer.getAccumulated)
		@grille.setPartie(@partie)
	end

end
