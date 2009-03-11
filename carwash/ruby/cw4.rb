#Juan Vazquez
#Omaha Dynamic Language User Group's Carwash Challenge
#version 4
class CarwashMachine
  attr_reader  :workingStatus
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
  
  def performSimpleTouchlessPlan
    puts "....performing Simple Touchless on the vehicle...."
  end
  
  def performCleanTouchlessPlan
    puts "....performing Clean Touchless on the vehicle...."
  end
  
  def performStupendousTouchlessPlan
    puts "....Performing Stupendous Touchless on the vehicle...."
  end
  
  def performSimpleTouchless
    puts "....perform Simple Touchless on the vehicle...."
  end
  
  def performWash
    puts "....Washing the vehicle...."
  end
  
  def performSoak
    puts "....Soaking the vehicle...."
  end
  
  def performWax
    puts "....Waxing the vehicle...."
  end
  
  def performBroken
    workingStatus=false
    if !isWorking?
      puts "Sorry, I am not currenty Working"
    end
  end
  def isWorking?
    return workingStatus
  end
end

#used to validate input
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
#it just handles money
class MoneyMuncher
  attr_reader :balance, :status, :menuOption, :carwash, :tokenQty,:customerCodes
  #turn the system on  
  def turnOn
    @validator=Validator.new
    @carwash = CarwashMachine.new
    @customerCodes={}
    @status=true
    puts "\nHello, please wait while I get system going"
    clearbalance
    setOptions
    puts "All Systems go..Thanks for waiting\n "
    while @status
      interactWithCustomer
    end
  end
  
  def comeBackLater
    puts "   Which Plan would you like to purchase?"
    plan=gets.strip!
    #make sure there are no other codes
    if validOption?(plan.to_i)
      washPackage=getOptions(plan.to_i)
      #make sure they have enough befor generating key
      puts(" your Code is =>"+generateCode(washPackage).to_s) if makeDebit(washPackage,false)
    end
  end
  
  #code will be a hash of code numeber=>option 
  #in order to redeem properly
  def generateCode(washPackage)
    genCode=Kernel.rand(10000) unless @customerCodes.has_key?(genCode)
    @customerCodes[genCode]= washPackage
    return genCode
  end
  
  def validateCustomerCode
    puts " Enter in your Code"
    code=gets.strip!
    if @customerCodes.has_key?(code.to_i)
      @customerCodes[code.to_i].runAction
      @customerCodes.delete(code.to_i)
    else
      puts" Sorry, #{code} is an invalid code"
    end   
  end
  
  def turnOff
    @status=false
  end
  
  def generateMenu
    puts "\nPlease choose an option below\n\n"
    for counter in 0... @menuOp.length 
      printf(" [%s] %19s ", counter+=1,getOptions(counter).optionName )
      getOptions(counter).price<=0 ? puts : printf("$%5.2f\n",getOptions(counter).price)
    end
    puts " [i] to insert money\n [r] to return your money\n [q] to quit\n\n"
    printf("\n   Balance is $%5.2f  With %d Tokens\n\n",@balance,@tokenQty)
    puts
  end
  def interactWithCustomer
    generateMenu
    input=gets.strip!
    puts
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
              cash = gets.strip!
              if @validator.isFloat(cash) or @validator.isInteger(cash) 
                if response=='t'
                  (@validator.isInteger(cash) ? takeMoney(0,cash.to_i) : puts("Invalid Token Entry"))
                else
                  takeMoney(cash.to_f)
                end
              end
    else makeSelection(input.to_i)
    end
  end
  
  #set up your options
  def setOptions
    @menuOp={ 1   => Options.new(1,'simple',5.00,1){@carwash.performSimplePlan},
          2   => Options.new(2,'clean',6.00,2){@carwash.performCleanPlan},
          3   => Options.new(3,'stupendous',7.00,3){@carwash.performStupendousPlan},   
          4   => Options.new(4,'simpleTouchless',5.00,1){@carwash.performSimpleTouchlessPlan},
          5   => Options.new(5,'cleanTouchless',6.00,2){@carwash.performCleanTouchlessPlan},
          6   => Options.new(6,'stupendousTouchless',7.00,3){@carwash.performStupendousTouchlessPlan},
          7   => Options.new(7,'testbroken',0.00,0){isCarwashBroken?},
          8   => Options.new(8,'Get Code for Later',0.00,0){comeBackLater},   
          9   => Options.new(9,'Enter Customer Code',0.00,0){validateCustomerCode}             
          }
  end
  def isCarwashBroken?
    @carwash.performBroken
    returnMoney
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
      puts "Dohhh, Invalid Option" 
    end
  end
  #Debit the Balance
  #return true or false based on if it was able to debit the account
  def makeDebit(selectedOp, runActionbool=true)
    debitAmount=selectedOp.price
    hasEnoughCashBool=true
    if @tokenQty >= selectedOp.tokenCost
      @tokenQty-=selectedOp.tokenCost
      selectedOp.runAction if(runActionbool)
    else 
      monitaryVal=convertToDollars(@tokenQty)
      debitAmount=selectedOp.price - monitaryVal #diff of tokens and price
     if @balance-debitAmount <0 
        puts "="* 38+"\n=  ...Sorry, Not enough Credit       =\n"+"="* 38 
        hasEnoughCashBool=false
      else
        @balance -= debitAmount 
        @tokenQty=0 
        printf("you chose option %s which costs $%5.2f/%d Token[s] \n" , selectedOp.optionName ,selectedOp.price ,selectedOp.tokenCost)
        #call the action
        selectedOp.runAction if(runActionbool)
      end
    end
    return hasEnoughCashBool
  end
  
  #convert Tokens to Cash
  #WILL NEED TO CHANGE WHEN COIN QTY MAP TO DIFFERENT PLANS
  #i.e. 2 toks = touchless($5) and hand wash($7)
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
    if @balance<=0 and @tokenQty<=0
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