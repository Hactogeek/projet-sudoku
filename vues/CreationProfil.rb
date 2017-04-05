require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class CreationProfil < WindowSudoku

	def initialize(invite, fenetre)
		super("Création du profil")

		#Création du label
		nomLabel = Gtk::Label.new("Nom d'utilisateur : ")
		confirm = Gtk::Label.new("")

		#Création du form
		name = Gtk::Entry.new

		#Création du bouton
		valider = Gtk::Button.new(:label => "Valider")
		retour = Gtk::Button.new(:label => "Retour")

		#Redirection des boutons
		valider.signal_connect "clicked" do |widget|
			if(name.text=="")
				confirm.set_text("Veuillez rentrer un nom d'utilisateur")
			else
				joueur=Joueur.creer(name.text)
				if(joueur.creerProfil)
				confirm.set_text("Ce profil a déjà été créé. Veuillez en choisir un autre.")
				else
					# Ca marche pas ça. C'est nul
					# confirm.set_text("La création du profil est un succès")
					# sleep(3)
					hide
					if(invite!=1 && invite!=0)
						newWindow=Fenetre.new(invite)
					else
						newWindow=MenuProfil.new
					end
				end
			end
		end

		retour.signal_connect "clicked" do |widget|
			hide
			if(invite==1)
				newWindow=Invite.new
			elsif(invite==0)
				newWindow=Index.new
			else
				fenetre.show_all
			end
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(nomLabel, 2, 6, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(name, 2, 6, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(confirm, 2, 6, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(valider, 4, 6, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 2, 4, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		show_all
	end
end