// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import consumer from '../channels/consumer'

import NewVoter from '../components/voters/NewVoter'
import Rooms from '../components/rooms/Rooms'
import { AppContext } from '../components/AppContext'

import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link,
  useRouteMatch,
  useParams,
} from 'react-router-dom'

import 'antd/dist/antd.css'

const App = () => {
  return (
    <Router>
      <div>
        <nav>
          <ul>
            <li>
              <Link to="/">Home</Link>
            </li>
          </ul>
        </nav>

        <Switch>
          <Route path="/rooms">
            <Rooms />
          </Route>
          <Route path="/">
            <NewVoter />
          </Route>
        </Switch>
      </div>
    </Router>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  const initialState = JSON.parse(document.querySelector('meta[name="app-context"]').content)
  ReactDOM.render(
    <AppContext.Provider value={initialState}>
      <App />
    </AppContext.Provider>,
    document.body.appendChild(document.createElement('div'))
  )
})
