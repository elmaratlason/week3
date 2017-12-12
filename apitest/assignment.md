# Day11

## tictactoe.loadtest.js
### Find appropriate numbers to configure the load test so it passes on your buildserver under normal load.
  - timelimit = 600;
  - count = 20;
  - ToDo: validate on jenkins as github/jenkins integration is broken after I moved to new repo


## tictactoe-game-player.js

### Explain how this apparently sequential code can function to play *two* sides of the game.

playOSide() is called recursively from userA

- at first round, userB first line will not be run until A has moved (expectGameJoined and ExpectMoveMade fails)
-  instead jump to userA.
 - first and second statements evaluate to true
  - A joins game
- Next round userB first line evaluates to true, (A has moved)
 - B joins game
- A places move

```
A - game has been created, call function recursively
A - has joined the game
B - Join game as A has joined
A - place move 0.0
B - place move 1.0
A - place move 1.1
A - place move 2.2 and expect to win game
B - place move 2.0
```


### Run load tests. See them succeed a couple of times.
    Move expectMoveMade() and expectGameJoined() after joinGame() call, and expectGameCreated() after createGame() call
    like this:
         userB.joinGame(userA.getGame().gameId).expectMoveMade('X').expectGameJoined().then(function () {

     Run load tests again. They should fail. Explain why they fail.

I ran the tests again and they succeeded, both with and without suggested changes

## user-api.js
### Explain what the push/pop functions do for this API. What effect would it have on the fluent API if we did not have them?
- it allows for asynchrounous function, waiting on moves, if move has not been pushed to "stack" we will wait for it


## test-api.js
### Trace this call - back and forth - through the code.
  Put in log statements that enable you to trace the messages going back and forth.
  Result is a list of modules/functions in this source code which get invoked when cleanDatabase is called.
