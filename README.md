# E-Commerce Microservices Application

A full-stack MERN e-commerce application built with microservices architecture, featuring 4 separate Node.js backend services and a React frontend.

## 🏗️ Architecture Overview

This application demonstrates modern microservices architecture with the following components:

```
Frontend (React) → API Gateway → Microservices
                                    ├── User Service (3001)
                                    ├── Product Service (3002)
                                    ├── Cart Service (3003)
                                    └── Order Service (3004)
```

## 🔧 Technology Stack

### Backend
- **Runtime**: Node.js with Express.js
- **Database**: MongoDB with Mongoose ODM
- **Authentication**: JWT tokens
- **Architecture**: RESTful APIs with microservices

### Frontend
- **Framework**: React 18
- **Routing**: React Router
- **State Management**: React Query + Context API
- **HTTP Client**: Axios
- **Styling**: CSS3 with responsive design

## 📦 Microservices

### 1. User Service (Port 3001)
- User registration and authentication
- Profile management
- JWT token generation and validation
- User data persistence

**Endpoints:**
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User authentication
- `GET /api/auth/me` - Get current user
- `GET /api/users/profile` - Get user profile
- `PUT /api/users/profile` - Update user profile

### 2. Product Service (Port 3002)
- Product catalog management
- Category management
- Product search and filtering
- Inventory tracking

**Endpoints:**
- `GET /api/products` - Get products with filtering/pagination
- `GET /api/products/:id` - Get single product
- `POST /api/products` - Create product (admin)
- `PUT /api/products/:id` - Update product (admin)
- `DELETE /api/products/:id` - Soft delete product (admin)
- `GET /api/categories` - Get all categories
- `POST /api/categories` - Create category (admin)

### 3. Cart Service (Port 3003)
- Shopping cart management
- Add/remove/update cart items
- Cart validation
- Integration with Product Service

**Endpoints:**
- `GET /api/cart/:userId` - Get user's cart
- `POST /api/cart/:userId/items` - Add item to cart
- `PUT /api/cart/:userId/items/:productId` - Update cart item
- `DELETE /api/cart/:userId/items/:productId` - Remove cart item
- `DELETE /api/cart/:userId` - Clear entire cart
- `POST /api/cart/:userId/validate` - Validate cart items

### 4. Order Service (Port 3004)
- Order creation and management
- Payment processing simulation
- Order status tracking
- Integration with Cart and Product Services

**Endpoints:**
- `GET /api/orders/user/:userId` - Get user's orders
- `GET /api/orders/:id` - Get single order
- `POST /api/orders` - Create new order
- `PUT /api/orders/:id/status` - Update order status
- `DELETE /api/orders/:id` - Cancel order
- `POST /api/payments/process` - Process payment
- `POST /api/payments/refund` - Process refund

## 🚀 Getting Started

### Prerequisites
- Node.js 16+ and npm
- MongoDB (local or cloud instance)

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd ecommerce-microservices
```

2. **Install dependencies for each service**
```bash

# Install User Service dependencies
cd backend/user-service && npm install

# Install Product Service dependencies
cd ../product-service && npm install

# Install Cart Service dependencies
cd ../cart-service && npm install

# Install Order Service dependencies
cd ../order-service && npm install

