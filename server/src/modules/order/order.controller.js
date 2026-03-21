import Order from "./order.model.js";
import User from "../user/user.model.js";
import Product from "../product/product.model.js";

// Create order. If body.user is missing, assign to a default user (first user with role 'user')
export const createOrder = async (req, res) => {
  try {
    const { user: userId, items, address } = req.body;

    if (!items || !Array.isArray(items) || items.length === 0)
      return res.status(400).json({ message: "Items are required" });

    // resolve user
    let user = null;
    if (userId) {
      user = await User.findById(userId).lean();
    } else {
      user = await User.findOne({ role: "user" }).lean();
    }

    if (!user) return res.status(400).json({ message: "No user found" });

    // Calculate total and validate products
    let total = 0;
    const resolvedItems = [];
    for (const it of items) {
      const product = await Product.findById(it.product).lean();
      if (!product) return res.status(400).json({ message: `Product not found: ${it.product}` });
      const price = product.price || 0;
      const qty = it.quantity || 1;
      total += price * qty;
      resolvedItems.push({ product: product._id, quantity: qty, price });
    }

    const order = await Order.create({
      user: user._id,
      items: resolvedItems,
      total,
      address,
    });

    res.status(201).json(order);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const getOrders = async (req, res) => {
  try {
    const orders = await Order.find().populate("user", "username email").sort({ createdAt: -1 });
    res.json(orders);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const getOrderById = async (req, res) => {
  try {
    const order = await Order.findById(req.params.id).populate("user", "username email");
    if (!order) return res.status(404).json({ message: "Order not found" });
    res.json(order);
  } catch (error) {
    res.status(400).json({ message: "Invalid ID" });
  }
};
