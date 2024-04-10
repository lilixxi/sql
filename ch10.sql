-- ch10
# sub query 를 쓸수 있는 부분은?
# group by 제외하고 다 쓸수 있다
# (현실적으로는 select from where 에만 쓴다)
# sub query
# select  :  value 1
# from : table 1, 별명 필수 
# where : column 1 (결과값 여러개 가능) (%exists 제외)
# 배테컬
# where 컬럼 연산자 서브쿼리 

-- DROP DATABASE IF EXISTS pokemon;
-- CREATE DATABASE pokemon;
USE pokemon;
drop table if exists mypokemon;
drop table if exists ability;
CREATE TABLE mypokemon (
number  INT,
name VARCHAR(20)
);
INSERT INTO mypokemon (number, name)
VALUES (10, 'caterpie'),
(25, 'pikachu'),
(26, 'raichu'),
(133, 'eevee'),
(152, 'chikoirita');
CREATE TABLE ability (
number INT,
type VARCHAR(10),
height FLOAT,
weight FLOAT,
attack INT,
defense INT,
speed int
);
INSERT INTO ability (number, type, height, weight, attack, defense, speed)
VALUES (10, 'bug', 0.3, 2.9, 30, 35, 45),
(25, 'electric', 0.4, 6, 55, 40, 90),
(26, 'electric', 0.8, 30, 90, 55, 110),
(133, 'normal', 0.3, 6.5, 55, 50, 55),
(152, 'grass', 0.9, 6.4, 49, 65, 45);

# SELECT
select number,name, #컴마 후 서브쿼리 잊지말기 
	(select height 
	from ability
    where number = 25) as height
from mypokemon #여기까지만 하면 키가 0.4 인 (서브쿼리 결과) 모든 포켓몬을 가지고 옴
where name = "pikachu";# 피카츄를 가져오기 위한 조건 추가

# FROM
select number ,height_rank # 이 값자체가 없음 하지만 전체적으로 번호를 가져올거는 아님
from (select number, rank()over(order by height desc) as height_rank
		from ability) as A # ability 테이블에서 키순서대로 정렬한 순위와 번호가 있는 테이블을 가져옴
where height_rank = 3; #그 중에서 랭크가 3순위인것만 조건으로 가져옴

select number, rank()over(order by height desc) as height_rank from ability;
select number
from ability
where height < (select avg(height) from ability);

select number 
from ability
where attack < all(select attack from ability where type="electric");

select number
from ability
where exists(select number from ability where type="bug");

# 문제
# 1
# 힌트 = 최대값이 몸무게인경우 
# 직접적인 방법으로 최대값구하기
select number
from ability
;


# 간접적인 방법으로 최대값 구하기(등수중 1등)

select number 
from (select weight from ability 
where max(wei;
# max 를 하려면 select/having/where
# 결과 값으로 안받으니까 select x
# 특정 테이블을 만들어서 보려는 것도 아님 having x
# where 절에 조건으로 넣어준다 
# 서브쿼리에 넣음으로서  group by를 안해도 된다
#2
select number 
from ability
where speed < any(select attack from ability where type="electric");

#3
select name
from ability
where attack>defense;

#1 ?? 같은 조건을 두번 써야하나?
select height ,weight ,
	(select name from mypokemon where number = 133) as name
from ability
where number = 133;

select name from mypokemon where number = 133;

#2 ans 두번째로 빠른 포켓몬
select number, speed
from (select number, speed,rank()over(order by speed desc) as speed_rank from ability) as a
where  a.speed_rank = 2; #speed_rank 가 2


#3
#메인을 mypokemon 으로 -> 결과값이 name 이니까      
 # 서브쿼리로 만들어준 number 가 mypokemon 의 number 안에 있는지 확인!!    
 
 
SELECT defense FROM ability WHERE type="electric"; 
 
SELECT name
FROM mypokemon
WHERE number IN (
    SELECT number
    FROM ability
    WHERE defense > ALL (
        SELECT defense
        FROM ability
        WHERE type="electric"
    )
);

# extra
# auto_increment : 자동으로 숫자가 증가됩니다
drop table if exists capability;
show tables;
create table capability(
	number int auto_increment,
    name varchar(20),
    type varchar(20),
    attack int,
    defense int,
    speed int
);
    
# value 값에 number 을 넣어줄 필요가 없다!
insert into capability(name,tupe,attack,defense,speed)
values ('Pikachu', 'electric', 55, 40, 90),
	('Raichu', 'electric', 85, 50, 110),
	('Jolteon', 'electric', 65, 60, 130),
	('Zapdos', 'electric', 90, 85, 100),
	('Electabuzz', 'electric', 83, 57, 105),
	('Bulbasaur', 'grass', 49, 49, 45);
    
select *
from capability
wh