import alt from "../alt"
import GamesActions from "../actions/gamesActions"

class GamesStore {
  constructor() {
    this.games = [
      {id: 1, name: "woo", key: "woo"},
      {id: 2, name: "wah", key: "wah"}
    ];

    this.bindListeners({
      handleUpdateGames: GamesActions.UPDATE_GAMES
    })
  }

  handleUpdateGames(games) {
    this.games = games
  }
}

export default alt.createStore(GamesStore, "GamesStore")
