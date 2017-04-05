require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Index < WindowSudoku

	def initialize
		super("Index")


		header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "./vues/header.png", :width => 205, :heigth => 200)))

		#Placement des images et ajout dans la table
		tableMain.attach(header, 0, 10, 0, 3)


		#Création des boutons
		seConnecter = Gtk::Button.new(:label => "Se connecter")
		seConnecter.override_background_color(:normal, @colorNeutral)
		seConnecter.set_size_request(205,50)
		creerProfil = Gtk::Button.new(:label => "Créer un profil")
		creerProfil.override_background_color(:normal, @colorNeutral)
		creerProfil.set_size_request(205,50)
		sessionInvite = Gtk::Button.new(:label => "Session invité")
		sessionInvite.override_background_color(:normal, @colorNeutral)
		sessionInvite.set_size_request(205,50)

		#Redirection des boutons
		seConnecter.signal_connect "clicked" do |widget|
			hide
			Dir.chdir(Dir.pwd+"/profil")
			newWindow=Connexion.new
		end
		creerProfil.signal_connect "clicked" do |widget|
			hide
			newWindow=CreationProfil.new(0)
		end
		sessionInvite.signal_connect "clicked" do |widget|
			hide
			#Dir.chdir(Dir.pwd+"/profil/Invite")
			newWindow=Invite.new
		end

		tableMain.attach(seConnecter, 0, 10, 3, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 1,0)
		tableMain.attach(creerProfil, 0, 10, 5, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 1,0)
		tableMain.attach(sessionInvite, 0, 10, 7, 9, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 1,0)

		show_all
	end
end