import userModel from "../user/user.model.js";

export const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        message: "Username and password are required",
      });
    }

    const user = await userModel.findOne({ email }).lean();

    if (!user) {
      return res.status(401).json({
        message: "Invalid email or password",
      });
    }

    if (user.password !== password) {
      return res.status(401).json({
        message: "Invalid email or password",
      });
    }

    res.json({
      message: "Login successful",
      user: {
        _id: user._id,
        email: user.email,
        role: user.role,
      },
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const register = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res
        .status(400)
        .json({ message: "Email and password are required" });
    }

    const existingUser = await userModel.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: "Email already exists" });
    }

    // Tạo username ngẫu nhiên: user_ + 5 ký tự ngẫu nhiên
    const randomUsername = `user_${Math.random().toString(36).substring(2, 7)}`;

    const newUser = new userModel({
      username: randomUsername,
      email: email,
      password: password, // Lưu ý: Dự án thực tế nên dùng bcrypt để hash
      role: "user",
    });

    await newUser.save();

    res.status(201).json({
      message: "User registered successfully",
      user: {
        _id: newUser._id,
        username: newUser.username,
        email: newUser.email,
        role: newUser.role,
      },
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export const fakeLogin = async (req, res) => {
  try {
    const user = await userModel.findOne({ role: "user" }).lean();
    if (!user) return res.status(404).json({ message: "No user found" });

    res.json({
      message: "Login successful",
      user: {
        _id: user._id,
        username: user.username,
        role: user.role,
      },
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
