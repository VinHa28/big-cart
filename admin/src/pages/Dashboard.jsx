import { Card, Row, Col, Statistic } from "antd";
import { useState } from "react";
import { userService } from "../services/user.service";
import { useEffect } from "react";

export default function Dashboard() {
  const [stats, setStats] = useState({
    totalProducts: 0,
    totalCategories: 0,
    totalUsers: 0,
    totalOrders: 0,
  });

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const res = await userService.getStats();
        console.log(res.data);
        setStats(res.data);
      } catch (error) {
        console.error(error);
      }
    };
    fetchStats();
  }, []);
  return (
    <Row gutter={16}>
      <Col span={6}>
        <Card>
          <Statistic title="Products" value={stats.totalProducts} />
        </Card>
      </Col>
      <Col span={6}>
        <Card>
          <Statistic title="Categories" value={stats.totalCategories} />
        </Card>
      </Col>
      <Col span={6}>
        <Card>
          <Statistic title="Users" value={stats.totalUsers} />
        </Card>
      </Col>
      <Col span={6}>
        <Card>
          <Statistic title="Orders" value={stats.totalOrders} />
        </Card>
      </Col>
    </Row>
  );
}
