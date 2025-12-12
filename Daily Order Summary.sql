#Daily Order Summary

select * from olist_orders_dataset;
create table daily_order_summary (
	order_date date,
    total_orders int,
    total_revenue decimal(10,2)
);



delimiter $$
create event ev_daily_order_summary
on schedule every 1 day 
starts current_timestamp
do 
begin
	insert into daily_order_summary (order_date, total_orders, total_revenue )
    select 
		date(order_purchase_timestamp)
		,count(order_id)
        ,sum(payment_value) 
        from olist_orders_dataset o
        left join olist_order_payments_dataset p
		on o.order_id=p.order_id
		group by date(order_purchase_timestamp) ;
end $$	
delimiter ;


SET GLOBAL event_scheduler = ON;