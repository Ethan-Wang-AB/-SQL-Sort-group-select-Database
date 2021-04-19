
set echo on
set linesize 132
set pagesize 66

-- Create Spool
spool c:/cprg250s/Queries.txt
--question 1
select customer_no "Customer Num",actual_date_returned-date_due "Days Delay"
from cp_rental 
where actual_date_returned>date_due
order by 1;

--question 2
COLUMN "Film Title" FORMAT A30
COLUMN actors FORMAT A22
COLUMN "Rating" FORMAT A20
select initcap(film_title) "Film Title",actors,star_rating "Rating"
from cp_title
where runtime<150 and length(star_rating)>3
order by star_rating,film_title;
CLEAR COLUMNS
--question 3
select store_number ,count(DVD_number) "# of DVDs"
from CP_DVD
group by store_number
order by store_number;

--question 4
select name,Area_code ||' '|| phone_number "Phone Number", film_title "Film",date_out, date_due
from cp_customer c join CP_RENTAL r on r.customer_no=c.customer_no
			     join CP_DVD d on d.DVD_number=r.DVD_number
				 join CP_TITLE t on t.Title_code=d.Title_code
where actual_date_returned is null;

--question 5
select name 
from CP_CUSTOMER
where customer_no not in (select customer_no from cp_rental)
order by name;

--question 6
select name, count(dvd_number)
from cp_customer join cp_rental using(customer_no)
group by name
having count(dvd_number) > (select avg(count(dvd_number))
							from cp_rental
							group by customer_no)
order by name;

--question 7
select category_description "Category",film_title "Film",count (dvd_number) "# of DVDs"
from cp_dvd d, cp_title t,cp_category c
where d.title_code=t.title_code and c.category_code=t.category_code
group by grouping sets(category_description,film_title,())
order by category_description,film_title;

spool off