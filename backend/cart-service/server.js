const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const dotenv = require('dotenv');

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3003;

// Middleware
app.use(cors());
app.use(express.json());

// MongoDB Connection (retries so the service stays up while MongoDB is starting)
const connectDB = () => {
  mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/ecommerce_carts', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
    .then(() => console.log('Cart Service connected to MongoDB'))
    .catch((err) => {
      console.error(`Cart Service MongoDB connection failed: ${err.message}. Retrying in 5s...`);
      setTimeout(connectDB, 5000);
    });
};
connectDB();

// Sample response
app.get('/', (req, res) => {
  res.send('Cart Service Running');
});

// Routes
app.use('/api/cart', require('./routes/cart'));

// Health check
app.get('/health', (req, res) => {
  res.json({ service: 'Cart Service', status: 'OK', port: PORT });
});

app.listen(PORT, () => {
  console.log(`Cart Service running on port ${PORT}`);
});