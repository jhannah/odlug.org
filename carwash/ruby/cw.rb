#Juan Vazquez
#Omaha Dynamic Language User Group's Carwash Challenge
#version 1
class CarwashMachine
  def performSimplePlan
    performWash
  end
  def performCleanPlan
    performWash
    performSoak
  end
  def performStupendousPlan
    performWash
    performSoak
    performWax
  end
  def performWash();
    puts "....Washing the vehicle...."
  end
  def performSoak();
  
    puts "....Soaking the vehicle...."
  end
  def performWax();
    puts "....Waxing the vehicle...."
  end
  
end

class Validator
  def isInteger(input)
    #could be an actual integer, so convert to string
    input.to_s =~/^\d+$/ ? bool=true : bool=false
    return bool
  end
  def isFloat(input)
    bool=false
    if input.to_s =~/^\d+.\d\d$/ or input =~/^\d?.\d\d$/
      bool = true
    end    
    return bool
  end
end
#actions are proc calls
class Options
  attr_reader :optionName, :price, :actions
  def initialize(optionName, price ,&action )
    @optionName=optionName
    @price=price
    @actions=action
  end
  def runAction
    @actions.call(self)
  end
end

#give and take money coin box
#it just handles money, doesnt care what it triggers
class MoneyMuncher
  attr_reader :balance, :status, :menuOp, :carwash
  #turn the system on  
  def turnOn
    @validator=Validator.new
    @carwash = CarwashMachine.new
    @status=true
    puts "\nHello, please wait while I get system going"
    clearbalance
    setOptions
    puts "All Systems go..Thanks for waiting\n "
    while @status
      puts "\nPlease choose an option below\n\n"
      
      for counter in 0... @menuOp.length 
        printf(" [%s] %10s $%5.2f \n", counter+=1,getOptions(counter).optionName ,getOptions(counter).price)
      end
      puts " [i] to insert money\n [q] to quit\n\n"
      printf("\n   Balance is $%5.2f\n\n",@balance)
      puts
      input=gets.strip!
      interactWithCustomer(input)
    end
  end
  
  
  #quit
  def turnOff
    @status=false
  end
  
  def interactWithCustomer(input)
    if input=='q'
      @status=false
    elsif input=='r'
      returnMoney
    elsif input=='i'
      puts "enter in the cashola!"
      cash = gets
      if @validator.isFloat(cash) or @validator.isInteger(cash)
        takeMoney(cash.to_f)
      end
    elsif(@validator.isInteger(input)==false) 
      puts "Dohhh, '#{input.to_s}' is not a valid option" 
    else
      makeSelection(input.to_i)
    end
  end
  
  #set up your options
  def setOptions
    @menuOp={ 1   => Options.new('simple',5.00){@carwash.performSimplePlan},
          2   => Options.new('clean',6.00){@carwash.performCleanPlan},
          3   => Options.new('stupendous',7.00){@carwash.performStupendousPlan}
          }
  end
  
  #get the options in hash style option=>price
  def getOptions(selection)
    option_obj=@menuOp[selection]
    return option_obj
  end
  
  def validOption?(sel)
    return @menuOp.has_key?(sel)
  end
  
  def makeSelection(selection)
    if validOption?(selection)
      makeDebit(getOptions(selection))
    else
      puts "Dohhh, '#{selection.to_s}' is not a valid option" 
    end
      
  end
  def makeDebit(selectedOp)
    if @balance-selectedOp.price <0 
      puts "="* 38
      printf( "=...Sorry, Not enough Credit\n=...Please Insert $%5.2f\n",selectedOp.price-@balance )
      puts "="* 38
    else
      @balance -= selectedOp.price 
      puts "you chose option #{selectedOp.optionName} which costs #{selectedOp.price } "
      #call the action
      selectedOp.runAction
    end
  end
  def takeMoney(money)
    @balance+=money
  end
  
  #give money back
  def returnMoney
    if @balance<=0
      puts "Sorry, no money to give back"
    else
      printf("take your $%5.2f please", @balance)
      clearbalance
    end
  end
  
  def clearbalance
    @balance=0
  end
  
end



#turn it on
  fcw=MoneyMuncher.new
  fcw.turnOn
