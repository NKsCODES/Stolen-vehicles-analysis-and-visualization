CREATE DATABASE St_vehicles

use St_vehicles

--- Step 2- Open the data dictionary file and all csvs 

---- Categorical data , Dimensions
--- Numerical Data, Measures

-- Car make-- 10 types
-- Colors- 5 types
-- Location-- 30 locations
-- Make_year-- 50 yrs
--- Vehicle_type- 3 types


--- Step 3-- Copy first row from your csv, and create a table over here with the name of CSV.
-- Eg - Locations

--create table locations
(/* paste the first row from your CSv) --- repeat the same steps for all table

--- give them same datatype (Varchar(max) to all fields/ columns in each table)*/


--- we are creating a container type of structure, which can hold any kind of data (num,char,date)
create table locations
(location_id varchar(max),	region varchar(max), country varchar(max),	
population varchar(max),density varchar(max))

select * from Locations

--- Next step - close your locations csv, then we'll write a query to fetch the data from your local path

--path: "C:\Users\STANLEY\Downloads\locations.csv"   (Windows 11)
--Path:  C:\Users\STANLEY\Downloads\locations.csv   (Lower Version than Windows 11)

---- Bulk insert query

BUlk insert locations
from /*path*/ 'C:\Users\STANLEY\Downloads\locations.csv'
with 
	(Fieldterminator=',' ,
						Rowterminator='\n',
											firstrow=2, maxerrors=20)

--- do the similar steps for all tables

-- mysql query-- show variables like 'secure_file_prev';


create table st_veh
(vehicle_id varchar(max),vehicle_type varchar(max),make_id varchar(max),model_year varchar(max),vehicle_desc varchar(max),
color varchar(max),date_stolen varchar(max),location_id varchar(max))


								
BUlk insert st_veh
from /*path*/ 'C:\Users\STANLEY\Downloads\stolen_vehicles.csv'
with 
	(Fieldterminator=',' ,
						Rowterminator='\n',
											firstrow=2, maxerrors=20)

--make details

create table make_d
(make_id varchar(max),make_name varchar(max),make_type varchar(max))

								
BUlk insert make_d
from /*path*/ 'C:\Users\STANLEY\Downloads\make_details.csv'
with 
	(Fieldterminator=',' ,
						Rowterminator='\n',
											firstrow=2, maxerrors=20)





select * from st_veh
select * from make_d
select * from locations


select Column_name, Data_type from
Information_schema.columns
where Table_name='St_veh'
SELECT *
FROM st_veh

--- we need to plan for Data validation--
--vehicle_id- int
--make_id - int
--date_stolen-- date
--location_id- int

--- Alter

alter table st_veh
alter column vehicle_id int

alter table st_veh
alter column make_id int

alter table st_veh
alter column date_stolen date

---- Date_stolen column requires the cleaning, one or multiple date values in this column might not following the date format (YYYY-MM-DD)


alter table st_veh
alter column location_id int


---- Locations-


SELECT *
FROM st_veh
SELECT *
FROM make_d
SELECT *
FROM locations

--Location_id, Population, density

alter table locations
alter column location_id int


alter table locations
alter column population int

alter table locations
alter column density float


-- make_d

alter table make_d
alter column make_id int

---

SELECT date_stolen,
	   TRY_CONVERT(DATE, date_stolen) AS formatted_date
FROM st_veh
where TRY_CONVERT(DATE, date_stolen) is null

---
SELECT date_stolen,
	   CONVERT(DATE, date_stolen) AS formatted_date
FROM st_veh
WHERE CONVERT(DATE, date_stolen) IS NULL


--- We've got two date values which are following the date format
---2021/15/10, 13-02-2022

-- Sunday 8th Sept 2024-- date?
-- 08-Sept-2024 ??
-- September, Sunday 8th 2024 ?

--- YYYY-MM-DD , this is a date for SQL

select Convert(Varchar(40), getdate(), /*style no-optional*/)
select getdate()


--Update those date values

Update st_veh set date_stolen= case when date_stolen= '2021/15/10' then '2021-10-15'
									when date_stolen='13-02-2022' then '2022-02-13'
									else date_stolen end


--- select, order by, from, join, top(limit), group by , aggregation, having,where
--- select, top,from,join, aggre,where,group by,having,order by

--- execution order
--from,join,where,agg group by,having,select,order by,limit(top)

select * from St_veh
select distinct model_year from st_veh

select min(model_year) , max(model_year) from st_veh

--- segment, vintage- 1940-1960, oldest_model- >1960 and 2000, mid_range_model- 2001 to 2017 , latest- >2017
select *, case when model_year between 1940 and 1960 then 'Vintage'
				when model_year between 1961 and 2000 then 'Oldest_model'
				when model_year between 2001 and 2017 then 'mid_range_model'
				else 'latest_model' end as 'Vehicle_segment' from St_veh

alter table st_veh
alter column date_stolen date

select Column_name, Data_type
from Information_schema.columns
where table_name='St_veh'


--- Next_step-- 

select * from st_veh
where isdate(date_stolen)=0


select * from St_veh

---- Check the stolen_vehicle pattern according to vehicle_type ,color

--safemode off in mysql
--set sql_safe_updates=0


select vehicle_type,COUNT(vehicle_id) as 'No_ofveh_stln',
case when model_year between 1940 and 1960 then 'Vintage'
				when model_year between 1961 and 2000 then 'Oldest_model'
				when model_year between 2001 and 2017 then 'mid_range_model'
				else 'latest_model' end as 'vehicle_seg'
 from st_veh
where Vehicle_type is not null
group by vehicle_type,case when model_year between 1940 and 1960 then 'Vintage'
				when model_year between 1961 and 2000 then 'Oldest_model'
				when model_year between 2001 and 2017 then 'mid_range_model'
				else 'latest_model' end 

---- Assignments here,, create more stolen vehicle profile, create on question for this db.

create table product
(pid int, pdesc varchar(30), price int)

create table stock
(pid int, st_in_hand int)

alter table product
--alter column pid int not null
add constraint p001 primary key(PID)

alter table stock
add constraint fr01 foreign key (pid) references product(PID)
on delete cascade
on update cascade

insert into product
values(1,'TV',45000),(2,'Laptop',76000),(3,'Speaker',15000),(4,'webcam',4000)

insert into stock
values(1,40),(2,43),(3,50),(4,60)

delete from product
where PID=4

select * from product

select * from Stock

update product set pid=4
where pid=2

select Distinct Model_year from st_veh


select COUNT(vehicle_id), color from stolen_vehicles
group by color

-----



---- Continue with the stolen_vehicles_Db---

use St_vehicles

select * from 

create table testing
(id int, dates varchar(40))


insert into testing
VALUES(1, '14 Sep 2024'), (2,'2024-01-13')

select * from testing
where isdate(dates)=1   --- the date is true

SELECT *
FROM testing
WHERE ISDATE(dates) = 0  --- the date is non date format

select * , convert(date,dates,23) from testing


select convert(varchar(40),getdate(),106) 

--- YYYY=MM-DD

alter table testing
alter column dates date



---- 

Select * from st_veh

select * from locations
select * from make_d

---- create the stolen_vehcile profile region wise

select region, m.make_type, Count(Vehicle_id) as 'No_of_veh_stl'
from Locations l
join st_veh st
on l.location_id=st.location_id
join make_d m
on m.make_id=st.make_id
group by region,m.make_type
order by no_of_veh_stl desc


---- we need to find the increasing trend of vehicles stolen as per the location

--- Analyze the locations where trend is increasing

select datediff(month, min(date_stolen),max(date_stolen)) from st_veh

-- informations will be coming from two tables
-- st_veh, locations
--- region, vehcile_id, 

---- we do the profiling with the CTE ( with clause)

select * from st_veh


---- CTE-- with clause--- it is a subquery refactoring ,, it creates a temp table expression for the session only.. 

with CTE as (Select model_year, count(vehicle_id) as 'No_of_veh' from st_veh group by model_year)

select Model_year, sum(No_of_veh) as 'Total_veh' from CTE 
group by model_year


SELECT model_year,
	   COUNT(vehicle_id) AS 'No_of_veh'
FROM st_veh
where no_of_veh>5
GROUP BY model_year


select * from St_veh

with Yearly_theft as ( Select st.location_id, region, Month(date_stolen) as 'theftmonth', Count(vehicle_id) as 'No_of_veh_Stl'
from st_veh st
join locations l
on st.location_id=l.location_id
group by st.location_id, l.region,month(date_stolen)
), 

--- another CTE in the same expression-- so no need to write the with syntax again , only place a comma and write the expression name
theft_pr as ( select location_id, region,theftmonth,no_of_veh_stl as mnthly_th_cnt, 
			LEAD(
			
			
---- Note-- LEAD() and LAG() provides the  

--- NTILE(), LEAD, LAG, Windows aggregation (Sum), Avg()

select * from Yearly_theft


use lb14thjuly

select * from emp_sal

--- total_sal 
select * from emp_sal
select Dept,sum(salary) from emp_sal
group by dept

--- find the cumalative salaries or running total of salaries

With Run_total as (select *, sum(salary) over (partition by dept order by Eid ) as 'Run_total' from emp_Sal),

salary_ranking as(

select *, row_number() over(partition by dept order by salary desc ) as 'row_num'  from run_total)

select * from salary_ranking
where row_num=1

--- LAG() -- it gives the previous row value in a new column, so that we can compare the data with the previous data
---- LEAD()- it gives the next row value in a new column

use lb15thjuly

select * from sales_v

select *, LAG(S_value) over (order by id) as 'Prev_val' from sales_v

--- find out the sales_performance with the previous from current sales

select *, LAG(S_value) over (order by id) as 'Prev_val' ,S_value-LAG(S_value) over (order by id) as 'Diff_val',
 LEAD(S_value,2) over (order by id) as 'next_val' 
from sales_v


with Yearly_theft as ( Select st.location_id, region, datename(Month,date_stolen) as 'theftmonth', Count(vehicle_id) as 'No_of_veh_Stl'
from st_veh st
join locations l
on st.location_id=l.location_id
group by st.location_id, l.region,Datename(Month,date_stolen)
), 

--- another CTE in the same expression-- so no need to write the with syntax again , only place a comma and write the expression name
theft_pr as ( select yt.location_id, yt.region,yt.theftmonth,yt.no_of_veh_stl as mnthly_th_cnt, 
			LEAD(yt.no_of_veh_stl) over (partition by yt.location_id order by yt.theftmonth) as 'next_month_theft'
			from yearly_theft yt)
			
select * from theft_pr
where mnthly_th_cnt<next_month_theft


--write the interpretation of this output, and check if more detailing is required (like the  calculation with yearly, quarter ,etc)


---- Year, Month, Qtr, weekday, day, hour, min,seco, mill, microsec

select datepart(quarter,getdate())

select quarter(getdate())


---- Find out the vehicle_type most stolen in High population area/region

select * from locations

select min(population), avg(population),max(population) from locations

---- low_po-- <200000
--- mid_pop between 200000 and 1000000
---- high_pop-- >1000000

select *, case when population <200000 then 'low_pop'
				when population between 200000 and 1000000 then 'mid_pop'
				else 'High_pop' end as population_cluster
from locations
order by population desc


--- considered the high populated region is >500000
select vehicle_type, count(vehicle_id) as Theft_count
from st_veh st
join locations L 
on st.location_id=l.location_id
where l.population>500000
group by vehicle_type
order by theft_count Desc

select distinct vehicle_type from st_veh

select * from st_veh

select make_type, count(vehicle_id) as 'total_cnt' from make_d m
join st_veh st
on m.make_id=st.make_id
group by make_type



--- check the output and try to interpret, if required more detailing then try to gather what are the other information you wants to add.

select * from emp_sal


With Run_total as (select *, sum(salary) over (partition by dept order by Eid ) as 'Run_total' from emp_Sal),

salary_ranking as(

select *, row_number() over(partition by dept order by salary desc ) as 'row_num'  from run_total)

select top 10 *, sum(salary) over (order by eid) as 'orig_order' from emp_sal---
select top 10 *, sum(salary) over (order by salary desc) as 'sal_order' from emp_sal

where row_num=1

--- Company wants to find when there was 10 people joined what was the total salary
---- find out the top 10 salaried employees and what will be the total cost to the company

With Run_total as (select *, sum(salary) over (partition by dept order by Eid ) as 'Run_total' from emp_Sal),
salary_ranking as(

select *, row_number() over( order by Run_total ) as 'row_num'  from run_total)

select * from salary_ranking
where dept='Admin'

---- Continues
with Yearly_theft as ( Select st.location_id, region,YEAR(DATE_STOLEN) AS 'tYEAR', Month(date_stolen) as 'theftmonth', Count(vehicle_id) as 'No_of_veh_Stl'
from st_veh st
join locations l
on st.location_id=l.location_id
group by st.location_id, l.region,Month(date_stolen),YEAR(DATE_STOLEN) 
), 

theft_pr as ( select yt.location_id, yt.region,TYEAR,yt.theftmonth,yt.no_of_veh_stl as mnthly_th_cnt, 
			LEAD(yt.no_of_veh_stl) over (partition by yt.location_id order by yt.tYEAR) as 'next_month_theft'
			from yearly_theft yt)
			
select * from theft_pr
where mnthly_th_cnt<next_month_theft

with Yearly_theft as ( Select st.location_id, region,YEAR(DATE_STOLEN) AS 'tYEAR', Month(date_stolen) as 'theftmonth', Count(vehicle_id) as 'No_of_veh_Stl'
from st_veh st
join locations l
on st.location_id=l.location_id
group by st.location_id, l.region,Month(date_stolen),YEAR(DATE_STOLEN) 
), 

theft_pr as ( select yt.location_id, yt.region,TYEAR,yt.theftmonth,yt.no_of_veh_stl as mnthly_th_cnt, 
			LEAD(yt.no_of_veh_stl) over (partition by yt.location_id order by yt.tYEAR) as 'next_month_theft'
			from yearly_theft yt)
			
select * from theft_pr



---- mehak

with Yearly_theft as ( Select st.location_id, region, datename(month,date_stolen) as 'theftmonth',datename(year, date_stolen) as 'theft_year', Count(vehicle_id) as 'No_of_veh_Stl'from st_veh stjoin locations lon st.location_id=l.location_idgroup by st.location_id, l.region,datename(Month,date_stolen), Datename(year,date_stolen)),theft_per as (select yt.location_id, yt.region, yt.theftmonth, yt.theft_year,yt.No_of_veh_Stl as 'monthly_theft_cnt',			LEAD(yt.No_of_veh_Stl) over (partition by yt.location_id order by LOCATION_ID) as  'next_month_theft'			from Yearly_theft as yt)select * from theft_perwhere monthly_theft_cnt < next_month_theft AND REGION='nORTHLAND'
order by location_id,theftmonth


----

/* 101	Northland	2021	10	25	32
101	Northland	2021	11	32	33
101	Northland	2021	12	33	38
101	Northland	2022	1	38	37
101	Northland	2022	2	37	57
101	Northland	2022	3	57	12
101	Northland	2022	4	12	NULL*/

---
/* 101	Northland	2021	10	25	32
101	Northland	2021	11	32	33
101	Northland	2021	12	33	38
101	Northland	2022	2	37	57*/


---- The crime dept, wants to anlyse the weekend and weekdays stolen_vehicles profile..

--- if you wants to anlyse the profile, what are the matrix you wants to shows as profile.


select * from st_veh
select distinct model_year from st_veh -- 63
SELECT DISTINCT REGION FROM LOCATIONS  --16

select distinct color from st_veh  -- 15 color types

select distinct vehicle_type from st_veh   -- 25 types

select distinct make_name from make_d    -- 138 types

select distinct make_type from make_d   -- 2 types

With St_veh_prof as (select st.vehicle_id, make_type, make_name, vehicle_type, st.make_id, model_year, vehicle_desc,color, date_stolen, st.location_id, region,population,density
from st_veh st 
join make_d m
on st.make_id=m.make_id
join locations L 
on st.location_id=l.location_id
where vehicle_type is not null)

select region, count(vehicle_id) as 'no_ofstvhl', 
													count(distinct make_name) as 'make',
													Count(distinct color) as 'V_color'
													,count(model_year) as 'M_year',
													avg(CAST(population AS FLOAT)) as 'avg_pop'
													,avg(CAST(density AS FLOAT)) as 'avg_density'
 from st_veh_prof
 group by region
 order  by region 

----

SELECT 1634 + 443 +660  --- 2737

SELECT COUNT(VEHICLE_ID) FROM ST_VEH  -- 4553

SELECT (2737 *100.0)/4553    --- 60% OF VEH STOLEN ARE FROM THREE REGION

--- 40 % OF VEH STOLEN FROM OTHER 13 REGION

---- 
with st_type as (Select Vehicle_type, model_year ,Count(case when vehicle_type='Saloon' then vehicle_id end) 'veh_stolen_num'

 from St_veh
 where vehicle_type='saloon'

 Group by Vehicle_type, model_year)

 select sum(veh_stolen_num) as 'total_veh' from st_type

--- 

Select model_year ,l.region,Count(case when vehicle_type='Saloon' then 1 end) 'saloon',
Count(case when vehicle_type like '%Trailer%' then 1 end) 'Trailer'
,Count(case when vehicle_type='mobile-Home' then 1 end) 'mobile_home'
,Count(case when vehicle_type='Mobile machine' then 1 end) 'mobile-machine'
,Count(case when vehicle_type='Moped' then 1 end) 'Moped'
,Count(case when vehicle_type='Light van' then 1 end) 'Light van'
,Count(case when vehicle_type='Light bus' then 1 end) 'light bus'
,Count(case when vehicle_type='Hatchback' then 1 end) 'Hatchback'
,Count(case when vehicle_type='Convertible' then 1 end) 'Convertible'
,Count(case when vehicle_type='Caravan' then 1 end) 'caravan'
,Count(case when vehicle_type='Articulated Truck' then 1 end) 'Articulated Truck'
,Count(case when vehicle_type='All Terrain Vehicle' then 1 end) 'All Terrain Vehicle'
,Count(case when vehicle_type='stationwagon' then 1 end) 'stationwagon'


 from St_veh
 join locations L 
 on st_veh.location_id=l.location_id
 where vehicle_type is not null

 Group by model_year,region

 ---we need to get the details of all vehicle type counts as per the model_year in the segregate columns

 select Distinct vehicle_type from st_veh


 -----    weekdays profile

 select *, datename(weekday, date_stolen) as 'Dayname' 
 from St_veh
 where datename(weekday, date_stolen) not in ('Sunday','Saturday')
 --- 3380 rows we are getting--


 --- weekend
  select *, datename(weekday, date_stolen) as 'Dayname' 
 from St_veh
 where datename(weekday, date_stolen) in ('Sunday','Saturday')

 --- 1173 rows we are getting

 with weekday_matrix as (Select datename(weekday,date_stolen) as 'Day_name', Count(vehicle_id) as 'veh_cnt',
  rank() over(order by count(vehicle_id) desc) as 'Top_rank'
, rank() over (order by count(vehicle_id)) as 'Bottom_rank'		
from st_veh
group by datename(weekday,date_stolen))

select day_name,veh_cnt, case when top_rank<=3 then 'Top' +cast(Top_rank as varchar(30))
						when bottom_rank<=3 then 'Bottom' +cast(Bottom_rank as varchar(30))
						Else 'NA'
						End as 'Ranking'
						from weekday_matrix
						order by case when Top_rank<=3 then top_rank
						when bottom_rank<=3 then (bottom_rank +3)
						Else
						 4
						 End
							
-- 
