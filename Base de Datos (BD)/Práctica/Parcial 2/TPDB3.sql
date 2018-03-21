1)

select A.au_lname,A.au_fname,T.title from authors A
	inner join titleauthor TA
		on A.au_id = TA.au_id
	inner join titles T
		on T.title_id = TA.title_id
	order by au_lname

2)

select P.pub_name,E.fname,E.lname/*,E.job_lvl*/ from publishers P
	inner join employee E
		on P.pub_id = E.pub_id
	where E.job_lvl >= 200

3)

select A.au_lname,A.au_fname,sum(T.price*S.qty) 'Ingresos' from authors A
	inner join titleauthor TA
		on A.au_id = TA.au_id
	inner join titles T
		on T.title_id = TA.title_id
	inner join sales S
		on T.title_id = S.title_id
	group by A.au_lname,A.au_fname
	order by 3 desc

4)

select type from titles
	group by type
	having avg(price) > 12

5)

select lname,fname from employee
	where hire_date = (select max(hire_date) from employee)

6)

Con 'inner join'

select P.pub_name from publishers P
	inner join titles T
		 on P.pub_id = T.pub_id
	where T.type = 'business'
	group by P.pub_name

Con 'in'

select P.pub_name from publishers P
	where P.pub_id in (select T.pub_id from titles T
				where type = 'business') 

7)

select title from titles
	where title_id not in (select title_id from sales
				where year(ord_date) = 1993 or year(ord_date) = 1994)
	order by title

8)

select T.title,P.pub_name,T.price from titles T
	inner join publishers P
		on T.pub_id = P.pub_id
	where T.price < (select avg(price) from titles TT
				inner join publishers PP
					on TT.pub_id = PP.pub_id
				where P.pub_id = PP.pub_id)
	order by P.pub_name desc


9)

select T.title, pub_name, price from publishers P
	inner join titles T
		on P.pub_id = T.pub_id
	where (T.price < (select avg(TT.price) from publishers PP
			inner join titles TT
				on PP.pub_id = TT.pub_id
			where (P.pub_id = PP.pub_id))
		or T.title_id in (select title_id from titles T
			where not exists (select * from titles TT
				inner join sales S
					on (TT.title_id = S.title_id 
						and T.title_id = TT.title_id))))
	order by pub_name desc

10)

select au_fname 'Nombre',au_lname 'Apellido', case contract
						when 0 then 'No'
						when 1 then 'Si'
						end '¿Posee contrato?' from authors
	where state = 'CA'

11)

A)

select lname, case 
		when job_lvl < 100 then 'Puntaje menor a 100'
		when job_lvl between 100 and 200 then 'Puntaje entre 100 y 200'
		when job_lvl > 200 then 'Puntaje mayor a 200'
	      end  'Nivel' 
		
		from employee
		order by job_lvl

B)

select lname, case 
		when job_lvl < 100 then 'Puntaje menor a 100'
		when job_lvl > 200 then 'Puntaje mayor a 200'
		else 'Puntaje entre 100 y 200'
	      end  'Nivel' 
		
		from employee
		order by job_lvl

12)

create view AutoresCalifornia
as
select A.au_lname, A.au_fname, A.phone, T.title, T.type, T.price from titles T
	inner join titleauthor TA
		on T.title_id = TA.title_id
	inner join authors A
		on TA.au_id = A.au_id
	where (A.state = 'CA')

13)

create view newmoon as
select * from titles
	where (pub_id = 0736)

select A.au_lname + ' ' + A.au_fname 'Nombre', T.title from newmoon T
	inner join titleauthor TA
		on T.title_id = TA.title_id
	inner join authors A
		on TA.au_id = A.au_id
