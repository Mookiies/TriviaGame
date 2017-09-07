/**
 * A question factory that will return the correct version of a question.
 
 Malcolm Scruggs
Trivia Project
 */
public class QuestionFactory {

  /**
   * Creates the correct instance of a question by using the type field of the given JSONObject.
   * The JSONObject must be in the correct format. Will return a TFQuestion if the type if of
   * boolean (true of false), and a multiple choice question otherwise.
   *
   * @param jsonObject the JSONObject to inspect for what type of question to return
   * @return Question object of appropiate type.
   */
  public  Question create(JSONObject jsonObject) {
    String type = jsonObject.getString("type");
    if (type.equals("boolean")) {
      return new TFQuestion(jsonObject);
    }
    else {
      return new MCQuestion(jsonObject);
    }
  }
  
}