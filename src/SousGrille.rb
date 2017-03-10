require 'gtk3'

class SousGrille < Gtk::Table # contenant elle même une grille
	def new(grille)
		initialize(grille)
	end

	def initialize (grille)
		super(1,1,true)
		background = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "grille.png", :width => 432, :heigth => 432)))
		attach(grille    , 0, 1, 0, 1)
		attach(background, 0, 1, 0, 1)
		# attach une nouvelle grille ici qui sera celle des indices
	end

end