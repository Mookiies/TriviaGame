/*
This is the main class, keeping track of key elements and delegating.
It handles the loading of images, the calls to query database, the creation
of questions, keeping track of what question, and resets.

Malcolm Scruggs
Trivia Project
*/

List<Question> questions; //stores the questions
int questionIdx; //stores what question user is on
int score; // stores the number of correct answers
boolean atEnd; //true if the set of answers has been completed

TextDisplayer td = new TextDisplayer(); //used to display text
QuestionFactory qf = new QuestionFactory(); //used to create questions

//used to build URL. Done through the build as the framework to create a way for users to buil
//a url is there
String url = new URLBuilder(50)
                 .type(URLBuilder.MULTIPLE_CHOICE)
                 //.type(URLBuilder.TRUE_FALSE)
                 //.category(URLBuilder.SPORTS)
                 //.category(20)
                 //.difficulty(URLBuilder.HARD)
                 .build();

//colors
public final color BACKGROUND_COLOR = #424242;
public final color BUTTON_COLOR = #0D47A1;
public final color BUTTON_HIGHLIGHT = #2196F3;

public Map<String, PImage> categoryImages; //Stores the images by category string

//strings used as keys for categoryImages
public static final String GENERAL_KNOWLEDGE = "genKnow";
public static final String ENTERTAINMENT = "entertainment";
public static final String SCIENCE = "science";
public static final String MYTHOLOGY = "mythology";
public static final String SPORTS = "sports";
public static final String GEOGRAPHY = "geography";
public static final String HISTORY = "history";
public static final String POLITICS = "politics";
public static final String ART = "art";
public static final String CELEBRITIES = "celebrities";
public static final String ANIMALS = "animals";
public static final String VEHICLES =  "vehicles";

public static final int IMAGE_RESIZE_SCALE = 100;

void settings() {
  size(1000, 800);
}
void setup() {
  questionIdx = 0;
  score = 0;
  atEnd = false;
  questions = new ArrayList<Question>();

  loadImages();
  
  loadNewQuestions();
}

/**
 * Loads questions. Tried to query the database with url, but if it is unsucessful for any
 * reason loads backup questions from a text file containg questions
 */
private void loadNewQuestions() {
  questions.clear(); //removes any questions left over from previous uses
  JSONObject json;

  try { //query the database
    json = new NetworkUtils().queryDB(url);
    System.out.println("Succesful query");
  }
  catch (Exception e) {//load from backup since query failed
    System.out.println("Error loading from database: " + e.getMessage());
    json = loadJSONObject("another.json");
    System.out.println("Backup questions loaded");
  }

  //questions come in an array following the response code, so this get the array of questions
  JSONArray jsonQuestions = json.getJSONArray("results");

  for (int i = 0; i < jsonQuestions.size(); i++) {
    JSONObject jsonObj = jsonQuestions.getJSONObject(i);
    questions.add(qf.create(jsonObj)); //uses the factory to create correct type of question
  }
}

/**
 * Resets the triva game in one of two ways. If new questions is true, the new questions are loaded.
 * If new questions is false, then the same questions are used and the game is reset to question 1.
 */
private void reset(boolean newQuestions) {
  questionIdx = 0;
  score = 0;
  atEnd = false;
  for (Question q : questions) {
    q.reset();
  }
  if (newQuestions) {
    loadNewQuestions();
  }
  else {
    //do nothing
  }
}

/**
 * Loads all images, resizes the desired dimensions, and places them in the map using the key string.
 */
private void loadImages() {
  categoryImages = new HashMap<String, PImage>();
  
  PImage genK = loadImage("genKnoledge.png");
  genK.resize(IMAGE_RESIZE_SCALE, IMAGE_RESIZE_SCALE);
  categoryImages.put(GENERAL_KNOWLEDGE, genK);
  
  PImage entertain = loadImage("entertainment.png");
  entertain.resize(IMAGE_RESIZE_SCALE, IMAGE_RESIZE_SCALE);
  categoryImages.put(ENTERTAINMENT, entertain);

  PImage science = loadImage("science.png");
  science.resize(IMAGE_RESIZE_SCALE, IMAGE_RESIZE_SCALE);
  categoryImages.put(SCIENCE, science);

  PImage myth = loadImage("mythology.png");
  myth.resize(IMAGE_RESIZE_SCALE, IMAGE_RESIZE_SCALE);
  categoryImages.put(MYTHOLOGY, myth);

  PImage sports = loadImage("sports.png");
  sports.resize(IMAGE_RESIZE_SCALE, IMAGE_RESIZE_SCALE);
  categoryImages.put(SPORTS, sports);

  PImage geography = loadImage("geography.png");
  geography.resize(IMAGE_RESIZE_SCALE, IMAGE_RESIZE_SCALE);
  categoryImages.put(GEOGRAPHY, geography);

  PImage hist = loadImage("history.png");
  hist.resize(IMAGE_RESIZE_SCALE, IMAGE_RESIZE_SCALE);
  categoryImages.put(HISTORY, hist);

  PImage poli = loadImage("politics.png");
  poli.resize(IMAGE_RESIZE_SCALE, IMAGE_RESIZE_SCALE);
  categoryImages.put(POLITICS, poli);

  PImage art = loadImage("art.png");
  art.resize(IMAGE_RESIZE_SCALE, IMAGE_RESIZE_SCALE);
  categoryImages.put(ART, art);

  PImage celb = loadImage("celebrities.png");
  celb.resize(IMAGE_RESIZE_SCALE, IMAGE_RESIZE_SCALE);
  categoryImages.put(CELEBRITIES, celb);

  PImage ani = loadImage("animal.png");
  ani.resize(IMAGE_RESIZE_SCALE, IMAGE_RESIZE_SCALE);
  categoryImages.put(ANIMALS, ani);

  PImage veh = loadImage("vehicles.png");
  veh.resize(IMAGE_RESIZE_SCALE, IMAGE_RESIZE_SCALE);
  categoryImages.put(VEHICLES, veh);
  System.out.println("images loaded");
}

void draw() {
  background(BACKGROUND_COLOR);
  Question q = questions.get(questionIdx);
  q.display();
  fill(255);
  text(Integer.toString(score), width - 30, 30);

  if (atEnd) {
    text("Game Over. Final Score: " + score + "/" + questions.size(), width / 2, 200);
  }

  handleQuestionSelection(q);
}

/**
 * Handles determing if a question has been answered properly. First checks if the question
 * has been answered, if it hasn't nothing is done. If it has it moves to next question and
 * increases score if the question was answered correctly. Does not reset the question.
 */
private void handleQuestionSelection(Question q) {
  if (q.hasAnswerBeenChoosen()) {
    if (q.correctAnswerSelected()) {
      if (!atEnd) {
        score++;
      }
    } else {
    }

    if (questionIdx < questions.size() - 1) {
      questionIdx++;
    } else {
      atEnd = true;
    }
  }
}

void mousePressed() {
  questions.get(questionIdx).update();
}

/**
 * r to reset the current questions
 * n to load a new set of questions
 */
void keyPressed() {
  if (Character.toLowerCase(key) == 'r') {
    reset(false);
  }
  else if (Character.toLowerCase(key) == 'n') {
    reset(true);
  }
}