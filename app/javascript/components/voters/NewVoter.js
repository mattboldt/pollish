import React from 'react'

import { useHistory } from 'react-router-dom'
import { Layout, Form, Input, Button, Select } from 'antd'

const { Option } = Select
const layout = {
  wrapperCol: {
    span: 16,
  },
}

const NewVoter = () => {
  const history = useHistory()
  const [form] = Form.useForm()

  const onFinish = (values) => {
    fetch('/voters', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ voter: values }),
    })
      .then((res) => res.json())
      .then((json) => {
        history.push(`/rooms/${json.room.id}`)
      })
  }

  const onReset = () => {
    form.resetFields()
  }

  return (
    <Layout className="layout">
      <Layout.Content style={{ padding: '0 50px' }}>
        <Form {...layout} form={form} name="control-hooks" onFinish={onFinish}>
          <Form.Item
            name="name"
            label="Name"
            rules={[
              {
                required: true,
              },
            ]}>
            <Input />
          </Form.Item>
          <Form.Item
            name={['rooms_attributes', 0, 'name']}
            label="Room Name"
            rules={[
              {
                required: true,
              },
            ]}>
            <Input />
          </Form.Item>
          <Form.Item>
            <Button type="primary" htmlType="submit">
              Submit
            </Button>
          </Form.Item>
        </Form>
      </Layout.Content>
    </Layout>
  )
}

export default NewVoter
