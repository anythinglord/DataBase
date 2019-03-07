


DROP TRIGGER IF EXISTS eliminar_persona;
DELIMITER $$
CREATE TRIGGER eliminar_persona BEFORE DELETE ON persona FOR EACH ROW 
BEGIN 
	SET @per_nombre =OLD.per_nombre;
    SET @per_apellido = OLD.per_apellido;
    SET @per_cedula = OLD.per_cedula;
    SET @per_telefono = OLD.per_telefono;
    INSERT INTO historial_personas(per_nombre, per_apellido, per_cedula, per_telefono) 
    VALUES (@per_nombre, @per_apellido, @per_cedula, @per_telefono);
    DELETE FROM empleado WHERE per_cedula = @per_cedula;
    DELETE FROM cliente WHERE per_cedula = @per_cedula;
END $$
DELIMITER ;



-- trigger eliminar clientes
DROP TRIGGER IF EXISTS eliminar_cliente;
DELIMITER $$
CREATE TRIGGER eliminar_cliente BEFORE DELETE ON cliente FOR EACH ROW 
BEGIN 
    SET @per_cedula = OLD.per_cedula;
	SET @per_nombre = '';
    SET @per_apellido = '';
    SET @per_telefono = '';
    SELECT per_nombre, per_apellido, per_telefono INTO @per_nombre, @per_apellido, @per_telefono FROM persona 
		WHERE per_cedula = @per_cedula;
    INSERT INTO historial_clientes_eliminados(per_nombre, per_apellido, per_cedula, per_telefono) 
    VALUES (@per_nombre, @per_apellido, @per_cedula, @per_telefono);
END $$
DELIMITER ;



-- trigger eliminar empleados
DROP TRIGGER IF EXISTS eliminar_empleado;
DELIMITER $$
CREATE TRIGGER eliminar_empleado BEFORE DELETE ON empleado FOR EACH ROW 
BEGIN 
	SET @emp_id = OLD.emp_id;
    SET @per_cedula = OLD.per_cedula;
	SET @per_nombre = '';
    SET @per_apellido = '';
    SET @per_telefono = '';
    SET @cargo_id = OLD.cargo_id;
    SET @cargo_nombre = '';
    SET @cargo_salario = '';
    SELECT per_nombre, per_apellido, per_telefono INTO @per_nombre, @per_apellido, @per_telefono FROM persona 
		WHERE per_cedula = @per_cedula;
	SELECT cargo_nombre, cargo_salario INTO @cargo_nombre, @cargo_salario FROM cargo WHERE cargo_id = @cargo_id;
    INSERT INTO historial_empleados_eliminados(per_nombre, per_apellido, per_cedula, per_telefono, cargo_nombre, cargo_salario) 
    VALUES (@per_nombre, @per_apellido, @per_cedula, @per_telefono, @cargo_nombre, @cargo_salario);
    DELETE FROM embodegar WHERE emp_id = @emp_id;
    DELETE FROM venta_producto WHERE emp_id = @emp_id;
    DELETE FROM venta_medicamento WHERE emp_id = @emp_id;
    DELETE FROM masaje WHERE emp_id = @emp_id;
    DELETE FROM inyeccion WHERE emp_id = @emp_id;
END $$
DELIMITER ;