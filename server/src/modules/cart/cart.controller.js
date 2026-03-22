import cartModel from "./cart.model.js";

export const addToCart = async (req, res) => {
  try {
    const { userId, productId, quantity } = req.body;

    if (!userId || !productId) {
      return res.status(400).json({ message: "Thiếu userId hoặc productId" });
    }

    const qty = Number(quantity) || 1;

    let cart = await cartModel.findOne({ user: userId });

    if (!cart) {
      cart = new cartModel({
        user: userId,
        items: [{ product: productId, quantity: qty }],
      });
    } else {
      const itemIndex = cart.items.findIndex(
        (item) => item.product.toString() === productId,
      );

      if (itemIndex > -1) {
        cart.items[itemIndex].quantity += qty;
      } else {
        cart.items.push({ product: productId, quantity: qty });
      }
    }

    await cart.save();

    res.status(200).json({
      message: "Thêm vào giỏ hàng thành công",
    });
  } catch (error) {
    console.error("Error addToCart:", error);
    res.status(500).json({ message: "Lỗi server", error: error.message });
  }
};

export const getCartByUserId = async (req, res) => {
  try {
    const { userId } = req.params;
    const cart = await cartModel
      .findOne({ user: userId })
      .populate("items.product");

    if (!cart) {
      return res.status(200).json({ items: [] });
    }
    res.status(200).json(cart);
  } catch (error) {
    res.status(500).json({ message: "Lỗi server", error: error.message });
  }
};

export const removeFromCart = async (req, res) => {
  try {
    const { userId, productId } = req.body;

    let cart = await cartModel.findOne({ user: userId });
    if (!cart)
      return res.status(404).json({ message: "Không tìm thấy giỏ hàng" });

    const itemIndex = cart.items.findIndex(
      (item) => item.product.toString() === productId,
    );

    if (itemIndex > -1) {
      if (cart.items[itemIndex].quantity > 1) {
        cart.items[itemIndex].quantity -= 1; // Giảm 1
      } else {
        cart.items.splice(itemIndex, 1); // Nếu là 1 thì xóa hẳn
      }
      await cart.save();
    }

    const updatedCart = await cartModel
      .findById(cart._id)
      .populate("items.product");
    res.status(200).json(updatedCart);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const clearItemFromCart = async (req, res) => {
  try {
    const { userId, productId } = req.body;

    let cart = await cartModel.findOne({ user: userId });
    if (!cart)
      return res.status(404).json({ message: "Không tìm thấy giỏ hàng" });

    cart.items = cart.items.filter(
      (item) => item.product.toString() !== productId,
    );

    await cart.save();
    const updatedCart = await cartModel
      .findById(cart._id)
      .populate("items.product");
    res.status(200).json(updatedCart);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
