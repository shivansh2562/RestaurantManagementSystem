-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 17, 2019 at 05:35 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `la_bourse`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_order_items` (IN `order_id_input` INT, IN `item_id_input` INT, IN `quantity_input` INT, IN `statement_type` INT)  NO SQL
    DETERMINISTIC
BEGIN  
declare ord_id, ord_status, k int;

declare cur1 cursor for select order_id, order_status from orders where order_id=order_id_input ;

declare continue handler for not found set k=1;
open cur1;
set k=0;
fetch cur1 into ord_id, ord_status;

while k=0 do

IF statement_type = 1 then  
  insert into order_items (order_id,item_id,quantity) values( order_id_input, item_id_input,quantity_input);  
  select * from order_items;
  
 
ELSEIF statement_type =0 then
update order_items 
set item_id = item_id_input, quantity=quantity_input 
WHERE order_id= ord_id and ord_status=1;  
END IF;
fetch cur1 into ord_id, ord_status;
end while;
 close cur1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `allocate_table` (IN `members` INT, IN `reserve_id` INT)  begin 
declare k int;
declare a_occupied varchar(3);
declare c, t_id int;
declare assigned_tableid int;
declare cur1 cursor for select table_id, capacity, table_status from la_table ;

declare continue handler for not found set k=1;
open cur1;
set k=0;
fetch cur1 into t_id, c ,a_occupied ;

while k=0 do
     if (c=members && c<=8 && a_occupied ='no') then
      set assigned_tableid= t_id;
     end if; 
     
     fetch cur1 into t_id, c ,a_occupied ; 
      
   end while;
close cur1;

update la_table set table_status='yes' where table_id= assigned_tableid;
select reserve_id, members, assigned_tableid, table_status from la_table where table_id= assigned_tableid;
insert into reserve_table VALUES(reserve_id, assigned_tableid);

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Customer_max_orders` (IN `year_input` INT)  begin
     
declare user_id_max int ;

declare total_order int;

declare  k int;

declare bill_date_ date ;
 
 declare cur1 cursor for select 


COUNT(orders.user_id), bill.bill_date,orders.user_id from orders ,bill where  year_input = extract(YEAR from bill.bill_date) 
  and orders.order_id = bill.order_id 
    group by  orders.user_id  having COUNT(orders.user_id) = ( select max(mycount)  from ( select orders.user_id, COUNT(orders.user_id) as mycount from bill ,orders where orders.order_id = bill.order_id group by orders.user_id) as T );

    declare continue handler for not found set k = 1; 
    open cur1;
         set k = 0;
         fetch cur1 into  total_order, bill_date_, user_id_max;

         while k = 0 do  

  
    select total_order, bill_date_, user_id_max ;
 fetch cur1 into  total_order, bill_date_, user_id_max;
end while;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_amount` (IN `order_id_input` INT)  begin
 declare billamount , k int;
 declare item_price_amt ,order_id_amt,order_qty_amt int;

declare cur1 cursor for select order_id ,sum(menu.item_price*quantity) as billamount from order_items, menu where order_id = order_id_input and order_items.item_id=menu.item_id GROUP BY order_id ;

declare continue handler for not found set k=1;



open cur1;
set k=0;

fetch cur1 into ORDER_ID_INPUT , BILLAMOUNT;

while k=0 do

select order_id_input , billamount;
fetch cur1 into ORDER_ID_INPUT , BILLAMOUNT;
   end while;
   
close cur1;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_level` (IN `user_type_get` VARCHAR(15), IN `password_input` VARCHAR(15))  NO SQL
begin 
declare k int;
declare password_check varchar(10);
 
declare cur1 cursor for select password from users where user_type ="admin" ;
declare continue handler for not found set k=1;


open cur1;
set k=0;
fetch cur1 into password_check ;

while k=0 do
     if (user_type_get ='admin' && password_input =password_check) then
     select user_id, user_name, userLevel(user_id) from users where user_type <> 'admin';
     
     
     end if;
     IF ((user_type_get ='admin' && password_input <>password_check)||(user_type_get <>'admin' && password_input <>password_check)|| (user_type_get <>'admin' && password_input =password_check) ) then
     select 'you cant access data';
       end if;
     fetch cur1 into password_check;
     
    

   end while;
