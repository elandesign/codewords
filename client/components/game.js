import React from 'react'
import Board from './board'
import GamesStore from "../stores/gamesStore"

class Game extends React.Component {
  constructor(props) {
    super(props)
    this.state = GamesStore.getState()
    debugger
  }

  render() {
    return (
      <div id="board">
        <Board />
      </div>
    );
  } 
};

export default Game
