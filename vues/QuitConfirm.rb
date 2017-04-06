require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class QuitConfirm < Gtk::Window

	attr_reader :tableMain, :oui, :non, :label

	def initialize
		super()

		begin
			header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/header.png", :width => 205, :heigth => 200)))
		rescue
			header = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "./vues/header.png", :width => 205, :heigth => 200)))
		end

		signal_connect "destroy" do
			hide
		end
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)

		#Taille de la fenêtre, correspondant à celle du jeu.
		#set_default_size(400, 300)

		#Création du label
		@label = Gtk::Label.new("")

		#Création du bouton
		@oui = Gtk::Button.new(:label => "Oui")
		@oui.override_background_color(:normal, @colorNeutral)
		@oui.set_size_request(205,50)
		@non = Gtk::Button.new(:label => "Non")
		@non.override_background_color(:normal, @colorNeutral)
		@non.set_size_request(205,50)

		#Création de la table contenant les boutons
		@tableMain = Gtk::Table.new(10, 10)

		#Placement des images et ajout dans la table
		@tableMain.attach(header, 0, 10, 0, 2)

		#Placement des boutons et ajout dans la table
		@tableMain.attach(@label, 0, 10, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		@tableMain.attach(@non, 0, 10, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		@tableMain.attach(@oui, 0, 10, 5, 6, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		add(@tableMain)

		show_all
	end
end