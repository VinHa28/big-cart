import { useEffect, useState } from "react";
import {
  Table,
  Button,
  Modal,
  Form,
  Input,
  InputNumber,
  Select,
  Space,
  Popconfirm,
  message,
} from "antd";
import { PlusOutlined } from "@ant-design/icons";
import { productService } from "../services/product.service";
import { categoryService } from "../services/category.service";

export default function Products() {
  const [products, setProducts] = useState([]);
  const [categories, setCategories] = useState([]);
  const [editingId, setEditingId] = useState(null);
  const [loading, setLoading] = useState(false);
  const [open, setOpen] = useState(false);
  const [form] = Form.useForm();

  const fetchProducts = async () => {
    setLoading(true);
    try {
      const res = await productService.getAll();
      setProducts(res.data);
    } catch {
      message.error("Failed to load products");
    } finally {
      setLoading(false);
    }
  };

  const fetchCategories = async () => {
    try {
      const res = await categoryService.getAll();
      setCategories(res.data);
    } catch {
      message.error("Failed to load categories");
    }
  };

  useEffect(() => {
    fetchProducts();
    fetchCategories();
  }, []);

  const handleSubmit = async () => {
    try {
      const values = await form.validateFields();

      if (editingId) {
        await productService.update(editingId, values);
        message.success("Product updated");
      } else {
        await productService.create(values);
        message.success("Product created");
      }

      form.resetFields();
      setOpen(false);
      setEditingId(null);
      fetchProducts();
    } catch (err) {
      console.error(err);
    }
  };

  const handleDelete = async (id) => {
    try {
      await productService.delete(id);
      message.success("Product deleted");
      fetchProducts();
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
            alt="product"
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
      title: "Category",
      dataIndex: ["category", "name"],
      render: (_, record) => record.category?.name || "-",
    },
    {
      title: "Price",
      dataIndex: "price",
      render: (price) => `${price?.toLocaleString()} đ`,
    },
    {
      title: "Stock",
      dataIndex: "stock",
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
              form.setFieldsValue({
                ...record,
                category: record.category?._id,
              });
            }}
          >
            Edit
          </Button>

          <Popconfirm
            title="Delete this product?"
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
          Add Product
        </Button>
      </Space>

      <Table
        rowKey="_id"
        columns={columns}
        dataSource={products}
        loading={loading}
      />

      {/* Create Modal */}
      <Modal
        title={editingId ? "Edit Product" : "Create Product"}
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
            label="Product name"
            name="name"
            rules={[{ required: true, message: "Name is required" }]}
          >
            <Input />
          </Form.Item>

          <Form.Item
            label="Category"
            name="category"
            rules={[{ required: true, message: "Category is required" }]}
          >
            <Select placeholder="Select category">
              {categories.map((cat) => (
                <Select.Option key={cat._id} value={cat._id}>
                  {cat.name}
                </Select.Option>
              ))}
            </Select>
          </Form.Item>

          <Form.Item
            label="Price"
            name="price"
            rules={[{ required: true, message: "Price is required" }]}
          >
            <InputNumber
              style={{ width: "100%" }}
              min={0}
              placeholder="Price"
            />
          </Form.Item>

          <Form.Item
            label="Stock"
            name="stock"
            rules={[{ required: true, message: "Stock is required" }]}
          >
            <InputNumber style={{ width: "100%" }} min={0} />
          </Form.Item>

          <Form.Item label="Image URL" name="image">
            <Input placeholder="https://..." />
          </Form.Item>
        </Form>
      </Modal>
    </>
  );
}
