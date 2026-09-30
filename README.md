# 酒店管理平台

一个面向酒店日常运营场景的前后端分离项目，覆盖后台管理、前台接待与住客端自助预订三类角色。项目基于 `Spring Boot 3 + Spring Security + MyBatis-Plus + MySQL + Vue 3 + Vite` 构建，提供完整接口、权限模型、业务流转与极简风格前端界面，适合作为课程设计、毕业设计、全栈练手项目或中小型酒店业务原型。

<details>
<summary><b>English</b>（点击展开英文版 · Click to expand）</summary>

# Hotel Management Platform

A full-stack, front-end/back-end separated project for daily hotel operations, covering three roles: back-office administration, front-desk reception, and guest self-service booking. Built on `Spring Boot 3 + Spring Security + MyBatis-Plus + MySQL + Vue 3 + Vite`, it provides complete APIs, a permission model, business workflows, and a minimalist front-end UI — suitable as a course project, graduation project, full-stack practice project, or a prototype for small and mid-sized hotel businesses.

## Highlights

- Three-role collaboration: admin, front desk, and guest portal all connect to the same platform
- Complete hotel business chain: room types, rooms, guests, reservations, check-in, check-out, settlement, and reports
- Formalized access control: role-based access control built on Spring Security and JWT
- Reservation status flow: supports `BOOKED / CHECKED_IN / CHECKED_OUT / CANCELLED`
- Automatic pricing: order amounts computed from room-type price and number of nights
- Charge breakdown closer to real business: room fee, breakfast, extra bed, deposit, and coupon accounted separately
- Room-status calendar: view room availability, bookings, occupancy, and out-of-service status by date
- Real front-desk operations: extend stays, change rooms, check in, check out, and cancel reservations
- Financial transactions and audit logs: records of fee changes, deposits, discounts, and key operation logs
- Notification center: booking success, upcoming check-in, upcoming check-out reminders with unread badges
- Operations analytics dashboard: overview metrics, trend charts, and Excel report export
- Minimalist admin UI: consistent information structure, lightweight visual language, great for demos and further development

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for the daily update log.

## Tech Stack

### Backend

- Spring Boot 3.3.5
- Spring Security
- MyBatis-Plus 3.5.8
- MySQL 8
- JWT
- Apache POI

### Frontend

- Vue 3
- Vite 4
- Lightweight custom UI built with plain CSS

## Core Features

### 1. Authentication & Permissions

- Admin back-office login
- Guest portal registration and login
- JWT authentication
- User password change
- Role separation and API access control
- Supported roles:
  - `ADMIN`
  - `FRONT_DESK`
  - `CUSTOMER`

### 2. Admin Back Office

- Dashboard overview
- Revenue trend analysis
- Excel report export
- Room type CRUD
- Room CRUD
- Reservation CRUD
- Reservation pagination, filtering, and search
- Reservation status flow
- Room-status calendar with color legend
- Check-in, stay extension, and room change handling
- Financial transaction queries and summary statistics
- Operation log queries
- Notification center with unread alerts
- Guest CRUD
- Membership tier management
- Check-in registration and check-out processing
- APIs for reservation slip, check-in slip, and checkout settlement
- Admin account and role management

### 3. Reservations & Settlement

- Room fee computed automatically from number of nights
- Breakfast, extra bed, deposit, and coupon amounts split out separately
- Automatic total amount due per reservation
- Room availability and date-conflict validation
- Historical stays and spending statistics
- Fee and order total recalculated automatically on stay extension
- Target room availability validated automatically on room change
- Financial transactions recorded for fee adjustments, deposits, coupons, and settlement

### 4. Room Status, Logs & Notifications

- Room-status calendar: view room status over 7 / 10 / 14 days
- Hover details: shows date, room, reservation number, guest, and cleaning status
- Financial transactions: charges, deductions, refunds, and net flow
- Operation logs: operator, role, action type, and before/after snapshots
- Notifications: unread count, home-page alert cards, and mark-as-read

### 5. Guest Portal

- Guest registration
- Guest login
- Browse room types and base prices
- Submit bookings online
- View personal reservations
- View personal profile and membership tier

## Screenshots

### Admin Dashboard

![Admin Dashboard](docs/screenshots/admin-dashboard.png)

