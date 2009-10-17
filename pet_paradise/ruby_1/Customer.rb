#Pet Paradise Challenge for ODynUG
#author: Juan Vazquez http://javazquez.com

require  'Pet'
class Customer
  attr_reader :cust_id, :amount, :animals, :date_range
  def initialize(cust_id,amount,date_range,pets)
    @cust_id, @amount, @animals, @date_range = cust_id.to_i,amount.to_f,[], date_range
    pets=  pets.delete_if{|x| x=="\n"}
    pets.each do |pet|
      weight, type = pet.split('pound')
      if(type.strip == 'DOG') then @animals<< Dog.new(cust_id,weight)
      elsif( type.strip == 'CAT' ): @animals<< Cat.new(cust_id,weight)
      else puts("We don't accept #{type} at this Hotel")  
      end  
    end
  end
  
end



 