# Monthly Revenue by Seller

create table monthly_revenue_seller(
	seller_id varchar(50)
    ,month date
    ,revenue decimal(10,2)
);
	 seller_id varchar(50)
    ,month date
    ,revenue decimal(10,2)
);



delimiter $$
create event ev_monthly_revenue_seller
on schedule every 1 month
starts current_date
do
begin 
		insert into ev_monthly_revenue_seller(seller_id, month, revenue)
        select
        oi.seller_id
        ,date_format(o.order_purchase_timestamp, '%Y-%m-01')
        ,sum(p.payment_value)
        from olist_order_items_dataset oi
        join olist_orders_dataset o on o.order_id=oi.order_id
        join olist_order_payments_dataset p on oi.order_id=p.order_id
        group by oi.seller_id;
end $$
delimiter ;
	