close cur1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `payment_after_discount` (IN `input_payment_id` INT, IN `input_payment_mode` VARCHAR(20))  NO SQL
begin 
    declare pay_amount , discount_ float;
    declare pay_mode ,pay_status varchar(10);
    declare k ,pay_id int;
   

    declare cur1 cursor for select bill_number , payment_method , payment_amount , payment_status from payment where input_payment_mode = payment_method and input_payment_id = bill_number;
    
    declare continue handler for not found set k = 1; 
    open cur1;
         set k = 0;
 fetch cur1 into pay_id, pay_mode, pay_amount , pay_status; 
         while k = 0 do       
                   if pay_mode = 'creditcard' && pay_status='unpaid' then
set discount_ = 0.3 ;
                        elseif pay_mode = 'cash' && pay_status='unpaid'  then
set discount_ = 0.15 ;
                       elseif  pay_mode = 'netbanking' && pay_status='unpaid'  then
set discount_ = 0.2 ;
       elseif pay_mode = 'paytm' && pay_status='unpaid' then
set discount_ = 0.25 ;
                      end if;
               set pay_amount = pay_amount - (discount_*pay_amount) ; 
               select pay_id,pay_mode,pay_amount;
               fetch cur1 into pay_id, pay_mode, pay_amount,pay_status;
         end while; 
    close cur1;
update payment set payment_amount = pay_amount where  input_payment_mode = payment_method and input_payment_id = bill_number and payment_status= 'unpaid';
update payment set payment_status='paid' where input_payment_mode = payment_method and input_payment_id = bill_number ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `payment_after_offer` (IN `input_payment_id` INT)  NO SQL
    DETERMINISTIC
begin 
    declare pay_amount , dis float;
    declare pay_status, off_name varchar(20);
    declare k ,pay_id int;
   
    declare cur1 cursor for select offer.offer_discount , offer.offer_name , payment.payment_amount from offer , payment  where offer.offer_status = 'yes' and  input_payment_id = payment.payment_id and payment.payment_id in (select payment.payment_id from payment where payment_status = 'unpaid') ;
    declare continue handler for not found set k = 1; 
    open cur1;
         set k = 0;
 fetch cur1 into dis,off_name, pay_amount; 
         while k = 0 do       
                  
               set pay_amount = (pay_amount - (dis*pay_amount)/100) ; 
               select input_payment_id,off_name, pay_amount;
                fetch cur1 into dis,off_name, pay_amount;
         end while; 
    close cur1;
update payment set payment_amount= pay_amount where input_payment_id= payment.payment_id;
update payment set payment_status='paid' where  input_payment_id = payment.payment_id ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `place_order` (IN `user_id_input` INT, IN `table_id_input` INT)  NO SQL
BEGIN

