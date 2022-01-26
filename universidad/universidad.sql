-- 1- Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos. El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo='alumno' ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;
-- 2- Halla el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo='alumno' AND telefono IS NULL;
-- 3- Devuelve el listado de los alumnos que nacieron en 1999.
SELECT apellido1, apellido2, nombre FROM persona WHERE YEAR(fecha_nacimiento) = '1999' AND tipo = 'alumno';
-- 4- Devuelve el listado de profesores que no han dado de alta su número de teléfono en labase de datos y además su nif termina en K.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';
-- 5- Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
SELECT nombre FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
-- 6- Devuelve un listado de los profesores junto con el nombre del departamento al que están vinculados. El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento.  El resultado estará ordenado alfabéticamente de menor a mayor por los apellidos y el nombre.
SELECT p.nombre, p.apellido1, p.apellido2, d.nombre FROM (persona p LEFT JOIN profesor m ON p.id = m.id_profesor) LEFT JOIN departamento d ON m.id_departamento = d.id WHERE d.nombre IS NOT NULL ORDER BY p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;
-- 7- Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno con nif 26902806M.
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin 
FROM (alumno_se_matricula_asignatura LEFT JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura=asignatura.id) LEFT JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE alumno_se_matricula_asignatura.id_alumno = (SELECT id FROM persona WHERE nif LIKE '26902806M');
-- 8- Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).
SELECT DISTINCTROW d.nombre FROM departamento d INNER JOIN profesor m ON(d.id = m.id_departamento) INNER JOIN asignatura a ON (m.id_profesor = a.id_profesor) INNER JOIN grado g ON (a.id_grado = g.id) WHERE g.nombre='Grado en Ingeniería Informática (Plan 2015)';
-- 9- Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.
SELECT DISTINCTROW p.nombre, p.apellido1, curso_escolar.anyo_inicio FROM persona p INNER JOIN alumno_se_matricula_asignatura ON (p.id = alumno_se_matricula_asignatura.id_alumno) INNER JOIN curso_escolar ON (alumno_se_matricula_asignatura.id_asignatura = curso_escolar.id) WHERE curso_escolar.anyo_inicio = 2018;
-- 10- Devuelve un listado con los nombres de todos los profesores y departamentos que tienen vinculados. El listado también debe mostrar a aquellos profesores que no tienen ningún departamento asociado. El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y nombre.
SELECT d.nombre, p.apellido1, p.apellido2 , p.nombre FROM departamento d RIGHT JOIN profesor m ON (m.id_departamento = d.id) RIGHT JOIN persona p ON (m.id_profesor = p.id) ORDER BY d.nombre ASC, p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;
-- 11- Devuelve un listado con los profesores que no están asociados a un departamento.
SELECT m.* FROM profesor m LEFT JOIN departamento d ON (m.id_departamento = d.id) WHERE d.id IS NULL;
-- 12- Devuelve un listado con los departamentos que no tienen profesores asociados.
SELECT d.* FROM departamento d LEFT JOIN profesor m ON (d.id = m.id_departamento) WHERE id_departamento IS NULL;
-- 13- Devuelve un listado con los profesores que no imparten ninguna asignatura.
SELECT m.* FROM profesor m LEFT JOIN asignatura a ON (m.id_profesor = a.id_profesor) WHERE a.id IS NULL;
-- 14- Devuelve un listado con las asignaturas que no tienen un profesor asignado.
SELECT a.* FROM asignatura a LEFT JOIN profesor m ON (a.id_profesor = m.id_profesor) WHERE a.id_profesor IS NULL;
-- 16- Devuelve el número total de alumnos existentes.
SELECT count(*) FROM persona WHERE tipo LIKE 'alumno';
-- 17- Calcula cuántos alumnos nacieron en 1999.
SELECT count(*) FROM persona WHERE tipo LIKE 'alumno' AND fecha_nacimiento LIKE '1999%';
-- 18- Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.
SELECT d.nombre, COUNT(m.id_departamento) AS total_profesores FROM profesor m INNER JOIN departamento d ON (m.id_departamento = d.id) GROUP BY d.nombre ORDER BY total_profesores DESC;
-- 19- Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. Tenga en cuenta que pueden existir departamentos que carecen de profesores asociados. Estos departamentos también deben aparecer en el listado.
SELECT d.nombre AS nombre_departamento, COUNT(m.id_departamento) AS total_profesores FROM profesor m RIGHT JOIN departamento d ON (m.id_departamento = d.id) GROUP BY d.nombre;
-- 20- Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta que pueden existir grados que carecen de asignaturas asociadas. Estos grados también deben aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
SELECT g.nombre AS nombre_grado, COUNT(a.id_grado) AS total_asignaturas FROM asignatura a RIGHT JOIN grado g ON (a.id_grado = g.id) GROUP BY g.nombre ORDER BY total_asignaturas DESC;
-- 21- Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.
SELECT g.nombre AS nombre_grado, COUNT(a.id_grado) AS total_asignaturas FROM grado g INNER JOIN asignatura a ON (a.id_grado = g.id) HAVING total_asignaturas > 40;
-- 22- Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos existentes para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que existen de este tipo.
SELECT g.nombre AS nombre_grado, a.tipo AS tipo_asignatura, SUM(a.creditos) AS total_creditos FROM asignatura a RIGHT JOIN grado g ON(a.id_grado = g.id) GROUP BY a.tipo, g.nombre ORDER BY total_creditos DESC;
-- 23- Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado tendrá que mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.
SELECT DISTINCTROW curso_escolar.anyo_inicio AS año_inicio_curso, COUNT(alumno_se_matricula_asignatura.id_alumno) AS alumnos_matriculados FROM curso_escolar INNER JOIN alumno_se_matricula_asignatura ON (curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar) GROUP BY curso_escolar.anyo_inicio;
-- 24- Devuelve un listado con el número de asignaturas que imparte cada profesor.  El listado debe tener en cuenta a aquellos profesores que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id_profesor) AS cant_asignaturas FROM (persona p RIGHT JOIN profesor m ON p.id = m.id_profesor) LEFT JOIN asignatura a ON (m.id_profesor = a.id_profesor) GROUP BY p.id ORDER BY cant_asignaturas DESC;
-- 25- Devuelve todos los datos del alumno más joven.
SELECT * FROM persona p WHERE tipo='alumno' ORDER BY p.fecha_nacimiento DESC LIMIT 1;
-- 26- Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.
SELECT  p.nombre, p.apellido1, p.apellido2 FROM persona p LEFT JOIN profesor m ON (p.id = m.id_profesor) LEFT JOIN asignatura a ON(m.id_profesor = a.id_profesor) WHERE p.tipo = 'profesor' AND a.nombre IS NULL;