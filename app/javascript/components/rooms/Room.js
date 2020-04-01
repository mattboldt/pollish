import React, { useState, useEffect } from 'react'

import { BrowserRouter as Router, Switch, Route, Link, useParams } from 'react-router-dom'
import { useHistory } from 'react-router-dom'
import { Layout, Form, Input, Button, Select } from 'antd'

const { Option } = Select
const layout = {
  wrapperCol: {
    span: 16,
  },
}

const Room = () => {
  const [poll, setPoll] = useState(null)
  const { roomId } = useParams()
  const [form] = Form.useForm()

  useEffect(() => {
    fetchCurrentPoll()
  }, [])

  const fetchCurrentPoll = () => {
    fetch(`/api/polls?room_id=${roomId}`)
      .then((res) => res.json())
      .then((json) => setPoll(json))
  }

  const onFinish = (values) => {
    fetch('/api/polls', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ ...values, room_id: roomId }),
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
    <Layout className="layout">
      <Layout.Content style={{ padding: '0 50px' }}>
        {poll && (
          <div>
            <h3>{poll.name}</h3>
            <p>Results: {JSON.stringify(poll.aggregate)}</p>
            <ul>
              {poll.options.map((o) => (
                <li key={o.id}>
                  <button onClick={() => vote(o)}>{o.name}</button>
                </li>
              ))}
            </ul>
          </div>
        )}
        {!poll && (
          <Form
            {...layout}
            form={form}
            initialValues={initialValues}
            name="control-hooks"
            onFinish={onFinish}>
            {initialValues.options.map((option, idx) => (
              <Form.Item
                key={`option-${option}`}
                name={['options', idx]}
                label="Option"
                rules={[
                  {
                    required: true,
                  },
                ]}>
                <Input />
              </Form.Item>
            ))}

            <Form.Item>
              <Button type="primary" htmlType="submit">
                Submit
              </Button>
            </Form.Item>
          </Form>
        )}
      </Layout.Content>
    </Layout>
  )
}

export default Room
