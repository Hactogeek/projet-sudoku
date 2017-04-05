require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class FenetreExamen < Jeu
	# @cadreAide
	# @boutons
	# @sousGrille
	# @grille

	def initialize (partie)
		super(partie)

		signal_connect "delete_event" do
			newWindow = ConfirmQuitProfil.new(@partie, self, 1)
		end

		@time = Gtk::Box.new(:vertical, 0)
		@time.add(Gtk::Label.new("Temps : "))
		tempsLabel=Gtk::Label.new("00:00:00")
		@time.add(tempsLabel)
		@partie.lanceTemps(0)
		@timer=Timer.new
		@timer.start(@partie.getTimer.getAccumulated)

		thr= Thread.new{
			while (sleep 0.2) do
				tempsLabel.set_markup(@timer.tick)
			end
			}
		tableMain.attach(@time, 0,9,0,1)
	    show_all
	end

end
