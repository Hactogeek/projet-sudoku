require 'gtk3'

Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class Parametres < Gtk::Window
	@grille
	@sousGrille
	@partie

	def initialize(grille, sousGrille, partie)
		super(Gtk::WindowType::TOPLEVEL)
		signal_connect "destroy" do
			hide()
		end

		@grille = grille
		@sousGrille = sousGrille
		@partie = partie

		# Property
		set_title "Paramètres"
		set_window_position(Gtk::WindowPosition::CENTER)
		set_resizable(false)
		
		table = Gtk::Table.new(10,2)
		table.attach(Gtk::Label.new().set_markup("<span font-weight=\"bold\">Choisissez votre thème:</span>"), 0,2 ,0 ,1)
		
		colorFocus = @partie.getPreferences().colorFocus
		colorEquals =  @partie.getPreferences().colorEquals
		colorError = @partie.getPreferences().colorError
		colorAide = @partie.getPreferences().colorAide
		colorNeutral = @partie.getPreferences().colorNeutral
		colorTextOriginal = @partie.getPreferences().colorTextOriginal
		colorTextPlayer = @partie.getPreferences().colorTextPlayer
		colorTextCandidat = @sousGrille.colorCandidat

		labelFocus = Gtk::Label.new("Case Focus :")
		labelEquals = Gtk::Label.new("Case Equivalente:")
		labelError = Gtk::Label.new("Case Erroné:")
		labelAide = Gtk::Label.new("Case d'aide")
		labelNeutral = Gtk::Label.new("Fond de la grille:")
		labelTextOriginal = Gtk::Label.new("Case Original:")
		labelTextPlayer = Gtk::Label.new("Case du Joueur:")
		labelTextCandidat = Gtk::Label.new("Candidats:")

		colorButtonFocus = Gtk::ColorButton.new(Gdk::Color.parse(colorFocus))
		colorButtonFocus.signal_connect("color-set"){
			colorFocus = colorButtonFocus.color.to_s[0..2] + colorButtonFocus.color.to_s[5..6] + colorButtonFocus.color.to_s[9..10]
		}
		table.attach(labelFocus, 0,1,1,2)
		table.attach(colorButtonFocus, 1,2,1,2)

		colorButtonEquals = Gtk::ColorButton.new(Gdk::Color.parse(colorEquals))
		colorButtonEquals.signal_connect("color-set"){
			colorEquals = colorButtonEquals.color.to_s[0..2] + colorButtonEquals.color.to_s[5..6] + colorButtonEquals.color.to_s[9..10]
		}
		table.attach(labelEquals, 0,1,2,3)
		table.attach(colorButtonEquals, 1,2,2,3)

		colorButtonAide = Gtk::ColorButton.new(Gdk::Color.parse(colorAide))
		colorButtonAide.signal_connect("color-set"){
			colorAide = colorButtonAide.color.to_s[0..2] + colorButtonAide.color.to_s[5..6] + colorButtonAide.color.to_s[9..10]
		}
		table.attach(labelAide, 0,1,3,4)
		table.attach(colorButtonAide, 1,2,3,4)

		colorButtonError = Gtk::ColorButton.new(Gdk::Color.parse(colorError))
		colorButtonError.signal_connect("color-set"){
			colorError = colorButtonError.color.to_s[0..2] + colorButtonError.color.to_s[5..6] + colorButtonError.color.to_s[9..10]
		}
		table.attach(labelError, 0,1,4,5)
		table.attach(colorButtonError, 1,2,4,5)

		colorButtonNeutral = Gtk::ColorButton.new(Gdk::Color.parse(colorNeutral))
		colorButtonNeutral.signal_connect("color-set"){
			colorNeutral = colorButtonNeutral.color.to_s[0..2] + colorButtonNeutral.color.to_s[5..6] + colorButtonNeutral.color.to_s[9..10]
		}
		table.attach(labelNeutral, 0,1,5,6)
		table.attach(colorButtonNeutral, 1,2,5,6)

		colorButtonTextOriginal = Gtk::ColorButton.new(Gdk::Color.parse(colorTextOriginal))
		colorButtonTextOriginal.signal_connect("color-set"){
			colorTextOriginal = colorButtonTextOriginal.color.to_s[0..2] + colorButtonTextOriginal.color.to_s[5..6] + colorButtonTextOriginal.color.to_s[9..10]
		}
		table.attach(labelTextOriginal, 0,1,6,7)
		table.attach(colorButtonTextOriginal, 1,2,6,7)

		colorButtonTextPlayer = Gtk::ColorButton.new(Gdk::Color.parse(colorTextPlayer))
		colorButtonTextPlayer.signal_connect("color-set"){
			colorTextPlayer = colorButtonTextPlayer.color.to_s[0..2] + colorButtonTextPlayer.color.to_s[5..6] + colorButtonTextPlayer.color.to_s[9..10]
		}
		table.attach(labelTextPlayer, 0,1,7,8)
		table.attach(colorButtonTextPlayer, 1,2,7,8)

		colorButtonTextCandidat = Gtk::ColorButton.new(Gdk::Color.parse(colorTextCandidat))
		colorButtonTextCandidat.signal_connect("color-set"){
			colorTextCandidat = colorButtonTextCandidat.color.to_s[0..2] + colorButtonTextCandidat.color.to_s[5..6] + colorButtonTextCandidat.color.to_s[9..10]
		}
		table.attach(labelTextCandidat, 0,1,8,9)
		table.attach(colorButtonTextCandidat, 1,2,8,9)


		buttonSave = Gtk::Button.new(:label =>"Sauvergarder", :use_underline => nil, :stock_id => nil)
		buttonSave.signal_connect("clicked"){
			#@grille.setColorStyle(colorFocus, colorEquals, colorError, colorNeutral, colorTextOriginal, colorTextPlayer)
			@partie.getPreferences().setColorStyle(colorFocus, colorEquals, colorError, colorAide, colorNeutral, colorTextOriginal, colorTextPlayer)
			@grille.loadStyle()
			@grille.resetColorOnAll()
			@grille.rafraichirGrille()
			@sousGrille.setColorCandidat(colorTextCandidat)
			hide()
		}
		table.attach(buttonSave, 0,2,9,10)
		add(table)
		show_all
	end
end