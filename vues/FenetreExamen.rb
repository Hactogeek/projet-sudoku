require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class FenetreExamen < Jeu
	# @cadreAide
	# @boutons
	# @sousGrille
	# @grille

	def initialize (partie, joueur)
		super(partie, joueur)

		signal_connect "delete_event" do
			ConfirmQuitProfil.new(@partie, self, 1)
		end

		@time = Gtk::Box.new(:vertical, 0)
		@time.add(Gtk::Label.new("Temps : "))
		tempsLabel=Gtk::Label.new("00:00:00")
		@time.add(tempsLabel)
		@partie.lanceTemps(0)
		@timer=Timer.new
		@timer.start(@partie.getTimer.getAccumulated)

		Thread.new do
			while (sleep 0.2) do
				tempsLabel.set_markup(@timer.tick)
			end
		end
		tableMain.attach(@time, 0,10,0,1)
	    show_all
	end

	def examen?
		return (@partie.getTimer.exam==1)
	end
end