### Front Desk Dashboard

![Front Desk Dashboard](docs/screenshots/frontdesk-dashboard.png)

### Guest Portal

![Guest Portal](docs/screenshots/guest-portal.png)

## Project Structure

```text
.
├── backend                     # Spring Boot API service
├── frontend                    # Vue 3 + Vite frontend
├── database                    # MySQL init and incremental scripts
└── docs/screenshots            # Screenshots for the README
```

## Business Roles

### Admin `ADMIN`

- View operations overview and trend analysis
- Manage room types, rooms, reservations, and guests
- Export Excel reports
- Manage back-office accounts, roles, and permission scopes

### Front Desk `FRONT_DESK`

- View dashboard data
- Handle check-in and check-out
- Manage reservations and guest profiles
- Assist with front-desk reception and daily operations

### Guest `CUSTOMER`

- Register a guest account
- Browse room types
- Submit bookings
- View personal reservations and profile

## Quick Start

### 1. Initialize the Database

Import the following script:

- [database/hotel_management.sql](database/hotel_management.sql)

If you prefer syncing the schema incrementally, you can also run:

- [database/migrations/2026-04-22_reservation_charge_breakdown.sql](database/migrations/2026-04-22_reservation_charge_breakdown.sql)
- [database/migrations/2026-04-22_customer_user.sql](database/migrations/2026-04-22_customer_user.sql)
- [database/migrations/2026-04-23_hotel_ops_extension.sql](database/migrations/2026-04-23_hotel_ops_extension.sql)

### 2. Configure the Database Connection

Edit [backend/src/main/resources/application.yml](backend/src/main/resources/application.yml) and adjust it for your local MySQL environment:

- `spring.datasource.url`
- `spring.datasource.username`
- `spring.datasource.password`

### 3. Start the Backend

```bash
cd backend
mvn spring-boot:run
```

Default port: `8080`

### 4. Start the Frontend

```bash
cd frontend
pnpm install
pnpm dev
```

Default URL: `http://localhost:5174`

## Default Test Accounts

### Back-office Admin

- Username: `admin`
- Password: `admin123`

### Front Desk

- Username: `frontdesk`
- Password: `front123`

### Guest Portal Sample Account

- Username: `13900000088`
- Password: `guest123`

## Key API Examples

### Authentication

- `POST /api/v1/auth/login`
- `GET /api/v1/auth/me`
- `POST /api/v1/auth/change-password`
- `POST /api/v1/customer/auth/login`
- `POST /api/v1/customer/auth/register`
- `GET /api/v1/customer/auth/me`

### Dashboard & Reports

- `GET /api/v1/dashboard/overview`
- `GET /api/v1/dashboard/trends`
- `GET /api/v1/reports/operations/export`

### Room Status, Transactions, Logs & Notifications

- `GET /api/v1/operations/room-calendar`
- `GET /api/v1/operations/financial-transactions`
- `GET /api/v1/operations/financial-summary`
- `GET /api/v1/operations/logs`
- `GET /api/v1/operations/notifications`
- `PUT /api/v1/operations/notifications/{id}/read`

### Room Types & Rooms

- `GET /api/v1/room-types`
- `GET /api/v1/room-types/page`
- `POST /api/v1/room-types`
- `PUT /api/v1/room-types/{id}`
- `DELETE /api/v1/room-types/{id}`
- `GET /api/v1/rooms`
- `GET /api/v1/rooms/page`
- `GET /api/v1/rooms/available`
- `POST /api/v1/rooms`
- `PUT /api/v1/rooms/{id}`
- `DELETE /api/v1/rooms/{id}`

### Reservations & Guests

- `GET /api/v1/reservations/page`
- `POST /api/v1/reservations`
- `PUT /api/v1/reservations/{id}`
- `PUT /api/v1/reservations/{id}/status`
- `PUT /api/v1/reservations/{id}/extend`
- `PUT /api/v1/reservations/{id}/change-room`
- `GET /api/v1/reservations/{id}/print`
- `GET /api/v1/reservations/{id}/check-in-slip`
- `GET /api/v1/reservations/{id}/checkout-settlement`
- `GET /api/v1/guests`
- `GET /api/v1/guests/{id}/profile`
- `POST /api/v1/guests`
- `PUT /api/v1/guests/{id}`
- `DELETE /api/v1/guests/{id}`

