drop database drogueria;
create database drogueria;
use drogueria;

CREATE TABLE persona (
    per_cedula INT(12) PRIMARY KEY,
    per_nombre VARCHAR(20) NOT NULL,
    per_apellido VARCHAR(20) NOT NULL,
    per_edad INT NOT NULL,
    per_telefono VARCHAR(30) NULL,
    per_direccion VARCHAR(30) NOT NULL
);

CREATE TABLE cliente (
    per_cedula INT(12) NOT NULL,
    cli_prestigio INT(2) NOT NULL,
    FOREIGN KEY (per_cedula)
        REFERENCES persona (per_cedula)
);



CREATE TABLE cargo (
    cargo_id INT(5) PRIMARY KEY,
    cargo_nombre VARCHAR(20) NOT NULL,
    cargo_salario DOUBLE NOT NULL
);



CREATE TABLE empleado (
    emp_id INT(5) PRIMARY KEY auto_increment,
    emp_horario VARCHAR(20),
    per_cedula INT(12) NOT NULL,
    cargo_id INT(5) NOT NULL,
    FOREIGN KEY (per_cedula)
        REFERENCES persona (per_cedula),
    FOREIGN KEY (cargo_id)
        REFERENCES cargo (cargo_id)
);


CREATE TABLE laboratorio (
    lab_nit INT(10) PRIMARY KEY,
    lab_nombre VARCHAR(20) NOT NULL,
    lab_telefono VARCHAR(25) NOT NULL,
    lab_direccion VARCHAR(25) NOT NULL
);


CREATE TABLE proveedor (
    prov_nit INT(10) PRIMARY KEY,
    prov_nombre VARCHAR(20) NOT NULL,
    prov_telefono VARCHAR(25) NOT NULL
);



CREATE TABLE medicamento (
    med_id INT(100) PRIMARY KEY,
    med_nombre VARCHAR(20) NOT NULL,
    med_precio DOUBLE NOT NULL,
    med_tipo VARCHAR(20) NOT NULL,
    med_bodega VARCHAR(10) NOT NULL,
    med_descripción VARCHAR(500) NULL
);



CREATE TABLE producto (
    pro_id INT(5) PRIMARY KEY,
    pro_nombre VARCHAR(20) NOT NULL,
    pro_precio DOUBLE NOT NULL,
    pro_marca VARCHAR(20) NOT NULL,
    pro_bodega VARCHAR(10) NOT NULL
);


CREATE TABLE composicion (
    com_id INT(100) PRIMARY KEY,
    com_descripcion VARCHAR(20) NOT NULL
);


CREATE TABLE componer (
    med_id INT(5) NOT NULL,
    com_id INT(5) NOT NULL,
    FOREIGN KEY (med_id)
        REFERENCES medicamento (med_id),
    FOREIGN KEY (com_id)
        REFERENCES composicion (com_id)
);


CREATE TABLE producir (
    med_id INT(5) NOT NULL,
    lab_nit INT(10) NOT NULL,
    FOREIGN KEY (med_id)
        REFERENCES medicamento (med_id),
    FOREIGN KEY (lab_nit)
        REFERENCES laboratorio (lab_nit)
);


CREATE TABLE embodegar (
    emp_id INT(100) NOT NULL,
    pro_id INT(100) NULL,
    med_id INT(100) NULL,
    FOREIGN KEY (emp_id)
        REFERENCES empleado (emp_id),
    FOREIGN KEY (med_id)
        REFERENCES medicamento (med_id),
    FOREIGN KEY (pro_id)
        REFERENCES producto (pro_id)
);


CREATE TABLE contratar (
    prov_nit INT(10) NOT NULL,
    lab_nit INT(10) NOT NULL,
    FOREIGN KEY (prov_nit)
        REFERENCES proveedor (prov_nit),
    FOREIGN KEY (lab_nit)
        REFERENCES laboratorio (lab_nit)
);

