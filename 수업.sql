-- CH2
SELECT 1+2,80-12,3*5,20/5,21%5;
# 숫자 -> 문자 CAST(칼럼명 AS 변환하려는타입) 
SELECT CAST(123 AS CHAR(5));
# 문자 -> 숫자 CONVERT(데이터타입, 칼럼명);
# 문자 -> 날짜 DATE_FORMAT(날짜,형식);
SELECT DATE_FORMAT(NOW(),'%y-%m-%d');
SELECT DATE_FORMAT(NOW(),'%Y-%M-%D-%I-%i-%S');
SHOW DATABASES;
CREATE DATABASE ENTER;
USE ENTER;
CREATE TABLE IDOL(
		이름 VARCHAR(20),
        나이 INT,
        소속 VARCHAR(50)
        );
        
ALTER TABLE IDOL RENAME DOL_I;
ALTER TABLE DOL_I ADD COLUMN 키 INT;
ALTER TABLE DOL_I 
CHANGE COLUMN 소속 소속그룹 VARCHAR(50);
DROP DATABASE ENER;
DROP TABLE DOL_I;
# 테이블 값만 지우기
TRUNCATE TABLE DOL_I;
DROP DATABASE IF EXISTS ENTER;
DROP TABLE IF EXISTS DOL_I;

INSERT INTO DOL_I (이름,나이,소속그룹,키)
VALUES ("JENNY",27,"BLACKPINK",160);

INSERT INTO DOL_I(이름,나이,소속그룹,키)
VALUES ("JISOO",28,"BLACKPINK",162),
		("ROSE",25,"BLACKPINK",167);

SELECT * FROM DOL_I;

DELETE FROM DOL_I
WHERE 나이 = 25;

SELECT * FROM DOL_I;

UPDATE DOL_I
SET 이름 = "지수"
WHERE 이름 = "JISOO";

-----------------
-- CH3
SELECT 123;
SELECT 1+2+3;
SELECT "ABC";

# LIMIT : 가져올 데이터의 로우 수 를 지정 
SELECT NUMBER,NAME 
FROM POKEMONE.MYPOKEMONE
LIMIT 2;

# DISTINCT : 중복된 데이터를 제외하고 같은 값은 한번만 가져오는 키워드
SELECT DISTINCT TYPE
FROM MYPOKEMONE;

# 1= TRUE 0 = FALSE
SELECT 1 = 1;
SELECT 0 = 1;

SELECT NUMBER
FROM MYPOKEMONE
WHERE NAME = 'PIKACHU';

SELECT NAME
FROM MYPOKEMONE
WHERE SPEED > 50;

SELECT NAME 
FROM MYPOKEMONE
WHERE SPEED <= 100 AND TYPE = "ELECTRIC";

SELECT NAME
FROM MYPOKEMONE
WHERE TYPE = "BUG" OR TYPE =  "NORMAL";

SELECT NAME
FROM MYPOKEMONE
WHERE SPEED <= 100 AND NOT TYPE = "BUG";

SELECT NAME
FROM MYPOKEMONE
WHERE SPEED BETWEEN 50 AND 100;

SELECT NAME
FROM MYPOKEMONE
WHERE TYPE IN ("BUG","NORMAL");

SELECT NAME
FROM MYPOKEMONE
WHERE NAME LIKE "%CHU";

SELECT NAME
FROM MYPOKEMONE
WHERE NAME LIKE "%A%";

INSERT INTO MYPOKEMONE(NAME,TYPE)
VALUES ("KKOBUGI","");
# 빈값은 공백으로 처리되고
# 아예 언급도 안해준 값들 자동으로 널값이 됨
SELECT * FROM MYPOKEMONE;

SELECT NAME
FROM MYPOKEMONE
WHERE NUMBER IS NULL;

SELECT NAME 
FROM MYPOKEMONE
WHERE TYPE IS NOT NULL;

------------------------
-- CH5

# ORDER BY :  가져온 데이터를 정렬해주는 키워드 
# ASC 오름차순 (1->2->3) 기본 / DESC 내림차순 (5->4->3)

SELECT NUMBER, NAME
FROM MYPOKEMONE
ORDER BY NUMBER DESC;
SELECT * FROM MYPOKEMONE;
SELECT NUMBER, NAME,ATTACK, DEFENCE
FROM MYPOKEMONE
ORDER BY ATTACK DESC, DEFENCE;
# ATTACK 으로 정렬 후 같은 값은 디펜스로 정렬

# SELECT 의 순서를 번호로 해서 지정도 가능 
SELECT NUMBER, NAME,ATTACK, DEFENCE
FROM MYPOKEMONE
ORDER BY 3 DESC, 4;