### Guest Portal

- `GET /api/v1/customer/room-types`
- `POST /api/v1/customer/reservations`
- `GET /api/v1/customer/reservations`

## Reservation Status

- `BOOKED`: booked
- `CHECKED_IN`: checked in
- `CHECKED_OUT`: checked out
- `CANCELLED`: cancelled

Supported core transitions:

- `BOOKED -> CHECKED_IN`
- `BOOKED -> CANCELLED`
- `CHECKED_IN -> CHECKED_OUT`

## Front-desk Operations

### Room-status Calendar

- `AVAILABLE`: vacant, available for booking
- `BOOKED`: reserved, awaiting check-in
- `CHECKED_IN`: occupied by a checked-in guest
- `MAINTENANCE`: under maintenance or out of service, not sellable

### Stay Extension

Front desk can select a reservation on the reservation page and set a new checkout date. The system validates that the original room has no conflicts during the extended period, and automatically recalculates the room fee, order total, and financial transactions.

### Room Change

Front desk can pick a target room for an in-progress reservation. The system validates whether the target room is under maintenance or conflicts with other reservations, and records an operation log and fee adjustments.

### Financial Transactions

Transaction directions include:

- `CHARGE`: charge, e.g. room fee, deposit, checkout settlement
- `DISCOUNT`: deduction, e.g. coupon
- `REFUND`: refund or negative adjustment

### Operation Logs

The system records key actions such as creating reservations, updating reservations, status transitions, stay extensions, room changes, and reservation deletion, making it easy to trace who made changes and what changed.

### Notifications

The system generates the following notifications:

- `BOOKING_SUCCESS`: booking success
- `UPCOMING_CHECKIN`: upcoming check-in
- `UPCOMING_CHECKOUT`: upcoming check-out

## Pricing Rules

- Room fee = room-type price × number of nights
- Order total = room fee + breakfast + extra bed + deposit − coupon

The final amount is subject to the backend-computed, persisted result.

## Use Cases

- Java full-stack course project
- Hotel management system graduation project
- Spring Boot + Vue front-end/back-end separation practice project
- Prototype demo for back-office management systems

## Possible Future Extensions

- Add Redis for hot-data caching and stronger session handling
- Enrich operation logs and audit records
- Integrate SMS and email notifications
- Add object storage for guest ID documents and attachments
- Split menu and button permissions into finer granularity
- Provide one-click deployment via Docker Compose

## License

This project is currently better suited as a learning, demo, or personal portfolio project. For commercial use, it is recommended to add more complete security, auditing, monitoring, and deployment solutions.
</details>

## 项目亮点

- 三端角色协同：管理员、前台专员、住客端统一接入同一套平台能力
- 完整酒店业务链路：房型、房间、住客、预订、入住、离店、结算、报表
- 正式化权限控制：基于 Spring Security 与 JWT 的角色访问控制
- 订单状态流转：支持 `BOOKED / CHECKED_IN / CHECKED_OUT / CANCELLED`
- 自动计价能力：按房型单价与入住晚数自动计算订单金额
- 费用拆分更贴近日常业务：房费、早餐、加床、押金、优惠券独立核算
- 房态日历：按日期查看房间空房、预订、在住、停用状态
- 真实前厅操作：支持订单续住、换房、入住、离店与取消
- 财务流水与操作审计：记录订单费用变化、押金、优惠与关键操作日志
- 消息提醒中心：预订成功、即将入住、即将退房提醒与未读角标
- 经营分析看板：概览指标、趋势图、Excel 报表导出
- 极简中后台 UI：统一信息结构、轻量视觉语言、适合演示与二次开发

## 更新日志

项目每日更新记录见 [CHANGELOG.md](CHANGELOG.md)。

## 技术架构

### 后端

- Spring Boot 3.3.5
- Spring Security
- MyBatis-Plus 3.5.8
- MySQL 8
- JWT
- Apache POI

### 前端

- Vue 3
- Vite 4
- 原生 CSS 轻量化定制界面

## 核心功能

### 1. 认证与权限

- 管理后台登录
- 住客端注册与登录
- JWT 鉴权
- 用户修改密码
- 角色区分与接口访问控制
- 支持角色：
  - `ADMIN`
  - `FRONT_DESK`
  - `CUSTOMER`

