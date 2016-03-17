

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
int NUM_ROWS = 30;
int NUM_COLS = 30;
final static int NUM_BOMBS =30;
private MSButton[][] buttons; //2d array of minesweeper buttons
PImage k;
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined
 
void setup ()
{
    //background( 0 );
    k=loadImage("rename.jpg");
    size(700, 700);
    textAlign(CENTER,CENTER);

    // make the manager
    Interactive.make( this );

    image(k, 0, 0,700,700);
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row = 0; row< NUM_ROWS; row++){
        for(int col = 0; col< NUM_COLS; col++){
            buttons[row][col] = new MSButton(row,col);
    }
    }
    setBombs();
}
public void setBombs()
{
    //your code   
   while(bombs.size()<NUM_BOMBS)
   {
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
       if(!bombs.contains(buttons[r][c]))
       {
         bombs.add(buttons[r][c]);
       }
   }
}

public void draw ()
{
   
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for(int r=0; r<NUM_ROWS; r++)
    {
        for(int c=0; c<NUM_COLS;c++)
        {
            if(bombs.contains(buttons[r][c])&&!buttons[r][c].isMarked())
            {
                return false;
            }
            
        }
    }
return true;
}
public void displayLosingMessage()
{
    
     for(int r=0; r<NUM_ROWS;r++)
        for(int c=0; c<NUM_COLS; c++)
            if(bombs.contains(buttons[r][c])&&!buttons[r][c].isClicked())
                buttons[r][c].mousePressed();
    stroke(225, 225, 225);
    fill(225, 225, 225);
    text("You Lose",310,570,70,70);
    

}
public void displayWinningMessage()
{
    //your code here
    stroke(225,225,225);
    fill(225, 225, 225);
    text("You Win",310,570,70,70);
    
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width+150;
        y = r*height+150;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed==true)
            marked=!marked;
        else if(bombs.contains(this))
            displayLosingMessage();
        else if(countBombs(r,c)>0)
            setLabel(""+countBombs(r,c));
        else 
        {
            if(isValid(r+1,c)&&buttons[r+1][c].isClicked()==false) // 8 if loops
                buttons[r+1][c].mousePressed();

            if(isValid(r-1,c)&&buttons[r-1][c].isClicked()==false)
                buttons[r-1][c].mousePressed();

            if(isValid(r,c+1)&&buttons[r][c+1].isClicked()==false)
                buttons[r][c+1].mousePressed();

            if(isValid(r,c-1)&&buttons[r][c-1].isClicked()==false)
                buttons[r][c-1].mousePressed();

            if(isValid(r-1,c-1)&&buttons[r-1][c-1].isClicked()==false)
                buttons[r-1][c-1].mousePressed();
            
            if(isValid(r-1,c+1)&&buttons[r-1][c+1].isClicked()==false)
                buttons[r-1][c+1].mousePressed();
            
            if(isValid(r+1,c+1)&&buttons[r+1][c+1].isClicked()==false)
                buttons[r+1][c+1].mousePressed();
            
            if(isValid(r+1,c-1)&&buttons[r+1][c-1].isClicked()==false)
                buttons[r+1][c-1].mousePressed();
        }

            
        //your code here
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r<NUM_ROWS && c<NUM_COLS && r>-1 && c>-1)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;

        if(isValid(r+1,c)&&bombs.contains(buttons[r+1][c]))
            numBombs++;
        if(isValid(r-1,c)&&bombs.contains(buttons[r-1][c]))
            numBombs++;
        if(isValid(r,c+1)&&bombs.contains(buttons[r][c+1]))
            numBombs++;
        if(isValid(r,c-1)&&bombs.contains(buttons[r][c-1]))
            numBombs++;
        if(isValid(r-1,c-1)&&bombs.contains(buttons[r-1][c-1]))
            numBombs++;
        if(isValid(r+1,c-1)&&bombs.contains(buttons[r+1][c-1]))
            numBombs++;
        if(isValid(r-1,c+1)&&bombs.contains(buttons[r-1][c+1]))
            numBombs++;
        if(isValid(r+1,c+1)&&bombs.contains(buttons[r+1][c+1]))
            numBombs++;

        return numBombs;
    }
}



