//Juan Vazquez 
//https://github.com/javazquez
//http://javazquez.com

//works in groovy console
boolean divisible (inNumb,rangevals,clos){
  def test = false
  for(it in rangevals){
    if(clos(inNumb,it)) test = true
    else{test=false;break}
  }
  return test
}

Range rangevals = (20..3)
int cnt=40
def inc=1
while(! divisible(cnt,rangevals,{x,y-> x%y == 0 ? true: false})){
  cnt=(20 *11 * 3 * inc++)
}
println cnt
//232792560
