require 'gtk3'

Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Preferences < Gtk::Window
	@grille
	def initialize(grille)
		super(Gtk::WindowType::TOPLEVEL)
		signal_connect "destroy" do
			Gtk.main_quit
		end

		@grille = grille

		# Property
		set_title "ku"
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)
		vbox = Gtk::Box.new(:vertical, 0)
		hbox = Gtk::Box.new(:horizontal, 0)
		
		vbox.add(Gtk::Label.new("Choisissez votre thème:"))
		vbox.add(hbox)
		
		rbDefault = Gtk::RadioButton.new(:label => "Default")
		rbMonokai = Gtk::RadioButton.new(:label => "Monokai", :member => rbDefault, :use_underline => false)
		rbDefault.set_group([rbDefault, rbMonokai])

		hbox.add(rbDefault)
		hbox.add(rbMonokai)

		button = Gtk::Button.new(:label =>"Sauvergarder", :use_underline => nil, :stock_id => nil)
		button.signal_connect("clicked"){
			@grille.setColorStyle()
			@grille.remplirGrille()
			destroy()
		}
		vbox.add(button)

		button = Gtk::ColorButton.new(Gdk::Color.parse("#ffffff"))
		button.signal_connect("clicked"){
			@grille.setColorStyle()
			@grille.remplirGrille()
			destroy()
		}
		vbox.add(button)
		#colorPicker = Gtk::ColorChooserWidget.new()
		#hbox.add(colorPicker)
		
		add(vbox)
		show_all
	end
end