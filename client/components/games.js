import React from 'react'
import GamesStore from "../stores/gamesStore"

class Games extends React.Component {
  constructor(props) {
    super(props);
    this.state = GamesStore.getState();
  }

  componentDidMount() {
    GamesStore.listen(this.onChange);
  }

  componentWillUnmount() {
    GamesStore.unlisten(this.onChange);
  }

  render() {
    return(
      <ul>
        {
          this.state.games.map((game) => {
            return <li key={game.id}>{game.id}</li>
          })
        }
      </ul>
    )
  }

  onChange(state) {
    this.setState(state)
  }
}

export default Games
