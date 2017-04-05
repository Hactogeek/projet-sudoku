require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Invite < WindowSudoku

	def initialize
		super("Invité")

		#Création des boutons
		nouvellePartie = Gtk::Button.new(:label => "Nouvelle partie")
		importerGrille = Gtk::Button.new(:label => "Importer grille")
		creerProfil = Gtk::Button.new(:label => "Créer un profil")
		methodeRes = Gtk::Button.new(:label => "Méthode de résolutions")
		deconnexion = Gtk::Button.new(:label => "Déconnexion")
		aPropos = Gtk::Button.new(:label => "A propos")

		#Redirection des boutons
		nouvellePartie.signal_connect "clicked" do |widget|
			hide
			newWindow=ChoixDifficulte.new(1)
		end
		importerGrille.signal_connect "clicked" do |widget|
			hide
			newWindow=FenetreImportee.new
		end
		creerProfil.signal_connect "clicked" do |widget|
			hide
			newWindow=CreationProfil.new(1)
		end
		methodeRes.signal_connect "clicked" do |widget|
			hide
			newWindow=MethodeRes.new(1)
		end
		deconnexion.signal_connect "clicked" do |widget|
			hide
			#Dir.chdir("../..")
			newWindow=Index.new
		end
		aPropos.signal_connect "clicked" do |widget|
			hide
			newWindow=APropos.new(1)
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(nouvellePartie, 4, 6, 2, 3, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(importerGrille, 4, 6, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(creerProfil, 4, 6, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(methodeRes, 4, 6, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(deconnexion, 4, 6, 7, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(aPropos, 4, 6, 8, 9, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		show_all
	end
end