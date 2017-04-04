require 'gtk3'

Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Preferences < Gtk::Window
	def initialize
		super(Gtk::WindowType::TOPLEVEL)
		signal_connect "destroy" do
			Gtk.main_quit
		end

		table = Gtk::Box.new(5, 5, true)
		add(table)

		table.attach(Gtk::Label.new("Couleur:"),)
		colorPicker = Gnome::colorPicker.new()
		show_all
	end
end