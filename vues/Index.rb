require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Index < WindowSudoku

	def initialize
		super("Index")

		#Création des boutons
		seConnecter = Gtk::Button.new(:label => "Se connecter")
		creerProfil = Gtk::Button.new(:label => "Créer un profil")
		sessionInvite = Gtk::Button.new(:label => "Session Invité")

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
			Dir.chdir(Dir.pwd+"/profil/Invite")
			newWindow=Invite.new
		end

		header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/header.png", :width => 919, :heigth => 200)))

		#Placement des boutons et ajout dans la table
		attach(header, 0, 9, 0, 3)
		tableMain.attach(seConnecter, 4, 6, 3, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(creerProfil, 4, 6, 5, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(sessionInvite, 4, 6, 7, 9, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		show_all
	end
end