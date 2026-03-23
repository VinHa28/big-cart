import userModel from "./user.model.js";

/**
 * CREATE user
 */
export const createUser = async (req, res) => {
  try {
    const user = await userModel.create(req.body);
    res.status(201).json(user);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

/**
 * GET all users
 */
export const getUsers = async (req, res) => {
  try {
    const users = await userModel.find().sort({ createdAt: -1 });
    res.json(users);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

/**
 * GET user by ID
 */
export const getUserById = async (req, res) => {
  try {
    const user = await userModel.findById(req.params.id);
    if (!user) return res.status(404).json({ message: "User not found" });

    res.json(user);
  } catch (error) {
    res.status(400).json({ message: "Invalid ID" });
  }
};

/**
 * UPDATE user
 */
export const updateUser = async (req, res) => {
  try {
    const user = await userModel.findById(req.params.id);
    if (!user) return res.status(404).json({ message: "User not found" });

    Object.assign(user, req.body);
    await user.save();

    res.json(user);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

/**
 * DELETE user
 */
export const deleteUser = async (req, res) => {
  try {
    const user = await userModel.findByIdAndDelete(req.params.id);
    if (!user) return res.status(404).json({ message: "User not found" });

    res.json({ message: "User deleted successfully" });
  } catch (error) {
    res.status(400).json({ message: "Invalid ID" });
  }
};

export const addAddress = async (req, res) => {
  try {
    const { userId, addressData } = req.body;
    const user = await userModel.findById(userId);
    if (!user) return res.status(404).json({ message: "User không tồn tại" });

    // Nếu là địa chỉ đầu tiên, mặc định đặt là default
    if (user.addresses.length === 0) {
      addressData.isDefault = true;
    } else if (addressData.isDefault) {
      // Nếu địa chỉ mới là default, bỏ default của các cái cũ
      user.addresses.forEach((addr) => (addr.isDefault = false));
    }

    user.addresses.push(addressData);
    await user.save();
    res.status(201).json(user.addresses);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// 2. Cập nhật địa chỉ
export const updateAddress = async (req, res) => {
  try {
    const { userId, addressId, updateData } = req.body;
    const user = await userModel.findById(userId);
    if (!user) return res.status(404).json({ message: "User không tồn tại" });

    const addrIndex = user.addresses.findIndex(
      (a) => a._id.toString() === addressId,
    );
    if (addrIndex === -1)
      return res.status(404).json({ message: "Không tìm thấy địa chỉ" });

    // Xử lý logic default nếu bản cập nhật yêu cầu set default
    if (updateData.isDefault) {
      user.addresses.forEach((addr) => (addr.isDefault = false));
    }

    user.addresses[addrIndex] = {
      ...user.addresses[addrIndex]._doc,
      ...updateData,
    };
    await user.save();
    res.status(200).json(user.addresses);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// 3. Xóa địa chỉ
export const deleteAddress = async (req, res) => {
  try {
    const { userId, addressId } = req.params;
    const user = await userModel.findById(userId);

    const addressToDelete = user.addresses.id(addressId);
    const wasDefault = addressToDelete?.isDefault;

    user.addresses.pull(addressId);

    // Nếu xóa địa chỉ default mà vẫn còn địa chỉ khác, đặt cái đầu tiên làm default
    if (wasDefault && user.addresses.length > 0) {
      user.addresses[0].isDefault = true;
    }

    await user.save();
    res.status(200).json(user.addresses);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// 4. Set default địa chỉ
export const setDefaultAddress = async (req, res) => {
  try {
    const { userId, addressId } = req.body;
    const user = await userModel.findById(userId);

    user.addresses.forEach((addr) => {
      addr.isDefault = addr._id.toString() === addressId;
    });

    await user.save();
    res.status(200).json(user.addresses);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const getAddresses = async (req, res) => {
  try {
    const { userId } = req.params;
    const user = await userModel.findById(userId).select("addresses");

    if (!user) {
      return res.status(404).json({ message: "User không tồn tại" });
    }

    res.status(200).json(user.addresses);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
};
