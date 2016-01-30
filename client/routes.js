import React from 'react'
import { browserHistory, Router, Route } from 'react-router'
import Games from "./components/games"
import Game from "./components/game"

var routes = <Router history={browserHistory}>
  <Route path="/" component={Games}/>
  <Route path="/games/:id/:key" component={Game} />
</Router>

export default routes


