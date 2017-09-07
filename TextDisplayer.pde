/**
 * Object to simplify the process of displaying text. This class was never truly flushed out.
 
 Malcolm Scruggs
Trivia Project
 */
public class TextDisplayer {
  
  public final int NORMAL_TEXT_SIZE = 18;
  public final int HEADER_TEXT_SIZE = 30;

  /**
   * Creates an instance to allow for the displaying of text.
   */
  public TextDisplayer() {
    
  }

  /**
   * Displays the given text at the given x and y cordinate. Used normal text size, and center
   * alignment.
   *
   * @param text the text to display
   * @param x the x corrdinate
   * @param y the y corrdinate
   */
  public void display(String text, int x, int y) {
    textSize(NORMAL_TEXT_SIZE);
    fill(255);
    textAlign(CENTER);
    rectMode(CENTER);
    text(text, x, y, width - 20, 200);
  }
}