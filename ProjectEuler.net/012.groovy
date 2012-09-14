//Juan Vazquez 
//https://github.com/javazquez
//http://javazquez.com

def startTime = System.nanoTime();
TreeSet<Long> primelist=[]
def megaPlist= [2l] as TreeSet
def (long total,long upperbound,long p)=[2*500,2000000,0]
def (t,tri,count)=[1l,0l,2l]
def tria = {long n->((n*(n+1))/2) as long}
def initOrInc={m,value-> (m[value]) ? m[value]+1: 1 }

def primeFacts={numToFact->
  def ret=[:]
  while(!megaPlist.contains(numToFact) && numToFact!=1){ 
    def td = megaPlist.find{numToFact%it==0}
    ret[td]=initOrInc(ret,td)
    numToFact = numToFact/td as long
    if(megaPlist.contains(numToFact)){ 
      ret[numToFact]=initOrInc(ret,numToFact)} 
  }
  return ret.values().toList()
}

def numOfFactors={List args->
  args.collect{it+1}.inject(1){long sum,long it->sum*it}
}
def getTri={ uplimit->
  tri=tria(count)
  while(tri<uplimit){count++
      tri=((count*(count+1))/2) as long
      if( numOfFactors(primeFacts(tri))>500l){ return tri} 
  }
}
//end definitions.. now load up the primes
(3..upperbound).step(2){primelist.add(it.toLong())}
while(Math.pow(p,2)< upperbound){
  p = primelist.first()
  total+=p
  for(long i=Math.pow(p,2).toLong();i<upperbound;i+=p){
    primelist.remove(i)}
  megaPlist<<p
  primelist.remove(p)
}
megaPlist+=primelist

println getTri(1000000000)
System.out.println("seconds:"+(System.nanoTime() - startTime)/1000000000); 
//output
//76576500