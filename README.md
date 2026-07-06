# Problem Statement
This project analyzes customer purchasing behavior, product performance, sales trends, and regional transactions in a fictional Indonesian retail store. The findings can support Sales and Marketing teams in understanding customer demand and identifying business opportunities.
# Dataset Overview
The dataset contains customer behaviour from 2024-01-15 to 2025-10-13, consisting of 420 rows and 19 columns. The dataset includes:
- Customer identity (pelanggan_id, nama, email, alamat, no_hp)
- Transaction date
- Price information (total, subtotal, Harga)
- Locations (kota, provinsi)
- Order status
- Quantity of product (jumlah, stok)
- Product identity (nama_produk, kategori)
# Dataset Limitation
- The dataset is synthetic (dummy) and created for educational purposes.
- Some product names and locations are real, but transactions are simulated.
- Transaction dates are not recorded for every day, which may limit time-series analysis.
- The dataset uses Indonesian language, which may reduce accessibility for international audiences.
- The dataset does not include customer demographics such as age, gender, or income, limiting deeper customer segmentation.
- The dataset doesn't include transactions from all Indonesian provinces.
# Data Understanding
- Customer identity (pelanggan_id, nama, email, alamat, no_hp, kota, provinsi)
  to identify customer who place orders.
- Transaction date
  to analyze when each transaction occurred.
- Price information (total, subtotal, Harga)
  to provide product prices and transaction values (price, subtotal, and total)
- Order status
  to identify the current status of each order (Paid, Shipped, Completed, or Cancelled).
- Quantity of product (jumlah, stok)
  to identify purchased quantities and available product stock.
- Product identity (nama_produk, kategori)
  to identify products and their categories purchased by customers.
# Business Questions
1. Which products and categories generate the highest sales each month?
2. For each month, what was the total sales and which product sold the most?
3. What is the distribution of order statuses (completed, shipped, paid, cancelled)?
4. Which products have the highest total purchase quantity? 
5. Which provinces generate the highest number of transactions?
6. Based on the revenue, which top 10 cities generate the highest total revenue?
7. Which product categories contribute the most to total revenue?
# Key Findings
1. What is the distribution of order statuses (completed, shipped, paid, cancelled)?
   "Completed was the most frequent order status (40.48%), while Cancelled accounted for 19.52% of
   transactions."
2. Which products have the highest total purchase quantity?
   "Gula Pasir Gulaku 1kg recorded the highest purchase quantity (19 total purchase), indicating
   consistently high customer demand."
4. Which provinces generate the highest number of transactions?
   "Jawa Tengah recorded the highest number of transactions, making it a promising region for
   further customer behavior analysis."
5. Based on the revenue, which top 10 cities generate the highest total revenue?
   "Manado generated the highest revenue among all cities during the observed period."
6. Which product categories contribute the most to total revenue?
   "Category makananan contribute the most to total revenue (IDR10.362.000). This may be influenced
   by the larger variety of food products available in the dataset."
# Dashboard Preview 
<img width="1277" height="717" alt="image" src="https://github.com/user-attachments/assets/aa0942cd-6e39-44df-b681-b205d00e1247" />





