import React from 'react'
import ReactDOM from 'react-dom'
import Game from './components/game'

let App = React.createClass({  
  render() {
    return (
      <div>
        <h1>Hello World</h1>
        <Game />
      </div>
    );
  }
});

ReactDOM.render(<App/>, document.getElementById("codewords"));
