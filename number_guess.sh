#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess --tuples-only -c"


PLAY() {
  echo "Enter your username:"
  read PLAYER_NAME
  CURRENT_PLAYER=$($PSQL "SELECT username, games, score FROM users WHERE username='$PLAYER_NAME'")
  if [[ -z $CURRENT_PLAYER ]]
  then
    echo "Welcome, $PLAYER_NAME! It looks like this is your first time here."
    INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES('$PLAYER_NAME')")
  else
    USER_DATA=$($PSQL "SELECT username, games, score FROM users WHERE username='$PLAYER_NAME'")
    echo $USER_DATA | while read PLAYER BAR PLAYER_GAMES BAR PLAYER_SCORE
    do
      echo "Welcome back, $PLAYER! You have played $PLAYER_GAMES games, and your best game took $PLAYER_SCORE guesses."
    done
  fi


  SCORE=$($PSQL "SELECT score FROM users WHERE username='$PLAYER_NAME'")
  GAMES=$($PSQL "SELECT games FROM users WHERE username='$PLAYER_NAME'")

  ATTEMPTS=1

  
  IS_PLAYING=true
  RANDOM_NUMBER=$(( RANDOM % 1000 + 1 ))

  echo "Guess the secret number between 1 and 1000:"
  read GUESS

  while $IS_PLAYING
  do    
    if [[ ! $GUESS =~ ^[0-9]+$ ]]
    then
      echo "That is not an integer, guess again:"
      read GUESS
      ATTEMPTS=$(( ATTEMPTS + 1 ))
    elif [[ $GUESS -gt $RANDOM_NUMBER ]]
      then
      echo -e "It's higher than that, guess again:"
      read GUESS
      ATTEMPTS=$(( ATTEMPTS + 1 ))
    elif [[ $GUESS -lt $RANDOM_NUMBER ]]
      then
      echo "It's lower than that, guess again:"
      read GUESS
      ATTEMPTS=$(( ATTEMPTS + 1 ))
    elif [[ $GUESS -eq $RANDOM_NUMBER ]]
      then
        echo "You guessed it in $ATTEMPTS tries. The secret number was $RANDOM_NUMBER. Nice job!"
        IS_PLAYING=false
    fi
  done

  if [[ $SCORE -eq 0 ]]
  then
    SCORE=$ATTEMPTS
  fi

  if [[ $ATTEMPTS -lt $SCORE ]]
  then
    SCORE=$ATTEMPTS
  fi
  GAMES=$(( GAMES + 1 ))

  UPDATE_PLAYER=$($PSQL "UPDATE users SET games=$GAMES, score=$SCORE WHERE username='$PLAYER_NAME'")
}

PLAY