#Pet Paradise Challenge for ODynUG
#author: Juan Vazquez http://javazquez.com

class Crate
  attr_accessor :occupant_list
  def initialize
    @occupant_list =[]
  end
  
end

class LargeCrate < Crate
  attr_reader :room_for_more
  def insert_guest(guest)
    bool = true
    if  (@occupant_list.nil?)
      @occupant_list=[guest] 
    elsif run_checks(guest): @occupant_list<<guest 
    else bool=false
    end
    return bool
  end
  def run_checks(guest); full?(guest); end

  def full?(guest=[])
    answer = true
    if(guest==[] || @occupant_list[0].instance_of?(guest.class))
      if(@occupant_list.select{|animal| animal.weight <= 60 }.size >=1) : answer = false
      elsif(@occupant_list.select{|animal| (20..60).include?(animal.weight) }.size >=2) : answer = false
      elsif(@occupant_list.select{|animal| animal.weight < 20 }.size >=3 ) : answer = false  
      end
    else  answer = false
    end
    return answer
  end
  
end

class SmallCrate < Crate
  def insert_guest(guest)
    (@occupant_list.nil?) ? @occupant_list=[guest] :(@occupant_list<<guest if run_checks(guest) )
  end
  def full?; @occupant_list.size>=1; end
  def run_checks(guest); full?; end

end
