-- 1. Išrinkite visus aktorių vardus ir pavardes.

SELECT first_name, Last_name
FROM actor;

-- 2. Parašykite SQL užklausą, kuri ištrauktų visus stulpelius iš lentelės „actor“ , surūšiuotus pagal stulpelį „first_name“
-- mažėjimo tvarka.

SELECT * 
FROM actor
ORDER BY first_name;

-- 3. Viename stulpelyje pateikite aktorių vardus ir pavardes.

Select concat( first_name,' ',Last_name) AS vardas_pavarde_kartu
FROM actor; 

-- 4. Viename stulpelyje pateikite aktorių vardus ir pavardes mažosiomis raidėmis ir pavadinkite stulpelį
-- „Aktorių vardai“.

Select concat(lower(first_name),' ',lower(Last_name)) AS aktoriu_vardai
FROM actor; 

-- 5. Kurie aktorių vardai pasikartoja dažniausiai ir kiek kartų?

select distinct (first_name), count(first_name) AS pasikartoja_kartu
FROM actor
group by first_name
order by pasikartoja_kartu desc;


-- PO BRUKSNELIO 

-- 1 Išvesti iš lentelės film:
-- a. Vidutinę nuomos trukmę
-- b. Vidutinę nuomos kainą
-- c. Vidutinę filmo trukmę
-- d. Vidutinę pakeitimo kainą


SELECT ROUND(AVG(rental_duration) ,2) AS Vidutine_Nuomos_trukme ,ROUND(AVG(rental_rate) ,2) AS Vidutine_Nuomos_Kaina, ROUND(AVG(length) ,2) AS Vidutine_Filmo_Trukme, ROUND(AVG(replacement_cost) ,2) AS Vidutine_Pakeitimo_Kaina
FROM film;

-- 2 Bendrą visų filmų trukmę

SELECT SUM(length) AS Filmu_Trukmes_Suma
FROM film;

-- 3. Bendrą visų filmų nuomos laiką


SELECT SUM(rental_duration) AS Bendras_Filmu_Nuomos_Laikas
FROM film;

-- 4. Kokia trumpiausia nuomos trukmė?

SELECT MIN(rental_duration)
FROM film;

-- 5. Kokie filmai buvo išsinuomoti ilgiausiai, trumpiausiai, kiek jų buvo kiek vienoje grupėje?


-- BENDRAS 

SELECT title, rental_duration
FROM film
WHERE rental_duration = (SELECT MIN(rental_duration) FROM film)
OR rental_duration = (SELECT MAX(rental_duration) FROM film)
ORDER BY rental_duration DESC;

-- TRUMPIAUSIO LAIKO GRUPE

SELECT title, rental_duration
FROM film
WHERE rental_duration = (SELECT MIN(rental_duration) FROM film)
ORDER BY rental_duration DESC;

-- ILGIAUSIO LAIKO GRUPE

SELECT title, rental_duration
FROM film
WHERE rental_duration = (SELECT MAX(rental_duration) FROM film)
ORDER BY rental_duration DESC;

-- BENDRAS VIENOJE LENTELEJE

select (select count(film_id)
       from film
       where rental_duration = (select distinct (max(rental_duration))from film)) as 'isnuomoti ilgiausiai',
       (select count(film_id)
       from film
       where rental_duration = (select distinct (min(rental_duration)) from film)) as 'isnuomoti trumpiausiai';



-- 6. Kokie ir kiek filmų buvo išsinuomoti vidutiniam nuomos laikui?

(SELECT ROUND(avg(rental_duration) ,0)
FROM film);

SELECT film_id, title, rental_duration
FROM film
WHERE rental_duration =(SELECT ROUND(avg(rental_duration) ,0)
FROM film); 



-- 7. Kiek filmų aprašymuose buvo pavartotas žodis ’boring’?

SELECT title
FROM film
WHERE description like '%boring%';

-- 8. Kiek filmų buvo minimalios trukmės, vidutinės, maksimalioS?

(SELECT min(length)
from film);

select count(film_id) AS Triumpiausiu_Filmu_kiekis
from film
where length = (SELECT min(length)
from film);



SELECT count(rental_duration) AS Vidutinio_Ilgio_Filmu_Kiekis
FROM film
WHERE rental_duration =(SELECT ROUND(avg(rental_duration) ,0)
FROM film); 

select count(film_id) AS Triumpiausiu_Filmu_kiekis
from film
where length = (SELECT max(length)
from film);

select count(film_id) AS Triumpiausiu_Filmu_kiekis
from film
where length = (SELECT max(length)
from film);

(SELECT ROUND(avg(length) ,0)
FROM film);

select count(film_id) AS Vidutinio_Ilgio_Filmu_kiekis
from film
WHERE Length = (SELECT ROUND(avg(length) ,0)
FROM film);

-- GALUTINE 8


SELECT 
	(select count(film_id) AS Triumpiausiu_Filmu_kiekis
from film
where length = (SELECT min(length)
from film)) AS minimali_trukme, 
	(select count(film_id) AS Vidutinio_Ilgio_Filmu_kiekis
from film
WHERE length = (SELECT ROUND(avg(length) ,0)
FROM film)) AS vidutina_trukme, 
	(select count(film_id) AS Triumpiausiu_Filmu_kiekis
FROM film
WHERE length = (SELECT max(length)
FROM film)) AS ilgiausi_trukme
FROM film
LIMIT 1;


SELECT length, COUNT(*) AS 'Kikeis'
FROM film
WHERE length = (SELECT MAX(length) FROM film)
OR length = (SELECT MIN(length) FROM film)
OR length = (SELECT ROUND(AVG(length),0) FROM film)
GROUP BY length
ORDER BY length ASC;



-- 9. Suraskite, kiek vidutiniškai trukdavo filmai, priklausomai nuo reitingo.

SELECT rating, ROUND(avg(length) ,0)
FROM film
GROUP BY RATING; 

-- 10. Suraskite vidutinį nuomos laiką filmams pagal reitingą.


SELECT rating, ROUND(avg(rental_duration) ,2)
FROM film
GROUP BY RATING; 


-- 11.Suraskite vidutinę nuomos kainą filmams pagal reitingą.

SELECT rating, ROUND(avg(rental_rate) ,3)
FROM film
GROUP BY RATING; 

-- 12 12. Išvesti aktorių vardus, pavardes viename stulpelyje. Vardai turi būti mažosiomis raidėmis, pavardės
-- didžiosiomis.

Select concat(lower(first_name),' ',UPPER(Last_name)) AS aktoriu_vardai
FROM actor; 

-- 13. 13. Išvesti aktorių vardus, prasidedančius raidėmis ’A’, ’B’, ’E’. Suskaičiuoti, kiek vardų prasideda raidėmis ’D’,
-- ’E’, ’W’. PVZ., jog jei turime Dan, Ed, Wolf, tai atsakymas bus 3.

SELECT distinct first_name AS Vardai_Prasideda_ABE
FROM actor
WHERE first_name REGEXP "^[abe]"
ORDER BY first_name ASC;

SELECT distinct COUNT(*) AS vardai_Prasideda_DEW
FROM actor
WHERE first_name regexp '^[dew]';