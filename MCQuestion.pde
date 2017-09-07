import java.util.ArrayList;
import java.util.List;
import java.util.*;

import processing.data.JSONArray;
import processing.data.JSONObject;

/**
 * Represents a multiplce choice trivia question.
 
 Malcolm Scruggs
Trivia Project
 */
public class MCQuestion extends Question {
  TextDisplayer tdCentered = new TextDisplayer();
  
  boolean correctAnsPicked = false;
  boolean hasAnswerBeenPicked = false;
  public final int buttonWidth = 800;
  ArrayList<Button> buttons;

  //both constructors just delegate instantiating fields to Question and create buttons
  public MCQuestion(String category, String type, String difficulty, String questionText,
                  String correctAnswer, List<String> incorrectAnswers) {
    super(category,type, difficulty,questionText, correctAnswer, incorrectAnswers);
    createButtons();
  }

  public MCQuestion(JSONObject jsonObject) {
    super(jsonObject);
    createButtons();
  }

  /**
   * Creates the buttons for this question. At most will create four buttons. If there are
   * more than three incorrect answers, only the first three will be used. Randomized the position
   * of the correct button. If a quesiton is created with less than three incorrect answers then
   * then the button locations will still be randomly selected, possibly leaving a space unfilled.
   * Will not throw errors if there was at least one incorrect question.
   */
  private void createButtons() {
    buttons = new ArrayList<Button>();
    int y1 = height - 100;
    int y2 = height - 200;
    int y3 = height - 300;
    int y4 = height - 400;

    ArrayList<Integer> yPos = new ArrayList<Integer>();
    yPos.add(y1);
    yPos.add(y2);
    yPos.add(y3);
    yPos.add(y4);
    Collections.shuffle(yPos); //randomize the positions by shuffling the list of possible y cordinates

    Button correctAnswerButton = new Button(width / 2 - buttonWidth / 2, yPos.get(0), buttonWidth,
            75, BUTTON_COLOR, BUTTON_HIGHLIGHT, correctAnswer);
    buttons.add(correctAnswerButton); //add correct answer to the start of button array
    
    for (int i = 0; i < incorrectAnswers.size() && i < 3; i++) {
      Button incorrectAnswerButton = new Button(width / 2 - buttonWidth / 2, yPos.get(i + 1),
              buttonWidth, 75, BUTTON_COLOR, BUTTON_HIGHLIGHT, incorrectAnswers.get(i));
      buttons.add(incorrectAnswerButton);
    }
  }

  public boolean correctAnswerSelected() {
    for (Button b : buttons) {
      if (hasAnswerBeenPicked) {
        break;
      }
      if (b.clicked()) {
        hasAnswerBeenPicked = true;
      }
    }
    
    if (hasAnswerBeenPicked) {
      //the correct answer is always the first is the button list
      correctAnsPicked = buttons.get(0).clicked();
    }
    return correctAnsPicked;
  }
  
  public boolean hasAnswerBeenChoosen() { 
    return hasAnswerBeenPicked;
  }
  
  public void display() {
    image(categoryImg, 30, 30);
    tdCentered.display(questionText, width / 2, height / 2);
    textAlign(CORNER);
    text(category, 30, 30);
    for (Button b : buttons) {
      b.draw();
    }
  }
  
  public void update() {
     for (Button b : buttons) {
       b.update();
     }
     correctAnswerSelected();
  }
  
  public void reset() {
    correctAnsPicked = false;
    hasAnswerBeenPicked = false;
    for (Button b : buttons) {
       b.reset();
    }
  }
  
}