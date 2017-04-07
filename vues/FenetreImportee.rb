require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class FenetreImportee < Gtk::Window 
	# @cadreAide
	# @boutons
	# @sousGrille
	# @grille

	def initialize(joueur)
		super(Gtk::WindowType::TOPLEVEL)
		signal_connect "delete_event" do
			Gtk.main_quit
		end


		# Property
		set_title "ku"
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)


		#=====================================#
		# Initialisation des classe interface #
		#=====================================#
		@partie = Partie.nouvelle(0)
		@joueur=joueur
		@grille = Grille.new(@partie,@joueur)
		@sousGrille = SousGrille.new(@grille)
		@cadreAide = CadreAide.new(@grille, @sousGrille)
		@cadreImportation = CadreImportation.new(@grille, @sousGrille)
		@boutons = Boutons.new(@grille, @sousGrille) 

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

	        # Quitter
	        quitterMenuItem = Gtk::MenuItem.new(:label => "Retourner au menu", :use_underline => false)
            quitterMenuItem.signal_connect "activate" do
            	hide
            	if(@joueur!=nil)
            		newWindow = MenuProfil.new
            	else
            		newWindow = Invite.new
            	end
            end
            fileMenu.add(quitterMenuItem)


        # Barre des menus 
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
		tableMain.attach(@sousGrille, 0,5,1,9) # Support Grille (background + sous grille + grille)
		tableMain.attach(@cadreImportation , 5,9,1,9) # Aide
		tableMain.attach(@boutons   , 0,9,9,10) # Boutons

		@cadreImportation.getHintButton.signal_connect "clicked" do |widget|
			if @grille.getPartie().getPlateau().importerGrille
				hide
				if(@joueur==nil)
					newWindow=FenetreInvitee.new(@grille.getPartie)
				else
					newWindow=FenetreApprentissage.new(@grille.getPartie, joueur)
				end
			else
				@cadreImportation.setAideText("Erreur")
			end
		end

	    show_all
	end

end
