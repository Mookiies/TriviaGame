 import org.apache.commons.lang3.StringEscapeUtils;

import java.util.ArrayList;
import java.util.List;

import processing.data.JSONArray;
import processing.data.JSONObject;

/**
 * Abstract class used to abstract commonality of questions. Offers constructors to simplify
 * creation and formatts the text accordingly. Does add any abstract method requirements.
 
 Malcolm Scruggs
Trivia Project
 */
public abstract class Question implements IQuestion {
  String category;
  String type;
  String difficulty; //TODO make this enum?
  String questionText;
  String correctAnswer;
  List<String> incorrectAnswers;
  PImage categoryImg;

  /**
   * Creates a multiplce choice trivia question from all the contained values, except the image.
   * Formats text and fetches the proper category image. Will throw exception if category is not
   * a valid category. This constructor is primarily for testing purposes.
   *
   * @param category
   * @param type
   * @param difficulty
   * @param questionText
   * @param correctAnswer
   * @param incorrectAnswers
   */
  public Question(String category, String type, String difficulty, String questionText,
                  String correctAnswer, List<String> incorrectAnswers) {
    this.category = category;
    this.type = type;
    this.difficulty = difficulty;
    this.questionText = questionText;
    this.correctAnswer = correctAnswer;
    this.incorrectAnswers = incorrectAnswers;
    finishSetup();
  }

  /**
   * Creates a question from a jsonObject. The jsonObject must be in the correct format.
   * Formats text and fetches the proper category image. Will throw exception if jsonObject
   * does not contain a valid category.
   *
   * @param jsonObject the json object from which to create the question
   */
  public Question(JSONObject jsonObject) {
    this.category = jsonObject.getString("category");
    this.type = jsonObject.getString("type");
    this.difficulty = jsonObject.getString("difficulty");
    this.questionText = jsonObject.getString("question");
    this.correctAnswer = jsonObject.getString("correct_answer");
    this.incorrectAnswers = new ArrayList<String>();
    JSONArray incorrectAnsJSONArray = jsonObject.getJSONArray("incorrect_answers");
    for (int i = 0; i < incorrectAnsJSONArray.size(); i++) {
      incorrectAnswers.add(StringEscapeUtils.unescapeHtml4(incorrectAnsJSONArray.getString(i)));
    }
    finishSetup();
  }

  /**
   * Method to list delegation of formatting that needs to occur on fields of Question.
   * Formats text and create refrence to image.
   */
  private void finishSetup() {
    formatQuotes();
    fetchImage();
  }

  /**
   * Format all strings to unescape special html encoding.
   */
  private void formatQuotes() {
    this.category = StringEscapeUtils.unescapeHtml4(category);
    this.type = StringEscapeUtils.unescapeHtml4(type);
    this.difficulty = StringEscapeUtils.unescapeHtml4(difficulty);
    this.questionText = StringEscapeUtils.unescapeHtml4(questionText);
    this.correctAnswer = StringEscapeUtils.unescapeHtml4(correctAnswer);
    for (String s : incorrectAnswers) {
      s = StringEscapeUtils.unescapeHtml4(s);
    }
  }

  /**
   * Uses category to correctly create a refrence to the correct category image.
   */
  private void fetchImage() {
    String categoryString;
    if (category.contains("General ")) {
      categoryString = GENERAL_KNOWLEDGE;
    }
    else if (category.contains("Entertainment")) {
      categoryString = ENTERTAINMENT;
    }
    else if (category.contains("Science")) {
      categoryString = SCIENCE;
    }
    else if (category.contains("Mythology")) {
      categoryString = MYTHOLOGY;
    }
    else if (category.contains("Sports")) {
      categoryString = SPORTS;
    }
    else if (category.contains("Geography")) {
      categoryString = GEOGRAPHY;
    }
    else if (category.contains("History")) {
      categoryString = HISTORY;
    }
    else if (category.contains("Politic")) {
      categoryString = POLITICS;
    }
    else if (category.contains("Art")) {
      categoryString = MYTHOLOGY;
    }
    else if (category.contains("Celeb")) {
      categoryString = CELEBRITIES;
    }
    else if (category.contains("Animal")) {
      categoryString = ANIMALS;
    }
    else if (category.contains("Vehicle")) {
      categoryString = VEHICLES;
    }
    else {
      throw new IllegalStateException("Invalid Category" + category);
    }
    
    categoryImg = categoryImages.get(categoryString);
  }

  //I did not use any of these methods, but in the case that any special rendering are desired
  // of a question, these getters will return copies (meaning the values of this question
  // cannot be mutated through them) so that such actions can be preformed.
  public String getCategory() {
    return new String(category);
  }

  public String getType() {
    return new String(type);
  }

  public String getDifficulty() {
    return new String(difficulty);
  }

  public String getQuestionText() {
    return new String(questionText);
  }

  public String getCorrectAnswer() {
    return new String(correctAnswer);
  }

  public List<String> getIncorrectAnswers() {
    return new ArrayList<String>(incorrectAnswers);
  }

}