const io = require('socket.io-client');
const RoutingContext = require('../client/src/routing-context');

let UserAPI = require('./fluentapi/user-api');

const userAPI = UserAPI(inject({
    io,
    RoutingContext
}));


function playGame(done) {

    let userA = userAPI.create();
    let userB = userAPI.create();

    let gamesDone = {};

    function gameDone(side) {
        gamesDone[side] = true;
        if (gamesDone['X'] && gamesDone['O']) {
            done();
        }
    }

    /*
    Assignment: Explain how this apparently sequential code can function to play *two* sides
    of the game.

    playOSide() is called recursively from userA

    - at first round, userB first line will not be run until A has moved (expectGameJoined and ExpectMoveMade fails)
    -  instead jump to userA.
     - first and second statements evaluate to true
      - A joins game
    - Next round userB first line evaluates to true, (A has moved)
     - B joins game
    - A places move


    A - game has been created, call function recursively
    A - has joined the game
    B - Join game as A has joined
    A - place move 0.0
    B - place move 1.0
    A - place move 1.1
    A - place move 2.2 and expect to win game
    B - place move 2.0

    .

    */
    function playOSide() {

        /*
        Assignment: Run load tests. See them succeed a couple of times.
                    Move expectMoveMade() and expectGameJoined() after joinGame() call, and expectGameCreated() after createGame() call
                    like this:
                         userB.joinGame(userA.getGame().gameId).expectMoveMade('X').expectGameJoined().then(function () {


                     Run load tests again. They should fail. Explain why they fail.


         */
        userB.expectGameJoined().expectMoveMade('X').joinGame(userA.getGame().gameId).then(function () {
        //userB.joinGame(userA.getGame().gameId).expectMoveMade('X').expectGameJoined().then(function () {
//          console.log("B - Join game as A has joined")
            userB.expectMoveMade('O').expectMoveMade('X').placeMove(1, 0).then(() => {                      // B after A moves
  //            console.log("B - place move 1.0")
                userB.expectMoveMade('O').expectMoveMade('X').expectGameWon().placeMove(0, 2).then(() => { // B after A moves
    //              console.log("B - place move 2.0")
                    userB.disconnect();
                    gameDone("O");
                })
            })
        })
    }

    userA.expectGameCreated().createGame().then(() => {
//        console.log("A - game has been created, call function recursive")
        playOSide();
        userA.expectGameJoined().then(() => {
  //        console.log("A - has joined the game")
            userA.expectMoveMade('X').expectMoveMade('O').placeMove(0, 0).then(() => {   //  A
    //          console.log("A - place move 0.0")
                userA.expectMoveMade('X').expectMoveMade('O').placeMove(1, 1).then(() => {   // A
      //            console.log("A - place move 1.1")
                    userA.expectMoveMade('X').expectGameWon().placeMove(2, 2).then(function () {
        //              console.log("A - place move 2.2 and expect to win game")
                        userA.disconnect();
                        gameDone("X");
                    }); // Winning move
                })
            })
        })
    })
}

module.exports= {
    playGame: playGame
};
