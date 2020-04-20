import React, { useContext } from 'react'
import { useHistory } from 'react-router-dom'
import { Container, Row, Col, Form, Button } from 'react-bootstrap'
import { useForm } from 'react-hook-form'

import { AppContext } from '../AppContext'

const CreateRoom = () => {
  const appContext = useContext(AppContext)
  const history = useHistory()
  const { register, handleSubmit, watch, errors } = useForm()

  const onSubmit = (data) => {
    fetch('/api/users', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ user: data }),
    })
      .then((res) => res.json())
      .then(({ data }) => {
        const id = data.attributes.latestRoomId
        id && history.push(`/rooms/${id}`)
      })
  }

  const onReset = () => {
    form.resetFields()
  }

  return (
    <Container>
      <Form onSubmit={handleSubmit(onSubmit)}>
        <Form.Group controlId="name">
          <Form.Label>Name</Form.Label>
          <Form.Control name="name" ref={register({ required: true })} />
        </Form.Group>
        <Form.Group controlId="rooms">
          <Form.Label>Room Name</Form.Label>
          <Form.Control
            name="rooms_attributes[0][name]"
            label="Room Name"
            ref={register({ required: true })}
          />
        </Form.Group>

        <Button variant="primary" type="submit">
          Submit
        </Button>
      </Form>
    </Container>
  )
}

export default CreateRoom