insert into orders (user_id,table_id, order_date, order_time, waiter_id, chef_id)values( user_id_input, table_id_input, curdate(), curtime(), '1', '2');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reservation_history` ()  NO SQL
BEGIN
declare b int ;
declare rdate date;
declare cur1 cursor for select reservation.reservation_date from reservation inner join reserve_table on reservation.reservation_id = reserve_table.reservation_id group by reserve_table.reservation_id order by reservation.reservation_date;

declare continue handler for not found set b=1;
open cur1;
set b=0;
fetch cur1 into rdate;
while b = 0 do 


select * from reservation inner join reserve_table on reservation.reservation_id = reserve_table.reservation_id where reservation.reservation_date = rdate;
fetch cur1 into rdate;
end while;
close cur1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Sales_by_Year` (IN `AtBeginning_Date` DATE, IN `AtEnding_Date` DATE)  BEGIN
   SELECT
      orders.order_date,
      orders.order_id,
      bill.amount,
      year(order_date) AS Year
   FROM orders 
      JOIN bill ON orders.order_id = bill.order_id
   WHERE orders.order_date BETWEEN AtBeginning_Date AND AtEnding_Date;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_all_tables_admin` (IN `user_type_get` VARCHAR(12), IN `password_input` VARCHAR(10))  begin 
declare k int;
declare password_check varchar(10);
 
declare cur1 cursor for select password from users where user_type ="admin" ;
declare continue handler for not found set k=1;


open cur1;
set k=0;
fetch cur1 into password_check ;

while k=0 do
     if (user_type_get ='admin' && password_input =password_check) then
     select *from users where user_type <> 'admin';
     select *from reservation;
     select *from orders;
     select *from order_items order by order_id;
     select *from la_table;
     select *from bill;
     select *from payment;
     
     end if;
     IF ((user_type_get ='admin' && password_input <>password_check)||(user_type_get <>'admin' && password_input <>password_check)|| (user_type_get <>'admin' && password_input =password_check) ) then
     select 'you cant access data';
       end if;
     fetch cur1 into password_check;
     
    

   end while;
close cur1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Ten_Most_Expensive_Dishes` ()  BEGIN
   SELECT 
      menu.item_name AS TenMostExpensiveProducts,
      menu.item_price
   FROM menu
   ORDER BY menu.item_price DESC
   LIMIT 10;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `userLevel` (`user_id_level` INT) RETURNS VARCHAR(10) CHARSET latin1 BEGIN
    DECLARE level varchar(10);
    declare o_user_id, no_orders, k int;
 
   declare cur1 cursor for select orders.user_id, COUNT(*) as no_orders FROM orders where orders.user_id= user_id_level GROUP BY user_id
ORDER BY no_orders DESC;
   declare continue handler for not found set k=1;
 open cur1;
  set k=0;
fetch cur1 into o_user_id, no_orders;
while k=0 do
   IF no_orders > 20 THEN
 SET level = 'PLATINUM';
    ELSEIF (no_orders <= 20 AND no_orders >= 10) THEN
        SET level = 'GOLD';
    ELSEIF no_orders < 10 THEN
        SET level = 'SILVER';
    END IF;
        fetch cur1 into o_user_id, no_orders;
end while;
    close cur1;
 
 RETURN level;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `order_id` int(11) NOT NULL,
  `bill_number` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `bill_date` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`order_id`, `bill_number`, `amount`, `bill_date`) VALUES
(1, 1, 2850, '2019-04-12'),
(2, 2, 650, '2019-04-13'),
(3, 3, 1610, '2019-04-14');

--
-- Triggers `bill`
--
DELIMITER $$
CREATE TRIGGER `table_status` AFTER INSERT ON `bill` FOR EACH ROW BEGIN
   update la_table SET table_status='NO' where bill.order_id=orders.order_id and orders.table_id=la_table.table_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `chef`
--

CREATE TABLE `chef` (
  `chef_id` int(11) NOT NULL,
  `chef_name` varchar(30) NOT NULL,
  `sex` varchar(1) NOT NULL,
  `isassigned` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chef`
--

INSERT INTO `chef` (`chef_id`, `chef_name`, `sex`, `isassigned`) VALUES
(1, 'Faizal Khurana', 'M', ''),
(2, 'Pankaj Kapoor', 'F', '');

-- --------------------------------------------------------

--
-- Table structure for table `la_table`
--

CREATE TABLE `la_table` (
  `table_id` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  `table_status` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `la_table`
--

INSERT INTO `la_table` (`table_id`, `capacity`, `table_status`) VALUES
(1, 4, 'no'),
(2, 2, 'no'),
(3, 3, 'yes'),
(4, 4, 'yes'),
(5, 5, 'yes'),
(6, 6, 'no'),
(7, 7, 'yes'),
(8, 8, 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(20) NOT NULL,
  `item_info` varchar(50) NOT NULL,
  `item_price` int(11) NOT NULL,
  `add_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`item_id`, `item_name`, `item_info`, `item_price`, `add_date`) VALUES
