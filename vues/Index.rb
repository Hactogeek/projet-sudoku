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
			puts(Dir.pwd)
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

		#Placement des boutons et ajout dans la table
		tableMain.attach(seConnecter, 4, 6, 2, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(creerProfil, 4, 6, 4, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(sessionInvite, 4, 6, 6, 8, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		show_all
	end
end