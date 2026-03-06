# 厨师上门服务平台 - 快速启动指南

## 📋 项目概述

这是一个基于地理定位的厨师上门烹饪服务平台，提供以下核心功能：
- 用户注册登录（支持普通用户和厨师）
- 厨师浏览与搜索（按菜系、等级、距离）
- 在线预约下单
- 地理位置匹配
- 订单管理
- 评价系统

## 🛠️ 技术栈

### 后端
- Spring Boot 3.x
- Spring Security + JWT（认证授权）
- MyBatis-Plus（ORM）
- MySQL 8.0（数据库）
- Redis（缓存）

### 前端
- Vue 3（Composition API）
- Vite（构建工具）
- Element Plus（UI 组件库）
- Pinia（状态管理）
- Vue Router（路由）

## 📁 项目结构

```
cookercome/
├── backend/              # 后端项目
│   ├── src/main/java/com/hs/backend/
│   │   ├── config/       # 配置类
│   │   ├── controller/   # 控制器层
│   │   ├── service/      # 服务层
│   │   ├── mapper/       # DAO 层
│   │   ├── entity/       # 实体类
│   │   ├── dto/          # 数据传输对象
│   │   ├── common/       # 公共组件
│   │   ├── security/     # 安全相关
│   │   └── exception/    # 异常处理
│   └── pom.xml
├── front/                # 前端项目
│   ├── src/
│   │   ├── api/          # API 接口
│   │   ├── views/        # 页面
│   │   ├── components/   # 组件
│   │   ├── router/       # 路由
│   │   ├── store/        # 状态管理
│   │   └── utils/        # 工具
│   └── package.json
└── sql/                  # 数据库脚本
    └── schema.sql
```

## 🚀 快速开始

### 1. 环境准备

**必需软件：**
- JDK 17+
- Maven 3.6+
- Node.js 20+
- MySQL 8.0+
- Redis 6.0+

### 2. 数据库配置

#### 2.1 创建数据库
```bash
mysql -u root -p < sql/schema.sql
```

#### 2.2 修改数据库配置
编辑 `backend/src/main/resources/application.properties`：
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/cookercome?...
spring.datasource.username=root
spring.datasource.password=你的密码
```

### 3. 后端启动

#### 3.1 进入后端目录
```bash
cd backend
```

#### 3.2 安装依赖并编译
```bash
mvn clean install
```

#### 3.3 启动后端服务
```bash
mvn spring-boot:run
```

后端将在 `http://localhost:8080` 启动

### 4. 前端启动

#### 4.1 进入前端目录
```bash
cd front
```

#### 4.2 安装依赖
```bash
npm install
```

#### 4.3 启动开发服务器
```bash
npm run dev
```

前端将在 `http://localhost:5173` 启动

## 🔑 默认账号

### 测试用户
- 管理员：admin / 123456
- 厨师：chef1 / 123456
- 普通用户：user1 / 123456

**注意：** 首次使用请修改密码！

## 📝 API 接口说明

### 认证接口
- `POST /api/auth/register` - 用户注册
- `POST /api/auth/login` - 用户登录
- `GET /api/auth/current` - 获取当前用户
- `POST /api/auth/logout` - 退出登录

### 厨师接口
- `GET /api/chef/list` - 分页查询厨师列表
- `GET /api/chef/detail/{id}` - 获取厨师详情
- `GET /api/chef/nearby` - 搜索附近厨师
- `POST /api/chef` - 创建厨师（管理员）
- `PUT /api/chef` - 更新厨师信息
- `POST /api/chef/audit/{id}` - 审核厨师（管理员）

### 请求头
所有需要认证的接口需要在 Header 中携带 JWT Token：
```
Authorization: Bearer {token}
```

## ⚙️ 配置说明

### 后端配置 (application.properties)

#### 数据库配置
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/cookercome
spring.datasource.username=root
spring.datasource.password=your_password
```

#### Redis 配置
```properties
spring.redis.host=localhost
spring.redis.port=6379
```

#### JWT 配置
```properties
jwt.secret=your_secret_key
jwt.expiration=86400000
```

### 前端配置

创建 `.env` 文件在 `front/` 目录：
```env
VITE_API_BASE_URL=http://localhost:8080/api
```

## 🔒 安全特性

1. **JWT Token 认证** - 无状态认证机制
2. **密码加密** - BCrypt 强加密
3. **权限控制** - 基于角色的访问控制
4. **SQL 注入防护** - MyBatis 参数化查询
5. **XSS 防护** - 输入验证和输出转义
6. **CORS 配置** - 跨域请求控制

## 📊 数据库表结构

### 核心表
- `user` - 用户表
- `chef` - 厨师信息表
- `orders` - 订单表
- `dish` - 菜品表
- `review` - 评价表
- `user_address` - 用户地址表

详细表结构请查看 `sql/schema.sql`

## 🧪 测试建议

### 后端测试
```bash
# 运行单元测试
mvn test

# 运行集成测试
mvn verify
```

### 前端测试
```bash
# 运行单元测试
npm run test

# 运行 E2E 测试
npm run test:e2e
```

## 📦 部署

### 后端打包
```bash
mvn clean package -DskipTests
java -jar target/backend-0.0.1-SNAPSHOT.jar
```

### 前端打包
```bash
npm run build
# 生成的文件在 dist/ 目录
```

## 🐛 常见问题

### 1. 后端启动失败
- 检查 MySQL 是否启动
- 检查 Redis 是否启动
- 确认数据库连接配置正确
- 查看端口 8080 是否被占用

### 2. 前端无法连接后端
- 确认后端服务已启动
- 检查 CORS 配置
- 确认 API 基础 URL 配置正确

### 3. 登录失败
- 确认数据库中已有测试用户
- 检查密码加密是否正确
- 查看 JWT 密钥配置

## 📖 开发规范

### 代码风格
- 后端：遵循阿里巴巴 Java 开发手册
- 前端：遵循 Vue 3 最佳实践

### Git 分支
- `main` - 主分支
- `dev` - 开发分支
- `feature/*` - 功能分支

### 提交规范
```
feat: 新功能
fix: 修复 bug
docs: 文档更新
style: 代码格式调整
refactor: 重构代码
test: 测试相关
chore: 构建/工具链相关
```

## 🎯 下一步开发建议

1. **完善页面**
   - 厨师详情页
   - 订单管理页
   - 个人中心页
   - 地图选点页

2. **增强功能**
   - 支付集成（微信/支付宝）
   - 百度地图 API 集成
   - 短信验证码
   - 图片上传功能
   - 实时通知

3. **性能优化**
   - Redis 缓存优化
   - 数据库索引优化
   - 前端懒加载
   - CDN 加速

4. **安全加固**
   - 限流防刷
   - 敏感信息脱敏
   - 日志审计
   - HTTPS 部署

## 📞 技术支持

如有问题，请查看：
- Spring Boot 官方文档：https://spring.io/projects/spring-boot
- Vue 3 官方文档：https://vuejs.org/
- Element Plus 文档：https://element-plus.org/
- MyBatis-Plus 文档：https://baomidou.com/

---

**祝开发顺利！** 🎉
