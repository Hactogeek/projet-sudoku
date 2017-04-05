require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class ConfirmQuitInvite < QuitConfirm

	def initialize
		super()
		
		set_title "Confirmez avant de quitter"
		#Création du label
		label.set_text("Etes-vous sûr de vouloir quitter?")

		#Redirection des boutons
		oui.signal_connect "clicked" do |widget|
			Gtk.main_quit
		end
		non.signal_connect "clicked" do |widget|
			hide
		end

		show_all
	end
end