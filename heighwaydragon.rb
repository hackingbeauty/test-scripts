require 'pp'
class HeighwayDragon
  class Turtle
    attr_accessor :x, :y, :direction, :dragon, :step
    def initialize
      @x = 0
      @y = 0
      @direction = :N
      @step = 0
    end
 
    RIGHT = {
      :N => :E,
      :E => :S,
      :S => :W,
      :W => :N
    }.freeze
    LEFT = RIGHT.invert.freeze
 
    def right
      @direction = RIGHT[@direction]
      @step
    end
 
    def left
      @direction = LEFT[@direction]
      @step
    end
 
    def forward
      case @direction
      when :N
        @y += 1
      when :E
        @x += 1
      when :S
        @y -= 1
      when :W
        @x -= 1
      end
      @step += 1
    end
 
    def pp
      p [:step, @step, :x, @x, :y, @y, :direction, @direction]
    end
  end
 
  def initialize(max_dragon = 1, max_steps = 1)
    @max_dragon = max_dragon
    @max_steps = max_steps
    @turtle = Turtle.new
    @stack = [:a, @max_dragon, :F]
    @register = []
  end
 
  def run
    while instr = @stack.pop
      case instr
      when :a
        i = (@register.pop || @max_dragon) - 1
        if i >= 0
          @stack << :R
          @stack << :F
          @stack << :b
          @stack << i
          @stack << :R
          @stack << :a
          @stack << i
          p [:a, i]
        end
      when :b
        i = (@register.pop || @max_dragon)- 1
        if i >= 0
          @stack << :b
          @stack << i
          @stack << :L
          @stack << :a
          @stack << i
          @stack << :F
          @stack << :L
          p [:b, i]
        end
      when :F
        @turtle.forward
        p @turtle.pp
      when :L
        @turtle.left
        @turtle.pp
      when :R
        @turtle.right
        @turtle.pp
      else
        @register << instr
      end
      return if @turtle.step >= @max_steps
    end
  end
 
end
 
mydragon = HeighwayDragon.new(5,20)
mydragon.run
 
# Results should be 18,16 for D(10), n=500