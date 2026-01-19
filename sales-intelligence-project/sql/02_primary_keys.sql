ALTER TABLE olist_orders_dataset
ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);

ALTER TABLE olist_customers_dataset
ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id);

ALTER TABLE olist_products_dataset
ADD CONSTRAINT pk_products PRIMARY KEY (product_id);

ALTER TABLE olist_sellers_dataset
ADD CONSTRAINT pk_sellers PRIMARY KEY (seller_id);