# Install Frontend dependencies
cd ../../frontend && npm install
```

3. **Set up environment variables**

Create `.env` files in each service directory:

**backend/user-service/.env:**
```env
PORT=3001
MONGODB_URI=mongodb://localhost:27017/ecommerce_users
JWT_SECRET=your-jwt-secret-key
```

**backend/product-service/.env:**
```env
PORT=3002
MONGODB_URI=mongodb://localhost:27017/ecommerce_products
```

**backend/cart-service/.env:**
```env
PORT=3003
MONGODB_URI=mongodb://localhost:27017/ecommerce_carts
PRODUCT_SERVICE_URL=http://localhost:3002
```

**backend/order-service/.env:**
```env
PORT=3004
MONGODB_URI=mongodb://localhost:27017/ecommerce_orders
CART_SERVICE_URL=http://localhost:3003
PRODUCT_SERVICE_URL=http://localhost:3002
USER_SERVICE_URL=http://localhost:3001
```

**frontend/.env:**
```env
REACT_APP_USER_SERVICE_URL=http://localhost:3001
REACT_APP_PRODUCT_SERVICE_URL=http://localhost:3002
REACT_APP_CART_SERVICE_URL=http://localhost:3003
REACT_APP_ORDER_SERVICE_URL=http://localhost:3004
```

### Running the Application


** Run services individually**

Terminal 1 - User Service:
```bash
cd backend/user-service && npm start
```

Terminal 2 - Product Service:
```bash
cd backend/product-service && npm start
```

Terminal 3 - Cart Service:
```bash
cd backend/cart-service && npm start
```

Terminal 4 - Order Service:
```bash
cd backend/order-service && npm start
```

Terminal 5 - Frontend:
```bash
cd frontend && npm start
```

The application will be available at:
- Frontend: http://localhost:3000
- User Service: http://localhost:3001
- Product Service: http://localhost:3002
- Cart Service: http://localhost:3003
- Order Service: http://localhost:3004

## 🎯 Features

### User Features
- **Authentication**: Register and login with JWT tokens
- **Product Browsing**: View products with search, filtering, and pagination
- **Shopping Cart**: Add, update, and remove items
- **Checkout Process**: Complete order placement with shipping and payment
- **Order Management**: View order history and track status
- **Profile Management**: Update personal information and addresses

### Admin Features (Future Enhancement)
- Product and category management
- Order status updates
- Inventory management
- User management

### Technical Features
- **Microservices Architecture**: Loosely coupled services
- **RESTful APIs**: Standard HTTP methods and status codes
- **Data Validation**: Input validation and error handling
- **Cross-Service Communication**: HTTP-based service interactions
- **Responsive Design**: Mobile-friendly user interface
- **Error Handling**: Comprehensive error management
- **Loading States**: User-friendly loading indicators

## 📁 Project Structure

```
ecommerce-microservices/
├── backend/
│   ├── user-service/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── middleware/
│   │   ├── server.js
│   │   └── package.json
│   ├── product-service/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── server.js
│   │   └── package.json
│   ├── cart-service/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── server.js
│   │   └── package.json
│   └── order-service/
│       ├── models/
│       ├── routes/
│       ├── server.js
│       └── package.json
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   ├── contexts/
│   │   ├── pages/
│   │   ├── services/
│   │   ├── App.js
│   │   └── index.js
│   ├── Dockerfile          # multi-stage: React build → nginx
│   ├── nginx.conf          # static files + /api reverse proxy
│   └── package.json
├── terraform/              # AWS infrastructure (VPC, SG, EC2, user-data)
├── scripts/
│   └── build-and-push.sh   # build linux/amd64 images & push to Docker Hub
├── docker-compose.yml      # local test stack (mirrors EC2 setup)
└── README.md
```
Each `backend/*-service/` also contains a `Dockerfile` and a `.dockerignore`.

## 🔧 API Testing

You can test the APIs using tools like Postman or curl:

```bash
# Health check for all services
curl http://localhost:3001/health
curl http://localhost:3002/health
curl http://localhost:3003/health
curl http://localhost:3004/health

# Register a new user
curl -X POST http://localhost:3001/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"firstName":"John","lastName":"Doe","email":"john@example.com","password":"password123"}'

# Get products
curl http://localhost:3002/api/products

# Get categories
curl http://localhost:3002/api/categories
```

## 🚀 Deployment

### Production Considerations

1. **Environment Variables**: Use proper environment variable management
2. **Database**: Use MongoDB Atlas or other managed database services
3. **Process Management**: Use PM2 or similar for process management
4. **Load Balancing**: Implement load balancing for high availability
5. **Monitoring**: Add logging and monitoring solutions
6. **Security**: Implement rate limiting, CORS, and other security measures

## ☁️ AWS Deployment with Docker + Terraform

All 5 services are containerized, published to Docker Hub, and deployed to an AWS EC2 instance that Terraform provisions. A single `terraform apply` reproduces the whole environment.

### Deployment Architecture

```
                         Internet
                            │  HTTP :80
┌───────────────────────────▼──────────────────────────────────────────┐
│ VPC 10.0.0.0/16  (us-east-1)                                         │
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ Public subnet 10.0.1.0/24  ── route 0.0.0.0/0 → Internet Gateway │ │
│ │ ┌──────────────────────────────────────────────────────────────┐ │ │
│ │ │ EC2 t3.small · Ubuntu 22.04 · SG: 80 public, 3001-3004 VPC   │ │ │
│ │ │                                                              │ │ │
│ │ │  Docker network "ecommerce-net"                              │ │ │
│ │ │  ┌─────────────────────────┐                                 │ │ │
│ │ │  │ frontend  :80 (nginx)   │ serves React build + proxies:   │ │ │
│ │ │  └──┬──────┬──────┬──────┬─┘                                 │ │ │
│ │ │     │      │      │      │  /api/auth,/api/users → user      │ │ │
│ │ │     ▼      ▼      ▼      ▼  /api/products,/categories → prod │ │ │
│ │ │   user  product  cart  order  /api/cart → cart               │ │ │
│ │ │   :3001  :3002  :3003  :3004  /api/orders,/payments → order  │ │ │
│ │ │     └──────┴──────┴──────┴──► mongodb :27017 (internal only) │ │ │
│ │ └──────────────────────────────────────────────────────────────┘ │ │
│ └──────────────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────────┘
```

**Design decisions**
- **Single public entry point.** The browser only talks to port 80. nginx in the frontend container proxies `/api/*` to the right backend by path, because React bakes its API URLs in at build time and `localhost:300x` wouldn't work from a user's browser. The backend ports (3001–3004) are open only inside the VPC.
- **MongoDB runs as a 6th container** (`mongo:7`) on the same Docker network, with a named volume. This keeps the deployment self-contained and reproducible.
- **No SSH key or port 22.** The instance has an IAM role for AWS Systems Manager (SSM), so you can inspect it with Session Manager or `aws ssm send-command`.

### Docker Images (Docker Hub)

| Service | Image | Container port | Sample response (`GET /`) |
|---|---|---|---|
| Frontend | `sripatirnd/ecommerce-frontend:v1` | 80 | React app; `GET /health` → `Frontend is Live` |
| User | `sripatirnd/ecommerce-user-service:v1` | 3001 | `User Service Running` |
| Product | `sripatirnd/ecommerce-product-service:v1` | 3002 | `Product Service Running` |
| Cart | `sripatirnd/ecommerce-cart-service:v1` | 3003 | `Cart Service Running` |
| Order | `sripatirnd/ecommerce-order-service:v1` | 3004 | `Order Service Running` |

- **Backend Dockerfiles** (`backend/*/Dockerfile`) use `node:20-alpine`, install production dependencies only, run as the non-root `node` user, and start with `node server.js`. The repo's `npm start` uses `nodemon`, which is a dev dependency.
- **Frontend Dockerfile** (`frontend/Dockerfile`) is multi-stage: `npm run build` in Node, then the static build is served by `nginx:1.27-alpine` using [`frontend/nginx.conf`](frontend/nginx.conf).
- Images are built for **`linux/amd64`** (EC2 x86), even when you build on an Apple Silicon Mac.

### Code changes made for containerization
- Each backend `server.js`: added `GET /` returning `"<Name> Service Running"`. The MongoDB connection now retries every 5 s instead of crashing the process when the DB isn't reachable yet.
- `frontend/src/services/api.js`: `||` → `??`, so an empty `REACT_APP_*_URL` (set in the Docker build) gives relative URLs that nginx proxies. Local `npm start` still defaults to `localhost:300x`.
- `.gitignore`: added Node (`node_modules/`) and Terraform (`.terraform/`, `*.tfstate`, `*.tfvars`) entries.

### Prerequisites
- Docker (with `buildx`) and a Docker Hub account
- Terraform ≥ 1.5
- AWS CLI v2 configured with credentials allowed to create VPC, EC2 and IAM resources (`aws sts get-caller-identity` should work)

### Step 1: Build and test images locally

```bash
# Build all images and run the full stack (incl. MongoDB) exactly as on EC2
docker compose up -d --build

