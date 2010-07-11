class ShortId

  Alphabet = 'bcdfghjklmnpqrstvwxyz0123456789bcdfghjklmnpqrstvwxyz'
  AlphabetLength = Alphabet.length

  def init
    id = 123456
    encodedId = ShortId.encode(id)
    puts "encoded id => #{encodedId}"
    # decodedId = ShortId.decode(id)
    # puts "decoded id => #{decodedId}"
  end

  def self.encode(id)
    alpha = ''
    while id !=0
      alpha = Alphabet[id%AlphabetLength].chr + alpha
      id /= AlphabetLength
    end
    alpha
  end
  
  def self.decode(alpha)
    alpha = alpha.dup; id=0
    0.upto(alpha.length -1) do |i|
      id += Alphabet.length(alpha[-1]) * (AlphabetLength ** i)
      alpha.chop!
    end
    id
  end
  
end

ShortId.new.init