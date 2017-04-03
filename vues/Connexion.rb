require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Connexion < WindowSudoku

	def initialize
		super("Connexion")

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
		retour = Gtk::Button.new(:label => "Retour")

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
		tableMain.attach(nomLabel, 4, 6, 2, 3, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(vbox, 2, 6, 4, 8, Gtk::EXPAND | Gtk::FILL, Gtk::EXPAND | Gtk::FILL, 0,0)
		tableMain.attach(valider, 4, 6, 8, 9, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		tableMain.attach(retour, 2, 4, 8, 9, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		show_all
	end
end