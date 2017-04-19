require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Jeu < Gtk::Window 
	# @cadreAide
	# @boutons
	# @sousGrille
	# @grille
	attr_reader :tableMain, :partie, :fileMenu, :sauvergarderMenuItem, :chargerMenuItem, :quitterMenuItem

	def initialize (partie,joueur)
		super(Gtk::WindowType::TOPLEVEL)

		# Property
		set_title "Ku"
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)


		#=====================================#
		# Initialisation des classe interface #
		#=====================================#
		@partie = partie
		@joueur=joueur
		@grille = Grille.new(@partie, @joueur)
		@sousGrille = SousGrille.new(@grille)
		@cadreAide = CadreAide.new(@grille, @sousGrille)
		@boutons = Boutons.new(@grille, @sousGrille)

		#==========================#
		# Remplissage de la grille #
		#==========================#
		if(@partie.estVide?)
			@partie.creerPartie
		end
		@sousGrille.remplirGrille

		#===============#
		# Aides boutons #
		#===============#

		@helpButtons = Gtk::Table.new(10, 10)
		@undoButton = Gtk::Button.new(:label =>"Undo", :use_underline => nil, :stock_id => nil)
		@undoButton.signal_connect "clicked" do
			@partie.getUndoRedo.undo
		    @sousGrille.rafraichirGrille
		end

		@redoButton = Gtk::Button.new(:label =>"Redo", :use_underline => nil, :stock_id => nil)
		@redoButton.signal_connect "clicked" do
			@partie.getUndoRedo.redo
		    @sousGrille.rafraichirGrille
		end

		@helpButtons.attach(@undoButton, 0,1,0,1, Gtk::AttachOptions::SHRINK, Gtk::AttachOptions::SHRINK)
		@helpButtons.attach(@redoButton, 1,2,0,1, Gtk::AttachOptions::SHRINK, Gtk::AttachOptions::SHRINK)

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
	    @fileMenu = Gtk::Menu.new() # Menu de Fichier
	    fileMenuItem.set_submenu(@fileMenu)
	    
	        # Sauvegarder
	        @sauvergarderMenuItem = Gtk::MenuItem.new(:label => "Sauvegarder", :use_underline => false)
	        @sauvergarderMenuItem.signal_connect "activate" do
	        	if(@partie.getTimer.exam==1)
	        		@partie.stopTemps
	        	end
	        	Sauvegarde.savePartie(@partie,"partie1")
	        end
	        @fileMenu.append(sauvergarderMenuItem)

	        # Charger
	        @chargerMenuItem = Gtk::MenuItem.new(:label => "Charger", :use_underline => false)
	        @chargerMenuItem.signal_connect "activate" do
	        	chargement
	        end
	        if(!File.exist?("partie1.txt"))
	        	@chargerMenuItem.sensitive=false
	        end
	        @fileMenu.append(chargerMenuItem)

	        # Quitter
	        @quitterMenuItem = Gtk::MenuItem.new(:label => "Retourner au menu", :use_underline => false)
	        @quitterMenuItem.signal_connect "activate" do
	        	ConfirmQuitProfil.new(@partie, self, 0)
	        end
	        @fileMenu.add(quitterMenuItem)

		# Menu Checkpoint
	    checkpointMenuItem = Gtk::MenuItem.new(:label => "Checkpoint", :use_underline => false) # Item Checkpoint
	    checkpointMenu = Gtk::Menu.new() # Menu de checkpoint
	    checkpointMenuItem.set_submenu(checkpointMenu)
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
		    	@sousGrille.rafraichirGrille
		    end
		    checkpointMenu.append(undoCPMenuItem)

		    # redo checkpoint
		    redoCPMenuItem = Gtk::MenuItem.new(:label => "Redo Checkpoint", :use_underline => false)
		    redoCPMenuItem.signal_connect "activate" do
		    	@partie.getCheckPoint().redo
		    	@sousGrille.rafraichirGrille
		    end
		    checkpointMenu.append(redoCPMenuItem)

		# Menu Aide
		aideMenuItem = Gtk::MenuItem.new(:label => "Aides", :use_underline => false)
		aideMenu = Gtk::Menu.new()
		aideMenuItem.set_submenu(aideMenu)

		    # Candidat possible
		    candidatPossibleMenuItem = Gtk::MenuItem.new(:label => "Candidat possible", :use_underline => false)
		    candidatPossibleMenuItem.signal_connect "activate" do
		    	@grille.getPartie.getUndoRedo.addMemento
		    	@grille.incNbAide(1)
		    	@sousGrille.loadAllCandidats
		    end
		    aideMenu.append(candidatPossibleMenuItem)

		    # verification grille
		    verificationGrilleMenuItem = Gtk::MenuItem.new(:label => "Verifier la grille", :use_underline => false)
		    verificationGrilleMenuItem.signal_connect "activate" do
		    	@grille.colorCaseIncorrect()
		    	@grille.incNbAide(1)
		    end
		    aideMenu.append(verificationGrilleMenuItem)

		    # resoudre
		    resoudreGrilleMenuItem = Gtk::MenuItem.new(:label => "Resoudre la grille", :use_underline => false)
		    resoudreGrilleMenuItem.signal_connect "activate" do
		    	@grille.getPartie.getUndoRedo.addMemento
		    	@partie.getAide().resoudre()
		    	@grille.incNbAide(10000)
		    	@sousGrille.rafraichirGrille
		    end
		    aideMenu.append(resoudreGrilleMenuItem)

		    # etatInitial
		    initialGrilleMenuItem = Gtk::MenuItem.new(:label => "Grille initiale", :use_underline => false)
		    initialGrilleMenuItem.signal_connect "activate" do
		    	@partie.getAide().etatInitial
		    	@sousGrille.rafraichirGrille			
		    end
		    aideMenu.append(initialGrilleMenuItem)

		    # etatInitial
		  #   candidatGrilleMenuItem = Gtk::MenuItem.new(:label => "test", :use_underline => false)
		  #   candidatGrilleMenuItem.signal_connect "activate" do
				# if @partie.getPlateau().aucunCandidat?
				# 	print("\n Vrai")
				# else
				# 	print("\n Faux")
				# end
		  #   end
		  #   aideMenu.append(candidatGrilleMenuItem)


		  
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
	        	Parametres.new(@grille, @sousGrille, @partie, @joueur)
	        end
	        optionMenu.add(parametresMenuItem)

        # Barre des menus 
        menuBar.append(fileMenuItem)	
        menuBar.append(checkpointMenuItem)
        menuBar.append(aideMenuItem)
        menuBar.append(optionMenuItem)
        

		#==========#
		# Niveau 2 #
		#==========#

		vboxMain.pack_start(menuBar,:expand => false, :fill => false, :padding => 0)
		@tableMain = Gtk::Table.new(10, 10)
		vboxMain.pack_start(@tableMain,:expand => true, :fill => true, :padding => 0)

		

		#==========#
		# Niveau 3 #
		#==========#

		@tableMain.attach(@sousGrille,  0,5,1,9,Gtk::AttachOptions::SHRINK,Gtk::AttachOptions::SHRINK) # Support Grille (background + sous grille + grille)
		@tableMain.attach(@helpButtons, 5,9,1,2,Gtk::AttachOptions::FILL,Gtk::AttachOptions::FILL)
		@tableMain.attach(@cadreAide ,  5,9,2,9,Gtk::AttachOptions::FILL,Gtk::AttachOptions::FILL) # Aide
		@tableMain.attach(@boutons   ,  0,9,9,10,Gtk::AttachOptions::FILL,Gtk::AttachOptions::FILL) # Boutons

		show_all
	end

	def chargement
		@partie=Sauvegarde.loadPartie("partie1")
		if(@partie.getTimer.exam==1)
			@partie.lanceTemps(@partie.getTimer.getAccumulated)
			@timer.start(@partie.getTimer.getAccumulated)
		end
		@grille.setPartie(@partie)
		@sousGrille.rafraichirGrille
		@cadreAide.cancelHint
	end

end
