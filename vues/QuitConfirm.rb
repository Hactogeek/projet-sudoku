require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class QuitConfirm < Gtk::Window

	attr_reader :tableMain, :oui, :non, :label

	def initialize
		super()

		signal_connect "destroy" do
			hide
		end
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)

		#Taille de la fenêtre, correspondant à celle du jeu.
		set_default_size(400, 300)

		#Création du label
		@label = Gtk::Label.new("")

		#Création du bouton
		@oui = Gtk::Button.new(:label => "Oui")
		@non = Gtk::Button.new(:label => "Non")

		#Création de la table contenant les boutons
		@tableMain = Gtk::Table.new(10, 10)

		#Placement des boutons et ajout dans la table
		@tableMain.attach(@label, 2, 6, 3, 4, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		@tableMain.attach(@non, 2, 4, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)
		@tableMain.attach(@oui, 4, 6, 4, 5, Gtk::AttachOptions::EXPAND, Gtk::AttachOptions::EXPAND, 0,0)

		add(@tableMain)

		show_all
	end
end