# Verify
curl http://localhost:3001/          # User Service Running
curl http://localhost:3002/          # Product Service Running
curl http://localhost:3003/          # Cart Service Running
curl http://localhost:3004/          # Order Service Running
curl http://localhost:8080/health    # Frontend is Live
open http://localhost:8080           # React app (frontend is mapped to 8080 locally)

docker compose down                   # stop (add -v to also delete Mongo data)
```

### Step 2: Tag and push images to Docker Hub

```bash
docker login -u <dockerhub-username>
./scripts/build-and-push.sh <dockerhub-username> v1
```
The script builds each service for `linux/amd64` and pushes the tags `<user>/ecommerce-<service>:v1` and `:latest`. The repositories must be **public**, because the EC2 instance pulls them without credentials.

### Step 3: Provision AWS infrastructure with Terraform

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars   # set dockerhub_username (and region/tag if needed)
terraform init
terraform plan
terraform apply
```

**Terraform files**

| File | Purpose |
|---|---|
| [`versions.tf`](terraform/versions.tf) | Terraform/provider versions, AWS provider with default tags |
| [`variables.tf`](terraform/variables.tf) | Region, CIDRs, instance type, Docker Hub user, image tag, allowed CIDRs |
| [`main.tf`](terraform/main.tf) | VPC, public subnet, IGW, route table, security group, SSM IAM role, Ubuntu 22.04 AMI lookup, EC2 |
| [`user_data.sh.tftpl`](terraform/user_data.sh.tftpl) | Bootstrap: install Docker CE, pull all images, create network, run containers, self-check |
| [`outputs.tf`](terraform/outputs.tf) | Public IP/DNS, frontend URL, backend status URLs, SSM command |

