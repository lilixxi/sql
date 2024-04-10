-- CH6
use pokemon;
show tables;
select * from mypokemone;

# CRUD Delete (DML: 데이터 조작) 하나하나 조작 / (DDL:데이터 정의) drop 테이블이 아예 삭제됨 
drop database if exists pokemone;


# CRUD Create 
Create database pokemon;
use pokemon;
drop table if exists mypokemon;
Create table mypokemon(
        number int,
        name varchar(20),
        type varchar(20),
        height float,
        weight float
        );
insert into mypokemon(number,name,type,height,weight)        
VALUES (10, 'caterpie', 'bug', 0.3, 2.9),
	   (25, 'pikachu', 'electric', 0.4, 6),
	   (26, 'raichu', 'electric', 0.8, 30),
		(125, 'electabuzz', 'electric', 1.1, 30),
	   (133, 'eevee', 'normal', 0.3, 6.5),
		(137, 'porygon', 'normal', 0.8, 36.5),
	   (152, 'chikoirita', 'grass', 0.9, 6.4),
		(153, 'bayleef', 'grass', 1.2, 15.8),
		(172, 'pichu', 'electric', 0.3, 2),
		(470, 'leafeon', 'grass', 1, 25.5);


# p1
select type
from mypokemon
group by type;
# p2
select type,count(*),count(type),count(1),round(avg(height),2),max(weight)
from mypokemon
group by type;
# p3
select type,count(*),count(1),avg(height),max(weight)
from mypokemon
group by type
having count(1) >= 2;

select min(name),type,count(1),max(weight)
from mypokemon
where name like "%a%"
group by type;

select type,count(1),max(weight)
from mypokemon
where name like "%a%"
group by type
having max(height) > 1
order by 3;

select type,count(1),max(weight)
from mypokemon
group by type 
having max(height) >1
order by 3; #max(weight)

select type,count(1),max(weight)
from mypokemon
where name like "%a%"
group by type
having max(height) >1
order by 3;

# 문제
# 1 
Select type, avg(weight)
from mypokemon
where length(name) > 5
group by type
having avg(weight) >= 20 
order by 2;

#2
select type,min(height), max(height)
from mypokemon
where number < 200
group by type
having max(weight) > 10 and min(weight) >= 2 
order by 2,3 desc;

# 2 ans
select type,min(height), max(height)
from mypokemon
where number < 200
group by type
having max(weight) > 10 and min(weight) >= 2 
order by 2 desc,3 desc;

# select: 결과를 보고 싶을때
# where : 그룹화 전체 행을 필터링(조건지정)
# haivng : 그룹화 된 결과에 대한 조건 지정
#1 
select type, round(avg(height),2)
from mypokemon
group by type;

#2 
select type, round(avg(weight),2)
from mypokemon
group by type;

#3
select type, round(avg(height),2),round(avg(weight),2)
from mypokemon
group by type;

#4 avg => select , having 
select type
from mypokemon
group by type
having avg(height) >= 0.5; 
#그룹지으라는 말이 없는데 키의 평균값을 값으로 안내보내고 싶음
#하지만 평균이라는 값 자체를 구하려면
#전체에 대한 평균 혹은 그룹에 대한 평균 밖에 없는데
#전체에 대한 평균을 가져오는건 아무 의미 없고
# (왜냐 키가 0.5 이상인 포켓몬이 없음)
# 그러므로 문제에는 이야기 안해도 그룹으로 묶어주기 

#5 
select type
from mypokemon
group by type
having avg(weight) >= 20;

#6
select type, sum(number)
from mypokemon
group by type;

#7
select type,count(type)
from mypokemon
where height >= 0.5
group by type;

#8
select type, min(height)
from mypokemon
group by type;

#9
select type, max(weight)
from mypokemon
group by type;

#10
select type
from mypokemon
group by type
having min(height) > 0.5 and max(weight) < 30; # 다음 조건이 해빙절에
