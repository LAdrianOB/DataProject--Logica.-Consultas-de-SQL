/* 1. Crea el esquema de la BBDD */


/* 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’. */
 select "title", "rating"
 from "film"
 where "rating" = 'R';

/* 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40. */
select "first_name", "last_name", "actor_id"
from "actor"
where "actor_id" between 30 and 40;

/* 4. Obtén las películas cuyo idioma coincide con el idioma original. CORREGIDO*/
select "film_id"
from "film"
where "language_id" = "original_language_id" AND "original_language_id" IS NOT NULL;  

/* 5. Ordena las películas por duración de forma ascendente. */
select "film_id", "length"
from "film"
order by "length" asc;

/* 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido. */
select "first_name", "last_name"
from "actor"
where "last_name" ILIKE '%Allen%'; --utilizamos ilike, insensible a mayus. y %para decir que contiene

/* 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento. */
select "rating", count(distinct "film_id") as "cantidad_pelis"
from "film"
group by "rating"; 


/* 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film. */
SELECT "title", "rating", "length"
FROM "film"
where "rating" = 'PG-13' or "length" > 180; 

/* 9. Encuentra la variabilidad de lo que costaría reemplazar las películas. */
SELECT round(variance("replacement_cost"),2) as "variabilidad" --redondear para no tener tantos decimales
FROM "film";

/* 10. Encuentra la mayor y menor duración de una película de nuestra BBDD. */
SELECT MAX("length") as "mayor duracion", MIN("length") as "menor_duracion"
FROM "film"

/* 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día. */
SELECT p.amount, r.rental_date
FROM rental r
join payment p on r.rental_id = p.rental_id 
order by r.rental_date desc  --esta tabla es la que debe estar en el from
offset 2
limit 1; 

/* 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación. */
SELECT "title", "rating"
FROM "film"
where "rating" not in ('G','NC-17');

/* 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración. */
SELECT "rating", round(AVG("length"),2) as "promedio"
FROM "film"
group by "rating";

/* 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos. */
SELECT "title", "length"
FROM "film"
where "length" > 180 ;

/* 15. ¿Cuánto dinero ha generado en total la empresa? */
SELECT SUM("amount") as "beneficio_total"
FROM "payment"

/* 16. Muestra los 10 clientes con mayor valor de id. */
SELECT "first_name", "last_name", "customer_id"
from "customer"
order by "customer_id" desc 
limit 10;

/* 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’. CORREGIDO*/
SELECT a."first_name", a."last_name"
FROM "actor" a
join "film_actor" fa on a.actor_id = fa.actor_id
join "film" f on f.film_id = fa.film_id
where "title" ilike 'Egg Igby'; --volvemos a utilizar el ilike porque en la bbdd los nombres estan en mayus

/* 18. Selecciona todos los nombres de las películas únicos. */
SELECT distinct "title"
FROM "film";

/* 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”. */
SELECT f."title", c."name", f."length"
FROM "film" f
join "film_category" fc on f.film_id = fc.film_id
join "category" c on c.category_id = fc.category_id
where c."name" ilike '%comedy%' and f.length > 180; 

/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración. */
SELECT c.name as "categorias", round(avg(f.length),2) as "promedio"
FROM category c
join film_category fc on fc.category_id = c.category_id  
join "film" f on f.film_id = fc.film_id
group by c."name" --necesitamos algo por lo que agrupar el promedio calculado abajo  
having avg(f.length) > 110;  -- no podemos utilizar el where porque tenemos una funcion agregacion!

/* 21. ¿Cuál es la media de duración del alquiler de las películas? */
SELECT round(avg(extract(epoch from return_date - rental_date) / (60*60*24) ), 2) AS "media_duracion" --utilizamos extract para partes concretas de una fecha o intervalo tiempo, 
FROM rental                                                                                      --utilizamos epoch y no day porque day solo extraeria dias enteros pero no minutos 
WHERE return_date IS NOT NULL;                                                                                       --y segundos, es decir es mas exacto, porque extrae hasta segundos.

