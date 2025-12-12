# Update Delayed Orders

delimiter $$
create event ev_update_delayed_orders 
on schedule every 1 day
starts current_date
do
begin 
	update olist_orders_dataset
    set order_status='late'
    where order_status not in ('canceled','delivered')
    and order_purchase_timestamp < date_sub(now(), interval 7 day) ;
end $$
delimiter ;
