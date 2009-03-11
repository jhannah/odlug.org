#Juan Vazquez
#Omaha Dynamic Language User Group's Carwash Challenge
#version 2
class CarwashMachine
  attr_reader :workingStatus
  attr_writer :workingStatus
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
  def isWorking?
    return WorkingStatus
  end
end


class Validator
  def isInteger(input)
  #could be an actual integer, so convert to string
    input.to_s =~/^[0-9]+$/ ? bool=true : bool=false
    return bool
  end
  def isFloat(input)
    bool=false
    if input.to_s =~/^\d+.\d\d$/ or input =~/^\d?.\d\d$/ or input =~/^\d?.\d$/
      bool = true
    end    
   return bool
  end
end
#actions are proc calls
class Options
  #decided to put a reference to what causes the option to run
  #aka-Menutrigger..or number entered in keypad
  attr_reader :menuTrigger, :optionName, :price, :actions, :tokenCost
  def initialize(menuTrigger,optionName, price ,tokCost,&action )
    @menuTrigger=menuTrigger
    @optionName=optionName
    @price=price
    @tokenCost=tokCost
    @actions=action
  end
  def runAction
    @actions.call(self)
  end
end

#give and take money coin box
#it just handles money, doesnt care what it triggers
class MoneyMuncher
  attr_reader :balance, :status, :menuOption, :carwash, :tokenQty
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
      interactWithCustomer
    end
  end
  
  #quit
  def turnOff
    @status=false
  end
  
  def interactWithCustomer
    puts "\nPlease choose an option below\n\n"
    for counter in 0... @menuOp.length 
      printf(" [%s] %10s $%5.2f \n", counter+=1,getOptions(counter).optionName ,getOptions(counter).price)
    end
    puts " [i] to insert money\n [q] to quit\n\n"
    printf("\n   Balance is $%5.2f\nWith %d Tokens\n\n",@balance,@tokenQty)
    puts
    input=gets.strip!
    case input
    when 'q':   turnOff
    when 'r':   returnMoney
    when 'i': 
              puts "enter in 'c' cash or 't' for tokens!"
              response=gets.strip!
              if response=='t' 
                puts("enter in quantity of Tokens") 
              elsif response=='c'
                puts("enter cashola!")
              end
              cash = gets
              if @validator.isFloat(cash) or @validator.isInteger(cash) 
                if response=='t'
                  (@validator.isInteger(cash) ? takeMoney(0,cash.to_i) : puts("Invalid Token Entry"))
                else
                  takeMoney(cash.to_f)
                end
              end
    when @validator.isInteger(input)==false:  puts "Dohhh, '#{input.to_s}' is not a valid option" 
    else makeSelection(input.to_i)
    end
  end
  
  #set up your options
  def setOptions
    @menuOp={ 1   => Options.new(1,'simple',5.00,1){@carwash.performSimplePlan},
          2   => Options.new(2,'clean',6.00,2){@carwash.performCleanPlan},
          3   => Options.new(3,'stupendous',7.00,3){@carwash.performStupendousPlan}
          }
  end
  
  #get the options in hash style option=>price
  def getOptions(selection)
    optionObj=nil
    if @validator.isInteger(selection)
      optionObj=@menuOp[selection]
    else
      #check for name
      @menuOp.values.each do |item|
        if item.optionName==selection
          optionObj=@menuOp[item.menuTrigger]
          break
        end
      end
    end
    return optionObj
  end
  
  def validOption?(sel)
    return @menuOp.has_key?(sel)
  end
  
  def makeSelection(selection)
    if validOption?(selection)
      selectedOp=getOptions(selection)
      makeDebit(selectedOp)
    else
      puts "Dohhh, '#{selection.to_s}' is not a valid option" 
    end
  end
  
  #Debit the Balance
  def makeDebit(selectedOp)
    debitAmount=selectedOp.price
    if @tokenQty >= selectedOp.tokenCost
      @tokenQty-=selectedOp.tokenCost
      selectedOp.runAction
    else 
      monitaryVal=convertToDollars(@tokenQty)
      debitAmount=selectedOp.price - monitaryVal #diff of tokens and price
     if @balance-debitAmount <0 
        puts "="* 38+"\n=  ...Sorry, Not enough Credit       =\n"+"="* 38 
       # printf( "=...Sorry, Not enough Credit\n",debitAmount-@balance, )
       # puts "="* 38
      else
        @balance -= debitAmount 
        @tokenQty=0 
        #call the action
        selectedOp.runAction
      end
    end
  end
  
  #convert Tokens to Cash
  def convertToDollars(qty)
    cashValue=0
    case qty
    when 0 :cashValue = 0
    when 1 :cashValue = getOptions('simple').price
    when 2 :cashValue = getOptions('clean').price
    when 3 :cashValue = getOptions('stupendous').price
    else
      puts "Sorry, no conversion for #{qty} tokens"
    end
    return cashValue
  end
  #check both for cash and tokens
  def takeMoney(money,token=0)
    @balance+=money
    @tokenQty+=token
  end
  
  #give money back
  def returnMoney
    if @balance<=0  and @tokenQty<=0
      puts "Sorry, no money to give back"
    else
      printf("take your $%5.2f and %d token(s) please\n\n", @balance,@tokenQty)
      clearbalance
    end
  end
  
  def clearbalance
    @balance=0
    @tokenQty=0
  end
  
end



#turn it on
  fcw=MoneyMuncher.new
  fcw.turnOn