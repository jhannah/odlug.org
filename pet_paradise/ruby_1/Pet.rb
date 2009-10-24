#Pet Paradise Challenge for ODynUG
#author: Juan Vazquez http://javazquez.com

class Pet
  attr_reader :owner, :weight
  def initialize(cust_id,weight,date_range=[])
    @owner, @weight = cust_id, weight
  end
end

class Cat < Pet
end
class Dog < Pet
end