(1, 'pasta', 'white sauce gravy', 250, '2018-04-01'),
(2, 'Farmhouse Pizza', 'red green yellow capsicum with onion ', 400, '2019-01-09'),
(3, ' garlic bread', 'delicious garlic bread with oregano', 300, '2018-02-12'),
(4, 'cheesy pizza', 'pizza with 7 type of cheese', 500, '2019-04-15'),
(5, 'paneer chilli', 'delicious panner with spicy gravy', 290, '2018-12-03'),
(6, 'paneer lababdar', 'cubes of cottage cheese cooked in cashew nut gravy', 400, '2019-02-04'),
(7, 'tacos', 'mexican dish', 300, '2018-03-10'),
(8, 'cheesy loaded nachos', 'cheesy nachos with mayo sauce and full of cheese', 270, '2019-03-11'),
(9, ' cheese cake', 'served with blue berry compote and mint', 670, '2019-02-11'),
(10, 'Minestrone soup', 'traditional italian soup with veg. and pasta', 270, '0000-00-00'),
(11, 'cheesy platter', 'mixed dish with cheese balls, cheese fries', 670, '2019-03-11'),
(12, 'mexican sizzler', 'all in one mexican dish', 550, '2019-04-08'),
(13, 'special pizza', 'La_bourse special pizza ', 700, '2019-02-04'),
(14, 'chocolate mouse', 'Loaded with dark and white chocolate', 340, '2018-10-15');

-- --------------------------------------------------------

--
-- Table structure for table `offer`
--

CREATE TABLE `offer` (
  `offer_name` varchar(20) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `offer_discount` int(11) NOT NULL,
  `offer_status` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `offer`
--

INSERT INTO `offer` (`offer_name`, `offer_id`, `offer_discount`, `offer_status`) VALUES
('daily_bonus', 1, 10, 'yes'),
('weekend_bonus', 2, 15, 'no'),
('festive_offer', 3, 25, 'no'),
('happy 20', 4, 20, 'no');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `table_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `order_time` time NOT NULL,
  `order_status` int(11) NOT NULL,
  `chef_id` int(11) NOT NULL,
  `waiter_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `table_id`, `order_date`, `order_time`, `order_status`, `chef_id`, `waiter_id`) VALUES
(1, 4, 2, '2019-04-12', '19:00:00', 1, 1, 1),
(2, 2, 2, '2019-04-13', '18:00:00', 2, 1, 2),
(3, 3, 3, '2019-04-14', '20:00:00', 2, 1, 1),
(4, 2, 6, '2019-04-13', '19:09:00', 2, 1, 1),
(7, 2, 1, '2019-04-18', '14:00:00', 1, 1, 1),
(8, 4, 4, '2019-04-17', '15:55:28', 1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_id`, `item_id`, `quantity`) VALUES
(1, 4, 2),
(1, 2, 4),
(1, 1, 1),
(2, 1, 1),
(2, 2, 1),
(3, 11, 2),
(3, 10, 1),
(3, 4, 4);

--
-- Triggers `order_items`
--
DELIMITER $$
CREATE TRIGGER `check_quantity` BEFORE INSERT ON `order_items` FOR EACH ROW begin
    declare msg varchar(128);
    if new.quantity < 0 then
        set msg = concat('MyTriggerError: Trying to insert a negative quantity of items ', cast(new.quantity as char));
        signal sqlstate '45000' set message_text = msg;
    end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `bill_number` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_status` varchar(10) NOT NULL,
  `payment_amount` float NOT NULL,
  `payment_method` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `bill_number`, `user_id`, `payment_status`, `payment_amount`, `payment_method`) VALUES
(1, 1, 2, 'unpaid', 2400, 'paytm'),
(2, 3, 3, 'unpaid', 2800, 'netbanking'),
(3, 2, 4, 'unpaid', 850, 'creditcard');

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `reservation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reservation_date` date NOT NULL,
  `reservation_time` time NOT NULL,
  `no_of_people` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`reservation_id`, `user_id`, `reservation_date`, `reservation_time`, `no_of_people`) VALUES
(1, 2, '2019-04-12', '11:20:00', 4),
(2, 4, '2019-04-12', '18:00:00', 2),
(3, 3, '2019-04-16', '18:00:00', 7),
(4, 2, '2019-04-18', '22:00:00', 8);

--
-- Triggers `reservation`
--
DELIMITER $$
CREATE TRIGGER `check_time` BEFORE INSERT ON `reservation` FOR EACH ROW begin
 declare msg varchar(128);
 if(new.reservation_date< CURRENT_DATE) THEN
 set msg = 'Error :You cannot make reservation';
