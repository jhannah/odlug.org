package coderetreat;

public class Game {

	private boolean[][] board;
	private int x;
	private int y;

	public Game(int i, int j) {
		x = i;
		y = j;
		board = new boolean[x][y];
	}

	public boolean isEmpty() {
		return true;
	}

	public void setBoard(boolean[][] board) {
		this.board = board;
	}

	public boolean[][] getBoard() {
		return board;
	}

	public void setCellState(int i, int j, boolean b) {
		board[i][j] = b;
	}

	public boolean getCellState(int i, int j) {
		return board[i][j];
	}

	public void incrementTime() {
		boolean[][] newBoard = new boolean[x][y];
		int count;

		for (int i = 0; i < x; i++) {
			for (int j = 0; j < y; j++) {
				count = 0;

				for (int k = i - 1; k < i + 2; k++) {

					for (int l = j - 1; l < j + 2; l++) {

						if (k >= 0 && k < x && l >= 0 && l < y) {
							if (k != i || l != j) {
								if (board[k][l]) {
									count++;
								}
							}
						}
					}
				}

				if (count < 2 || count > 3) {
					newBoard[i][j] = false;
				} else if( count == 3 ) {
					newBoard[i][j] = true;
				} else if( count == 2 ) {
					newBoard[i][j] = board[i][j];
				}
			}
		}

		board = newBoard;
	}

	@Override
	public String toString() {
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < x; i++) {
			for (int j = 0; j < y; j++) {
				if (board[i][j]) {
					buffer.append("0");
				} else {
					buffer.append("_");
				}
			}
			buffer.append("\n");
		}
		return buffer.toString();
	}
}
