require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }



class MenuProfil < WindowSudoku

	def initialize

		super("Menu")

		header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/header.png", :width => 205, :heigth => 200)))

		#Placement des images et ajout dans la table
		tableMain.attach(header, 0, 10, 0, 3)

		#Création du label
		nomJoueur = Gtk::Label.new("Bonjour, " + File.split(Dir.getwd)[-1]+ " !")

		#Création des boutons
		nouvellePartie = Gtk::Button.new(:label => "Nouvelle\n  partie")
		nouvellePartie.override_background_color(:normal, @colorNeutral)
		nouvellePartie.set_size_request(102,50)
		importerGrille = Gtk::Button.new(:label => "Importer\n  grille")
		importerGrille.override_background_color(:normal, @colorNeutral)
		importerGrille.set_size_request(102,50)
		chargerPartie = Gtk::Button.new(:label => "Charger\n partie")
		chargerPartie.override_background_color(:normal, @colorNeutral)
		chargerPartie.set_size_request(102,50)
		statistique = Gtk::Button.new(:label => "Statistique")
		statistique.override_background_color(:normal, @colorNeutral)
		statistique.set_size_request(102,50)
		parametres = Gtk::Button.new(:label => "Paramètres")
		parametres.override_background_color(:normal, @colorNeutral)
		parametres.set_size_request(102,50)
		methodeRes = Gtk::Button.new(:label => "Méthodes")
		methodeRes.override_background_color(:normal, @colorNeutral)
		methodeRes.set_size_request(102,50)
		deconnexion = Gtk::Button.new(:label => "Quitter")
		deconnexion.set_size_request(102,50)
		deconnexion.set_name "deconnexion"


		aPropos = Gtk::Button.new(:label => "A propos")
		aPropos.set_size_request(102,50)

		#Redirection des boutons
		nouvellePartie.signal_connect "clicked" do
			hide
			ChoixMode.new
		end
		importerGrille.signal_connect "clicked" do
			hide
			FenetreImportee.new(Sauvegarde.loadJoueur(File.split(Dir.getwd)[-1]))
		end
		chargerPartie.signal_connect "clicked" do
			hide
			newWindow=FenetreExamen.new(Partie.nouvelle(3), Sauvegarde.loadJoueur(File.split(Dir.getwd)[-1]))
			newWindow.chargement
			if(!newWindow.examen?)
				newWindow.hide
				newWindow2=FenetreApprentissage.new(Partie.nouvelle(3),Sauvegarde.loadJoueur(File.split(Dir.getwd)[-1]) )
				newWindow2.chargement
			end
		end
		statistique.signal_connect "clicked" do
			hide
			Statistiques.new(Sauvegarde.loadJoueur(File.split(Dir.getwd)[-1]))
		end
		parametres.signal_connect "clicked" do
			Parametres.new(nil, nil,nil, Sauvegarde.loadJoueur(File.split(Dir.getwd)[-1]))
		end
		methodeRes.signal_connect "clicked" do
			hide
			MethodeRes.new(0)
		end
		deconnexion.signal_connect "clicked" do
			hide
			Dir.chdir("../..")
			Index.new
		end
		aPropos.signal_connect "clicked" do
			hide
			APropos.new(0)
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(nomJoueur, 0, 10, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(nouvellePartie, 0, 5, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(importerGrille, 0, 5, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(chargerPartie, 5, 10, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(statistique, 5, 10, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(parametres, 0, 5, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(methodeRes, 5, 10, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(deconnexion, 0, 5, 7, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(aPropos, 5, 10, 7, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		if(!File.exist?("partie1.txt"))
			chargerPartie.sensitive = false
		end

		show_all
	end
end