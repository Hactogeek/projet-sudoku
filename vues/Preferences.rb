require 'gtk3'

Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Preferences < Gtk::Window
	@grille
	@sousGrille

	def initialize(grille, sousGrille)
		super(Gtk::WindowType::TOPLEVEL)
		signal_connect "destroy" do
			Gtk.main_quit
		end

		@grille = grille
		@sousGrille = sousGrille

		# Property
		set_title "ku"
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)
		vbox = Gtk::Box.new(:vertical, 0)
		hbox = Gtk::Box.new(:horizontal, 0)
		
		vbox.add(Gtk::Label.new("Choisissez votre thème:"))
		vbox.add(hbox)
		
		colorFocus = @grille.colorFocus
		colorEquals =  @grille.colorEquals
		colorError = @grille.colorError
		colorNeutral = @grille.colorNeutral
		colorTextOriginal = @grille.colorTextOriginal
		colorTextPlayer = @grille.colorTextPlayer
		colorTextCandidat = @sousGrille.colorCandidat

		labelFocus = Gtk::Label.new("Case Focus :")
		labelEquals = Gtk::Label.new("Case Equivalente:")
		labelError = Gtk::Label.new("Case Erroné:")
		labelNeutral = Gtk::Label.new("Fond de la grille:")
		labelTextOriginal = Gtk::Label.new("Case Original:")
		labelTextPlayer = Gtk::Label.new("Case du Joueur:")
		labelTextCandidat = Gtk::Label.new("Candidats:")

		colorButtonFocus = Gtk::ColorButton.new(Gdk::Color.parse(colorFocus))
		colorButtonFocus.signal_connect("color-set"){
			colorFocus = colorButtonFocus.color.to_s[0..2] + colorButtonFocus.color.to_s[5..6] + colorButtonFocus.color.to_s[9..10]
		}
		vbox.add(Gtk::Box.new(:horizontal, 0).add(labelFocus).add(colorButtonFocus))

		colorButtonEquals = Gtk::ColorButton.new(Gdk::Color.parse(colorEquals))
		colorButtonEquals.signal_connect("color-set"){
			colorEquals = colorButtonEquals.color.to_s[0..2] + colorButtonEquals.color.to_s[5..6] + colorButtonEquals.color.to_s[9..10]
		}
		vbox.add(Gtk::Box.new(:horizontal, 0).add(labelEquals).add(colorButtonEquals))

		colorButtonError = Gtk::ColorButton.new(Gdk::Color.parse(colorError))
		colorButtonError.signal_connect("color-set"){
			colorError = colorButtonError.color.to_s[0..2] + colorButtonError.color.to_s[5..6] + colorButtonError.color.to_s[9..10]
		}
		vbox.add(Gtk::Box.new(:horizontal, 0).add(labelError).add(colorButtonError))

		colorButtonNeutral = Gtk::ColorButton.new(Gdk::Color.parse(colorNeutral))
		colorButtonNeutral.signal_connect("color-set"){
			colorNeutral = colorButtonNeutral.color.to_s[0..2] + colorButtonNeutral.color.to_s[5..6] + colorButtonNeutral.color.to_s[9..10]
		}
		vbox.add(Gtk::Box.new(:horizontal, 0).add(labelNeutral).add(colorButtonNeutral))

		colorButtonTextOriginal = Gtk::ColorButton.new(Gdk::Color.parse(colorTextOriginal))
		colorButtonTextOriginal.signal_connect("color-set"){
			colorTextOriginal = colorButtonTextOriginal.color.to_s[0..2] + colorButtonTextOriginal.color.to_s[5..6] + colorButtonTextOriginal.color.to_s[9..10]
		}
		vbox.add(Gtk::Box.new(:horizontal, 0).add(labelTextOriginal).add(colorButtonTextOriginal))

		colorButtonTextPlayer = Gtk::ColorButton.new(Gdk::Color.parse(colorTextPlayer))
		colorButtonTextPlayer.signal_connect("color-set"){
			colorTextPlayer = colorButtonTextPlayer.color.to_s[0..2] + colorButtonTextPlayer.color.to_s[5..6] + colorButtonTextPlayer.color.to_s[9..10]
		}
		vbox.add(Gtk::Box.new(:horizontal, 0).add(labelTextPlayer).add(colorButtonTextPlayer))

		colorButtonTextCandidat = Gtk::ColorButton.new(Gdk::Color.parse(colorTextCandidat))
		colorButtonTextCandidat.signal_connect("color-set"){
			colorTextCandidat = colorButtonTextCandidat.color.to_s[0..2] + colorButtonTextCandidat.color.to_s[5..6] + colorButtonTextCandidat.color.to_s[9..10]
		}
		vbox.add(Gtk::Box.new(:horizontal, 0).add(labelTextCandidat).add(colorButtonTextCandidat))


		buttonSave = Gtk::Button.new(:label =>"Sauvergarder", :use_underline => nil, :stock_id => nil)
		buttonSave.signal_connect("clicked"){
			@grille.setColorStyle(colorFocus, colorEquals, colorError, colorNeutral, colorTextOriginal, colorTextPlayer)
			@sousGrille.setColorCandidat(colorTextCandidat)
			hide()
		}
		vbox.add(buttonSave)		
		add(vbox)
		show_all
	end
end