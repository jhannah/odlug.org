// Juan Vazquez 
// https://github.com/javazquez
// http://javazquez.com

def primelist = [] as TreeSet
long total = 2
long upperbound = 2000000
int p = 0
(3..upperbound).step(2){primelist.add(it.toInteger())}

while(Math.pow(p,2)< upperbound){
  p = primelist.first()
  total+=p
  for(int i = Math.pow(p,2).toInteger(); i<upperbound; i+=p){
    primelist.remove(i)
  }
  primelist.remove(p)
}
primelist.each{total+= it}
assert total == 142913828922 
