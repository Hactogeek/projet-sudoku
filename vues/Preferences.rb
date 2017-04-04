require 'gtk3'

Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Preferences < Gtk::Window
	def initialize
		super(Gtk::WindowType::TOPLEVEL)
		signal_connect "destroy" do
			Gtk.main_quit
		end

		hbox = Gtk::Box.new(:horizontal, 0)

		table.add(Gtk::Label.new("Couleur:"))
		colorPicker = Gnome::colorPicker.new()

		add(hbox)
		show_all
	end
end