import axiosClient from "../api/axios";

export const productService = {
  getAll() {
    return axiosClient.get("/products");
  },

  getById(id) {
    return axiosClient.get(`/products/${id}`);
  },

  create(data) {
    return axiosClient.post("/products", data);
  },

  update(id, data) {
    return axiosClient.put(`/products/${id}`, data);
  },

  delete(id) {
    return axiosClient.delete(`/products/${id}`);
  },
};