### 2. 管理后台

- 仪表盘概览
- 营收趋势分析
- Excel 报表导出
- 房型管理 CRUD
- 房间管理 CRUD
- 订单管理 CRUD
- 订单分页、筛选、搜索
- 订单状态流转
- 房态日历与颜色图例
- 入住续住与换房办理
- 财务流水查询与汇总统计
- 操作日志查询
- 消息提醒中心与未读提醒
- 住客管理 CRUD
- 会员等级维护
- 入住登记与离店处理
- 订单打印单、入住单、退房结算单接口
- 管理员账户与角色维护

### 3. 订单与结算

- 按入住晚数自动计算房费
- 拆分早餐费、加床费、押金、优惠券金额
- 自动汇总订单应收金额
- 校验房间可用性与日期冲突
- 记录历史入住与消费统计
- 续住时自动重算房费与订单合计
- 换房时自动校验目标房间可用性
- 记录房费调整、押金、优惠券、结算等财务流水

### 4. 房态、日志与提醒

- 房态日历：按 7 / 10 / 14 天查看房间状态
- 悬浮详情：展示日期、房间、订单号、住客和清洁状态
- 财务流水：展示入账、抵扣、退款和净流水
- 操作日志：记录操作人、角色、动作类型、前后快照
- 消息提醒：支持未读数量、首页提醒卡片、标记已读

### 5. 住客端

- 住客注册
- 住客登录
- 浏览房型与基础价格
- 在线提交预订
- 查看个人订单
- 查看个人资料与会员等级

## 系统截图

### 管理员工作台

![管理员工作台](docs/screenshots/admin-dashboard.png)

### 前台工作台

![前台工作台](docs/screenshots/frontdesk-dashboard.png)

### 住客中心

![住客中心](docs/screenshots/guest-portal.png)

## 目录结构

```text
.
├── backend                     # Spring Boot 接口服务
├── frontend                    # Vue 3 + Vite 前端
├── database                    # MySQL 初始化脚本与增量脚本
└── docs/screenshots            # README 展示截图
```

## 业务角色说明

### 管理员 `ADMIN`

- 查看运营总览与趋势分析
- 管理房型、房间、订单、住客
- 导出 Excel 报表
- 管理后台账号、角色与权限范围

### 前台专员 `FRONT_DESK`

- 查看工作台数据
- 办理入住、离店
- 管理订单与住客档案
- 辅助前厅接待与日常流转

### 住客 `CUSTOMER`

- 注册住客账号
- 查看房型
- 提交预订
- 查询个人订单与基础资料

## 快速开始

### 1. 初始化数据库

导入以下脚本：

- [database/hotel_management.sql](database/hotel_management.sql)

如果你需要按增量方式同步结构，也可以执行：

- [database/migrations/2026-04-22_reservation_charge_breakdown.sql](database/migrations/2026-04-22_reservation_charge_breakdown.sql)
- [database/migrations/2026-04-22_customer_user.sql](database/migrations/2026-04-22_customer_user.sql)
- [database/migrations/2026-04-23_hotel_ops_extension.sql](database/migrations/2026-04-23_hotel_ops_extension.sql)

### 2. 配置数据库连接

编辑 [backend/src/main/resources/application.yml](backend/src/main/resources/application.yml)，按本地 MySQL 环境修改：

- `spring.datasource.url`
- `spring.datasource.username`
- `spring.datasource.password`

### 3. 启动后端

```bash
cd backend
mvn spring-boot:run
```

默认端口：`8080`

### 4. 启动前端

```bash
cd frontend
pnpm install
pnpm dev
```

默认地址：`http://localhost:5174`

## 默认测试账号

### 后台管理员

- 账号：`admin`
- 密码：`admin123`

### 前台专员

- 账号：`frontdesk`
- 密码：`front123`

### 住客端示例账号

- 账号：`13900000088`
- 密码：`guest123`

## 关键接口示例

### 认证接口

- `POST /api/v1/auth/login`
- `GET /api/v1/auth/me`
- `POST /api/v1/auth/change-password`
- `POST /api/v1/customer/auth/login`
- `POST /api/v1/customer/auth/register`
- `GET /api/v1/customer/auth/me`

