class Generateur
    attr_reader :size, :base, :length, :grid
    
    def initialize base=3
      @base   = base.to_i
      @size   = @base*@base
      @length = @size*@size
      @grid = Array.new(@size) do |i|
        Array.new(@size){|j| 0}
      end
    end
    
    #Renvoie le coté du Sudoku
    # * [Retourne :]
    #             Fixnum
    def set x, y, val
      if x<0 || x>=size || y<0 || y>=size || val<0 || val > size
        raise ArgumentError, "#{x},#{y} => #{val} is impossible in a #{size}x#{size} sudoku"
      end
      @grid[x][y] = val
    end
    
    #Renvoie la valeur en x,y
    # * [Retourne :]
    #             Fixnum
    def get x, y
      if x<0 || x>=size || y<0 || y>=size
        raise ArgumentError, "Is there a #{x},#{y} cell in a #{size}x#{size} sudoku ?"
      end
      @grid[x][y]
    end
    
    #Parcourt tout le sudoku
    # @yield [x, y, val] la position et la valeur courante
    # * [Retourne :]
    #             self
    def each
      @size.times do |y|
        @size.times do |x|
          yield x, y, @grid[x][y]
        end
      end
      self
    end

    #Remplit la diagonale descendante de 1 a self.size
    # * [Retourne :]
    #             self
    def make_diagonal
      each{|x,y,val| set x,x,x+1 if x==y}
      self
    end
    
    #Remplit tout le sudoku de maniere a ce qu'il soit valide
    # * [Retourne :]
    #             self
    def make_valid
      pattern = Array.new(size){|i| i+1}.shuffle
      size.times do |y|
        size.times do |x|
          set x, y, pattern[x]
        end
        base.times{|i| pattern.push pattern.shift}
        pattern.push pattern.shift if base - (y%base) == 1
      end
      self
    end
  
    #Cree un sudoku valide et laisse des cases vides au hasard
    # * [Parametre :]
    #             [Fixnum]seed Le parametre a utiliser pour rand()
    # * [Retourne :]
    #             self
    def make_valid_incomplete seed=2
      pattern = Array.new(size){|i| i+1}.shuffle
      size.times do |y|
        size.times do |x|
          set x, y, pattern[x] if rand(seed) == seed-1
        end
        base.times{|i| pattern.push pattern.shift}
        pattern.push pattern.shift if base - (y%base) == 1
      end
      self
    end

    #Représentation texte humainement lisible
    # * [Retourne :]
    #             string
    def to_s
      res  = ""
      width = size.to_s.length
      zero = ".".center width+1
      
      size.times do |y|
        res += "\n" if y>0 && y%base == 0
        size.times do |x|
          res += " " if x>0 && x%base == 0
          val = get x, y
          res += val.zero? ? zero : "#{val.to_s.center width} "
        end
        res += "\n"
      end
      res
    end
end

#grille.make_valid()

#grille.make_valid_incomplete()

#print grille

#print grille.grid