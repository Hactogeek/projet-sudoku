require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Connexion < WindowSudoku

	def initialize
		super("Connexion")

		header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../vues/header.png", :width => 205, :heigth => 200)))

		#Placement des images et ajout dans la table
		tableMain.attach(header, 0, 10, 0, 3)


		#Création du label
		#nomLabel = Gtk::Label.new("Choisissez un nom d'utilisateur")

		#Création de la zone de choix de nom
		vbox=Gtk::Box.new(:vertical, 0)
		scrolled_win = Gtk::ScrolledWindow.new
		scrolled_win.set_policy(:automatic,:automatic)	
		listeNom = Gtk::ListStore.new(String)
		column = Gtk::TreeViewColumn.new("Choisissez un profil",
                                 Gtk::CellRendererText.new, {:text => 0})
		nomTree = Gtk::TreeView.new(listeNom)
		nomTree.append_column(column)
		nomTree.selection.set_mode(:single)

		Dir["./*"].each do |x|
			iter = listeNom.append
			iter[0]=x[2..-1]
		end

		scrolled_win.set_size_request(205,100)
		scrolled_win.add_with_viewport(nomTree)

		vbox.pack_start(scrolled_win,:expand => true, :fill => true, :padding => 0)

		#Création des boutons
		valider = Gtk::Button.new(:label => "Valider")
		valider.override_background_color(:normal, @colorNeutral)
		valider.set_size_request(102,50)
		retour = Gtk::Button.new(:label => "Retour")
		retour.override_background_color(:normal, @colorNeutral)
		retour.set_size_request(102,50)

		#Redirection des boutons
		valider.signal_connect "clicked" do |widget|
			hide
			Dir.chdir("./" + nomTree.selection.selected[0])
			newWindow=MenuProfil.new
		end

		retour.signal_connect "clicked" do |widget|
			hide
			Dir.chdir("../")
			newWindow=Index.new
		end

		#Placement des boutons et ajout dans la table
		#tableMain.attach(nomLabel, 4, 6, 2, 3, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(vbox, 0, 10, 3, 8, Gtk::AttachOptions::EXPAND | Gtk::AttachOptions::FILL, Gtk::AttachOptions::EXPAND | Gtk::AttachOptions::FILL, 0,0)
		tableMain.attach(valider, 5, 10, 8, 10, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 0, 5, 8, 10, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		show_all
	end
end