1)

select title_id,title,type,price*0.8 from titles
	order by type,title

2)

select title_id,title,type,price*0.8 "Precio" from titles
	order by type,title

3)

select title_id,title,type,price*0.8 "Precio" from titles
	order by price desc

4)

select title_id,title,type,price*0.8 "Precio" from titles
	order by 4 desc

5)

select au_lname + ', ' + au_fname 'Listado de autores'
	from authors
	order by 1

6, 7)

select tittle_id + ' posee un valor de ' + convert(varchar(10),price)
	from titles

8)

exec sp_tables

9)

exec sp_columns @table_name = 'authors'

10)

select title, price from titles
	where (price <= 13)
	order by price

select title, price from titles
	where not (price > 13)
	order by price

11)

select lname, hire_date from employee
	where (hire_date between '01/01/1991' and '01/01/1992')

12)

select au_id, address, city from authors
	where au_id in ('172-32-1176','238-95-7766')

13)

select title_id, title from titles
	where (title like '%Computer%')

14)

select pub_name, city, state from publishers
	where (state is NULL)

15)

exec sp_columns @table_name = publishers

16)

select count(price) 'Cant. de precios', count(title_id) 'Cant. de títulos' from titles

17)

select count(distinct price) from titles

18)

select lname,fname from employee
	where (hire_date = (select max(hire_date) from employee))

19)

select sum(price*ytd_sales) from titles

20)

select count(stor_id) from sales
	where (month(ord_date) = 6)

21)

select * from sysobjects
	where (type in ('S','V','P','TR','K','FK'))
