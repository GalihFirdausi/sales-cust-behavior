-- join all the dataset ----------------------------------------------------------------------
select *
from orders as o
inner join pelanggan as c
on c.pelanggan_id = o.pelanggan_id
inner join detil_order as d
on d.order_id = o.order_id
inner join produk as p
on p.produk_id = d.produk_id;


-- create staging table to clean the data ------------------------------------------------------------------------------------------------------------------
create table sales_data as
select 
	o.*,
	c.nama,
    c.email,
    c.alamat,
    c.kota,
    c.provinsi,
    c.no_hp,
    d.detil_id,
    d.produk_id,
    d.jumlah,
    d.subtotal,
    p.nama_produk,
    p.kategori,
    p.harga,
    p.stok
from orders as o
inner join pelanggan as c
on c.pelanggan_id = o.pelanggan_id
inner join detil_order as d
on d.order_id = o.order_id
inner join produk as p
on p.produk_id = d.produk_id;


-- Standardize formats ------------------------------------------------------------------------------------------------------------------
select *
from sales_data;

select *
from (
		select *,
        row_number() over(
			partition by detil_id
		) as row_num
        from sales_data
) duplicates
where row_num > 1;

describe sales_data;

alter table sales_data
modify tanggal date;

select
	sum(tanggal is null),
    sum(total is null),
    sum(harga is null)
from sales_data;

select *
from sales_data
where total < 0
	or harga < 0
    or jumlah < 0
    or stok < 0;


-- Data Validation ------------------------------------------------------------------------------------------------------------------
select count(*) as total_rows
from sales_data;

select min(tanggal), max(tanggal)
from sales_data;

select min(total), max(total), avg(total)
from sales_data;

select min(harga), max(harga), avg(harga)
from sales_data;


-- Key findings ------------------------------------------------------------------------------------------------------------------
select *
from sales_data;

-- 1. Which products and categories generate the highest sales each month?
with CTE_salary as ( 
	select 
		month(tanggal) as `month`, 
		nama_produk, 
		kategori, 
		sum(subtotal) as total_sales  
	from sales_data 
	group by month(tanggal), nama_produk, kategori
),
ranked as (
	select *,
		row_number() over(
        partition by `month`
        order by total_sales desc
        ) as row_num 
from CTE_salary
)
select *
from ranked
where row_num = 1;


-- 2. For each month, what was the total sales and which product sold the most?
 DROP VIEW top_product_each_month;
CREATE VIEW top_product_each_month AS 
 with product_sales as (
	select 
		year(tanggal) as `Year`,
        month(tanggal) as MonthNo,
        concat(year(tanggal), '-', lpad(month(tanggal), 2, '0')) as `Date`, 
        monthname(tanggal) as `Month`,
        nama_produk as `Nama Produk`,
        kategori as Kategori,
        sum(subtotal) as `Total Sales`,
        row_number() over(
			partition by year(tanggal), month(tanggal)
			order by sum(subtotal) desc
        ) row_num
    from sales_data
    group by `Date`, `Year`, `Month`, MonthNo, `Nama Produk`, Kategori
)
select `Date`, `Year`, `Month`, `Nama Produk`, Kategori, `Total Sales`
from product_sales
where row_num = 1;


-- 3. What is the distribution of order statuses (completed, shipped, paid, cancelled)?
select `status`, count(*) as distribution_status, 
		round(count(*) * 100.0 / sum(count(*)) over(), 2) as percentage
from sales_data
group by `status`
order by distribution_status desc;
-- Completed was the most frequent order status (40.48%), while Cancelled accounted for 19.52% of transactions.


-- 4. Which products have the highest total purchase quantity?
select nama_produk, sum(jumlah) as total_purchase
from sales_data
group by nama_produk
order by total_purchase desc;
-- Gula Pasir Gulaku 1kg recorded the highest purchase quantity (19 total purchase), indicating consistently high customer demand.


-- 5. Which provinces generate the highest number of transactions?
select provinsi, count(*) as total_transactions
from sales_data
group by provinsi
order by total_transactions desc;
-- Jawa Tengah recorded the highest number of transactions (44 total), making it a promising region for further customer behavior analysis.


-- 6. Based on the revenue, which top 10 cities generate the highest total revenue?
select kota, sum(subtotal) as total_revenue
from sales_data
group by kota
order by total_revenue desc;
-- Manado generated the highest revenue among all cities during the observed period.


-- 7. Which product categories contribute the most to total revenue?
select kategori, sum(total) as total_revenue
from sales_data
group by kategori
order by total_revenue desc;

select kategori, count(*) as jmlah
from sales_data
group by kategori;
-- Category makananan contribute the most to total revenue (IDR10.362.000). This may be influenced by the larger variety of food products available in the dataset.
















