require 'gtk3'

class WindowSudoku < Gtk::Window

	#private_class_method :new
	attr_reader :tableMain

	def initialize(titre)
		super()

		signal_connect "destroy" do
			Gtk.main_quit
		end

		set_title titre
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)

		#Taille de la fenêtre, correspondant à celle du jeu.
	#	set_default_size(919, 602)

		#Création de la table contenant les boutons
		@tableMain = Gtk::Table.new(10, 10)

		add(@tableMain)
	end
end