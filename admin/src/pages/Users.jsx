import { useEffect, useState } from "react";
import {
  Table,
  Button,
  Modal,
  Form,
  Input,
  Select,
  Space,
  Popconfirm,
  message,
  Tag,
} from "antd";
import { PlusOutlined } from "@ant-design/icons";
import { userService } from "../services/user.service";

export default function Users() {
  const [users, setUsers] = useState([]);
  const [open, setOpen] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [loading, setLoading] = useState(false);
  const [form] = Form.useForm();

  const fetchUsers = async () => {
    setLoading(true);
    try {
      const res = await userService.getAll();
      setUsers(res.data);
    } catch {
      message.error("Failed to load users");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  const handleSubmit = async () => {
    try {
      const values = await form.validateFields();

      if (editingId) {
        await userService.update(editingId, values);
        message.success("User updated");
      } else {
        await userService.create(values);
        message.success("User created");
      }

      form.resetFields();
      setOpen(false);
      setEditingId(null);
      fetchUsers();
    } catch (err) {
      console.error(err);
    }
  };

  const handleDelete = async (id) => {
    try {
      await userService.delete(id);
      message.success("User deleted");
      fetchUsers();
    } catch {
      message.error("Delete failed");
    }
  };

  const columns = [
    {
      title: "Username",
      dataIndex: "username",
    },
    {
      title: "Email",
      dataIndex: "email",
    },
    {
      title: "Phone",
      dataIndex: "phone",
    },
    {
      title: "Role",
      dataIndex: "role",
      render: (role) =>
        role === "admin" ? (
          <Tag color="red">Admin</Tag>
        ) : (
          <Tag color="blue">User</Tag>
        ),
    },
    {
      title: "Action",
      render: (_, record) => (
        <Space>
          <Button
            size="small"
            onClick={() => {
              setEditingId(record._id);
              setOpen(true);
              form.setFieldsValue(record);
            }}
          >
            Edit
          </Button>

          <Popconfirm
            title="Delete this user?"
            onConfirm={() => handleDelete(record._id)}
          >
            <Button danger size="small">
              Delete
            </Button>
          </Popconfirm>
        </Space>
      ),
    },
  ];

  return (
    <>
      <Space style={{ marginBottom: 16 }}>
        <Button
          type="primary"
          icon={<PlusOutlined />}
          onClick={() => setOpen(true)}
        >
          Add User
        </Button>
      </Space>

      <Table
        rowKey="_id"
        columns={columns}
        dataSource={users}
        loading={loading}
      />

      <Modal
        title={editingId ? "Edit User" : "Create User"}
        open={open}
        onOk={handleSubmit}
        onCancel={() => {
          setOpen(false);
          setEditingId(null);
          form.resetFields();
        }}
      >
        <Form form={form} layout="vertical">
          <Form.Item
            label="Username"
            name="username"
            rules={[{ required: true }]}
          >
            <Input />
          </Form.Item>

          <Form.Item label="Email" name="email" rules={[{ type: "email" }]}>
            <Input />
          </Form.Item>

          <Form.Item label="Phone" name="phone">
            <Input />
          </Form.Item>

          <Form.Item label="Role" name="role" rules={[{ required: true }]}>
            <Select>
              <Select.Option value="admin">Admin</Select.Option>
              <Select.Option value="user">User</Select.Option>
            </Select>
          </Form.Item>
        </Form>
      </Modal>
    </>
  );
}
