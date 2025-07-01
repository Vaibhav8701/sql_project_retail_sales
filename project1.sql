create database SQL_project_p1;

create table retails_sales(
transactions_id	int primary key,
sale_date       date,
sale_time	    time,
customer_id	    int,
gender	        varchar(20),
age	            int,
category	    varchar(20),
quantiy	        int,
price_per_unit	float,
cogs	        float,
total_sale      float
);

select * from retails_sales;

select count(*) from retails_sales;

-->        data cleaning
---------------------------------------
select * from retails_sales
where transactions_id	is null
      or
	  sale_date         is null
      or
	  sale_time         is null
      or
	  customer_id  	    is null
      or
	  gender	        is null
      or
	  age	            is null
      or
	  category	        is null
      or
	  quantiy	        is null
      or
	  price_per_unit    is null
      or
	  cogs	            is null
      or
	  total_sale        is null;

delete from retails_sales
where transactions_id	is null
      or
	  sale_date         is null
      or
	  sale_time         is null
      or
	  customer_id  	    is null
      or
	  gender	        is null
      or
	  age	            is null
      or
	  category	        is null
      or
	  quantiy	        is null
      or
	  price_per_unit    is null
      or
	  cogs	            is null
      or
	  total_sale        is null;

--> DATA EXPLORATON..
-------------------------------------------------------------------------
--1.how many sales we have
select count(sale_date)as total_sale from retails_sales;

--2.how many unique customers we have
select count(distinct customer_id)as total_customer from retails_sales;

--3.select category
select distinct category from retails_sales;


--> DATA ANALYSIS AND BUSSNISS KEY PROBLEMS
---------------------------------------------------------------------------
--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
  
   select * from retails_sales
   where sale_date='2022-11-05';
   
--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

  select * from retails_sales
  where  category = 'Clothing' and quantiy = 4 and to_char(sale_date, 'yyyy-mm')='2022-11';
   
--3.Write a SQL query to calculate the total sales (total_sale) for each category.:

  select category,sum(total_sale) from retails_sales
  group by category;
  
--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

  select  round(avg(age),2) from  retails_sales
   where  category='Beauty';

--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
  select * from  retails_sales
  where total_sale > 1000;
  
--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

  select gender,category,count(transactions_id)as total_number from retails_sales
  group by gender,category
  order by total_number;
  
--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

  select * from 
  (select 
     extract(year from sale_date) as year,
     extract(month from sale_date) as month,
     avg(total_sale) ,
	 rank() over(partition by extract(year from sale_date)  order by avg(total_sale) desc)
  from retails_sales
  group by 1,2) as t1
 where rank=1;
  
--8.**Write a SQL query to find the top 5 customers based on the highest total sales **:

   select customer_id,sum(total_sale) from retails_sales
   group by 1
   order by 2 desc
   limit  5;
  
--9.Write a SQL query to find the number of unique customers who purchased items from each category.:

  select category,count(distinct customer_id)
  from retails_sales
  group by 1;
--10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

  select *,
     case
	     when extract(hour from sale_time) < 12 then 'Morning'
		 when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		 else 'Evening'
	 end as shift
  from retails_sales
-------------------------------------------------------------------------------------
-->.....................END OF PROJECT.........................