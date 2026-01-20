import { Route } from "react-router-dom";
import AdminLayout from "../layouts/AdminLayout";
import Dashboard from "../pages/Dashboard";
import Categories from "../pages/Categories";
import Products from "../pages/Products";
import Users from "../pages/Users";

export default function AdminRoutes() {
  return (
    <Route path="/" element={<AdminLayout />}>
      <Route index element={<Dashboard />} />
      <Route path="categories" element={<Categories />} />
      <Route path="products" element={<Products />} />
      <Route path="users" element={<Users />} />
    </Route>
  );
}
