import categoryModel from "../category/category.model.js";
import orderModel from "../order/order.model.js";
import productModel from "../product/product.model.js";
import userModel from "../user/user.model.js";

export const getStats = async (req, res) => {
  try {
    const [totalProducts, totalCategories, totalUsers, totalOrders] =
      await Promise.all([
        productModel.countDocuments(),
        categoryModel.countDocuments(),
        userModel.countDocuments(),
        orderModel.countDocuments(),
      ]);
    res
      .status(200)
      .json({ totalProducts, totalCategories, totalUsers, totalOrders });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};
