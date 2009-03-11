carwash_x.py

date: 2007-08-20
written by: Jeff Hinrichs
copyright 2007
License: GPL2  (see COPYING for more)
    
Each of the files carwash_1.py -> carwash_4.py represent each phase of the challenge.
I did this so a reader could see any refactoring I did as I progressed through each 
iteration.


Some random general notes:

The CarWashMachine class is not strictly necessary.  It could have been implemented 
as just 4 functions and in fact pylint complains vigorously about the fact.  However,
I thought it would be a good way to show off subclassing in python and also, if this 
were actual code,  the CarWashMachine functions would have probably been supplied 
in some other language and I would have created bindings for them so I could access
them from python.

The FroBozzMachine subclasses CarWashMachine and implements the business logic 
of the different types of washes available.  Implementing new wash types is as easy 
as modifying CarWashMachine and updating the PRICELIST. (*1,*2)

You will notice that I include a reference to the FroBozzWash(FBW) methods in the PRICELIST.
This is laziness on my part as it negated me doing any fancy lookups later when I wanted 
to access those methods.  The method associated with the PRICELIST element is the 
one to use.

PRICELIST is a list of dictionaries (hashes for your perl types<g>), it contains washtype,
price in dollars, price in coins and a reference to the FBW method involved.

(*1)The code does do some user input validation and in the Schedule Appointment logic I 
get smarter and stop playing with index manipulation and just use 0->n for the list as 
opposed to the code in the main loop that does a touchup to the index before 
accessing the PRICELIST.

CoinBox has 2 simple instance variables, dollars and coins. The rest of the class is 
pretty vanilla.

[str(x) for x in range(len(day_names))] 
    is newspeak(python 2.4+) for map(str,range(len(the_days)))
What this honey does could be summed up like:
apply the function str(x) to each element of the list 0->n-1 when n is the length of the list,
the_days. Returns the results of the function as a list.  so if,
the_days was the list [1,2,3,4,5], the len would be 5, the range would be [0,1,2,3,4] and 
applying str(x) would result in ['0','1','2','3','4'].  But day_names is actually a list of proper
names for days and not a simple list of ints -- but you get the idea.

(*2)In the main loop, I actually list out the 6 acceptable inputs for wash types.  If this was an 
app that was likely to change frequently, I would have refactored it like the Appointment 
logic where it will dynamically expand/contract by using exceptions.  But since I'm lazy and
this is just for fun -- I'm leaving it as an exercise for the reader. ;)


enjoy.
-jlh