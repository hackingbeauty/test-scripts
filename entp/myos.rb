class Object
  
  #Grab in a variable the singleton class of this variable
  def singleton_class
    class << self
      self
    end
  end

end


# OpenStruct automatically creates attributes for anything.  You don't need attr_accesor

class MyOS
  
  
  
  def method_missing(m,*args)
    m = m.to_s
    # Testing to see if = sign is used
    if /(.*)=$/.match(m) # o.x=1  - 'x=' is the method
      base = $1
      sc = singleton_class
      sc.class_eval do
        define_method(m) {|arg| instance_variable_set("@#{base}"),arg }
      end
      send(m,*args)
    end
      
  end
  
end


require 'test/unit'

class MyOSTest < Test::Unit::TestCase
  def test_set_on_attribute
    m = MyOS.new
    m.x = 1
    assert_equal(1,m.x)
  end
  
  def test_set_twice
    m = MyOS.new
    m.x = 1
    asert_equal(1,m.x)
    m.x = 2
    assert_equal(2,m.x)
  end
  
  def test_shortcut
    @m.x = 1
    @m.x += 2
    assert_equal(3,@m.x)
  end
  
  def test_overwite_existing
    
    
  end
end