# Weekly Top Selling Products

create table weekly_top_products(
	product_id varchar(50)
    ,week_start_date date
    ,total_quantity int
);

delimiter $$
create event ev_weekly_top_products
on schedule every 1 week
starts current_date
do
begin
		insert into weekly_top_products(product_id, week_start_date, total_quantity)
        select
        oi.product_id
        , date_sub(current_date,interval weekday(current_date) day)
        ,count(o.order_id)
        from olist_order_items_dataset  oi 
        join olist_orders_dataset o
			on o.order_id=oi.order_id
		group by oi.product_id;
end $$
delimiter ;