import axiosClient from "../api/axios";

export const userService = {
  getAll() {
    return axiosClient.get("/users");
  },

  getById(id) {
    return axiosClient.get(`/users/${id}`);
  },

  create(data) {
    return axiosClient.post("/users", data);
  },

  update(id, data) {
    return axiosClient.put(`/users/${id}`, data);
  },

  delete(id) {
    return axiosClient.delete(`/users/${id}`);
  },
};
