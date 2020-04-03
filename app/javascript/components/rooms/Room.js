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
    fetch(`/api/polls?room_id=${roomId}`)
      .then((res) => res.json())
      .then((json) => setPoll(json))
  }

  const onSubmit = (data) => {
    fetch('/api/polls', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ ...data, room_id: roomId }),
    })
      .then((res) => res.json())
      .then((json) => setPoll(json))
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
          <h3>{poll.name}</h3>
          <p>Results: {JSON.stringify(poll.aggregate)}</p>

          <Row>
            {poll.options.map((o) => (
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
          <Form.Label>Options</Form.Label>
          {initialValues.options.map((option, idx) => (
            <Form.Group key={`option-${option}`}>
              <Form.Control
                name={`options[${idx}]`}
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
