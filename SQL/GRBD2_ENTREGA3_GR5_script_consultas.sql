


	-- id de la reserva , cedula de la persona que lo realiza en la fecha solicitada
	select per_cedula,res_id from reserva where fecha_ini_res=fecha;

	-- Id del empleado e id del producto mas vendido y su cantidad en la fecha actual 
    select emp_id,pro_id,cantidad from venta_producto where fecha=fecha;
    
	-- la descripcion de la composicion del medicamento mas caro de la drogueria
    select com_descripcion from composicion natural join componer natural join medicamento where med_precio=max(med_precio);
    
    -- nombre, cedula e id de los empleados 
    select per_nombre,per_cedula,emp_id from empleado natural join persona where per_nombre=nombre ;
    
    -- nombre , cedula y prestigio de los clientes 
    select per_cedula,cli_prestigio from cliente natural join persona;
    
    -- nombre,cedula , cargo y salario de los empleados de la dro
	
	-- nombre del cliente que tomo un masaje y compro un medicamento el mismo dia
	select per_nombre from (select per_cedula from masaje natural join cliente natural join (venta_medicamento) where masaje.fecha=venta_medicamento.fecha)as R natural join persona;

	-- promedio del precio de los productos vendidos con un precio mayor a 5000
	select avg(pro_precio) from producto natural join venta_producto;
    
    -- nombre del empleado con el cargo de bodeguero y con un salario mayor a 389000
    select per_nombre from  empleado natural join persona natural join Cargo  where cargo_nombre='bodeguero' and cargo_salario> 389000; 

	-- id del producto compuesto por Ibuprofeno y con un precio menor a 3000
	select med_id from medicamento natural join componer natural join composicion where com_descripcion='Ibuprofeno' and med_precio <3000;
    
    