# ManzilIQ / PropEstate API Documentation

Base URL: `http://localhost:5000`

Stack: **Node.js + Express + Supabase** (no Firebase)

## Authentication

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/auth/register` | Register with role metadata |
| POST | `/api/auth/login` | Login, returns JWT session |
| GET | `/api/auth/me` | Current profile (Bearer token) |
| GET | `/api/auth/pending` | Admin: list pending users |
| POST | `/api/auth/approve` | Admin: approve/reject user |

## Societies

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/societies` | List societies |
| POST | `/api/societies` | Create society |
| POST | `/api/societies/plots/bulk` | CSV/bulk plot upload |

## Plots

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/plots/search` | Filter by city, block, price |
| PATCH | `/api/plots/status` | Update plot status |

## Bookings & Payments

See `backend/src/modules/` for full route definitions.

## Database Setup

Run SQL files in order from `database/schema/` then `database/rls/policies.sql` in Supabase SQL Editor.

Create storage buckets: `documents`, `society-maps`, `cnic-uploads`.

## AI Price Prediction

Flask service: `POST http://localhost:8000/api/predict-price`

```json
{
  "city": "Islamabad",
  "size_marla": 5,
  "block": "A",
  "category": "residential"
}
```
