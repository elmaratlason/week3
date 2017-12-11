
tictactoe.loadtest.js
  Assignment: Find appropriate numbers to configure the load test so it passes on your buildserver under normal load.

tictactoe-game-player.js

  Assignment: Explain how this apparently sequential code can function to play *two* sides
  of the game.


  Assignment: Run load tests. See them succeed a couple of times.
              Move expectMoveMade() and expectGameJoined() after joinGame() call, and expectGameCreated() after createGame() call
              like this:
                   userB.joinGame(userA.getGame().gameId).expectMoveMade('X').expectGameJoined().then(function () {


               Run load tests again. They should fail. Explain why they fail.



user-api.js
  Assignment: Explain what the push/pop functions do for this API. What effect would it have
  on the fluent API if we did not have them?


test-api.js
  Assignment: Trace this call - back and forth - through the code.
  Put in log statements that enable you to trace the messages going back and forth.
  Result is a list of modules/functions in this source code which get invoked when cleanDatabase is called.
