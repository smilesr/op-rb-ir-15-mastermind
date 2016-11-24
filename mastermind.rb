class SecretCode
  attr_reader :create_code
  COLORS = ["red","blue","green","yellow","black","white"]
  def create_code
    for i in 0..3
      secret << COLORS.sample
    end
  end
  secret
end


class Guess
  attr_reader :correct_in_position, :correct_outof_position

  def initialize(selection)
    @selection = selection
    diff = secret - guess
    @right = secret - diff
  end

  def correct_outof_position
    total_right = @right.each_with_object({}) do |e,h|
      h[e] ? h[e] += 1 : h[e] = 1
    end
    correct_not_in_place = total_right["red"] - counter
  end
end
  
  def correct_in_position
    counter = 0
    for i in 0..3 do
      if secret[i] == guess[i]
        counter += 1
      end
    end
  end 
end

class Player
  attr_reader :pick_colors
  def pick_colors
    puts "what is your next guess?"
    choice = gets.chomp
    selection = choice.split(" ")
    guess = Guess.new(selection)
  end
end 

secret = SecretCode.new 
guessing_player = Player.new
$gave_won = false
turn = 0
until turn <= 12 || $game_won = true
  @guessing_player.pick_colors
  turn += 1
end

