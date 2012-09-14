//Juan Vazquez 
//https://github.com/javazquez
//http://javazquez.com

def startTime = System.nanoTime();
def even={long n ->n/2l}
def odd={long n -> 3l*n + 1l}
long term=0
def memoize=[:] as TreeMap
long numToInsert=0
def findCount={ origNum->
  numToInsert = origNum
  term=0
  while(origNum>1){
    if(memoize.containsKey(origNum.toLong())){
      term+=memoize.get(origNum)
      origNum=1l
    }else{
      origNum = (origNum.toLong() % 2==0)? even(origNum).toLong():odd(origNum).toLong()
    }
    term+=1
  }
  memoize[numToInsert]=term+1l
  term+1
}

def ans =[num:0,max:0] 
long oneMil=1000000
long total=0
long current=0
for(long k=10;k<oneMil;k++){
  current=findCount(k)
  if(current>total){
    total=current
    ans.num=k
    ans.max=total
  }
  
}

println ans
System.out.println("seconds:"+(System.nanoTime() - startTime)/1000000000); 