### 仪表盘与报表

- `GET /api/v1/dashboard/overview`
- `GET /api/v1/dashboard/trends`
- `GET /api/v1/reports/operations/export`

### 房态、流水、日志与提醒

- `GET /api/v1/operations/room-calendar`
- `GET /api/v1/operations/financial-transactions`
- `GET /api/v1/operations/financial-summary`
- `GET /api/v1/operations/logs`
- `GET /api/v1/operations/notifications`
- `PUT /api/v1/operations/notifications/{id}/read`

### 房型与房间

- `GET /api/v1/room-types`
- `GET /api/v1/room-types/page`
- `POST /api/v1/room-types`
- `PUT /api/v1/room-types/{id}`
- `DELETE /api/v1/room-types/{id}`
- `GET /api/v1/rooms`
- `GET /api/v1/rooms/page`
- `GET /api/v1/rooms/available`
- `POST /api/v1/rooms`
- `PUT /api/v1/rooms/{id}`
- `DELETE /api/v1/rooms/{id}`

### 订单与住客

- `GET /api/v1/reservations/page`
- `POST /api/v1/reservations`
- `PUT /api/v1/reservations/{id}`
- `PUT /api/v1/reservations/{id}/status`
- `PUT /api/v1/reservations/{id}/extend`
- `PUT /api/v1/reservations/{id}/change-room`
- `GET /api/v1/reservations/{id}/print`
- `GET /api/v1/reservations/{id}/check-in-slip`
- `GET /api/v1/reservations/{id}/checkout-settlement`
- `GET /api/v1/guests`
- `GET /api/v1/guests/{id}/profile`
- `POST /api/v1/guests`
- `PUT /api/v1/guests/{id}`
- `DELETE /api/v1/guests/{id}`

### 住客端

- `GET /api/v1/customer/room-types`
- `POST /api/v1/customer/reservations`
- `GET /api/v1/customer/reservations`

## 订单状态说明

- `BOOKED`：已预订
- `CHECKED_IN`：已入住
- `CHECKED_OUT`：已退房
- `CANCELLED`：已取消

支持的核心流转：

- `BOOKED -> CHECKED_IN`
- `BOOKED -> CANCELLED`
- `CHECKED_IN -> CHECKED_OUT`

## 前厅操作说明

### 房态日历

- `AVAILABLE`：空房，可预订
- `BOOKED`：已预订，等待入住
- `CHECKED_IN`：已入住，占用中
- `MAINTENANCE`：维修或停用，不可售卖

### 续住

前台可在订单页选中订单，设置新的离店日期。系统会校验原房间在延长期内是否有冲突，并自动重算房费、订单合计和财务流水。

### 换房

前台可为未完成订单选择目标房间。系统会校验目标房间是否维修、是否与其他订单冲突，并记录操作日志与费用调整。

### 财务流水

流水方向包括：

- `CHARGE`：入账，例如房费、押金、退房结算
- `DISCOUNT`：抵扣，例如优惠券
- `REFUND`：退款或负向调整

### 操作日志

系统会记录创建订单、更新订单、状态流转、续住、换房、删除订单等关键动作，便于回溯责任人与业务变更。

### 消息提醒

系统会生成以下提醒：

- `BOOKING_SUCCESS`：预订成功
- `UPCOMING_CHECKIN`：即将入住
- `UPCOMING_CHECKOUT`：即将退房

## 计价规则说明

- 房费 = 房型单价 × 入住晚数
- 订单合计 = 房费 + 早餐费 + 加床费 + 押金 - 优惠券

最终金额以后端计算并落库结果为准。

## 项目适用场景

- Java 全栈课程设计
- 酒店管理系统毕业设计
- Spring Boot + Vue 前后端分离练手项目
- 业务后台管理系统原型演示

## 后续可扩展方向

- 接入 Redis 做热点缓存与会话强化
- 补充操作日志与审计记录
- 对接短信通知与邮件提醒
- 接入对象存储管理住客证件与附件
- 拆分更细粒度菜单权限与按钮权限
- 提供 Docker Compose 一键部署

## 许可说明

本项目当前更适合作为学习、演示与个人作品集项目使用，如需商用，建议补充更完整的安全、审计、监控与部署方案。
