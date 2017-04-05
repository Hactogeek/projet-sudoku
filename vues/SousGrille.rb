require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../api/*.rb'].each {|file| require file }

class SousGrille < Gtk::Table # contenant elle même une grille
	@grilleCandidat
	@candidat
	@grille
	@colorCandidat

	attr_reader :colorCandidat

	def new(grille)
		initialize(grille)
	end

	def initialize (grille)
		super(1,1,true)
		@grille = grille
		@grilleCandidat = Gtk::Table.new(26, 26, true)
		@candidat = false;
		@colorCandidat = "#900090"
		begin
			background = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "../../vues/grille.png", :width => 432, :heigth => 432)))
		rescue
			background = Gtk::EventBox.new().add(Gtk::Image.new( :pixbuf => GdkPixbuf::Pixbuf.new(:file => "./vues/grille.png", :width => 432, :heigth => 432)))	
		end		
		attach(@grilleCandidat, 0, 1, 0, 1)
		attach(@grille    , 0, 1, 0, 1)
		attach(background, 0, 1, 0, 1)

		for i in 0..26
			for y in 0..26
				@grilleCandidat.attach(Gtk::Label.new(), y, y+1, i, i+1)
			end
		end

		#loadAllCandidats()
	end

	def refreshAllCandidats()
		if(!@candidat)
			return
		end

		for x in 0..8
			for y in 0..8
				refreshCandidatsCase(x,y)
			end
		end
	end

	def refreshCandidatsCase(x, y)
		if (!@candidat)
			return
		end

		position = Position.new(x,y)
		if (@grille.getPartie().getPlateau().getCaseJoueur(position) != nil)
			pos = (x*81 + y*3) + 1
			for i in 0..2
				for u in 0..2
					@grilleCandidat.children()[729-(pos+u+i*27)].set_text("")
				end
			end			
			return
		end
		
		candidat = @grille.getPartie().getPlateau().getCase(position).getCandidat().getListeCandidat()
		
		pos = (x*81 + y*3) + 1
		for i in 0..2
			for u in 0..2
				@grilleCandidat.children()[729-(pos+u+i*27)].set_markup("<span size=\"small\" foreground=\"#{@colorCandidat}\">#{candidat[(u+i*3)+1]}</span>")
			end
		end
	end


	def loadAllCandidats()
		if(!@candidat)
			return
		end
		# print "Version Joueur : \n", @grille.getPartie().getPlateau()
		# print "Version Originale : \n", @grille.getPartie().getPlateau().printOri

		for x in 0..8
			for y in 0..8
				refreshCandidatsCase(x,y)
			end
		end
	end

	def loadCandidatsCase(x, y)
		if (!@candidat)
			return
		end

		position = Position.new(x,y)
		if (@grille.getPartie().getPlateau().getCaseJoueur(position) != nil)
			pos = (x*81 + y*3) + 1
			for i in 0..2
				for u in 0..2
					@grilleCandidat.children()[729-(pos+u+i*27)].set_text("")
				end
			end			
			return
		end
		
		@grille.getPartie().getPlateau().candidatPossible(position)
		candidat = @grille.getPartie().getPlateau().getCase(position).getCandidat().getListeCandidat()
		

		# print("\n Candidat en #{x+1},#{y+1}: ", candidat)
		pos = (x*81 + y*3) + 1
	    for i in 0..2
		    for u in 0..2
		      	@grilleCandidat.children()[729-(pos+u+i*27)].set_markup("<span size=\"small\" foreground=\"#{@colorCandidat}\">#{candidat[(u+i*3)+1]}</span>")
		    end
		end
	end

	def resetAllCandidats()
		for x in 0..8
			for y in 0..8
				resetCandidatCase(x,y)
			end
		end
	end

	def resetCandidatCase(x,y)
		pos = (x*81 + y*3) + 1
		for i in 0..2
			for u in 0..2
				@grilleCandidat.children()[729-(pos+u+i*27)].set_text("")
			end
		end
	end

	def setCandidatSurFocus(candidat)
		if (!candidat)
			return
		end
		posFocus = @grille.getCoordFocus()
		if (posFocus == nil || @grille.getPartie().getPlateau().getCaseJoueur(posFocus) != nil)
			return
		end

		pos = (posFocus.getX()*81 + posFocus.getY()*3) + 1
	    for i in 0..2
		    for u in 0..2
		    	if (candidat.to_i == u+i*3+1)
		    		if (@grilleCandidat.children()[729-(pos+u+i*27)].text.to_i == candidat)
		    			@grilleCandidat.children()[729-(pos+u+i*27)].set_text("")
		    			@grille.getPartie().getPlateau().getCase(posFocus).getCandidat.remove(candidat)
		    			print(@grille.getPartie().getPlateau().getCase(posFocus).getCandidat.getListeCandidat())
		    			return
		    		else
		    			@grilleCandidat.children()[729-(pos+u+i*27)].set_markup("<span size=\"small\" foreground=\"#{@colorCandidat}\">#{candidat}</span>")
		    			@grille.getPartie().getPlateau().getCase(posFocus).getCandidat.add(candidat)
		    			print(@grille.getPartie().getPlateau().getCase(posFocus).getCandidat.getListeCandidat())
		    			return
		    		end
		    	end
		    end
		end
	end

	def setCandidatState(bool)
		@candidat = bool
		if (@candidat)
			loadAllCandidats()
		else
			resetAllCandidats()
		end
	end

	def setColorCandidat(colorCandidat)
		@colorCandidat = colorCandidat
		refreshAllCandidats
	end
end

