require 'pry'
require 'pry-byebug'  

class SecretCode
  attr_reader :code
  COLORS = ["red","blue","green","yellow","black","white"]
  def initialize
    # @code = create_code
    @code = ["green", "white", "black", "red"]
  end
  def create_code
    secret = []
    for i in 0..3
      secret << COLORS.sample
    end
    secret
  end
end


class Guess
  attr_reader :correct_in_position, :correct_outof_position, :guess_feedback

  def initialize(selection)
    @counter = 0
    @selection = selection
    diff = $secret.code - @selection
    @right = $secret.code - diff
    @guess_feedback = guess_results
  end

  def guess_results
    guess=[]
    inpos = correct_in_position
    outpos = correct_outof_position
    guess.push(inpos, outpos)
    guess
  end

  private
    def correct_outof_position
      correct_not_in_place = 0
      total_right = @right.each_with_object({}) do |e,h|
        h[e] ? h[e] += 1 : h[e] = 1
      end
      correct_not_in_place = (total_right.values.inject{|sum, n| sum + n}) - @counter
      correct_not_in_place
    end

    def correct_in_position
      @counter = 0
      for i in 0..3 do
        if $secret.code[i] == @selection[i]
          @counter += 1
        end
      end
      @counter
   
    end 
end

class Display
  def initialize(positions)
    @positions = positions
    show_response
  end
  def show_response
    for i in 1..@positions[1]
      print "x"
    end
    for i in 1..@positions[0]
      print "X"
    end
    puts
  end
end

class Player
  attr_reader :pick_colors
  def pick_colors
    selections=[]
    until selections.length == 4
      puts "pick a color"
      choice = gets.chomp
      selections << choice
    end
    selections
  end
end 

$secret = SecretCode.new 
guessing_player = Player.new
$game_won = false 
turn = 0
while turn < 13 || $game_won != true
  selections = guessing_player.pick_colors  
  guess = Guess.new(selections)
  if guess.guess_feedback[0] == 4
    puts "you win!"
    break
  else
    Display.new(guess.guess_feedback)
  end
  turn += 1
end

