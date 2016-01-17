import React from 'react'
import Word from './word'

class Board extends React.Component {
  render() {
    return (
      <ul>
        <Word value="Apple" />
        <Word value="Banana" />
        <Word value="Pear" />
      </ul>
    );
  }
};

export default Board
