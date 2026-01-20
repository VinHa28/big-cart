import { BrowserRouter, Routes, Route } from "react-router-dom";
import AdminRoutes from "./routes/AdminRoutes";

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        {AdminRoutes()}
        <Route path="*" element={<div>404 Not Found</div>} />
      </Routes>
    </BrowserRouter>
  );
}
