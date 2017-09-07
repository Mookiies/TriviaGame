/**
 * Represents a trivia question.
 
 Malcolm Scruggs
Trivia Project
 */
public interface IQuestion {

  /**
   * Returns true f the correct answer for this questions has been selected. Will return false
   * if the wrong answer has been selected or the question has not been asnwered.
   *
   * @return true if yes, false if no
   */
  public boolean correctAnswerSelected();

  /**
   * Returns true if the answer has been choosen and false if it has not.
   *
   * @return true if asnwered, false if not
   */
  public boolean hasAnswerBeenChoosen();

  /**
   * Updates all the values and properties of the button that are dependent on input of any kind.
   * Should be called in the event that any listners are activated that this button may
   * respond to.
   */
  public void update();

  /**
   * Renders this questions. This consists of displaying the question text, question category,
   * question category image, and the options to select and answer for the question.
   */
  public void display();

  /**
   * Resets this question to an unanswered state.
   */
  public void reset();
  
}