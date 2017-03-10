require 'gtk3'

class CadreAide < Gtk::EventBox
	def initialize ()
		super
		add( Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "help.png", :width => 432, :heigth => 432)))
	end

	def setAide(titre, listeCase, desc) # à adapté quand on aura remis un label dans le cadre...
		titreFormat = "<span font-weight=\"bold\" size=\"x-large\" foreground=\"#200020\">"+titre+"</span>\n"
		listeCaseFormat = "<span font-style=\"italic\" size=\"large\" >Case:"+ (listeCase.empty? ? "Aucune" : listeCase.to_s) +"</span>\n"
		descFormat = "<span>"+desc+"</span>"
		@cadreAide.set_markup(titreFormat + listeCaseFormat + descFormat )
	end
end