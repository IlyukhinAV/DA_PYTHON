--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

-- Задание 1: Вывести name, class по кораблям, выпущенным после 1920
--
select name, class
from ships
where launched > 1920 


-- Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942
--
select name, class
from ships
where launched > 1920 and launched <= 1942

-- Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class
--
select class, count(*)
from ships
group by class 


-- Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes)
--
select class, country 
from classes
where bore >= 16

-- Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.
--
select ship
from Outcomes
where battle = 'North Atlantic' and result = 'sunk'


-- Задание 6: Вывести название (ship) последнего потопленного корабля
--
select ship
from Outcomes
join battles 
on Outcomes.battle  = battles.name
where result = 'sunk' and date = (select max(date) from Outcomes join battles on Outcomes.battle  = battles.name)
 

-- Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля
--
select name, class
from ships
where name in  (select ship
from Outcomes
join battles 
on Outcomes.battle  = battles.name
where result = 'sunk' and date = (select max(date) from Outcomes join battles on Outcomes.battle  = battles.name))




-- Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class
--where name in (select ship

select *
from ships
join classes
on ships.class = classes.class 
where bore >= 16 and name in (select ship from Outcomes where result = 'sunk')

-- Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class
--
select class
from classes
where country = 'USA'

-- Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class
select name, ships.class
from Ships
join Classes
on Ships.class = Classes.class
where Classes.country = 'USA'