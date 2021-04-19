-- Part B 
set echo off
set verify off
set feedback off
set linesize 100
set pagesize 30

clear columns
clear breaks
clear computes
TTITLE CENTER 'Customer' SKIP -
CENTER 'Usage Report' SKIP 1
BTITLE off
BREAK ON name  SKIP 1 ON category_description ON report
COMPUTE count LABEL 'Ttl Rented' of date_out on name
COMPUTE count LABEL 'CPV Ttl' of date_out on report

COLUMN name format A22 HEADING 'Name'
COLUMN category_description format A12 HEADING 'Category'
COLUMN Film_title format A40 HEADING 'Title'
COLUMN date_out  format A15 HEADING 'Rented on'

spool c:\cprg250s\Report.txt
select name, category_description,Film_title,to_char(date_out,'DD-MON-YY') date_out
from cp_customer join cp_rental using(customer_no)
			     join cp_dvd using(dvd_number)
				 join cp_title using(title_code)
				 join cp_category using(category_code)
order by name;
spool off


