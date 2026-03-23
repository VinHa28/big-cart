import axiosClient from "../api/axios";

export const orderService = {
  getAll() {
    return axiosClient.get("/order/all");
  },

  updateStatus(orderId, status) {
    return axiosClient.put("/order/update-status", { orderId, status });
  },

  getById(id) {
    return axiosClient.get(`/order/${id}`);
  },
};
