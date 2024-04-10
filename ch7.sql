-- ch7
use pokemon;
select * from mypokemon;
drop database if exists pokemon;
create database pokemon;
use pokemon;
create table mypokemon(
	number int,
    name varchar(20),
    type varchar(20),
    attack int,
    defense int
    );
    
insert into mypokemon(number,name,type,attack,defense)
values  (10, 'caterpie', 'bug', 30, 35), 
(25, 'pikachu', 'electric', 55, 40), 
(26, 'raichu', 'electric', 90, 55), 
(125, 'electabuzz', 'electric', 83, 57), 
(133, 'eevee', 'normal', 55, 50), 
(137, 'porygon', 'normal', 60, 70), 
(152, 'chikoirita', 'grass', 49, 65), 
(153, 'bayleef', 'grass', 62, 80), 
(172, 'pichu', 'electric', 40, 15), 
(470, 'leafeon', 'grass', 110, 130);

show tables;

# p1
select name, if(attack>= 60, "strong","weak") as attack_class
from mypokemon;

#p2
select name ,ifnull(name,"unknown") as full_name
from mypokemon;

#p3
select name,
case
	when attack >= 100 then "very strong!"
    when attack >= 60 then "strong"
    else "weak"
end 
as attack_class
from mypokemon;
select * from mypokemon;

select name,
case
	when defense >= 100 then "방어력이 매우 높다"
    when defense >= 70 then "강한편이다"
    else "약하다"
end
as denfense_class
from mypokemon;

#p4
select name, type,
case type
	when 'bug' then 'grass'
    when 'electric' then 'water'
    when 'grass' then 'bug'
end 
as rival_type
from mypokemon;

# 함수 만들기 function
# 함수 function
SET GLOBAL log_bin_trust_function_creators = 1;
# 8.0.36이 불안정해서 권한을 줘야함 

DELIMITER //
create function get_ability(attack int, defense int)
	returns int
BEGIN
	declare a int;
    declare b int;
    declare ability int;
    
    set a = attack;
    set b = defense;
    select a + b into ability;
    return ability;
END
//
DELIMITER ;

select get_ability(100,150);
select get_ability(50, 50);

# declare : 변수 선언
# set : 변수 할당 
---------------------- 
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //
create function get_ability_function (attack int,defense int)
	returns int
BEGIN
	declare ability int;
    
    set ability = attack + defense;
    return ability;
END
//
DELIMITER ;

select get_ability_function(50, 150);
----------------------
# q1
drop function if exists isStrong;

SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER //
create function isStrong (attack int , defense int)
	returns varchar(20)
BEGIN
	-- declare : 변수선언 
	declare power int;
    declare result varchar(20);
    -- set : 변수 할당
    set power = attack + defense;
    
    case
    -- 그래서 result 에 값을 할당할때마다 set 을 써준거임
		when power >= 120 then set result = "very strong";
        when power >= 90 then  set result = "strong";
        else set result = "not strong";
	end case;
    return result;
END
//
DELIMITER ;

select isStrong(45,145);
----------------------------
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER //
create function isStrong2(attack int, defense int)
	returns varchar(20)
BEGIN
	declare result varchar(20);
    if attack + defense > 120 then
		set result = 'very strong';
	elseif attack + defense > 90 then
		set result = 'strong';
	else
		set result = 'not strong';
	end if;
    return result;
END//
DELIMITER ;

select isStrong2(45,145);
---------------------------
select * from mypokemon;
# p1 
select name,if(number< 150, "old","new") as age
from mypokemon;

# p2
select name, if(attack+defense < 100 ,"weak","strong") as ability
from mypokemon;

# p3 틀림
# 타입별, 그룹별, 평균 -> 그룹바이
select type, if(avg(attack)>=60,True,False) as is_strong_type
from mypokemon
group by type;

#p4
select name,if( attack > 100 and defense>100 , 1,0) as ace
from mypokemon;

#p5
select name,
case 
	when number < 100 then "<100"
	when number < 200 then "<200"
    when number < 500 then "<500"
end as number_bin
from mypokemon;

#6 
select name,
case 
	when attack>= 50 and number>= 150 then "new_strong"
    when attack>= 50 and number< 150 then "old_strong"
    when attack< 50 and number >= 150 then "new_weak"
    else "old_weak"
end as age_attack
from mypokemon;

#7 헷갈림 조건이 무엇이 먼져 들어갈지 생각해보기 
select type,
case 
	when count(type) = 1 then "solo" # 맨 처음을 1인 조건으로 
    when count(type) < 3 then "minor" #1이아닌것중에 3보다 작은거 
    else "major" # 3이상인수 
end as count_by_type
from mypokemon
group by type;