/* 22. Crea una columna con el nombre y apellidos de todos los actores y actrices. */
SELECT concat(first_name, ' ', last_name) as "Nombre_completo" --tenemos que poner el espacio manualmente
FROM "actor" ;

/* 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente. */
SELECT date(rental_date) as "fecha", count(rental_date) as "alquileres" --count con la columna por si hay nulos
FROM rental 
group by date(rental_date)
order by alquileres desc; 


/* 24. Encuentra las películas con una duración superior al promedio. */
SELECT title, length
FROM film
where length > 
	(select round(avg(length),2)
	from film);

/* 25. Averigua el número de alquileres registrados por mes. */
SELECT to_char(rental_date, 'YYYY-MM') as mes, count(rental_date) as alquileres --transformamos a cadena de texto en formato año y mes, año porque no sabemos si solo trabajamos con un año o varios
FROM rental 
group by mes
order by mes; --no está de más ordenar las fechas 

/* 26. Encuentra el promedio, la desviación estándar y varianza del total pagado. */
SELECT round(avg(amount), 2) as promedio, round(stddev(amount), 2) as desv_estandar, round(variance(amount),2) as varianza
FROM payment;

/* 27. ¿Qué películas se alquilan por encima del precio medio? */
SELECT title, rental_rate
FROM film 
where rental_rate > 
	(select avg(rental_rate) 
	 from film);

/* 28. Muestra el id de los actores que hayan participado en más de 40 películas. */
SELECT actor_id, count(distinct film_id ) 
from film_actor
group by actor_id
having count(distinct film_id ) > 40;


/* 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible. */
select f.title, count(i.inventory_id) as cantidad_disponible
FROM film f 
left join inventory i on i.film_id = f.film_id 
group by f.title
order by cantidad_disponible desc; --ordenamos por tener mejor visual.


/* 30. Obtener los actores y el número de películas en las que ha actuado. */
SELECT concat(a.first_name, ' ', a.last_name), count(f.film_id) as peliculas_hechas
FROM actor a 
join film_actor fa on fa.actor_id = a.actor_id
join film f on f.film_id = fa.film_id
group by a.actor_id, a.first_name, a.last_name --añadimos actor id ya que es el que seguro que no se repetirá, podemos tener nombres iguales. 


/* 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados. */
SELECT f.title, string_agg(concat(a.first_name, ' ', a.last_name), ', ') as actor
FROM film f
left join film_actor fa on fa.film_id = f.film_id
left join actor a on a.actor_id = fa.actor_id
group by f.title
order by f.title; --ordenamos para poder ver la misma peli con los diferentes actores, pero mejoramos y ponemos actores en una misma linea con string_agg

/* 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película. CORREGIDO */
SELECT concat(a.first_name, ' ', a.last_name) as actores, string_agg(f.title, ', ') as pelis
FROM actor a
left join film_actor fa on fa.actor_id = a.actor_id
left join film f  on f.film_id  = fa.film_id 
group by a.first_name, a.last_name
order by actores;

/* 33. Obtener todas las películas que tenemos y todos los registros de alquiler. */
SELECT f.title, r.rental_id, r.rental_date
FROM film f 
cross join rental r;

/* 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros. CORREGIDO */
SELECT concat(c.first_name, ' ', c.last_name) AS cliente, SUM(p.amount) AS gasto_total
FROM customer c
join payment p on p.customer_id = c.customer_id
group by c.first_name, c.last_name
order by gasto_total desc 
limit 5;

/* 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'. CORREGIDO*/
SELECT concat(first_name, ' ', last_name)
FROM actor
where first_name = 'Johnny' ;

/* 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido. */

SELECT table_name, column_name
FROM information_schema.columns
WHERE column_name IN ('first_name', 'last_name') --detectamos que tablas tienen esa columna para proceder a cambiar nombre a todas

SELECT 
  actor_id AS id,
  first_name AS "Nombre",
  last_name AS "Apellido"
 
