#Pet Paradise Challenge for ODynUG
#author: Juan Vazquez http://javazquez.com

require 'Reservation'
require 'Customer'

hotel = Reservation.new
fh='reservations.txt'
File.open(fh).each do |line|
  cust_id,amount,date_range,*animals =  line.split('|') 
  date_range = date_range.split('-')
  hotel.add_reservation( Customer.new( cust_id,amount,(date_range[0]..date_range[1]),animals))   
end
  
total_reservations,grand_total=  hotel.confirm_reservations
puts "#{total_reservations.size} reservations made, with a Grand Total of $#{grand_total}"
 hotel.get_reservations.sort{|x,y| x.cust_id.to_i<=>y.cust_id }.each{|res| print "#{res.cust_id},"}
 
 
 
