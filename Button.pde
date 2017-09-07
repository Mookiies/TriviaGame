/**
 * Represents a rectangle button with a hover color change interaction.
 
 Malcolm Scruggs
Trivia Project
 */
public class Button {
  private int x;
  private int y;
  private int bWidth;
  private int bHeight;
  private color buttonColor;
  private color buttonHighlight;
  private boolean buttonOver;
  private boolean hasBeenClicked;
  private String text;


  /**
   * Creates a button object.
   *
   * @param x x cord of button
   * @param y y cord of button
   * @param width width of the button
   * @param height height of the button
   * @param buttonColor outline color of button
   * @param buttonHighlight color to display when button is hovered
   * @param text text to display inside button
   */
  public Button(int x, int y, int width, int height, color buttonColor, color buttonHighlight, String text) {
    this.x = x;
    this.y = y;
    this.bWidth = width;
    this.bHeight = height;
    this.buttonColor = buttonColor;
    this.buttonHighlight = buttonHighlight;
    this.buttonOver = false;
    this.hasBeenClicked = false;
    this.text = text;
  }

  /**
   * Renders the button. Color is changed if button is being hovered by mouse.
   */
  public void render() {
    if (buttonOver) {
      fill(buttonHighlight);
    }
    else {
      fill(buttonColor);
    }
    
    rectMode(CORNER);
    
    rect(x, y, bWidth, bHeight);

    textSize(22);
    fill(255);
    noStroke();
    textAlign(CENTER);
    text(text, x + bWidth / 2, y + bHeight / 2);
  }

  /**
   * Sets the boolean state for being hovered.
   */
  public void update() {
    mousePressedt();
    if (overButton()) {
      buttonOver = true;
    }
    else {
      buttonOver = false;
    }
  }

  /**
   * Changes the button to having been pressed if it has not already been pressed.
   */
  public void mousePressedt() {
    if (mousePressed && overButton() && !hasBeenClicked) {
      hasBeenClicked = true;
    }
  }

  /**
   * Determines if the mouse if over the button.
   *
   * @return true if mouse is over button, false otherwise
   */
  private boolean overButton()  {
    if (mouseX >= x && mouseX <= x+bWidth &&
            mouseY >= y && mouseY <= y+bHeight) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * The state of the button having being clicked. All buttons are configured
   * as a toggle button ie. starts off, turns on with click, turns back off on second click. If
   * button should not behave as a toggle, the button must be reset after being pressed.
   *
   * @return true if button is in clicked state, false if in unclicked state
   */
  public boolean clicked() {
    return hasBeenClicked;
  }

  /**
   * Resets the button to its starting/default state.
   */
  public void reset() {
    buttonOver = false;
    hasBeenClicked = false;
  }

/**
 * Renders this button.
 */
public void draw() {
    update();
    render();
  }
}