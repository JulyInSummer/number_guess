# Number Guessin Game
Relational Databases final certification project.

## Description
This is terminal number guessing name. The terminal will prompt you to enter your name. After that it will check if there is a record in the database with the given name. If yes it will welcome you:
```
Welcome back, <username>! You have played <games_played> games, and your best game took <best_score> guesses.
```

If not it will still welcome you but with different message:
```
Welcome, <username>! It looks like this is your first time here.
```
and add new record to the database with the given username

Game will randomly generate a number between 1-1000 and you are supposed to guess it.

## Installation
Clone this repository to your local machine. You need your postgres running and, execute:
```
psql -U postgres < number_guess.sql
```
it will create database with tables and contents needed to play around with the project

## Notes
This is final relational databases certification project [Build a Number Guessing Game](https://www.freecodecamp.org/learn/relational-database/build-a-number-guessing-game-project/build-a-number-guessing-game) on [freeCodeCamp](https://www.freecodecamp.org)
