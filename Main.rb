Dir[File.dirname(__FILE__) + '/api/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/vues/*.rb'].each {|file| require file }

Index.new

# Dir.chdir(Dir.pwd+"/profil/test")
# FenetreExamen.new(Partie.nouvelle(3),Sauvegarde.loadJoueur("test"))

Gtk.main