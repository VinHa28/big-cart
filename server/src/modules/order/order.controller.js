import cartModel from "../cart/cart.model.js";
import orderModel from "./order.model.js";

export const createOrder = async (req, res) => {
  try {
    const { userId, address } = req.body;

    const cart = await cartModel
      .findOne({ user: userId })
      .populate("items.product");
    if (!cart || cart.items.length === 0) {
      return res.status(400).json({ message: "Giỏ hàng trống" });
    }

    const orderItems = cart.items.map((item) => ({
      product: item.product._id,
      quantity: item.quantity,
      price: item.product.price,
    }));

    const total = orderItems.reduce(
      (sum, item) => sum + item.price * item.quantity,
      0,
    );
    const newOrder = new orderModel({
      user: userId,
      items: orderItems,
      total: total,
      address: address,
    });

    await newOrder.save();
    await cartModel.findOneAndDelete({ user: userId });

    res.status(201).json({ message: "Đặt hàng thành công", order: newOrder });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const getAllOrders = async (req, res) => {
  try {
    const orders = await orderModel
      .find()
      .populate("user", "username email")
      .populate("items.product", "name image")
      .sort({ createdAt: -1 });
    res.status(200).json(orders);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const updateOrderStatus = async (req, res) => {
  try {
    const { orderId, status } = req.body;
    const updatedOrder = await orderModel.findByIdAndUpdate(
      orderId,
      { status: status },
      { new: true },
    );
    res.status(200).json(updatedOrder);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const getUserOrders = async (req, res) => {
  try {
    const { userId } = req.params;
    const orders = await orderModel
      .find({ user: userId })
      .populate("items.product")
      .sort({ createdAt: -1 });
    res.status(200).json(orders);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
