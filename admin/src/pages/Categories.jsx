import { useEffect, useState } from "react";
import {
  Table,
  Button,
  Modal,
  Form,
  Input,
  Space,
  Popconfirm,
  message,
} from "antd";
import { PlusOutlined } from "@ant-design/icons";
import { categoryService } from "../services/category.service";

export default function Categories() {
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [open, setOpen] = useState(false);
  const [form] = Form.useForm();

  const handleSubmit = async () => {
    try {
      const values = await form.validateFields();

      if (editingId) {
        await categoryService.update(editingId, values);
        message.success("Category updated");
      } else {
        await categoryService.create(values);
        message.success("Category created");
      }

      form.resetFields();
      setOpen(false);
      setEditingId(null);
      fetchCategories();
    } catch (err) {
      console.error(err);
    }
  };

  const fetchCategories = async () => {
    setLoading(true);
    try {
      const res = await categoryService.getAll();
      setCategories(res.data);
      // eslint-disable-next-line no-unused-vars
    } catch (err) {
      message.error("Failed to load categories");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchCategories();
  }, []);

  // const handleCreate = async () => {
  //   try {
  //     const values = await form.validateFields();
  //     await categoryService.create(values);
  //     message.success("Category created");
  //     form.resetFields();
  //     setOpen(false);
  //     fetchCategories();
  //   } catch (err) {
  //     console.error(err);
  //   }
  // };

  const handleDelete = async (id) => {
    try {
      await categoryService.delete(id);
      message.success("Category deleted");
      fetchCategories();
    } catch {
      message.error("Delete failed");
    }
  };
  const columns = [
    {
      title: "Image",
      dataIndex: "image",
      render: (img) =>
        img ? (
          <img
            src={img}
            alt="category"
            style={{ width: 50, height: 50, objectFit: "cover" }}
          />
        ) : (
          "-"
        ),
    },
    {
      title: "Name",
      dataIndex: "name",
    },
    {
      title: "Description",
      dataIndex: "description",
      render: (text) => text || "-",
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
            title="Delete this category?"
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
          Add Category
        </Button>
      </Space>

      <Table
        rowKey="_id"
        columns={columns}
        dataSource={categories}
        loading={loading}
      />

      {/* Create Modal */}
      <Modal
        title={editingId ? "Edit Category" : "Create Category"}
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
            label="Category name"
            name="name"
            rules={[{ required: true, message: "Name is required" }]}
          >
            <Input />
          </Form.Item>

          <Form.Item label="Description" name="description">
            <Input.TextArea rows={3} />
          </Form.Item>

          <Form.Item label="Image URL" name="image">
            <Input placeholder="https://..." />
          </Form.Item>
        </Form>
      </Modal>
    </>
  );
}
