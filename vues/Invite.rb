require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Invite < WindowSudoku

	def initialize
		super("Invité")

		header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "./vues/header.png", :width => 205, :heigth => 200)))

		#Placement des images et ajout dans la table
		tableMain.attach(header, 0, 10, 0, 3)

		#Création des boutons
		nouvellePartie = Gtk::Button.new(:label => "Nouvelle\n  partie")
		nouvellePartie.override_background_color(:normal, @colorNeutral)
		nouvellePartie.set_size_request(102,50)
		importerGrille = Gtk::Button.new(:label => "Saisir\n  grille")
		importerGrille.override_background_color(:normal, @colorNeutral)
		importerGrille.set_size_request(102,50)
		creerProfil = Gtk::Button.new(:label => " Créer\n  profil")
		creerProfil.override_background_color(:normal, @colorNeutral)
		creerProfil.set_size_request(102,50)
		methodeRes = Gtk::Button.new(:label => "Méthodes")
		methodeRes.override_background_color(:normal, @colorNeutral)
		methodeRes.set_size_request(102,50)
		deconnexion = Gtk::Button.new(:label => "Quitter")
		deconnexion.override_background_color(:normal, @colorNeutral)
		deconnexion.set_size_request(102,50)
		aPropos = Gtk::Button.new(:label => "A propos")
		aPropos.override_background_color(:normal, @colorNeutral)
		aPropos.set_size_request(102,50)

		#Redirection des boutons
		nouvellePartie.signal_connect "clicked" do
			hide
			ChoixDifficulte.new(1,0)
		end
		importerGrille.signal_connect "clicked" do
			hide
			FenetreImportee.new(nil)
		end
		creerProfil.signal_connect "clicked" do
			hide
			CreationProfil.new(1, nil)
		end
		methodeRes.signal_connect "clicked" do
			hide
			MethodeRes.new(1)
		end
		deconnexion.signal_connect "clicked" do
			hide
			#Dir.chdir("../..")
			Index.new
		end
		aPropos.signal_connect "clicked" do
			hide
			APropos.new(1)
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(nouvellePartie, 0, 5, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(importerGrille, 0, 5, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(creerProfil, 5, 10, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(methodeRes, 5, 10, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(deconnexion, 0, 5, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(aPropos, 5, 10, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		show_all
	end
end