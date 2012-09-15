// Juan Vazquez 
// https://github.com/javazquez
// http://javazquez.com

def eSum= {mult, upperbound ->
n = ((upperbound-1) / mult ) as Integer //truncates decimal 
n * (n+1) / 2 * mult
}
println(eSum(3,1000)+eSum(5,1000) -eSum(15,1000))


//second way to do it
println( (1..999).findAll{it%3==0 || it%5==0}.sum())
