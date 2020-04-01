import React from 'react'

import { BrowserRouter as Router, Switch, Route, Link, useParams } from 'react-router-dom'

const Room = () => {
  const { roomId } = useParams()
  return <h3>Room ID: {roomId}</h3>
}

export default Room
