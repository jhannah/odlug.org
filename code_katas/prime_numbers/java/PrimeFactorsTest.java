package primeFactors;

import static org.junit.Assert.*;
import static primeFactors.PrimeFactors.generate;

import java.util.ArrayList;
import java.util.List;
import org.junit.Test;


public class PrimeFactorsTest {
	private List<Integer> list(int... ints) {
		List<Integer> list = new ArrayList<Integer>();
		
		for (int i : ints) {
			list.add(i);			
		}
		return list;
	} 
 
	@Test
    public void testOne() throws Exception {
 	   assertEquals(list(), PrimeFactors.generate(1));
    }

	@Test
    public void testTwo() throws Exception {
 	   assertEquals(list(2), PrimeFactors.generate(2));
    }
	
	@Test
    public void testThree() throws Exception {
 	   assertEquals(list(3), PrimeFactors.generate(3));
    }

	@Test
    public void testFour() throws Exception {
 	   assertEquals(list(2,2), PrimeFactors.generate(4));
    }

	@Test
    public void testSix() throws Exception {
 	   assertEquals(list(2,3), PrimeFactors.generate(6));
    }

	@Test
    public void testEight() throws Exception {
 	   assertEquals(list(2,2,2), PrimeFactors.generate(8));
    }

	@Test
    public void testNine() throws Exception {
 	   assertEquals(list(3,3), PrimeFactors.generate(9));
    }

	@Test
    public void testOneHundredFiftySix() throws Exception {
 	   assertEquals(list(2, 2, 3, 13), PrimeFactors.generate(156));
    }
}
