import axiosClient from "../api/axios";

export const authService = {
  login(data) {
    return axiosClient.post("/auth/login", data);
  },
};
