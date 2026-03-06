# 厨师上门服务平台 - 项目结构说明

## 项目概述
基于地理定位的厨师上门烹饪服务平台，为用户提供安全、便捷、高品质的上门烹饪服务。

## 技术栈
### 后端技术
- Spring Boot 3.x
- Spring Security + JWT（认证授权）
- MyBatis-Plus（ORM 框架）
- MySQL 8.0（数据库）
- Redis（缓存）
- Lombok（代码简化）

### 前端技术
- Vue 3（Composition API）
- Vite（构建工具）
- Element Plus（UI 组件库）
- Axios（HTTP 客户端）
- Vue Router（路由管理）
- Pinia（状态管理）
- 百度地图 API（地理定位）

## 文件夹结构说明

### backend/src/main/java/com/hs/backend/
```
com.hs.backend/
├── config/              # 配置类
│   ├── SecurityConfig.java         # 安全配置
│   ├── CorsConfig.java             # 跨域配置
│   ├── MybatisPlusConfig.java      # MP 配置
│   └── RedisConfig.java            # Redis 配置
├── controller/          # 控制器层
│   ├── AuthController.java         # 认证接口
│   ├── UserController.java         # 用户接口
│   ├── ChefController.java         # 厨师接口
│   ├── OrderController.java        # 订单接口
│   ├── DishController.java         # 菜品接口
│   ├── ReviewController.java       # 评价接口
│   └── LocationController.java     # 地理位置接口
├── service/             # 服务层
│   ├── UserService.java
│   ├── ChefService.java
│   ├── OrderService.java
│   ├── DishService.java
│   ├── ReviewService.java
│   └── LocationService.java
├── service/impl/        # 服务实现
│   ├── UserServiceImpl.java
│   ├── ChefServiceImpl.java
│   ├── OrderServiceImpl.java
│   ├── DishServiceImpl.java
│   ├── ReviewServiceImpl.java
│   └── LocationServiceImpl.java
├── mapper/              # DAO 层
│   ├── UserMapper.java
│   ├── ChefMapper.java
│   ├── OrderMapper.java
│   ├── DishMapper.java
│   └── ReviewMapper.java
├── entity/              # 实体类
│   ├── User.java                   # 用户实体
│   ├── Chef.java                   # 厨师实体
│   ├── Order.java                  # 订单实体
│   ├── Dish.java                   # 菜品实体
│   ├── Review.java                 # 评价实体
│   ├── Location.java               # 位置实体
│   └── Reservation.java            # 预约实体
├── dto/                 # 数据传输对象
│   ├── request/                    # 请求 DTO
│   │   ├── LoginRequest.java
│   │   ├── RegisterRequest.java
│   │   ├── OrderRequest.java
│   │   └── ChefSearchRequest.java
│   └── response/                   # 响应 DTO
│       ├── UserResponse.java
│       ├── ChefResponse.java
│       └── OrderResponse.java
├── common/              # 公共组件
│   ├── Result.java                 # 统一响应
│   ├── Constants.java              # 常量定义
│   └── enums/                      # 枚举类
│       ├── OrderStatus.java
│       ├── ChefLevel.java
│       └── UserType.java
├── exception/           # 异常处理
│   ├── GlobalExceptionHandler.java # 全局异常
│   ├── BusinessException.java      # 业务异常
│   └── ErrorCode.java              # 错误码
├── security/            # 安全相关
│   ├── JwtTokenProvider.java       # JWT 工具
│   ├── CustomUserDetailsService.java
│   └── JwtAuthenticationFilter.java
└── util/                # 工具类
    ├── JwtUtil.java
    ├── BaiduMapUtil.java           # 百度地图工具
    └── DateUtil.java
```

### front/src/
```
front/src/
├── api/                 # API 接口
│   ├── auth.js                     # 认证 API
│   ├── user.js                     # 用户 API
│   ├── chef.js                     # 厨师 API
│   ├── order.js                    # 订单 API
│   └── location.js                 # 位置 API
├── assets/              # 静态资源
│   ├── images/
│   └── styles/
├── components/          # 组件
│   ├── common/                     # 公共组件
│   │   ├── Header.vue
│   │   ├── Footer.vue
│   │   └── Loading.vue
│   ├── chef/                       # 厨师相关
│   │   ├── ChefCard.vue
│   │   ├── ChefList.vue
│   │   └── ChefDetail.vue
│   ├── order/                      # 订单相关
│   │   ├── OrderItem.vue
│   │   └── OrderForm.vue
│   └── dish/                       # 菜品相关
│       ├── DishCard.vue
│       └── DishGallery.vue
├── views/               # 页面
│   ├── Home.vue                    # 首页
│   ├── Login.vue                   # 登录
│   ├── Register.vue                # 注册
│   ├── ChefList.vue                # 厨师列表
│   ├── ChefDetail.vue              # 厨师详情
│   ├── Order.vue                   # 订单管理
│   ├── Profile.vue                 # 个人中心
│   └── MapSelector.vue             # 地图选点
├── router/              # 路由
│   └── index.js
├── store/               # 状态管理
│   ├── index.js
│   └── modules/
│       ├── user.js
│       └── order.js
├── utils/               # 工具
│   ├── request.js                  # Axios 封装
│   ├── auth.js                     # 认证工具
│   └── map.js                      # 地图工具
├── App.vue
└── main.js
```

## 核心业务流程

### 1. 用户预约流程
用户注册 → 实名认证 → 选择地址 → 浏览厨师 → 预约时间 → 下单支付 → 厨师上门 → 完成评价

### 2. 厨师服务流程
厨师申请 → 资料提交 → 平台审核 → 试菜考核 → 上线接单 → 准备食材 → 上门服务 → 获得评价

### 3. 地理位置匹配
用户地址 → 百度地图解析 → 计算距离 → 筛选附近厨师 → 按距离排序 → 推荐展示

## 数据库设计要点
- 用户表（含厨师和普通用户）
- 厨师信息表（技能、经验、服务范围）
- 菜品表（特色菜、价格、图片）
- 订单表（预约时间、状态、金额）
- 评价表（评分、内容、图片）
- 地址表（用户常用地址）

## 安全策略
1. JWT Token 认证
2. 密码 BCrypt 加密
3. 接口权限控制
4. SQL 注入防护
5. XSS 攻击防护
6. 敏感信息脱敏

## 第三方服务集成
1. 百度地图 API - 地理编码、距离计算
2. 新浪微博 API - 社交分享
3. 支付接口 - 微信支付/支付宝
4. 短信服务 - 验证码、通知

## 开发规范
- 代码遵循阿里巴巴 Java 开发手册
- 前端遵循 Vue 3 最佳实践
- 使用 ESLint + Prettier 统一代码风格
- Git 分支管理（main/dev/feature）
