require 'gtk3'
require "./MenuProfil.rb"

class Connexion < Gtk::Window

	def initialize
		super

		signal_connect "destroy" do
			Gtk.main_quit
		end

		set_title "Connexion"
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)

		#Taille de la fenêtre, correspondant à celle du jeu.
		set_default_size(919, 602)

		#Création du label
		nomLabel = Gtk::Label.new("Choisissez un nom d'utilisateur")

		#Création de la zone de choix de nom
		vbox=Gtk::Box.new(:vertical, 0)
		scrolled_win = Gtk::ScrolledWindow.new
		scrolled_win.set_policy(:automatic,:automatic)
		listeNom = Gtk::ListStore.new(String)
		column = Gtk::TreeViewColumn.new("Nom d'utilisateur",
                                 Gtk::CellRendererText.new, {:text => 0})
		nomTree = Gtk::TreeView.new(listeNom)
		nomTree.append_column(column)
		nomTree.selection.set_mode(:single)

		Dir["./*"].each do |x|
			iter = listeNom.append
			iter[0]=x[2..-1]
		end

		scrolled_win.add_with_viewport(nomTree)

		vbox.pack_start(scrolled_win,:expand => true, :fill => true, :padding => 0)

		#Création des boutons
		valider = Gtk::Button.new(:label => "Valider")

		#Création de la table contenant les boutons
		tableMain = Gtk::Table.new(10, 10)

		#Redirection des boutons
		valider.signal_connect "clicked" do |widget|
			hide
			Dir.chdir("./" + nomTree.selection.selected[0])
			newWindow=MenuProfil.new
		end

		#Placement des boutons et ajout dans la table
		tableMain.attach(nomLabel, 4, 6, 2, 3, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(vbox, 4, 6, 4, 8, Gtk::EXPAND | Gtk::FILL, Gtk::EXPAND | Gtk::FILL, 0,0)
		tableMain.attach(valider, 4, 6, 8, 9, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		add(tableMain)

		show_all
	end
end