FROM actor;


SELECT 
  customer_id AS id,
  first_name AS "Nombre",
  last_name AS "Apellido"
 
FROM customer;


SELECT 
  staff_id AS id,
  first_name AS "Nombre",
  last_name AS "Apellido"

FROM staff;

/* 37. Encuentra el ID del actor más bajo y más alto en la tabla actor. */

SELECT min("actor_id") as id_bajo, max("actor_id") as id_alto
FROM actor; --solo id's

SELECT actor_id, concat(first_name, ' ', last_name)
FROM actor
WHERE actor_id = (SELECT MIN(actor_id) FROM actor)
   OR actor_id = (SELECT MAX(actor_id) FROM actor); --id's + nombre // no utilizamos and ya que no hay un actor que sea max y min a la vez!

/* 38. Cuenta cuántos actores hay en la tabla “actor”. */
SELECT count(distinct actor_id) as num_actores
FROM actor;

/* 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente. */
SELECT concat(first_name, ' ', last_name)
FROM actor 
order by last_name asc; 

/* 40. Selecciona las primeras 5 películas de la tabla “film”. */
SELECT title, film_id 
FROM film 
order by film_id 
limit 5; 

/* 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido? */
SELECT first_name, count(first_name) as "num_personas"
FROM actor
group by first_name
order by num_personas desc --agrupem per noms, comptem quantes persones, y ponemos limite en uno para la lista en descendiente para quedarnos con el que mas tiene. Pero tal vez tenemos mas nombres con una max cantidad.
limit 1;


--opcional:
WITH contar_nombres AS --creamos CTE para agrupar y contar los que tenemos
  (SELECT first_name, COUNT(*) AS cantidad
  FROM actor
  GROUP BY first_name),

maximos AS (
  SELECT MAX(cantidad) AS max_cantidad
  FROM contar_nombres
)
SELECT first_name , cantidad 
FROM contar_nombres
WHERE cantidad = (SELECT max_cantidad FROM maximos);


/* 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron. */
SELECT r.rental_id, concat(c.first_name, ' ', c.last_name) as cliente
FROM rental r 
join customer c on c.customer_id = r.customer_id;


/* 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres. */
SELECT concat(c.first_name, ' ', c.last_name) as cliente, array_agg(r.rental_id) as alquileres --creamos una array para no tener tantas filas. es como el string agg
FROM customer c
left join rental r on r.customer_id = c.customer_id
group by cliente 
order by cliente ;

/* 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación. */
SELECT f.title , c.name 
FROM film f
CROSS JOIN category c;
 
--no aportaría valor ya que no utiliza relaciones verdaderas, por ejemplo haría peliculas con categorias que no le pertenecen. 

/* 45. Encuentra los actores que han participado en películas de la categoría 'Action'. */
SELECT concat(a.first_name, ' ', a.last_name) as actor, c."name"
FROM actor a
join film_actor fa on fa.actor_id = a.actor_id
join film_category fc on fc.film_id = fa.film_id
join category c on c.category_id = fc.category_id
where c."name" ilike '%action%' ;

/* 46. Encuentra todos los actores que no han participado en películas. */
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL; 

/* 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado. */
SELECT CONCAT(a.first_name, ' ', a.last_name) AS actor, COUNT(fa.film_id) AS cantidad_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY actor ;


/* 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado. */
create or replace view actor_num_peliculas as --ponemos el replace por si modificamos la vista, sino nos a error y nos dice que ya ha sido creada
	SELECT CONCAT(a.first_name, ' ', a.last_name) as actores, count(fa.film_id) as num_pelis
	FROM actor a
	join film_actor fa on fa.actor_id = a.actor_id
	group by a.actor_id
	order by a.first_name; 

select * from actor_num_peliculas; 
	

/* 49. Calcula el número total de alquileres realizados por cada cliente. */

