import java.util.ArrayList;
import java.util.List;

import processing.data.JSONArray;
import processing.data.JSONObject;
import java.util.Random;

/**
 * Represents a true of false trivia question.
 
 Malcolm Scruggs
Trivia Project
 */
public class TFQuestion extends Question {
  TextDisplayer tdCentered = new TextDisplayer();
  
  boolean correctAnsPicked = false;
  boolean hasAnswerBeenPicked = false;
  Button correctAnswerButton;
  Button incorrectAnswerButton;
  
  //both constructors just delegate instantiating fields to Question and create buttons
  public TFQuestion(String category, String type, String difficulty, String questionText,
                  String correctAnswer, List<String> incorrectAnswers) {
      super(category,type, difficulty,questionText, correctAnswer, incorrectAnswers);
      createButtons();
    }
  
  public TFQuestion(JSONObject jsonObject) {
    super(jsonObject);
    createButtons();
  }

  /**
   * Creates the buttons for this question. Always creates two buttons. Always places the true and false
   * buttons in the same place.
   */
  private void createButtons() {
    //int trueX = 500 - 95;
    //int falseX = 500 + 95;
    int trueX = (width / 2) - 95;
    int falseX = (width / 2) + 95;
    boolean isCorrectTrue = correctAnswer.equals("True");
    if (isCorrectTrue) {
      correctAnswerButton = new Button(trueX, height - 125, 100, 75, BUTTON_COLOR, BUTTON_HIGHLIGHT, correctAnswer);
      incorrectAnswerButton = new Button(falseX, height - 125, 100, 75, BUTTON_COLOR, BUTTON_HIGHLIGHT, incorrectAnswers.get(0));
    }
    else {
      correctAnswerButton = new Button(falseX, height - 125, 100, 75, BUTTON_COLOR, BUTTON_HIGHLIGHT, correctAnswer);
      incorrectAnswerButton = new Button(trueX, height - 125, 100, 75, BUTTON_COLOR, BUTTON_HIGHLIGHT, incorrectAnswers.get(0));
    }
  }
  
  public boolean correctAnswerSelected() {
    if (!hasAnswerBeenPicked && (correctAnswerButton.clicked() || incorrectAnswerButton.clicked())) { //change to check all buttons
      hasAnswerBeenPicked = true;
      correctAnsPicked = correctAnswerButton.clicked();
    }
    return correctAnsPicked;
  }
  
  public boolean hasAnswerBeenChoosen() { 
    return hasAnswerBeenPicked;
  }
  
  public void display() {
    //update();
    image(categoryImg, 30, 30);
    tdCentered.display(questionText, width / 2, height / 2);
    textAlign(CORNER);
    text(category, 30, 30);
    correctAnswerButton.draw();
    incorrectAnswerButton.draw();
  }
  
  public void update() {
     correctAnswerButton.update();
     incorrectAnswerButton.update();
     correctAnswerSelected();
  }
  
  public void reset() {
    correctAnsPicked = false;
    hasAnswerBeenPicked = false;
    correctAnswerButton.reset();
    incorrectAnswerButton.reset();
  }
  
}