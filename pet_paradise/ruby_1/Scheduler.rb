#Pet Paradise Challenge for ODynUG
#author: Juan Vazquez http://javazquez.com

require 'Crate'
class Scheduler
  attr_accessor :crates
  def initialize
   populate_crates
  end
  def populate_crates
     @crates = []
     4.times{@crates<< SmallCrate.new}
     3.times{@crates<< LargeCrate.new}
  end
  def combination(ary,head=[])
    return ary if(ary==[] )
    head << ary.shift 
    tail = ary.clone
    tmp=[]
   if(tail.length>=1)   
      tmp+= combination(tail[1..(tail.length)],head.flatten)+
              combination(Array(tail[-1]),head.flatten)
      tmp+=combination(tail[2..(tail.length)],head.flatten) if(tail[2])
    else
      tmp += combination(tail,Array(head[0]))
    end
    tmp += combination(tail, []) +combination(ary,head.flatten)  
    return (tmp<<head).uniq
  end
  
 def schedule_reservations(list_of_customers)
  good_res, conflicts =  find_conflicts(list_of_customers)
  list_of_possibilities = combination(conflicts)
  failed_check = list_of_possibilities.select{|cust_list| !check_crate_availability(cust_list)}
  list_of_possibilities = list_of_possibilities - failed_check
 return good_res + make_me_money(list_of_possibilities)

 end
 
 
 def check_crate_availability(list_of_customers)
  not_full=false
  list_of_customers.each do |customer|

    customer.animals.each do |pet|
      @crates.each do |crate|
       not_full = crate.insert_guest(pet) unless ( crate.full?)
       break  if (not_full)
      end
      if not_full :  puts "Got a false for #{customer.inspect} and pet #{pet.inspect}" ; end
    end
  end
  return not_full
 end
 
 def make_me_money(res_lst=[])
   most_money_lst,grand_total = [],0
   #need to track every combo with a total
   res_lst.each do |cust_comb_lst|
      total = @customer_combo_ary.inject(0){|sum,customer| sum + customer.amount}
      most_money_lst,grand_total = cust_comb_lst ,total       if(total>grand_total )         
   end
  return most_money_lst
 end
 
#return array of [good,conflicts]
 def find_conflicts(reservation_lst)
   cnt,conflict = 0,[]
   reservation_lst.each do |res|
    reservation_lst[cnt..reservation_lst.length].each do |tail|
      if(tail.date_range.include?(res.date_range.to_a[0]))
        conflict<< res  unless conflict.include?(res) 
        conflict<< tail unless conflict.include?(tail)        
      end
      cnt+=1
    end
   end
   good_reservations = reservation_lst - conflict
   return good_reservations,conflict
 end
end