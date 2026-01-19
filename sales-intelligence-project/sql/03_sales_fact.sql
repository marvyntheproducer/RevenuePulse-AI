-- SQLBook: Code
CREATE TABLE sales_fact AS
SELECT
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    o.customer_id,

    DATE(o.order_purchase_timestamp::timestamp) AS order_date,
    EXTRACT(YEAR FROM o.order_purchase_timestamp::timestamp) AS order_year,
    EXTRACT(MONTH FROM o.order_purchase_timestamp::timestamp) AS order_month,
    EXTRACT(WEEK FROM o.order_purchase_timestamp::timestamp) AS order_week,

    oi.price::NUMERIC AS price,
    oi.freight_value::NUMERIC AS freight_value,
    (oi.price::NUMERIC + oi.freight_value::NUMERIC) AS item_revenue,

    o.order_status,
    p.product_category_name AS product_category

FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id;

