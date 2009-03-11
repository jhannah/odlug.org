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
carwash_1.py
  
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
"""
__revision__ = "$Id: carwash_1.py 5 2007-08-19 03:47:22Z  $"  #for documentation

class CarWashMachine(object):
    """ interface to the CarWashMachine"""
    def performWash(self):
        """signal machinery to wash"""
        print "WASHING: scrub a dub"
        
    def performSoak(self):
        """signal machinery to soak"""
        print "SOAKING: splish splash"
        
    def performWax(self):
        """signal machinery to wax"""
        print "WAXING : rub a dub"

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

class CoinBox(object):
    """implements money taker/dispenser"""
    def __init__(self):
        """initialize balance at at startup"""
        self.balance = 0
        
    def insert_dollar(self):
        """a dollar is accepted by the money taker"""
        self.balance += 1
        
    def return_balance(self):
        """return balance(int) to user, re-init balance for next user"""
        balance = self.balance
        self.balance = 0
        return balance
        
    def use_credit(self, amount):
        """if balance >= amount, decrement balance return true,
        else return false"""
        if self.balance >= amount:
            self.balance -= amount
            return True
        else:
            return False

def usermenu(current_balance):
    """present user interface, return users requested Action"""
    print "Your balance: $%i" % current_balance
    print
    print "[i] insert dollar"
    print "[1] Buy Simple ($5)"
    print "[2] Buy Clean ($6)"
    print "[3] Buy Stupendous ($7)"
    print "[q] Quit"
    return raw_input('Action :')


#make some objects
FBW = FroBozzWash()
COINBOX = CoinBox()

#populate the PRICELIST with type/price/action-method information
PRICELIST = [
    {'type':'Simple','price':5,'action':FBW.simple},
    {'type':'Clean','price':6,'action':FBW.clean},
    {'type':'Stupendous','price':7,'action':FBW.stupendous}
]


ACTION = '' #put the needle on the record
while ACTION != 'q': #start dancing
    ACTION = usermenu(COINBOX.balance)#defer to the puny human
    #respond to request
    if ACTION == 'i':   # dollar inserted
        COINBOX.insert_dollar() #chalk it up
        print 'Cha-Ching'   #output warm fuzzy
        
    elif ACTION in ['1', '2', '3']: #a money making action selected
        IDX = int(ACTION) - 1    # make an int index out of the ACTION
        print "You Selected: %s" % PRICELIST[IDX]['type']
        if COINBOX.use_credit(PRICELIST[IDX]['price']): #charge it!
            PRICELIST[IDX]['action']()   #call the method
        else:   #they need to get J-O-B if they want to wash with me
            print "Sorry, Insert More Money or Try a different Action"
            
    elif ACTION == 'q': #they've quit
        if COINBOX.balance: # give'm back their dime and tell'm to go 2 hell
            print "Returning $%i" % COINBOX.return_balance()
            
    else:   #let them know you are not equipped with telepathic module
        print "Sorry, requested Action not understood"
        print
