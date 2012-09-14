// Juan Vazquez 
// https://github.com/javazquez
// http://javazquez.com

def primelist=[2,3,5,7,11,13]
for(canidate in (14..1000001)){
  primelist.find{prime-> canidate % prime==0 } ? null : primelist << canidate 
  if( primelist.size()>=10001){break}
}
println primelist[-1]
//104743