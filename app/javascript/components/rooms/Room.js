import React, { useState, useEffect } from 'react'
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link,
  useParams,
  useHistory,
} from 'react-router-dom'
import { Container, Row, Col, Form, Button } from 'react-bootstrap'
import { useForm } from 'react-hook-form'

const Room = () => {
  const [poll, setPoll] = useState(null)
  const { roomId } = useParams()
  const { register, handleSubmit, watch, errors } = useForm()

  useEffect(() => {
    fetchCurrentPoll()
  }, [])

  const fetchCurrentPoll = () => {
    fetch(`/api/rooms/${roomId}`)
      .then((res) => res.json())
      .then(({ data, included }) => setPoll(included[0]))
  }

  const onSubmit = (data) => {
    fetch('/api/polls', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ poll: data, room_id: roomId }),
    })
      .then((res) => res.json())
      .then(({ data }) => {
        setPoll({ ...data.attributes, ...data.relationships })
      })
  }

  const vote = (option) => {
    fetch('/api/votes', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ poll_id: poll.id, option_id: option.id }),
    })
      .then((res) => res.json())
      .then((json) => setPoll(json))
  }

  const onReset = () => {
    form.resetFields()
  }

  const initialValues = {
    options: [1, 2, 3, 5],
  }

  return (
    <Container>
      {poll && (
        <div>
          <h3>{poll.attributes.name}</h3>
          <p>Results: {JSON.stringify(poll.attributes.aggregate)}</p>

          <Row>
            {poll.relationships.options.data.map((o) => (
              <Col key={o.id}>
                <Button size="lg" className="p-5" onClick={() => vote(o)}>
                  {o.name}
                </Button>
              </Col>
            ))}
          </Row>
        </div>
      )}
      {!poll && (
        <Form onSubmit={handleSubmit(onSubmit)}>
          <Form.Label>New Poll</Form.Label>

          {initialValues.options.map((option, idx) => (
            <Form.Group key={`option-${option}`}>
              <Form.Control
                name={`options_attributes[${idx}][name]`}
                defaultValue={option}
                ref={register}></Form.Control>
            </Form.Group>
          ))}

          <Button variant="primary" type="submit">
            Submit
          </Button>
        </Form>
      )}
    </Container>
  )
}

export default Room
