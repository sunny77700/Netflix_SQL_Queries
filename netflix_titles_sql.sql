/* netflix data from keggle now we are doing some queries on this data */
/* NOTE - Dataset, we showcase example query on key 
SQL topics such as SQL Keywords,Data filtering, 
Joints, Unions, Aggregate functions, temp tables,Window 
functions etc.*/

/*Test the code by select the complete table*/
select * from netflix_titles;

/*Query-1 limit(5)*/
Select * from netflix_titles
limit 5

/*Query-2 select distinct*/
select distinct(show_id) from netflix_titles;

/* Query 3:- Select where ( selecting titles from netflix greater than relase_year2020)*/
select distinct(title) from netflix_titles
where release_year > 20

/* Query 4:- Select and,or,not*/
Select distinct(title) from netflix_titles
where release_year > 2020 and
title='Blood & Water' or release_year < 2021 
and title='Kota Factory'and not country= 'India'

/* Query 5:- order by */
select distinct(title) from netflix_titles 
order by title

/* Query 6:-  min, max,count,avg,sum*/
select 
min(release_year) as min_release_year,
max(release_year) as max_release_year,
count(release_year) as count_of_release_year,
round(avg(release_year),2) as avg_of_all_release_year,
sum(release_year) as sum_of_all_release_year
from netflix_titles

/* Query 7:- like*/
Select distinct 'country that Starts with ia :- '|| country as Value from netflix_titles
where country like 'A%'

/* Query 7:- in */
select * from netflix_titles
where country in ('india','united states','Australia')

/* Query 8:- between */
select * from netflix_titles
where release_year between 2020 and 2021

/* Query 9:- join */
select
n1.show_id as Show_idtable1,
n2.type as Show_idTable2,
n2.title as Showtable2
from netflix_titles n1
join netflix_titles n2 on n1.show_id = n2.show_id

/* Query 10:- Union */
select * from netflix_titles
where country = 'India'
union all
select * from netflix_titles
where country = 'Unites States'

/* Query 11:- case statement */
select sum(case when country='India' then 1 else 0 end) as shows_in_india ,
sum(case when country='United States' then 1 else 0 end) as shows_in_united_states ,
sum(case when country='South Africa' then 1 else 0 end) as shows_in_South_Africa 
from netflix_titles

/* Query 12:- subquery */
select count(release_year) from netflix_titles
where release_year = (select max(release_year) from netflix_titles)

/* Query 13:- coalesce */
/*Helps us to handle null values, it replaces the null 
values with the data we feed after the comma*/
select coalesce(release_year,2020) as first_non_zero_value from netflix_titles

/* Query 13:- convert */
select cast(release_year as float) as first_non_zero_value from netflix_titles

/* Query 14:- leg/lead */
select
title,
release_year,
case when release_year=lag(release_year) over (order by release_year asc) then 1 else 0 end as Back_to_Back
from netflix_titles
order by release_year asc

/* Query 15:- Dense rank */
select a.value from (
Select 
distinct ' country that End with ia :- '|| country as Value,
DENSE_RANK() OVER (ORDER BY country asc) as rank from netflix_titles
where country like'%ia'
)a
where rank=1

/* Query 16:- with */
with b as (
select 
a.country,
a.count_of_shows,
row_number () over (order by a.count_of_shows desc) as rank 
from
(
select 
count(distinct title) as count_of_shows,
country
from netflix_titles
group by country
) a
)
select country as country_most_shows from b
where  b.rank=1