# RANK : 데이터를 정렬해서 순위를 만들어 주는 함수 
# RANK()OVER (ORDER BY COL_NAME) 
# 항상 ORDER BY 와 함께 사용된다
# RANK : 공동순위가 있다면 다음순서로 건너뜀
# DENSE_RANK : 공동순위가 있어도 다음 순위를 뛰어넘지 않음
# ROW_NUMBER : 공동순위 무시(중복안함)

ALTER TABLE MYPOKEMONE
CHANGE COLUMN DEFENCE DEFENSE INT;

SELECT NAME, ATTACK, RANK()OVER (ORDER BY ATTACK DESC) AS ATTACK_RANK
FROM MYPOKEMONE;

SELECT NAME, ATTACK, DENSE_RANK()OVER (ORDER BY ATTACK DESC) AS ATTACK_RANK
FROM MYPOKEMONE;

SELECT NAME, ATTACK, ROW_NUMBER()OVER (ORDER BY ATTACK DESC) AS ATTACK_RANK
FROM MYPOKEMONE;

CREATE DATABASE BTS_MUSIC;
USE BTS_MUSIC;
CREATE TABLE BUTTER(
	PART INT,
	LYRIC VARCHAR(100)
);
INSERT INTO BUTTER(PART,LYRIC)
VALUES (1,'Smooth like butter'),
(2,'Like a criminal undercover'),
(3,"Gon' pop like trouble"),
(4,"Breakin' into your heart like that"),
(5,"Cool shade stunner");

SELECT * FROM BUTTER;

# 없으면 0 반환
SELECT LOCATE('u',LYRIC)
FROM BUTTER;

SELECT PART,SUBSTRING(LYRIC,3)
FROM BUTTER;

SELECT PART,RIGHT(LYRIC,3),LEFT(LYRIC,3)
FROM BUTTER;

SELECT PART,UPPER(LYRIC),LOWER(LYRIC)
FROM BUTTER;

SELECT PART,LENGTH(LYRIC)
FROM BUTTER;

SELECT PART, CONCAT(LEFT(LYRIC,1),RIGHT(LYRIC,1) ) AS FIRST_LAST
FROM BUTTER;

SELECT PART,REPLACE (LYRIC,' ','_')
FROM BUTTER;

USE POKEMONE;

ALTER TABLE MYPOKEMONE ADD COLUMN FRIENDSHIP  FLOAT;

UPDATE MYPOKEMONE 
SET FRIENDSHIP = CASE 
	WHEN NAME = "CATERPIE" THEN -1.455
    WHEN NAME = "PIKACHU" THEN 124.78
    WHEN NAME = "RAICHU" THEN 30.289
    WHEN NAME = "EEVEE" THEN 15.988
    WHEN NAME = "CHIKORITA" THEN 67.164
    END;

SELECT * FROM MYPOKEMONE;

SELECT NAME,FRIENDSHIP,ABS(FRIENDSHIP)
FROM MYPOKEMONE;

SELECT NAME, FRIENDSHIP, CEILING(FRIENDSHIP),FLOOR(FRIENDSHIP)
FROM MYPOKEMONE;

SELECT NAME, FRIENDSHIP, ROUND(FRIENDSHIP,1),TRUNCATE(FRIENDSHIP,0)
FROM MYPOKEMONE;

SELECT NAME,NUMBER,POWER(NUMBER,2)
FROM MYPOKEMONE;

SELECT NAME,NUMBER,MOD(NUMBER,2)
FROM MYPOKEMONE;

SELECT NOW(),CURRENT_DATE(),CURRENT_TIME();
SELECT NOW(),YEAR(NOW()),MONTH(NOW()),MONTHNAME(NOW());
SELECT NOW(),DAYNAME(NOW()),DAYOFMONTH(NOW()),WEEK(NOW());
SELECT NOW(),HOUR(NOW()),MINUTE(NOW()),SECOND(NOW());
SELECT DATE_FORMAT('1996-09-03',"%Y년 %m월 %d일 에 태어났습니다") AS FORMATTED_DATE;






--------------------------
--
-- CH4 




USE POKEMONE;
DROP TABLE  IF EXISTS MYPOKEMONE;
CREATE TABLE MYPOKEMONE(
	NUMBER INT,
    NAME VARCHAR(20),
    TYPE VARCHAR(20),
    HEIGHT FLOAT,
    WEIGHT FLOAT,
    ATTACK INT,
    DEFENCE INT,
    SPEED int
    );
 INSERT INTO MYPOKEMONE (NUMBER, NAME, TYPE, HEIGHT, WEIGHT, ATTACK, DEFENCE, SPEED)
 VALUES(10,'CATERPIE','BUG',0.3,2.9,30,35,45),
		(25,'PIKACHU','ELECTRIC',0.4,6,55,40,90),
        (26,'RAICHU','ELECTRIC',0.8,30,90,55,110),
        (133,'EEVEE','NORMAL',0.3,6.5,55,50,55),
        (152,'CHIKORITA','GRASS',0.9,6.4,49,65,45);


--------


