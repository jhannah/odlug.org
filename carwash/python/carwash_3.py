#! /usr/bin/env python
#~ Copyright 2007 Jeff Hinrichs
  
#~ This program is free software; you can redistribute it and/or modify
#~ it under the terms of the GNU General Public License as published by
#~ the Free Software Foundation; either version 3 of the License, or
#~ (at your option) any later version.

#~ This program is distributed in the hope that it will be useful,
#~ but WITHOUT ANY WARRANTY; without even the implied warranty of
#~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#~ GNU General Public License for more details.

#~ You should have received a copy of the GNU General Public License
#~ along with this program.  If not, see <http://www.gnu.org/licenses/>.

"""
carwash_3.py
  
Omaha Python Users Group - www.omahapython.org
  
Customer Requirements:
 Frobozz Gas and Go has installed a brand new automated car wash. There's 
 just one problem. The hardware that runs the car wash has no software to  
 run it. Basically, it's a coin-operated box that takes the customer's money
 and sends commands to the machine that washes the car. Frobozz has called 
 us to design this software and this is the list of requirements:
 1. Machine Takes Cash/Gives Change
 2. There are 3 packages for the wash and their prices are:
         Simple $5.00 (Action Sent To Wash Machine: Wash)
         Clean $6.00 (Actions Sent To Wash Machine: Wash, Soak)
         Stupendous $7.00 (Wash, Soak, Wax)
 And that's it.
 The interface for the washing machine is this (Specified in Java):
 public interface CarWashMachine {
 public void performWash();
 public void performSoak();
 public void performWax();
 }
1. They forgot to tell us to make sure to have the interface notify the user 
when the car wash is not functioning. This means there is a new method on 
CarWashMachine (boolean isWorking()).
2. They visited another car wash and loved the idea of using tokens in addition 
to money. They think this will be their competitive advantage since the other 
washer only accepts coins. They devised the following system: 
1 coin = simple package; 2 = clean package; 3 = stupendous package. 
Our interface still has to accept money as well.

I asked about the coins and they are worth the same as the plans for. So, 
1 coin=simple touchless, 
2 coins=clean touchless, 
3 coins=stupendous touchless. 
Remember, touchless is only a different kind of wash. It's one more feature on 
the machine and the plans only call touchless instead of the regular wash.

if the car wash machine is not working. you can inquire from the car wash 
machine if its operational or not, and to simply the tell the user to come 
back later.  Return any coins or money they have deposited.

"""
__revision__ = "$Id: carwash_3.py 7 2007-08-19 05:00:34Z  $"  #for documentation

class CarWashMachine(object):
    """ interface to the CarWashMachine"""
    def performWash(self):
        """signal machinery to wash"""
        print "WASHING: scrub a dub"
    
    def performTouchless(self):
        """signal machinery to touchless wash"""
        print "TOUCHLESS: scrub a dub"
        
    def performSoak(self):
        """signal machinery to soak"""
        print "SOAKING: splish splash"
        
    def performWax(self):
        """signal machinery to wax"""
        print "WAXING : rub a dub"
        
    def isWorking(self):
        """condition returned by equipment"""
        return True

class FroBozzWash(CarWashMachine):
    """extends CarWashMachine, implements business logic"""
    def simple(self):
        """Action Sent To Wash Machine: Wash"""
        self.performWash()
        print "*** Operations Complete ***"
        
    def clean(self):
        """Actions Sent To Wash Machine: Wash, Soak"""
        self.performWash()
        self.performSoak()
        print "*** Operations Complete ***"

    def stupendous(self):
        """Actions Sent To Wash Machine: Wash, Soak, Wax"""
        self.performWash()
        self.performSoak()
        self.performWax()
        print "*** Operations Complete ***"

    def tsimple(self):
        """Actions Sent To Wash Machine: Touchless"""
        self.performTouchless()
        print "*** Operations Complete ***"
        
    def tclean(self):
        """Actions Sent To Wash Machine: Touchless, Soak"""
        self.performTouchless()
        self.performSoak()
        print "*** Operations Complete ***"
        
    def tstupendous(self):
        """Actions Sent To Wash Machine: Touchless, Soak, Wax"""
        self.performTouchless()
        self.performSoak()
        self.performWax()
        print "*** Operations Complete ***"
        

