require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class FenetreApprentissage < Jeu
	# @cadreAide
	# @boutons
	# @sousGrille
	# @grille

	def initialize (partie)
		super(partie)

		signal_connect "delete_event" do
			newWindow = ConfirmQuitProfil.new(@partie, self, 1)
		end
		
	    show_all
	end

end