CREATE TABLE reservar(
    res_id INT(5) PRIMARY KEY auto_increment,
    res_cantidad int(5) not null,
    fecha_ini_res Varchar(10) NOT NULL,
    feha_fin_res Varchar(10) NOT NULL,
    per_cedula INT(12) NOT NULL,
    med_id int(8) null,
    pro_id int(8) null,
    turno  int(8) null
	);

CREATE TABLE venta_producto (
    num_factura INT(5) PRIMARY KEY auto_increment,
    fecha Varchar(10) NOT NULL,
    per_cedula INT(12) NOT NULL,
    emp_id INT(5) NOT NULL,
    pro_id INT(5) NOT NULL,
    cantidad INT(5) NOT NULL,
    FOREIGN KEY (per_cedula)
        REFERENCES cliente (per_cedula),
    FOREIGN KEY (emp_id)
        REFERENCES empleado (emp_id),
    FOREIGN KEY (pro_id)
        REFERENCES producto (pro_id)
);

CREATE TABLE venta_medicamento (
    num_factura INT(5) PRIMARY KEY auto_increment,
    fecha Varchar(10) NOT NULL,
    per_cedula INT(12) NOT NULL,
    emp_id INT(5) NOT NULL,
    med_id INT(5) NOT NULL,
    cantidad INT(5) NOT NULL,
    FOREIGN KEY (per_cedula)
        REFERENCES cliente (per_cedula),
    FOREIGN KEY (emp_id)
        REFERENCES empleado (emp_id),
    FOREIGN KEY (med_id)
        REFERENCES medicamento (med_id)
);

CREATE TABLE compra_proveedor (
    fecha DATE PRIMARY KEY,
    cantidad INT(5) NOT NULL,
    med_id INT(5) NOT NULL,
    prov_nit INT(10) NOT NULL,
    FOREIGN KEY (prov_nit)
        REFERENCES proveedor (prov_nit),
    FOREIGN KEY (med_id)
        REFERENCES medicamento (med_id)
);

CREATE TABLE masaje (
    turno INT(5) NOT NULL,
    fecha DATE NOT NULL,
    per_cedula INT(12) NOT NULL,
    emp_id INT(5) NOT NULL,
    PRIMARY KEY (turno , fecha),
    FOREIGN KEY (per_cedula)
        REFERENCES cliente (per_cedula),
    FOREIGN KEY (emp_id)
        REFERENCES empleado (emp_id)
);

CREATE TABLE inyeccion (
    turno INT(5) NOT NULL,
    fecha DATE NOT NULL,
    tipo VARCHAR(25) NOT NULL,
    per_cedula INT(12) NOT NULL,
    emp_id INT(5) NOT NULL,
    PRIMARY KEY (turno , fecha),
    FOREIGN KEY (per_cedula)
        REFERENCES cliente (per_cedula),
    FOREIGN KEY (emp_id)
        REFERENCES empleado (emp_id)
);

-- trigger eliminar personas
CREATE TABLE historial_personas (
    per_nombre VARCHAR(20) NOT NULL,
    per_apellido VARCHAR(20) NOT NULL,
    per_cedula INT(12) NOT NULL,
    per_telefono VARCHAR(20) NULL
);

-- historial clientes eliminados
CREATE TABLE historial_clientes_eliminados (
    per_nombre VARCHAR(20) NOT NULL,
    per_apellido VARCHAR(20) NOT NULL,
    per_cedula INT(12) NOT NULL,
    per_telefono VARCHAR(20) NULL
);

-- historial empleados eliminados
CREATE TABLE historial_empleados_eliminados (
    per_nombre VARCHAR(20) NOT NULL,
    per_apellido VARCHAR(20) NOT NULL,
    per_cedula INT(12) NOT NULL,
    per_telefono VARCHAR(20) NULL,
    cargo_nombre VARCHAR(20) NOT NULL,
    cargo_salario DOUBLE
);