SELECT concat(c.first_name, ' ', c.last_name) AS cliente, count(r.rental_id) AS total_alquileres
FROM customer c
left join rental r on r.customer_id = c.customer_id --aseguramos contar con los clientes que tienen 0 alquileres
group by c.customer_id, c.first_name, c.last_name
order by total_alquileres desc;

/* 50. Calcula la duración total de las películas en la categoría 'Action'. */

SELECT c.name as categoria, sum(f.length) as duracion_total
FROM film f
JOIN film_category fc on f.film_id = fc.film_id
JOIN category c on fc.category_id = c.category_id
WHERE c.name ilike '%Action%'
GROUP BY c.name;


/* 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente. */
create temporary table cliente_rentas_temporal AS
SELECT  customer_id, count(*) as total_alquileres
FROM rental
group by customer_id;


/* 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces. */
create temporary table peliculas_alquiladas AS
SELECT f.film_id, f.title, COUNT(*) AS veces_alquilada
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(*) >= 10;

/* 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película. */

SELECT f.title
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE c.first_name ilike '%Tammy%' AND c.last_name ilike '%Sanders%'
  AND r.return_date IS NULL
ORDER BY f.title;


/* 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido. */
SELECT distinct a.first_name, a.last_name as actor, c."name"
FROM actor a
join film_actor fa on fa.actor_id = a.actor_id
join film_category fc on fc.film_id = fa.film_id 
join category c on c.category_id = fc.category_id
where c."name" = 'Sci-Fi'
order by a.last_name, a.first_name;

/* 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido. */

SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN inventory i ON i.film_id = fa.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.rental_date > (
  SELECT MIN(r2.rental_date) --subconsulta con la que encontramos la fecha mas temprana en que se alquila la peli
  FROM rental r2
  JOIN inventory i2 ON i2.inventory_id = r2.inventory_id
  JOIN film f2 ON f2.film_id = i2.film_id
  WHERE f2.title ilike '%Spartacus Cheaper%'
)
ORDER BY a.last_name, a.first_name;


/* 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’. */
SELECT a.first_name, a.last_name, c."name" as categ
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id --para visualizar categoria y que no haya music
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE a.actor_id NOT IN ( --excluimos a los actores 
  SELECT fa.actor_id
  FROM film_actor fa
  JOIN film_category fc ON fc.film_id = fa.film_id
  JOIN category c ON c.category_id = fc.category_id
  WHERE c.name = 'Music'
)
ORDER BY a.last_name, a.first_name;


/* 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días. */
SELECT DISTINCT f.title, DATE_PART('day', AGE(return_date, rental_date))
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE return_date IS NOT NULL
  AND DATE_PART('day', AGE(return_date, rental_date)) > 8 --utilizamos funcion para extraer los dias del intervalo, sino nos dará error
ORDER BY f.title;


/* 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’. */
SELECT f.title, c."name"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Animation'
ORDER BY f.title;
 

/* 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película. */
SELECT title, length
FROM film
WHERE length = (
    SELECT length
    FROM film
    WHERE title ilike '%Dancing Fever%'
)
ORDER BY title;


/* 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido. */
SELECT c.first_name, c.last_name, COUNT(DISTINCT f.film_id)
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT f.film_id) >= 7
ORDER BY c.last_name, c.first_name;
 

/* 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres. */
SELECT c.name AS categoria, COUNT(r.rental_id) AS total_alquileres
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY total_alquileres DESC;


/* 62. Encuentra el número de películas por categoría estrenadas en 2006. */
SELECT c.name AS categoria, COUNT(f.film_id) AS total_peliculas, f.release_year
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
WHERE f.release_year = 2006
GROUP BY c.name, f.release_year
ORDER BY total_peliculas DESC;


/* 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos. */
SELECT 
  CONCAT(s.first_name, ' ', s.last_name) AS empleado, st.store_id AS tienda
FROM staff s
CROSS JOIN store st
ORDER BY empleado, tienda;


/* 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas. */
SELECT 
  c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_alquileres DESC;
 

