window.fakeStorage = {
  _data: {},

  setItem: function (id, val) {
    return this._data[id] = String(val);
  },

  getItem: function (id) {
    return this._data.hasOwnProperty(id) ? this._data[id] : undefined;
  },

  removeItem: function (id) {
    return delete this._data[id];
  },

  clear: function () {
    return this._data = {};
  }
};

function LocalStorageManager() {
  this.bestScoreKey     = "bestScore";
  this.gameStateKey     = "gameState";

  var supported = this.localStorageSupported();
  this.storage = supported ? window.localStorage : window.fakeStorage;
}

LocalStorageManager.prototype.localStorageSupported = function () {
  var testKey = "test";
  var storage = window.localStorage;

  try {
    storage.setItem(testKey, "1");
    storage.removeItem(testKey);
    return true;
  } catch (error) {
    return false;
  }
};

LocalStorageManager.prototype.saveID = function (id) {
  return this.storage.setItem("game_id", id);
};

LocalStorageManager.prototype.getID = function () {
  return this.storage.getItem("game_id") || 0;
};

// Best score getters/setters
LocalStorageManager.prototype.getBestScore = function () {
  return this.storage.getItem(this.bestScoreKey) || 0;
};

LocalStorageManager.prototype.setBestScore = function (score) {
  this.storage.setItem(this.bestScoreKey, score);
};

LocalStorageManager.prototype.rankBestScores = function (score) {


};

// Game state getters/setters and clearing
LocalStorageManager.prototype.getGameState = function () {
  // var stateJSON; //= this.storage.getItem(this.gameStateKey);
  return $.ajax("/games/:id", {async: false, type: "GET"});

      // create here?
      // $.post("/games", {game: {game_state: JSON.stringify(gameState)}})
      //   .done(function(data) {
      //     console.log("POST DONE!");
      //   })
      //   .fail(function(){
      //     console.log("POST FAIL");
      //   });

  // return stateJSON ? JSON.parse(stateJSON) : null;
};

LocalStorageManager.prototype.setGameState = function (gameState) {
  this.storage.setItem(this.gameStateKey, JSON.stringify(gameState));

  // $.post("/games", {game: {game_state: JSON.stringify(gameState)}})
  //   .done(function(data) {
  //     console.log("POST DONE!");
  //   })
  //   .fail(function(){
  //     console.log("POST FAIL");
  //   });


  $.ajax("/games/" + this.getID(), {
    type: "PATCH",
    game: {game_state: JSON.stringify(gameState)}
  })
    .done(function(data){
      console.log("PATCH DONE!");
      stateJSON = data.game_state;
    })
    .fail(function(){
      console.log("PATCH FAIL");
    });
};


LocalStorageManager.prototype.clearGameState = function () {
  this.storage.removeItem(this.gameStateKey);
};
