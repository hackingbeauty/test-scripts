class Card
  
  attr_accessor :suit
  attr_accessor :rank
  Suits = %w{Hearts Diamonds Spades Clubs}
  Ranks = %w{2 3 4 5 6 7 8 9 10 Jack Queen King Ace Joker}
    
  def initialize(suit,rank)
    
    if Suits.include?(suit)
      @suit = suit
    else
      raise "That's not a valid suit"
    end
    
    if Ranks.include?(rank)
      @rank = rank
    else
      raise "That's not a valid rank"
    end
    
    puts "The suit is #{@suit}, the rank is #{@rank}"
  
  end
  
  def flip
    puts "#{suit} #{num}"
  end
  
end