
	-- VISTAS
    
-- 1. ver informacion de clientes
Create view ver_cliente as (select * from cliente join persona using (per_cedula));

-- 2. ver informacion de empleados
Create view ver_empleado as (select * from empleado join persona using (per_cedula));

-- 3. ver medicamentos
Create view ver_medicamento as (select med_nombre as medicamento, med_precio as precio from medicamento);

-- 4. ver productos
Create view ver_producto as (select pro_nombre as producto, pro_marca as marca, pro_precio as precio from producto);

-- 5. ver cuantos clientes tiene la drogueria
Create view cant_clientes as (select count(*) as numeroDeClientes from cliente);

--  6. ver cuantos empleados pertenecen a la drogueria clasificados por cargo
Create view cant_empleados as (select count(per_cedula), cargo_nombre from empleado join cargo using (cargo_id) group by cargo_id);

--  7. Arroja el nombre y precio del producto mas caro
create view vista1 as (select pro_nombre,pro_precio from producto where pro_precio=max(pro_precio));

--  8. Nombre y precio de medicamentos que existen
create view vista2 as (select med_nombre,med_precio from medicamento );

--  9. Nombre y Cargo ID
create view vista3 as (select  per_nombre,emp_id,cargo_id from empleado);

--  10. Cedula y Prestigio
create view vista4 as(select per_cedula,cli_prestigio from cliente);

--  11. productos mas caros hasta la fecha
Create view view4 as (select count(med_id) from venta where precio=max(precio) and fecha=curdate());

-- 12 promedio del precio de venta de medicamentos entre los medicamentos con id 11 y 12
Create view view5 as(select avg(precio) from  venta medicamento where med_id=11 or med_id=12 )