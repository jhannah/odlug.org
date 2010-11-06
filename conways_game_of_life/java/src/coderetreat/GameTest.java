package coderetreat;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.Test;

public class GameTest {

	private Game game;

	@Before
	public void setup() {
		game = new Game(10, 10);
	}

	@Test
	public void testCreateWorldWithDem() throws Exception {
		assertNotNull(game);
		boolean[][] board = game.getBoard();
		assertEquals(10, board.length);

		for (int i = 0; i < board.length; i++) {
			assertEquals(10, board[i].length);
		}
	}

	@Test
	public void testSetCells() throws Exception {
		game.setCellState(3, 5, true);
		assertTrue(game.getCellState(3, 5));
		assertFalse(game.getCellState(4, 4));
	}

	@Test
	public void testSingleCellDies() throws Exception {
		game.setCellState(5, 5, true);
		game.incrementTime();
		assertFalse(game.getCellState(5, 5));
	}
	
	@Test
	public void testThreeLineOsc() {
		
		game.setCellState(1, 1, true);
		game.setCellState(1, 2, true);
		game.setCellState(1, 3, true);
		
		game.incrementTime();
		
		assertFalse(game.getCellState(1, 1));
		assertFalse(game.getCellState(1, 3));
		assertTrue(game.getCellState(1, 2));
		assertTrue(game.getCellState(0, 2));
		assertTrue(game.getCellState(2, 2));
		
		game.incrementTime();
		
		assertTrue(game.getCellState(1, 1));
		assertTrue(game.getCellState(1, 3));
		assertTrue(game.getCellState(1, 2));
		assertFalse(game.getCellState(0, 2));
		assertFalse(game.getCellState(2, 2));
	}
	
	@Test
	public void testSquareOfCellsLive() throws Exception {
		game.setCellState(4, 4, true);
		game.setCellState(4, 5, true);
		game.setCellState(5, 4, true);
		game.setCellState(5, 5, true);
		game.incrementTime();
		assertTrue(game.getCellState(5, 5));
		assertTrue(game.getCellState(4, 4));
		assertTrue(game.getCellState(5, 4));
		assertTrue(game.getCellState(4, 5));
	}
	
	@Test
	public void testOverCrowdedCross() throws Exception {
		game.setCellState(4, 4, true);
		game.setCellState(4, 5, true);
		game.setCellState(4, 6, true);
		game.setCellState(3, 5, true);
		game.setCellState(5, 5, true);
		
		game.incrementTime();
		
		assertFalse(game.getCellState(4, 5));
	}
	
	@Test
	public void testPairDies() throws Exception {
		game.setCellState(2, 2, true);
		game.setCellState(2, 3, true);
		
		game.incrementTime();
		
		for( int i = 1 ; i < 5; i++ ) {
			for( int j = 1; j < 5; j++ ) {
				assertFalse( "Failed on " + i +  ", " + j, game.getCellState(i, j));
			}
		}
	}

	@Test
	public void testGlider() throws Exception {
		game.setCellState(0, 2, true);
		game.setCellState(1, 0, true);
		game.setCellState(1, 2, true);
		game.setCellState(2, 2, true);
		game.setCellState(2, 1, true);

		System.out.println(game);

		for (int i = 0; i < 35; i++) {
			game.incrementTime();
			System.out.println(game);
		}
	}
}
