import axiosClient from "../api/axios";

export const categoryService = {
  getAll() {
    return axiosClient.get("/categories");
  },

  getById(id) {
    return axiosClient.get(`/categories/${id}`);
  },

  create(data) {
    return axiosClient.post("/categories", data);
  },

  update(id, data) {
    return axiosClient.put(`/categories/${id}`, data);
  },

  delete(id) {
    return axiosClient.delete(`/categories/${id}`);
  },
};
