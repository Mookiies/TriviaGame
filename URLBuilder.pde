/**
 * A helper class to build a URL to query the database. Public strings are for users
 * when they are are using the builder. Will allow user to double add a specifier,
 * although a url with two of the same specifier will likely be rejected by database.
 * Specifiers can be added in any order and will be valid.
 
 Malcolm Scruggs
Trivia Project
 */
public class URLBuilder {
  private String result;
  private final String base = "https://opentdb.com/api.php?";
  private final String connector = "&"; // added inbetween each specifier
  //base strings for each possible selection category
  private final String ammountBase = "amount=";
  private final String difficultyBase = "difficulty=";
  private final String categoryBase = "category="; //implement last
  private final String typeBase = "type=";

  //Strings for selecting difficulty
  //I wanted to make this an inner enum but Processing didn't allow
  //creation of an enum like EASY("easy")
  public static final String EASY = "easy";
  public static final String MEDIUM = "medium";
  public static final String HARD = "hard";

  //Strings for selecting type
  public static final String TRUE_FALSE = "boolean";
  public static final String MULTIPLE_CHOICE = "multiple";

  //category selectors
  private final int minCategoryVal = 9;
  private final int maxCategoryVal = 32;
  public static final int GENERAL_KNOWLEDGE = 9;
  public static final int ENTERTAINMENT_BOOKS = 10;
  public static final int ENTERTAINMENT_FILM = 11;
  public static final int ENTERTAINMENT_MUSIC  = 12;
  public static final int ENTERTAINMENT_THEATRE  = 13;
  public static final int ENTERTAINMENT_TELEVISION  = 14;
  public static final int ENTERTAINMENT_VIDEO_GAMES  = 15;
  public static final int ENTERTAINMENT_BOARD_GAMES  = 16;
  public static final int ENTERTAINMENT_COMICS  = 29;
  public static final int ENTERTAINMENT_ANIMIE  = 31;
  public static final int ENTERTAINMENT_CARTOON  = 32;
  public static final int SCIENCE_NATURE  = 17;
  public static final int SCIENCE_COMPUTER  = 18;
  public static final int SCIENCE_MATH  = 19;
  public static final int SCIENCE_GADGETS  = 30;
  public static final int MYTHOLOGY  = 20;
  public static final int SPORTS  = 21;
  public static final int GEOGRAPHY  = 22;
  public static final int HISTORY  = 23;
  public static final int POLITICS  = 24;
  public static final int ART  = 25;
  public static final int CELEBRITIES  = 26;
  public static final int VEHICLES  = 28;

  /**
  Prevent default instantiation. A URL must have an ammount so this is disallowed.
  */
  private URLBuilder() {}
 
  /**
   * Creates builder object. Must be instantiated with an ammount because a query
   * cannot be made unless a number of questions is specified.
   *
   * @param ammount
   */
  public URLBuilder(int ammount) {
    if (ammount <= 0 || ammount > 50) {
      throw new IllegalArgumentException("can only request a range from 1-50");
    }
    result = base + ammountBase + ammount;
  }

  /**
   * Adds a difficulty to resulting url.
   *
   * @param difficulty the difficulty to add
   * @return the URLBuilder in use to allow chaining
   */
  public URLBuilder difficulty(String difficulty) {
    result += connector + difficultyBase + difficulty;
    return this;
  }

  /**
   * Adds a category to the resulting url.
   *
   * @param category category to add
   * @return the URLBuilder in use to allow chaining
   */
  public URLBuilder category(int category) {
    if (category < minCategoryVal || category > maxCategoryVal) {
      throw new IllegalArgumentException("not a valid category");
    }
    result += connector + categoryBase + category;
    return this;
  }

  /**
   * Adds the type of question to the resulting url.
   *
   * @param type the type to add
   * @return the URLBuilder in use to allow chaining
   */
  public URLBuilder type(String type) {
    result += connector + typeBase + type;
    return this;
  }

  /**
   * Returns the url that has been built.
   *
   * @return the url as a string
   */
  public String build() {
    return result;
  }
  
}