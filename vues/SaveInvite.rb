require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class SaveInvite < Gtk::Window

	def initialize(partie, fenetre)
		super()

		begin
			header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/header.png", :width => 205, :heigth => 200)))
		rescue
			header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "./vues/header.png", :width => 205, :heigth => 200)))
		end
		#Placement des images et ajout dans la table
		tableMain.attach(header, 0, 10, 0, 2)

		signal_connect "destroy" do
			hide
		end

		set_title "Creer un profil"
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)

		#Taille de la fenêtre, correspondant à celle du jeu.
		#set_default_size(400, 300)

		#Création du label
		label = Gtk::Label.new("Si vous voulez sauvegarder, \nil va falloir créer un profil.")

		#Création du bouton
		creerProfil = Gtk::Button.new(:label => "Creer un profil")
		creerProfil.override_background_color(:normal, @colorNeutral)
		creerProfil.set_size_request(205,50)
		retour = Gtk::Button.new(:label => "Retour")
		retour.override_background_color(:normal, @colorNeutral)
		retour.set_size_request(205,50)

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
		tableMain.attach(label, 0, 10, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 0, 10, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(creerProfil, 0, 10, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		add(tableMain)

		show_all
	end
end