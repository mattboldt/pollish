// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import consumer from "../channels/consumer"

const Hello = props => {
  const [data, setData] = React.useState(null)
  // const ws = new WebSocket('ws://localhost:3000/cable')

  const ws = consumer.subscriptions.create({ channel: "RoomChannel", id: 'oNtN' })

  const sendMessage = () => {
    ws.send(JSON.stringify({ sent_by: "Paul", body: "This is a cool chat app." }))
  }

  React.useEffect(() => {
    ws.onopen = () => {
      // on connecting, do nothing but log it to the console
      console.log('connected')
    }

    ws.onmessage = evt => {
      // listen to data sent from the websocket server
      const message = JSON.parse(evt.data)
      console.log(message)
    }
  }, [])

  return <div>Hello {props.name}! {data} <button onClick={sendMessage}>send</button></div>
}

Hello.defaultProps = {
  name: 'David'
}

Hello.propTypes = {
  name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Hello name="React" />,
    document.body.appendChild(document.createElement('div')),
  )
})
