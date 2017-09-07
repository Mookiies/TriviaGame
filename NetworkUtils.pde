/**
 * Utility class for making connections to the trivia database. If the url passed in was invalid
 * it will throw the error that occured on attempt to pull from database and subsequently from a file.
 * Will also throw and error if the database returned a json that did not contain valid trivia
 * questions.
 
 Malcolm Scruggs
Trivia Project
 */
public class NetworkUtils {
  private String errorMessageCode_1 = "No Results Could not return results. " +
          "The API doesn't have enough questions for your query.";
  private String errorMessageCode_2 = "Invalid Parameter. Query contains an invalid parameter.";
  private String errorMessageCode_3 = "Token Not Found Session Token does not exist.";
  private String errorMessageCode_4 = "Token Empty Session Token has returned all possible" +
          " questions for the specified query. Resetting the Token is necessary.";

  /**
   * Create a network utils object. Was unable to figure out why processing did not allow the
   * queryDB method to be static, so creating an instance was necessary.
   */
  public NetworkUtils() {}


  /**
   * Querys the database to pull a JSONObject of valid trivia questions. Throws an exception if
   * connection was not established or if the database did not return valid questions. A returned
   * JSONObject is invalid if it has a response code of anything but 0.
   *
   * @param url the url of the database to query
   * @return the JSONObject containg the trivia questions
   */
  public JSONObject queryDB(String url) {
    JSONObject json = loadJSONObject(url);
    int responseCode = json.getInt("response_code");
    switch (responseCode) {
      case 0:
        return json;
      case 1:
        throw new IllegalArgumentException(errorMessageCode_1);
      case 2:
        throw new IllegalArgumentException(errorMessageCode_2);
      case 3:
        throw new IllegalArgumentException(errorMessageCode_3);
      case 4:
        throw new IllegalArgumentException(errorMessageCode_4);
      default:
        throw new IllegalArgumentException("Complete failure");
    }
  }

}