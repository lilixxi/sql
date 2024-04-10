-- ch9
-- DROP DATABASE IF EXISTS pokemon;
-- CREATE DATABASE pokemon;
USE pokemon;
Drop table if exists mypokemon;
CREATE TABLE mypokemon (
number  int,
name varchar(20),
type varchar(10),
attack int,
defense int
);
CREATE TABLE friendpokemon (
number  int,
name varchar(20),
type varchar(10),
attack int,
defense int
);
INSERT INTO mypokemon (number, name, type, attack, defense)
VALUES (10, 'caterpie', 'bug', 30, 35),
(25, 'pikachu', 'electric', 55, 40),
(26, 'raichu', 'electric', 90, 55),
(133, 'eevee', 'normal', 55, 50),
(152, 'chikoirita', 'grass', 49, 65);
INSERT INTO friendpokemon (number, name, type, attack, defense)
VALUES (26, 'raichu', 'electric', 80, 60),
(125, 'electabuzz', 'electric', 83, 57),
(137, 'porygon', 'normal', 60, 70),
(153, 'bayleef', 'grass', 62, 80),
(172, 'pichu', 'electric', 40, 15),
(470, 'leafeon', 'grass', 110, 130);

# union 중복제외 
# a , b 의 쿼리의 개수가 같아야 한다 
select name 
from mypokemon

union

select name
from friendpokemon;

# union all 중복 포함 
select name 
from mypokemon

union all

select name
from friendpokemon;

#order by : 맨 마지막에 써준다, 첫쿼리의 변수를 가져와 사용 
select name ,number, attack
from mypokemon

union all

select name ,number, attack # 둘다 같은 select 를 가져와야한다 
from friendpokemon
order by number;

# 교집합 intersection 특정 함수가 없어서.. 이렇게
select A.name # from 에서 지정해준 별칭을 select 에서도 사용 가능
from mypokemon as A
inner join friendpokemon as B
# 모든 변수들이 동일해야한다 
on A.number = B.number 
and A.name = B.name
and A.type = B.type
and A.attack = B.attack
and A.defense = B.defense;

# 교집합 아님
select A.name
from  mypokemon as A
inner join friendpokemon as B
on A.name = B.name;

# 차집합 아님
select A.name
from mypokemon as A
left join friendpokemon as B
on A.name = B.name # select 에 있어야함
where B.name is null; # 그 중에서 B에 없는 값 == 차집합

select A.name
from mypokemon as A
left join friendpokemon as B
on A.number = B.number
and A.name = B.name
and A.type = B.type
and A.attack = B.attack
and A.defense = B.defense
where  B.name is null; # select 에서 name 만 가져오니까 거기서 name 이 B에 없는것 (차집합)

# 실습
# 1
select type
from mypokemon
union
select type
from friendpokemon;

#2
select number, name
from mypokemon
where type = "grass"
union all
select number, name
from friendpokemon
where type = "grass";

# 실습2
#1 
select A.name 
from mypokemon as A
inner join friendpokemon as B
on A.name = B.name;

#2
select A.name
from mypokemon as A
left join friendpokemon as B
on A.name = B.name
where  B.name is null;
