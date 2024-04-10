-- ch8
use pokemon;
drop table if exists mypokemon;
create table mypokemon(
	number int,
    name varchar(20),
    type varchar(20)
    );
insert into mypokemon(number,name,type)
values (10,"caterpie","bug"),
		(25,"pikachu","electric"),
        (26,"raichu","electric"),
        (133,"eevee","normal"),
        (152,"chikorita","grass");

create table ability(
	number int,
    height float,
    weight float,
    attack int,
    defense int,
    speed int
    );
insert into ability(number,height,weight,attack,defense,speed)
VALUES (10, 0.3, 2.9, 30, 35, 45), 
		(25, 0.4, 6, 55, 40, 90), 
        (125, 1.1, 30, 83, 57, 105), 
        (133, 0.3, 6.5, 55, 50, 55), 
        (137, 0.8, 36.5, 60, 70, 40), 
        (152, 0.9, 6.4, 49, 65, 45), 
        (153, 1.2, 15.8, 62, 80, 60), 
        (172, 0.3, 2, 40, 15, 60), 
        (470, 1, 25.5, 110, 130, 95);



select * from mypokemon;
select * from ability;

# Join 
# inner / left / right / cross / 
# 1. inner join
select *
from mypokemon
inner join ability
on mypokemon.number = ability.number;

# 2. left join
select *
from mypokemon
left join ability
on mypokemon.number = ability.number;

# 3. right join
select *
from mypokemon
right join ability
on mypokemon.number = ability.number;

# 4. outer join = left join + (union) + right join
select *
from mypokemon
left join ability
on mypokemon.number = ability.number
union
select *
from mypokemon
right join ability
on mypokemon.number = ability.number;

# 5. cross join 
select *
from mypokemon
cross join ability;

# 6. self join (on x) -> inner join 으로 
select *
from mypokemon as t1
inner join mypokemon as t2
on t1.number = t2.number;


# practice !
# 1
select mypokemon.number,name,attack,defense
from mypokemon
left join ability
on mypokemon.number= ability.number;


select * from mypokemon;
select * from ability;

# 같은 이름을 가진 칼럼존재시 select 에서 어떤 테이블에서 합쳐진 컬럼을 가져올것인지 명시!
# ex) ability.name (ability table.column name)
#2
select ability.number,name
from ability
left join mypokemon # 주 테이블 
on ability.number = mypokemon.number;

drop table if exists ability;
create table ability(
	number int,
    height float,
    weight float,
    attack int,
    defense int,
    speed int
    );

INSERT INTO ability (number, height, weight, attack, defense, speed)
VALUES (10, 0.3, 2.9, 30, 35, 45),
(25, 0.4, 6, 55, 40, 90),
(125, 1.1, 30, 83, 57, 105),
(133, 0.3, 6.5, 55, 50, 55),
(137, 0.8, 36.5, 60, 70, 40),
(152, 0.9, 6.4, 49, 65, 45),
(153, 1.2, 15.8, 62, 80, 60),
(172, 0.3, 2, 40, 15, 60),
(470, 1, 25.5, 110, 130, 95);


# 실습2
# 1
select type, round(avg(height),2)
from mypokemon
left join ability
on mypokemon.number= ability.number
group by type;

# 2 ?? 결과 값 다름 
select type, round(avg(weight),2)
from mypokemon
left join ability
on mypokemon.number= ability.number
group by mypokemon.type;

# 3
select type , round(avg(height),2), round(avg(height),2)
from mypokemon
left join ability 
on mypokemon.number= ability.number
group by type;

#4 중요!! 어려움 
select mypokemon.number,name, attack,defense
from mypokemon
left join ability 
on mypokemon.number= ability.number
where mypokemon.number >= 100;

#5 
select mypokemon.name 
from mypokemon
left join ability 
on mypokemon.number= ability.number
order by attack+defense desc;

#6
select mypokemon.name
from mypokemon
left join ability 
on mypokemon.number= ability.number
group by name
having max(speed); # select 에 가져올꺼 아니니니까 having 으로??

#6 ans
select mypokemon.name
from mypokemon
left join ability 
on mypokemon.number= ability.number
order by speed desc
limit 1;

# 6 repeat
select name
from mypokemon
left join ability
on mypokemon.number= ability.number
order by speed desc #speed 순서 순으로 정렬한 후 
limit 1; # 맨처음 데이터만 가져오기
