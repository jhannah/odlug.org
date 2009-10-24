#Pet Paradise Challenge for ODynUG
#author: Juan Vazquez http://javazquez.com

#Class will read in file of reservations and use scheduler to find most profit
require 'Scheduler'

class Reservation
  attr_accessor :reservation_file, :reservation_list
  attr_reader :scheduler
  
  def initialize
    @reservation_file=""
    @reservation_list = []
    @scheduler= Scheduler.new
  end  
  def add_reservation(customer)
    @reservation_list<<customer
     @reservation_list.sort!{|customer1,customer2| customer1.date_range.to_a[0]<=>customer2.date_range.to_a[0]}
     
  end

  def get_reservations; @reservation_list ;end
  #find all overlapping reservations and add to the none overlapping
  def confirm_reservations
    @reservation_list = @scheduler.schedule_reservations(@reservation_list)   
    total=  @reservation_list.inject(0){|sum,item| sum + item.amount}
    return @reservation_list,total
  end

end