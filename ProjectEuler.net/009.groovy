def aSide = {m,n-> 2*(m * n) }
def bSide = {m,n-> m**2-n**2 }
def cSide = {m,n-> m**2+n**2 }
def answer = {a,b,c-> a+b+c==1000}

def combo= [( 1..50).toList() , (1..50).toList()].combinations().findAll{it[0]>it[1]}

for( x in combo){
  if(answer(aSide(x[0],x[1]),bSide(x[0],x[1]),cSide(x[0],x[1])) ){
    println "${aSide(x[0],x[1])},${bSide(x[0],x[1])},${cSide(x[0],x[1])}"
    println aSide(x[0],x[1])*bSide(x[0],x[1])*cSide(x[0],x[1])
    break
  }
}
