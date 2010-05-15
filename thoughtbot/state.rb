class State
  
  attr_accessor :state
  
  def initialize(state)
    @state = state
  end
  
  def self.new_england_states
    ["Maine","Vermont","New Hampshire", "Connecticut", "Rhode Island", "Massachusetts"].sort
  end

end