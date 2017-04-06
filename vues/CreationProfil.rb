require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class CreationProfil < WindowSudoku

	def initialize(invite, fenetre)
		super("Création du profil")

		header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "./vues/header.png", :width => 205, :heigth => 200)))

		#Placement des images et ajout dans la table
		tableMain.attach(header, 0, 10, 0, 3)

		#Création du label
		nomLabel = Gtk::Label.new("Nom d'utilisateur : ")
		confirm = Gtk::Label.new("")

		#Création du form
		name = Gtk::Entry.new

		#Création du bouton
		valider = Gtk::Button.new(:label => "Valider")
		valider.override_background_color(:normal, @colorNeutral)
		valider.set_size_request(102,50)
		retour = Gtk::Button.new(:label => "Retour")
		retour.override_background_color(:normal, @colorNeutral)
		retour.set_size_request(102,50)

		#Redirection des boutons
		valider.signal_connect "clicked" do |widget|
			if(name.text=="")
				confirm.set_text("Veuillez rentrer un nom d'utilisateur")
			else
				joueur=Joueur.creer(name.text)
				if(joueur.creerProfil)
				confirm.set_text("Ce profil existe déjà. \nVeuillez en choisir un autre.")
				else
					# Ca marche pas ça. C'est nul
					# confirm.set_text("La création du profil est un succès")
					# sleep(3)
					hide
					if(invite!=1 && invite!=0)
						newWindow=FenetreApprentissage.new(invite)
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
		tableMain.attach(nomLabel, 0, 10, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(name, 0, 10, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(confirm, 0, 10, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(valider, 5, 10, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 0, 5, 6, 7, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		show_all
	end
end