class CoinBox(object):
    """implements money taker/dispenser"""
    def __init__(self):
        """initialize dollars at at startup"""
        self.dollars = 0
        self.coins = 0
        
    def insert_dollar(self):
        """a dollar is accepted by the money taker"""
        self.dollars += 1
    
    def insert_coin(self):
        """a coint is accepted by the money taker"""
        self.coins += 1
        
    def return_dollars(self):
        """return dollars(int) to user, re-init dollars for next user"""
        dollars = self.dollars
        self.dollars = 0
        return dollars
        
    def return_coins(self):
        """return coins(int) to user, re-init coins for next user"""
        coins = self.coins
        self.coins = 0
        return coins
        
    def use_dollars(self, dollars_required):
        """if dollars >= dollars_required, decrement dollars return true,
        else return false"""
        if self.dollars >= dollars_required:
            self.dollars -= dollars_required
            return True
        else:
            return False

    def use_coins(self, coins_required):
        """if coins >= coins_required, decrement coins return true,
        else return false"""
        if self.coins >= coins_required:
            self.coins -= coins_required
            return True
        else:
            return False

def usermenu(current_dollars, current_coins):
    """present user interface, return users requested Action"""
    print "Your balance: $%i | %i coins" % (current_dollars, current_coins)
    print
    print "[i] insert dollar"
    print "[c] insert coin"
    print "[1] Buy Simple ($5/1 Coin)"
    print "[2] Buy Clean ($6/2 Coins)"
    print "[3] Buy Stupendous ($7/3 Coins)"
    print "[4] Buy Touchless Simple ($6/1 Coin)"
    print "[5] Buy Touchless Clean ($7/2 Coins)"
    print "[6] Buy Touchless Stupendous ($8/3 Coins)"
    print "[q] Quit"
    return raw_input('Action :')


#make some objects
FBW = FroBozzWash()
COINBOX = CoinBox()

#populate the PRICELIST with type/price/action-method information
PRICELIST = [
    {'type':'Simple',         'price':5, 'coins':1, 'action':FBW.simple},
    {'type':'Clean',          'price':6, 'coins':2, 'action':FBW.clean},
    {'type':'Stupendous', 'price':7, 'coins':3, 'action':FBW.stupendous},
    {'type':'Touchless Simple','price':6, 'coins':1, 'action':FBW.tsimple},
    {'type':'Touchless Clean',  'price':7, 'coins':2, 'action':FBW.tclean},
    {'type':'Touchless Stupendous','price':8, 'coins':3, 
        'action':FBW.tstupendous}
]



ACTION = '' #put the needle on the record
while ACTION != 'q': #start dancing
    ACTION = usermenu(COINBOX.dollars, COINBOX.coins)#defer to puny human

    #respond to request
    if ACTION == 'i':   # dollar inserted
        COINBOX.insert_dollar() #chalk it up
        print 'Cha-Ching'   #output warm fuzzy
    
    if ACTION == 'c':   #coin inserted
        COINBOX.insert_coin() #add it up
        print 'Cha-Chang'
        
    elif ACTION in ['1', '2', '3', '4', '5', '6']: #machine action selected
        if FBW.isWorking():  # only attempt if machine is on-line
            IDX = int(ACTION) - 1    # make an int index out of the ACTION
            print "You Selected: %s" % PRICELIST[IDX]['type']
            if COINBOX.use_dollars(PRICELIST[IDX]['price']): #charge it!
                PRICELIST[IDX]['action']()   #call the method
                
            elif COINBOX.use_coins(PRICELIST[IDX]['coins']):
                PRICELIST[IDX]['action']()   #call the method
                
            else:   #they need to get J-O-B if they want to wash with me
                print "Sorry, Insert More Money/Coins or Try different Action"
                
        else: # machine if off line
            print "Sorry, The Car Wash is temporarily off-line"
            print  "Please try again later."

    elif ACTION == 'q': #they've quit
        if COINBOX.dollars: # give'm back their dime
            print "Returning $%i" % COINBOX.return_dollars()
        if COINBOX.coins:
            print "Returning %i Coins" % COINBOX.return_coins()
            
    else:   #let them know you are not equipped with telepathic module
        print "Sorry, requested Action not understood"
        print
