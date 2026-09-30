<p align="center"><a href="./README.md">简体中文</a> | <b>English</b></p>

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
