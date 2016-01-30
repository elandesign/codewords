import React from 'react'
import ReactDOM from 'react-dom'
import Games from './components/games'

let App = React.createClass({  
  render() {
    return (
      <div>
        <h1>Hello World</h1>
        <Games />
      </div>
    );
  }
});

ReactDOM.render(<App/>, document.getElementById("codewords"));
