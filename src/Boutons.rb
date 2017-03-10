require 'gtk3'

class Boutons < Gtk::Box
	@grille

	def new(grille)
		initialize(grille)
	end

	def initialize(grille)
		super(:horizontal, 10)
		set_homogeneous(true)

		@grille = grille

		override_background_color(:normal, Gdk::RGBA::new(0.3,0.3,0.3,1.0))

		for i in 1..9
			btn = Gtk::Button.new(:label => i.to_s(), :use_underline => nil, :stock_id => nil)
			btn.signal_connect "clicked" do |widget|
				@grille.setValeurSurFocus(widget.label)
			end
			add(btn)
		end

	end
end