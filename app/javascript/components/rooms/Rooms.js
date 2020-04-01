import React from 'react'
import Room from './Room'

import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link,
  useRouteMatch,
  useParams,
} from 'react-router-dom'

const Rooms = () => {
  let match = useRouteMatch()
  return (
    <Switch>
      <Route path={`${match.url}/:roomId`}>
        <Room />
      </Route>
      <Route path={match.path}>
        <h3>Please select a room.</h3>
      </Route>
    </Switch>
  )
}

export default Rooms
