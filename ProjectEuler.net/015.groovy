// Juan Vazquez 
// https://github.com/javazquez
// http://javazquez.com

def factoral = { BigInteger ubound-> (1..ubound).inject(1 as BigInteger){sum, item-> sum * item }}
def descreteMath={n,r-> factoral(n)/(factoral(r)*factoral(n-r))}

assert  descreteMath(40,20) == 137846528820