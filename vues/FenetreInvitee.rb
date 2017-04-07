require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class FenetreInvitee < Jeu 
	# @cadreAide
	# @boutons
	# @sousGrille
	# @grille

	def initialize (partie)
		super(partie, nil)
		signal_connect "delete_event" do
			ConfirmQuitInvite.new
		end

		fileMenu.remove(sauvergarderMenuItem)
		fileMenu.remove(chargerMenuItem)
		fileMenu.remove(quitterMenuItem)
	        
        # CreerProfil
        sauvergarderMenuItem = Gtk::MenuItem.new(:label => "Sauvegarder", :use_underline => false)
        sauvergarderMenuItem.signal_connect "activate" do
        	SaveInvite.new(@partie,self)
        end
        fileMenu.append(sauvergarderMenuItem)

        # Quitter
        quitterMenuItem = Gtk::MenuItem.new(:label => "Retourner au menu", :use_underline => false)
        quitterMenuItem.signal_connect "activate" do
        	Invite.new
        end
        fileMenu.add(quitterMenuItem)

	    show_all
	end

end
