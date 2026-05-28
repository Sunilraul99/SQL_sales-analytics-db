# Sales Database - Quick Start Guide

## What You Got

A complete Git repository with a MySQL sales database including:
- 7 relational tables with sample data
- 8 pre-written business intelligence queries
- Full documentation and setup instructions

## Files in the Repository

```
sales-db-project/
├── README.md          # Comprehensive documentation
├── sales_db.sql          # Database schema + sample data + queries
```
## What Each Table Does

| Table | Purpose | Records |
|-------|---------|---------|
| customers | Customer profiles | 10 |
| products | Item catalog | 15 |
| sales_reps | Sales team | 8 |
| sales_orders | Orders placed | 25 |
| order_details | Items per order | 57 |
| payments | Payment records | 20 |
| inventory | Stock tracking | 15 |

## 8 Ready-to-Use Queries

All included in `sales_db.sql` - run them directly:

1. **Revenue by Type & Region** - Sales breakdown
2. **Product Performance** - Top products with margins
3. **Sales Rep Ranking** - Performance leaderboard
4. **Customer Lifetime Value** - High-value customer identification
5. **Month-over-Month Growth** - Revenue trends
6. **Customer Segmentation** - High/Medium/Low value buckets
7. **Cross-Sell Analysis** - Products bought together

## Common Tasks

**Start fresh:**
```sql
DROP DATABASE sales_db;
-- Then re-run setup.sql
```

**Add a new customer:**
```sql
INSERT INTO customers (customer_name, email, country, state, registration_date, customer_type, credit_limit) 
VALUES ('Your Name', 'email@example.com', 'USA', 'NY', CURDATE(), 'Individual', 50000);
```

**View top 5 orders:**
```sql
SELECT * FROM sales_orders ORDER BY net_amount DESC LIMIT 5;
```

