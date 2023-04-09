# Project: Hangman

Building a simple command line Hangman game where one player plays against the computer, but a bit more advanced.



## Dictionary file from the first20hours GitHub repository google-10000-english.

  [first20hours GitHub repository google-10000-english](https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt)

## Project requirements:

When a new game is started, the script should load in the dictionary and randomly select a word between 5 and 12 characters long for the secret word.


Display some sort of count so the player knows how many more incorrect guesses they have before the game ends. You should also display which correct letters have already been chosen (and their position in the word, e.g. _ r o g r a _ _ i n g) and which incorrect letters have already been chosen.

Update the display to reflect whether the letter was correct or incorrect. If out of guesses, the player should lose.

Implement the functionality where, at the start of any turn, instead of making a guess the player should also have the option to save the game.

When the program first loads, add in an option that allows you to open one of your saved games, which should jump you exactly back to where you were when you saved.

**From The Odin Project**