**Resources created (11)**

| Resource | Details |
|---|---|
| `aws_vpc` | `10.0.0.0/16`, DNS hostnames enabled |
| `aws_subnet` (public) | `10.0.1.0/24`, auto-assign public IP |
| `aws_internet_gateway` + `aws_route_table` + association | `0.0.0.0/0 → IGW` |
| `aws_security_group` | **Inbound:** TCP 80 from `0.0.0.0/0` (frontend); TCP 3001–3004 from the VPC CIDR and the SG itself (internal service traffic); optional `backend_debug_cidrs`. **Outbound:** all |
| `aws_iam_role` + policy attachment + instance profile | `AmazonSSMManagedInstanceCore` for Session Manager |
| `aws_instance` | `t3.small`, latest Canonical Ubuntu 22.04 AMI, 20 GB encrypted gp3, IMDSv2 only, `user_data_replace_on_change = true` |
| `random_password` | JWT secret passed to user-service |

**What user-data does on first boot**
1. Installs Docker CE from Docker's official apt repo and enables the service.
2. Pulls `mongo:7` and all 5 `sripatirnd/ecommerce-*:v1` images.
3. Creates the Docker network `ecommerce-net` and runs every container with `--restart unless-stopped`. Environment variables wire the services together (`MONGODB_URI`, `PRODUCT_SERVICE_URL`, …) using container names as hostnames.
4. Runs `docker ps` and curls every service. Output goes to `/var/log/user-data.log` and the EC2 system console.

Bootstrapping takes about 2–3 minutes after `terraform apply` finishes.

### Step 4: Access and verify

```bash
terraform output
```

Example output from the verified deployment:
```
frontend_url            = "http://3.238.9.101"
frontend_public_dns_url = "http://ec2-3-238-9-101.compute-1.amazonaws.com"
public_ip               = "3.238.9.101"
backend_status_urls = {
  frontend = "http://3.238.9.101/health"
  user     = "http://3.238.9.101/services/user/"
  product  = "http://3.238.9.101/services/product/"
  cart     = "http://3.238.9.101/services/cart/"
  order    = "http://3.238.9.101/services/order/"
}
```