signal sqlstate '45001' set message_text = msg;
end if;
 
  if (hour(new.reservation_time) > 23) || (hour(new.reservation_time) < 10) then
insert into trapped_reservation(user_name, trap_time) values (user(),current_timestamp());
            set msg = 'Error: You cannot make reservation: Restaurant closed';
signal sqlstate '45001' set message_text = msg;
  
      end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reserve_table`
--

CREATE TABLE `reserve_table` (
  `reservation_id` int(11) NOT NULL,
  `table_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reserve_table`
--

INSERT INTO `reserve_table` (`reservation_id`, `table_id`) VALUES
(1, 4),
(2, 3),
(3, 5);

-- --------------------------------------------------------

--
-- Table structure for table `trapped_reservation`
--

CREATE TABLE `trapped_reservation` (
  `user_name` varchar(20) NOT NULL,
  `trap_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trapped_reservation`
--

INSERT INTO `trapped_reservation` (`user_name`, `trap_time`) VALUES
('root@localhost', '0000-00-00 00:00:00'),
('root@localhost', '2019-04-13 20:38:06');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(30) NOT NULL,
  `contact_number` bigint(20) NOT NULL,
  `user_email` varchar(20) NOT NULL,
  `user_type` varchar(12) NOT NULL,
  `password` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `contact_number`, `user_email`, `user_type`, `password`) VALUES
(1, 'admin', 2147483647, 'admin@gmail.com', 'admin', 'admin'),
(2, 'hardi', 2147483647, 'hardi@gmail.com', 'customer', 'hardi'),
(3, 'shivansh', 2147483647, 'shivansh@gmail.com', 'customer', '123'),
(4, 'mudra', 2147483647, 'rytvu@gmail.com', 'customer', '423'),
(5, 'rutvi', 7575002299, 'rutvi.tilala@gmail.c', 'customer', 'ruts'),
(6, 'neha kapoor', 2147483647, 'riya@gmail.com', 'customer', 'riya');

-- --------------------------------------------------------

--
-- Table structure for table `waiter`
--

CREATE TABLE `waiter` (
  `waiter_id` int(11) NOT NULL,
  `waiter_name` varchar(30) NOT NULL,
  `waiter_sex` varchar(1) NOT NULL,
  `isassigned` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `waiter`
--

INSERT INTO `waiter` (`waiter_id`, `waiter_name`, `waiter_sex`, `isassigned`) VALUES
(1, 'sikander singh', 'M', 'yes'),
(2, 'Manav', 'M', 'no');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`bill_number`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `chef`
--
ALTER TABLE `chef`
  ADD PRIMARY KEY (`chef_id`);

--
-- Indexes for table `la_table`
--
ALTER TABLE `la_table`
  ADD PRIMARY KEY (`table_id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `offer`
--
ALTER TABLE `offer`
  ADD PRIMARY KEY (`offer_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`user_id`),
  ADD KEY `table_id` (`table_id`),
  ADD KEY `waiter_id` (`waiter_id`),
  ADD KEY `chef_id` (`chef_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD KEY `item_id` (`item_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `bill_number` (`bill_number`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `reservation_ibfk_1` (`user_id`);

--
-- Indexes for table `reserve_table`
--
ALTER TABLE `reserve_table`
  ADD KEY `reservation_id` (`reservation_id`),
  ADD KEY `table_id` (`table_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `waiter`
--
ALTER TABLE `waiter`
  ADD PRIMARY KEY (`waiter_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`table_id`) REFERENCES `la_table` (`table_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`waiter_id`) REFERENCES `waiter` (`waiter_id`),
  ADD CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`chef_id`) REFERENCES `chef` (`chef_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `menu` (`item_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`bill_number`) REFERENCES `bill` (`bill_number`),
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `reserve_table`
--
ALTER TABLE `reserve_table`
  ADD CONSTRAINT `reserve_table_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`),
  ADD CONSTRAINT `reserve_table_ibfk_2` FOREIGN KEY (`table_id`) REFERENCES `la_table` (`table_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
