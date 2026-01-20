import { Layout, Menu } from "antd";
import {
  DashboardOutlined,
  AppstoreOutlined,
  ShoppingOutlined,
  UserOutlined,
} from "@ant-design/icons";
import { Outlet, useNavigate, useLocation } from "react-router-dom";

const { Header, Sider, Content } = Layout;

const menuItems = [
  {
    key: "/",
    icon: <DashboardOutlined />,
    label: "Dashboard",
  },
  {
    key: "/categories",
    icon: <AppstoreOutlined />,
    label: "Categories",
  },
  {
    key: "/products",
    icon: <ShoppingOutlined />,
    label: "Products",
  },
  {
    key: "/users",
    icon: <UserOutlined />,
    label: "Users",
  },
];

export default function AdminLayout() {
  const navigate = useNavigate();
  const location = useLocation();

  return (
    <Layout style={{ minHeight: "100vh" }}>
      {/* Sidebar */}
      <Sider collapsible>
        <div
          style={{
            height: 48,
            margin: 16,
            color: "#fff",
            fontWeight: 600,
            textAlign: "center",
          }}
        >
          ADMIN
        </div>

        <Menu
          theme="dark"
          mode="inline"
          selectedKeys={[location.pathname]}
          items={menuItems}
          onClick={({ key }) => navigate(key)}
        />
      </Sider>

      {/* Main */}
      <Layout>
        <Header
          style={{
            background: "#fff",
            padding: "0 16px",
            fontWeight: 600,
          }}
        >
          Admin Dashboard
        </Header>

        <Content style={{ margin: 16 }}>
          <div
            style={{
              padding: 16,
              background: "#fff",
              minHeight: "100%",
            }}
          >
            <Outlet />
          </div>
        </Content>
      </Layout>
    </Layout>
  );
}
