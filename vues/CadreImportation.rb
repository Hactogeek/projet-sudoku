require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class CadreImportation < Gtk::Table
	def initialize (grille, sousGrille)
		super(12,8,true)
		@grille = grille
		@sousGrille = sousGrille
		@grille.setCadreImportation(self)

		candidatSwitch = Gtk::Switch.new()
		candidatSwitch.signal_connect('state-set') do
			if candidatSwitch.active?
				@sousGrille.setCandidatState(true)
			else
				@sousGrille.setCandidatState(false)
			end
		end

		@labelAide = Gtk::Label.new("")
		attach(@labelAide, 0,8, 1,6)

		@hintButton = Gtk::Button.new(:label =>"Valider", :use_underline => nil, :stock_id => nil)
		attach(@hintButton, 3,5 ,0,1)

		show_all
	end

	# Méthode qui défini un texte dans l'aide	
	# * [Paramètre :]
	# 				text => texte de l'aide
	def setAideText(text)
		textFormat = "<span size=\"large\" foreground=\"#200020\">"+text+"</span>\n"
		@labelAide.set_markup(textFormat)
	end

	def getHintButton
		return @hintButton
	end
end