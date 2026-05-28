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
├── setup.sql          # Database schema + sample data + queries
├── .gitignore         # Git configuration for excluding files
└── .git/              # Git version control history
```

## 30-Second Setup

```bash
# Navigate to the folder
cd sales-db-project

# Run the database setup
mysql -u root -p < setup.sql

# Login and check
mysql -u root -p
USE sales_db;
SELECT * FROM customers LIMIT 5;
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

All included in `setup.sql` - run them directly:

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

**Check Git history:**
```bash
git log --oneline
git show HEAD
```

## Key Features

✅ **Production-Ready** - Proper foreign keys and indexes  
✅ **Sample Data** - 10 months of realistic transactions  
✅ **Advanced Queries** - Window functions, CTEs, aggregations  
✅ **Well Documented** - Comments explaining each section  
✅ **Customizable** - Easy to modify for your needs  
✅ **Version Controlled** - Full Git history included  

## Troubleshooting

| Issue | Solution |
|-------|----------|
| MySQL not running | `mysql.server start` (Mac/Linux) or start MySQL service (Windows) |
| Access denied | Use correct username and password |
| Database already exists | Drop it first: `DROP DATABASE sales_db;` |
| Syntax errors | Make sure you're using MySQL 5.7+ |

## Next Steps

1. **Explore the data** - Run the business intelligence queries
2. **Understand the relationships** - Check foreign key constraints
3. **Practice SQL** - Write your own queries against the data
4. **Customize** - Add your own products, customers, or orders
5. **Version control** - Make changes and commit to git

## Git Commands to Know

```bash
# See what changed
git status
git log

# Make a change and save it
git add .
git commit -m "Your message here"

# See who changed what
git diff HEAD~1

# Reset to original
git checkout .
```

---

**Everything is documented in the README.md file inside the repository.** 

Enjoy! 🚀
