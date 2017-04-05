require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class MenuProfil < WindowSudoku

	def initialize
		super("Menu")

		#Création du label
		nomJoueur = Gtk::Label.new(File.split(Dir.getwd)[-1])

		#Création des boutons
		nouvellePartie = Gtk::Button.new(:label => "Nouvelle partie")
		importerGrille = Gtk::Button.new(:label => "Importer grille")
		chargerPartie = Gtk::Button.new(:label => "Charger partie")
		statistique = Gtk::Button.new(:label => "Statistique")
		parametres = Gtk::Button.new(:label => "Paramètres")
		methodeRes = Gtk::Button.new(:label => "Méthode de résolutions")
		deconnexion = Gtk::Button.new(:label => "Deconnexion")
		aPropos = Gtk::Button.new(:label => "A propos")

		#Redirection des boutons
		nouvellePartie.signal_connect "clicked" do |widget|
			hide
			newWindow=ChoixMode.new
		end
		importerGrille.signal_connect "clicked" do |widget|
			hide
			newWindow=FenetreImportee.new
		end
		chargerPartie.signal_connect "clicked" do |widget|
			hide
			newWindow=Fenetre.new(Partie.nouvelle(3))
			newWindow.chargement
		end
		statistique.signal_connect "clicked" do |widget|
		end
		parametres.signal_connect "clicked" do |widget|
		end
		methodeRes.signal_connect "clicked" do |widget|
			hide
			newWindow=MethodeRes.new(0)
		end
		deconnexion.signal_connect "clicked" do |widget|
			hide
			Dir.chdir("../..")
			newWindow=Index.new
		end
		aPropos.signal_connect "clicked" do |widget|
			hide
			newWindow=APropos.new(0)
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(nomJoueur, 4, 6, 0, 1, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(nouvellePartie, 4, 6, 1, 2, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(importerGrille, 4, 6, 2, 3, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(chargerPartie, 4, 6, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(statistique, 4, 6, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(parametres, 4, 6, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(methodeRes, 4, 6, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(deconnexion, 4, 6, 7, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(aPropos, 4, 6, 8, 9, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		show_all
	end
end