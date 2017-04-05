require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class SaveInvite < Gtk::Window

	def initialize(partie, fenetre)
		super()

		signal_connect "destroy" do
			hide
		end

		set_title "Creer un profil"
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)

		#Taille de la fenêtre, correspondant à celle du jeu.
		#set_default_size(400, 300)

		#Création du label
		label = Gtk::Label.new("Si vous voulez sauvegarder, il va falloir créer un profil.")

		#Création du bouton
		creerProfil = Gtk::Button.new(:label => "Creer un profil")
		retour = Gtk::Button.new(:label => "Retour")

		#Création de la table contenant les boutons
		tableMain = Gtk::Table.new(10, 10)

		#Redirection des boutons
		creerProfil.signal_connect "clicked" do |widget|
			hide
			fenetre.hide
			newWindow=CreationProfil.new(partie, fenetre)
		end

		retour.signal_connect "clicked" do |widget|
			hide
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(label, 2, 6, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 2, 4, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(creerProfil, 4, 6, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		add(tableMain)

		show_all
	end
end