import React from 'react'
import Board from './board'

class Game extends React.Component {
  getInitialState() {

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
