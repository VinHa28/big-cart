import { useEffect, useState } from "react";
import { Table, Tag, Select, message, Typography, Card, Space } from "antd";
import { orderService } from "../services/order.service";
import dayjs from "dayjs";

const { Text } = Typography;

export default function Orders() {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(false);

  const fetchOrders = async () => {
    setLoading(true);
    try {
      const res = await orderService.getAll();
      setOrders(res.data);
    } catch (error) {
      message.error("Không thể tải danh sách đơn hàng");
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchOrders();
  }, []);

  const handleStatusChange = async (orderId, newStatus) => {
    try {
      await orderService.updateStatus(orderId, newStatus);
      message.success("Cập nhật trạng thái thành công");
      fetchOrders(); // Load lại dữ liệu
    } catch (error) {
      message.error("Cập nhật thất bại");
      console.error(error);
    }
  };

  const columns = [
    {
      title: "Mã đơn hàng",
      dataIndex: "_id",
      key: "_id",
      render: (id) => <Text copyable>{id.slice(-6).toUpperCase()}</Text>,
    },
    {
      title: "Khách hàng",
      dataIndex: "user",
      key: "user",
      render: (user) => (
        <div>
          <div style={{ fontWeight: "bold" }}>{user?.username}</div>
          <div style={{ fontSize: "12px", color: "gray" }}>{user?.email}</div>
        </div>
      ),
    },
    {
      title: "Tổng tiền",
      dataIndex: "total",
      key: "total",
      render: (total) => (
        <Text type="danger" strong>
          ${total?.toLocaleString()}
        </Text>
      ),
    },
    {
      title: "Trạng thái",
      dataIndex: "status",
      key: "status",
      render: (status, record) => (
        <Select
          defaultValue={status}
          style={{ width: 120 }}
          onChange={(value) => handleStatusChange(record._id, value)}
          options={[
            { value: "pending", label: <Tag color="warning">Chờ xử lý</Tag> },
            {
              value: "paid",
              label: <Tag color="processing">Đã thanh toán</Tag>,
            },
            { value: "shipped", label: <Tag color="purple">Đang giao</Tag> },
            {
              value: "completed",
              label: <Tag color="success">Hoàn thành</Tag>,
            },
            { value: "cancelled", label: <Tag color="error">Đã hủy</Tag> },
          ]}
        />
      ),
    },
    {
      title: "Ngày đặt",
      dataIndex: "createdAt",
      key: "createdAt",
      render: (date) => dayjs(date).format("DD/MM/YYYY HH:mm"),
    },
    {
      title: "Địa chỉ giao hàng",
      dataIndex: "address",
      key: "address",
      render: (addr) => (
        <div style={{ fontSize: "12px" }}>
          {addr?.fullname} - {addr?.phoneNumber} <br />
          {addr?.address}, {addr?.city}
        </div>
      ),
    },
  ];

  return (
    <Card
      title={<Typography.Title level={3}>Quản lý đơn hàng</Typography.Title>}
    >
      <Table
        columns={columns}
        dataSource={orders}
        rowKey="_id"
        loading={loading}
        expandable={{
          expandedRowRender: (record) => (
            <div style={{ padding: "10px 50px" }}>
              <Typography.Title level={5}>Chi tiết sản phẩm:</Typography.Title>
              {record.items.map((item, index) => (
                <div key={index} style={{ marginBottom: 8 }}>
                  <Space>
                    <img
                      src={item.product?.image}
                      alt={item.product?.name}
                      style={{
                        width: 40,
                        height: 40,
                        objectFit: "cover",
                        borderRadius: 4,
                      }}
                    />
                    <Text strong>{item.product?.name}</Text>
                    <Text>x {item.quantity}</Text>
                    <Text type="secondary">(${item.price})</Text>
                  </Space>
                </div>
              ))}
            </div>
          ),
        }}
      />
    </Card>
  );
}
