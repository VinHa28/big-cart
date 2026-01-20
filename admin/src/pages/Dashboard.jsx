import { Card, Row, Col, Statistic } from "antd";

export default function Dashboard() {
  return (
    <Row gutter={16}>
      <Col span={6}>
        <Card>
          <Statistic title="Products" value={120} />
        </Card>
      </Col>
      <Col span={6}>
        <Card>
          <Statistic title="Categories" value={8} />
        </Card>
      </Col>
      <Col span={6}>
        <Card>
          <Statistic title="Users" value={56} />
        </Card>
      </Col>
      <Col span={6}>
        <Card>
          <Statistic title="Orders" value={32} />
        </Card>
      </Col>
    </Row>
  );
}
