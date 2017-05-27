// hoisting
function hoistIt() {
  var a;

  function theFirstHoist() {
    return "first hoist"
  }

  var theSecondHoist

  console.log(a) // undefined
  console.log(theFirstHoist()) // "first hoist"
  console.log(theSecondHoist) // undefined
  console.log(theSecondHoist()) // TypeError: theSecondHoist is not a function

  a = "a"

  theSecondHoist = function() {
    return "second hoist"
  }
}

hoistIt()

//// Todo read up on hoisting and understand what does and doesn't get hoisted.

var character = "Megaman"

var game = {
  character: "Mario",
  properties: {
    character: "Luigi",
    getCharacterName: function() {
      return this.character
    }
  }
}

console.log(game.properties.getCharacterName()) // "Luigi"
var printCharacterName = game.properties.getCharacterName
console.log(printCharacterName()) // "Megaman"