**Public checks (from anywhere)**
```bash
IP=$(terraform output -raw public_ip)
curl http://$IP/health                 # Frontend is Live
curl http://$IP/services/user/         # User Service Running
curl http://$IP/services/product/      # Product Service Running
curl http://$IP/services/cart/         # Cart Service Running
curl http://$IP/services/order/        # Order Service Running
curl http://$IP/services/user/health   # {"service":"User Service","status":"OK","port":"3001"}
curl http://$IP/api/products           # real API call through nginx → product-service → MongoDB
```
Open `http://<public_ip>` in a browser to use the React storefront (register, login, browse, cart, checkout).

**On-instance checks (no SSH needed)**
```bash
ID=$(terraform output -raw instance_id)
aws ssm send-command --instance-ids $ID --document-name AWS-RunShellScript \
  --parameters 'commands=["docker ps","tail -20 /var/log/user-data.log"]' \
  --query Command.CommandId --output text
aws ssm get-command-invocation --command-id <id-from-above> --instance-id $ID \
  --query StandardOutputContent --output text
# or an interactive shell (needs the Session Manager plugin):
aws ssm start-session --target $ID
```

Verified result:
```
NAMES             IMAGE                                     STATUS          PORTS
frontend          sripatirnd/ecommerce-frontend:v1          Up              0.0.0.0:80->80/tcp
order-service     sripatirnd/ecommerce-order-service:v1     Up              0.0.0.0:3004->3004/tcp
cart-service      sripatirnd/ecommerce-cart-service:v1      Up              0.0.0.0:3003->3003/tcp
product-service   sripatirnd/ecommerce-product-service:v1   Up              0.0.0.0:3002->3002/tcp
user-service      sripatirnd/ecommerce-user-service:v1      Up              0.0.0.0:3001->3001/tcp
mongodb           mongo:7                                   Up              27017/tcp
localhost:3001 -> User Service Running
localhost:3002 -> Product Service Running
localhost:3003 -> Cart Service Running
localhost:3004 -> Order Service Running
localhost:80/health -> Frontend is Live
```
Direct access to `http://<public_ip>:3001` from the internet is blocked by design. To allow it for debugging, set `backend_debug_cidrs = ["<your-ip>/32"]`.

### Step 5: Clean up

```bash
cd terraform
terraform destroy
```

### Troubleshooting
| Symptom | Check |
|---|---|
| Site not reachable right after apply | Wait 2–3 min for user-data, then `aws ec2 get-console-output --instance-id <id> --latest --output text \| grep user-data` |
| `exec format error` in container logs | The image was built for arm64. Rebuild with `--platform linux/amd64` (the script does this) |
| `pull access denied` in user-data log | The Docker Hub repo is private or the username in `terraform.tfvars` is wrong |
| API calls return 502 | The backend container is down: `docker logs <service>` via SSM |

### Assumptions and constraints
- A single EC2 instance hosts all containers. This is fine for the assignment, but it's not highly available.
- MongoDB data lives in a Docker volume on the instance and is lost on `terraform destroy` or when the instance is replaced.
- The app is served over HTTP only (no domain/TLS).
- The product catalog starts empty. Add categories/products via `POST /api/categories` and `POST /api/products`.
- The JWT secret is generated by Terraform. It's stored in Terraform state and in the instance's user-data, so keep the state file private.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📝 License

This project is licensed under the MIT License.

## 🆘 Support

For support and questions:
- Check the documentation
- Review API endpoints and expected payloads
- Ensure all services are running
- Verify database connections
- Check environment variables

## 🔮 Future Enhancements

- **API Gateway**: Centralized request routing and authentication
- **Message Queues**: Async communication between services
- **Caching**: Redis caching for improved performance
- **Search Engine**: Elasticsearch for advanced product search
- **File Upload**: Image upload and management
- **Email Service**: Order confirmations and notifications
- **Admin Dashboard**: Administrative interface
- **Analytics**: Order and user analytics
- **Payment Integration**: Real payment gateway integration
