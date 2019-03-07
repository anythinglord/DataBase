
	-- PROCEDIMIENTOS ALMACENADOS Y FUNCIONES
    
	use drogueria ;
	-- 1. procedimiento para reservar 
    -- El procedimiento ingresa todos los datos en la Tabla Reserva
    drop procedure if exists reserva;
    -- LLamado de la Funcion
    -- se pueden reservar un medicamento , producto, mesaje o solo uno o dos  
    -- call reserva('cantidad a reservar','fecha inical de reserva','fecha final de reserva','cedula de quien reserva','id del medicamento','id del producto','turno para el masaje');
    
    delimiter $$
	create procedure reserva(in cantidad int(3),in fecha_inicial date,in fecha_final date,in cedula varchar(20),in med_id int(5),in pro_id int(5),in turno int(5))
	begin
    declare prestige int;
    declare message varchar(70);
    declare message1 varchar(70);
    declare message2 varchar(70);
    set message='no se pudo realizar la operacion el prestigio debe ser mayor a 5';
    set message1='no se pudo realizar la operacion el prestigio debe ser mayor a 10';
    set message2='no se pudo realizar la operacion el prestigio debe ser mayor a 15';
    
    select cli_prestigio into prestige from cliente where per_cedula=cedula;
    
    if prestige >= 5 then 
		if med_id is not null and pro_id is null and turno is null then 
        insert into reservar(res_cantidad,fecha_ini_res,fecha_fin_res,per_cedula,med_id,pro_id,turno) values(cantidad,fecha_inicial,fecha_final,cedula,med_id,null,null);
		set prestige= prestige-5;
        update cliente set cli_prestigio=prestige where per_cedula=cedula;
		end if;
        if med_id is null and pro_id is not null and turno is null then 
        insert into reservar(res_cantidad,fecha_ini_res,fecha_fin_res,per_cedula,med_id,pro_id,turno) values(cantidad,fecha_inicial,fecha_final,cedula,null,pro_id,null);
		set prestige= prestige-5;
        update cliente set cli_prestigio=prestige where per_cedula=cedula;
        end if;
        if med_id is null and pro_id is null and turno is not null then 
        insert into reservar(res_cantidad,fecha_ini_res,fecha_fin_res,per_cedula,med_id,pro_id,turno) values(cantidad,fecha_inicial,fecha_final,cedula,null,null,turno);
		set prestige= prestige-5;
        update cliente set cli_prestigio=prestige where per_cedula=cedula;
        end if;
	else select message;
	end if;
    if prestige >= 10 then 
		if med_id is not null and pro_id is not null and turno is null then
        insert into reservar(res_cantidad,fecha_ini_res,fecha_fin_res,per_cedula,med_id,pro_id,turno) values(cantidad,fecha_inicial,fecha_final,cedula,med_id,pro_id,null);
		set prestige= prestige-10;
        update cliente set cli_prestigio=prestige where per_cedula=cedula;
		end if;
        if med_id is not null and pro_id is null and turno is not null then
        insert into reservar(res_cantidad,fecha_ini_res,fecha_fin_res,per_cedula,med_id,pro_id,turno) values(cantidad,fecha_inicial,fecha_final,cedula,med_id,null,turno);
		set prestige= prestige-10;
        update cliente set cli_prestigio=prestige where per_cedula=cedula;
		end if;
        if med_id is null and pro_id is not null and turno is not null then
        insert into reservar(res_cantidad,fecha_ini_res,fecha_fin_res,per_cedula,med_id,pro_id,turno) values(cantidad,fecha_inicial,fecha_final,cedula,null,pro_id,turno);
		set prestige= prestige-10;
        update cliente set cli_prestigio=prestige where per_cedula=cedula;
		end if;
	else select message1;
	end if;
    
    if prestige >= 15 and med_id is not null and pro_id is not null and turno is not null  then 
		insert into reservar(res_cantidad,fecha_ini_res,fecha_fin_res,per_cedula,med_id,pro_id,turno) values(cantidad,fecha_inicial,fecha_final,cedula,med_id,pro_id,turno);
		set prestige= prestige-15;
        update cliente set cli_prestigio=prestige where per_cedula=cedula;
	else select message2;
	end if;
    end $$
    delimiter ;
    
    -- 2. procedimiento vender producto o medicamento
    -- con el Procedimiento se pueden vender un producto o medicamento pero no al mismo tiempo
    -- La palabra tipo se debe reemplazar por la palabra medicamento o producto
    drop procedure if exists Vender;
    -- call Vender('fecha de la venta','cedula del cliente','id del empleado que realizo la venta','tipo','id el producto o medicamento','cantidad vendida'),
    
	delimiter $$
    create procedure Vender(in ifecha date,in cedula int(15),in id_empleado int(5),in tipo varchar(25),in id int(4),in cantidad int(2))
	begin
    if tipo='medicamento' then
    insert into venta_medicamento(fecha,per_cedula,emp_id,med_id,cantidad) values(ifecha,cedula,id_empleado,id,cantidad);
    if tipo='producto' then
    insert into venta_producto(fecha,per_cedula,emp_id,pro_id,cantidad) values(ifecha,cedula,id_empleado,id,cantidad);
    end if;
    end if;
    end $$
    delimiter ;
    
    -- 3 procedimiento utilizado al momento de realizar la compra al proveedor
    drop procedure if exists ProvCompra;
    -- call ProvCompra('cantidad por medicamento','id del medicamento a comprar','nit del proveedor');
    
    delimiter $$
	create procedure ProvCompra(in cant int(3),in medicamento_id int(5),in nit int(6))
	begin
    insert into compra_proveedor(fecha,cantidad,med_id,prov_nit) values(curdate(),cant,medicamento_id,nit);
    select * from compra_proveedor;
    end $$
    delimiter ;
    
    -- 4. procedimiento utilizado para verificar si el empleado que se va a agregar esta registrado o no en la base de datos 
    drop procedure if exists SEmpleado;
    -- call SEmpleado('horario','cedula','cargo');
    
    delimiter $$
    create procedure SEmpleado(in horario varchar(15),in cedula int(15),in cargo int(2))
	begin
    declare cedula int;
    declare cargo varchar(5);
    declare message varchar(80);
    declare message1 varchar(80);
    set message ='EL cargo que usted ingreso no esta registrado en la tabla de cargo';
    set message1 = 'El empleado ya se encuentra registrado en la tabla empleados';
    select per_cedula into cedula from empleado where per_cedula=cedula;
    select cargo_id into cargo from cargo where cargo_id =cargo;
    if cargo is not null then 
		if cedula is null then
		call NewEmpleado(horario,cedula,cargo);
        else select message1;
        end if;
    else select message;
    end if;
    end $$
    delimiter ;
       
    -- 5. Procedimiento utilizado para agregar nuevos empleados
    drop procedure if exists NewEmpleado;
    -- call NewEmpleado (cedula ,'nombre','apellido',edad,'telefono','direccion', 'cargo', 'horario');
    
    delimiter $$
    create procedure NewEmpleado (in cedula int(15),in nombre VARCHAR(20), in apellido VARCHAR(20),in edad INT,
    in telefono VARCHAR(30),in direccion VARCHAR(30), in cargo varchar (20), in horario varchar (5))
	begin
    set @cedula = cedula;
    set @emp_id_aux = 0;
    set @cargo_id = (select cargo_id from cargo where cargo_nombre = cargo);
    select max(emp_id) into @emp_id_aux from empleado;
    insert into persona (per_cedula, per_nombre, per_apellido,per_edad,per_telefono,per_direccion) 
    values(@cedula, nombre, apellido, edad, telefono, direccion);
    insert into empleado (emp_id, emp_horario, per_cedula, cargo_id) 
    values (@emp_id_aux+1, horario, @cedula, @cargo_id);
    end $$
    delimiter ;
    
    -- 6. Procedimiento utilizado para modificar un campo con valor entero de la tabla medicamento
	-- El parametro puede ser o el id o precio del medicamento;
    drop procedure if exists ModificarMed;
    -- call ModificarMed('parametro','el valor actual que desea modificar','el valor nuevo');
    
	delimiter $$
    create procedure ModificarMed(in parametro varchar(25),in viejoInt int(8),in nuevoint int(8))
    begin
    if parametro ='id' then
    update medicamento set med_id =nuevoint where med_id=viejoInt;
    elseif parametro ='precio' then
    update medicamento set med_precio =nuevoint where med_precio=viejoInt;
    end if;
    end $$
    delimiter ;
    
    -- 7. procedimieto que retorna el nombre el producto mas vendido y menos vendido en una determinada Fecha
    drop procedure if exists MasVend;
    --  call MasVend('Fecha')
    
	delimiter $$
    create procedure MasVend(in ifecha date)
    begin
    declare maxmed varchar(20);
    declare minmed varchar(20);
    select max(count(med_nombre)) into maxmed from meicamento natural join (select med_id from venta_producto where fecha=ifecha)as R group by med_id;  
    select max(count(med_nombre)) into minmed from meicamento natural join (select med_id from venta_producto where fecha=ifecha)as B group by med_id;  
    select maxmed,minmed;
    end $$
    delimiter ;
    
	-- 8. Procedimiento que le envia al  procedimiento Descripcion el id del medicamento 
    drop procedure if exists med;
    -- call med('Nombre del medicamento');
    
    delimiter $$
    create procedure med(in nombre varchar(20))
    begin 
    declare id int;
    declare des varchar(15);
    select med_id into id from medicamento where med_nombre=nombre;
    call descripcion(id,des);
    select nombre,des;
    end $$
    delimiter ;
    
    -- 9. procedimiento que retorna la descripcion del medicamento 
    -- procedimiento que utiliza variables OUT
    -- Procedimiento llamado desde el anterior procedmiento
    
    delimiter $$
    drop procedure if exists Descripcion;
    
    create procedure Descripcion(in id int(6),out nombre varchar(20))
    begin 
    declare salida varchar;
    select com_descripcion into salida from medicamento natural join composicion natural join componer where med_id=;
    delimiter ;
    
    -- 10. Funcion que muestra cuantos medicamentos estan compuestos de algun medicamento
    drop function if exists contarTipoMed;
    -- set @llamado = contarTipoMed('Medicamento composicion');
    -- select @llamado;
    
    delimiter $$
	create function contarTipoMed(tipo varchar(20)) returns varchar(25)
	begin 
    declare total int;
    select count(med_id) into total from medicamento natural join componer natural join composicion where com_descripcion=tipo;
    return total;
    end $$
    delimiter ;
    
    -- 11. Funcion que retorna el nombre del empleado que realizó el masaje dado un turno
    -- y si el empleado tiene mas de la edad dada, tiene que retornar la cedula del empleado
    drop function if exists Empl;
    -- set @llamado = Empl('turno','Edad');
    -- select @llamado;
    
    delimiter $$
    create function Empl(iturno int(2),iedad int(2) ) returns varchar(25)
    begin
    declare nombre varchar(20);
    declare cedula int;
    declare edad int;
    select emp_nombre,emp_cedula,emp_edad into nombre,cedula,edad from masaje natural join empleado where turno=iturno;
	if iedad < edad then 
    return nombre;
    else
    return cedula;
    end if;
    end $$
    delimiter ;
    
	-- 12. Funcion que retorna el salario del empleado correspondiente segun su cedula
    drop function if exists ver_salario;
    -- set @MiSalario = ver_salario ('Cedula del empleado');
    -- select @MiSalario;
    
    delimiter $$
    create function ver_salario (cedula int(15)) returns double
    begin
    set @cedula= cedula;
    set @cargo = 0;
    set @salario = 0;
    select cargo_id into @cargo from empleado where per_cedula = @cedula;
    select cargo_salario into @salario from cargo where cargo_id = @cargo;
    return @salario;
    end $$
    delimiter ;
    
    -- 13. Procedimiento para agregar nuevos clientes
    drop procedure if exists nuevo_cliente;
    -- call nuevo_cliente('cedula del cliente','nombre del cliente','apellido','edad','telefono','direccion'); 
    
    delimiter $$
    create procedure nuevo_cliente(in cedula int(15),nombre VARCHAR(20),apellido VARCHAR(20),edad INT,
    telefono VARCHAR(30),direccion VARCHAR(30))
	begin
    set @cedula = cedula;
    insert into persona (per_cedula, per_nombre, per_apellido,per_edad,per_telefono,per_direccion) 
    values(@cedula, nombre, apellido, edad, telefono, direccion);
    insert into cliente (per_cedula, cli_prestigio) values (@cedula, '10');
    end $$
    delimiter ;
    
    -- 14. Procedimiento para agregar un nuevo cargo o modificar el salario de un cargo
    drop procedure if exists modificar_cargo;
    -- call modificar_cargo('Nombre del cargo','salario'); 
    
    delimiter $$
    create procedure modificar_cargo (cargo varchar (20), salario double)
    begin
    set @cargo_id = (select cargo_id from cargo where cargo_nombre = cargo);
    set @cargo_id_aux = 0;
    if @cargo_id is null then
		select max(cargo_id) into @cargo_id_aux from cargo;
		insert into cargo (cargo_id, cargo_nombre, cargo_salario) values (@cargo_id_aux+1, cargo, salario);
	else 
		update cargo set cargo_salario = salario where cargo_nombre = cargo;
    end if ;
    end $$
    delimiter ;
    
    
    
    
    
    
    -- 