create database Tienda 
---------DROPS DE TODAS LAS TABLAS-------
DROP TABLE DETALLEVENTA;
DROP TABLE TIPOPAGO;
DROP TABLE VENTA;
DROP TABLE EMPLEADO;
DROP TABLE CLIENTE;
DROP TABLE COMPRA_DETALLE;
DROP TABLE COMPRA;
DROP TABLE EXISTENCIA;
DROP TABLE PRODUCTO; 
DROP TABLE CATEGORIA;
DROP TABLE MARCA;
DROP TABLE SUCURSAL;
DROP TABLE PROVEEDOR;
DROP TABLE CIUDAD;
DROP TABLE ESTADO;
---------------------------------------
-----------CREACION DE TABLAS----------
-----------CREACION TABLA ESTADO-------
create table ESTADO
(idEstado int not null,
descripcion varchar(50),
estatus char (1) default 'A' NOT NULL,
constraint chkEstatusEstado check (estatus in('A','M','P','B')),
constraint pkestadoidestado primary key (idEstado)
);
-----------CREACION TABLA CIUDAD--------
create table CIUDAD
(idCiudad int not null,
descripcion varchar(50),
idEstado int not null,
estatus char (1) default 'A' NOT NULL,
constraint chkEstatusCiudad check (estatus in('A','M','P','B')),
constraint pkciudadidciudad primary key (idCiudad),
constraint fkestadoidestado foreign key (idEstado) references  ESTADO (idEstado)
ON DELETE CASCADE
);
----------CREACION TABLA CATEGORIA-------
create table CATEGORIA
(
idCategoria int not null,
descripcion varchar(25),
estatus char (1) default ('A') not null,
constraint chkEstatusCategoria check (estatus in('A','M','P','B')),
constraint pkcategoriaidcategoria primary key (idCategoria)
);
----------CREACION TABLA PROVEEDOR-------
create table PROVEEDOR
(
idProveedor int not null,
nombre varchar(30) not null,
calle varchar(20) not null,
numExt varchar(5) not null,
colonia varchar(20) not null,
cp char(5) not null,
email varchar(30) not null,
telefono char(10) null,
fechaReg date not null,
app varchar(15) not null,
apm varchar(15) null,
idCiudad int not null,
estatus char (1) default ('A') not null,
constraint chkEstatusProveedor check (estatus in('A','M','P','B')),
constraint pkproveedoridproveedor primary key (idProveedor),
constraint fkproveedoridciudad foreign key (idCiudad) references CIUDAD (idCiudad)
ON DELETE CASCADE
);
----------CREACION TABLA MARCA-------
create table MARCA(
idMarca int not null,
descripcion varchar(50),
estatus char (1) default ('A') not null,
constraint chkEstatusMarca check (estatus in('A','M','P','B')),
constraint pkmarcaidmarca primary key (idMarca)
);

----------CREACION TABLA SUCURSAL-------
create table SUCURSAL
(
idSucursal int not null,
calle varchar(20) not null,
numExt char(5) not null,
colonia varchar(30) not null,
cp char(5) not null,
email varchar(30) not null,
telefono char(10) not null,
idCiudad int not null,
estatus char (1) default ('A') not null,
constraint chkEstatusSucursal check (estatus in('A','M','P','B')),
constraint pksucursalidsucursal primary key (idSucursal),
constraint fksucursalidciudad foreign key (idCiudad) references CIUDAD (idCiudad)
ON DELETE CASCADE
);
----------CREACION TABLA PRODUCTO-------
create table PRODUCTO
(
idProducto int not null,
descripcion varchar(50),
precio money,
idMarca int,
idCategoria int,
estatus char (1) default ('A') not null,
constraint chkEstatusProducto check (estatus in('A','M','P','B')),
constraint pkproductoidproducto primary key (idProducto),
constraint fkmarcaidmarca foreign key (idMarca) references MARCA (idMarca)ON DELETE CASCADE,
constraint fkcategoriaidcategoria foreign key (idCategoria) references CATEGORIA (idCategoria) ON DELETE CASCADE
);
----------CREACION TABLA CLIENTE-------
create table CLIENTE
(
idCliente int not null,
nombre varchar(20) not null,
app varchar(20) not null,
apm varchar(20),
email varchar(30) not null,
calle varchar(20) not null,
numExt varchar(5) not null,
colonia varchar(20) not null,
cp char(5) not null,
celular char(10) not null,
fecNac date not null,
idCiudad int not null,
estatus char (1) default ('A') not null,
constraint chkEstatusCliente check (estatus in('A','M','P','B')),
constraint pkclienteidcliente primary key (idCliente),
constraint fkclienteidciudad foreign key (idCiudad) references CIUDAD (idCiudad)ON DELETE CASCADE
);
----------CREACION TABLA EMPLEADO-------
create table EMPLEADO
(
idEmpleado int not null,
nombre varchar(20) not null,
app varchar(20) not null,
apm varchar(20),
email varchar(30) not null,
calle varchar(20) not null,
numExt varchar(5) not null,
colonia varchar(20) not null,
cp char(5) not null,
celular char(10) not null,
fecNac date not null,
idCiudad int null,
idJefe int  null,
idSucursal int null,
estatus char (1) default 'A' NOT NULL,
nombreUsuario varchar(80) not null,
contrasena varchar(80) not null,
rango char(1) default 'B' not null,
constraint chkRangoUsuario check (rango in('A','B')),
constraint chkEstatusEmpleado check (estatus in('A','M','P','B')),
constraint pkempleadoidempleado primary key (idEmpleado),
constraint fkempleadoidciudad foreign key (idCiudad) references CIUDAD (idCiudad) ,
constraint fkempladoidjefe  foreign key (idJefe) references EMPLEADO (idEmpleado),
constraint fkEmpleadoidsucursal foreign key (idSucursal) references SUCURSAL (idSucursal),
constraint unNombreUsuario unique (nombreUsuario)
);
----------CREACION TABLA VENTA-------
create table VENTA
(
idVenta int not null,
fechaVenta date not null,
subTotal money not null,
iva money not null,
idCliente int not null,
idEmpleado int not null,
idSucursal int not null,
estatus char (1) default 'A' NOT NULL,
constraint chkEstatusVenta check (estatus in('A','M','P','B')),
constraint pkventaidventa primary key (idVenta),
constraint fkventaidcliente foreign key (idCliente) references CLIENTE (idCliente),
constraint fkventaidempleado foreign key (idEmpleado) references EMPLEADO (idEmpleado),
constraint fkventaidsucursal foreign key (idSucursal) references SUCURSAL (idSucursal)
);
----------CREACION TABLA DETALLEVENTA-------
create table DETALLEVENTA
(
idVenta int not null,
idProducto int not null,
cantidad int not null,
precio money not null,
estatus char (1) default 'A',
constraint chkEstatusDetalleVenta check (estatus in('A','M','P','B')),
constraint pkDetalleIdVentaIdProducto primary key (idVenta,idProducto),
constraint fkdetalleidVenta foreign key (idVenta) references VENTA (idVenta) ON DELETE CASCADE,
constraint fkdetalleidProducto foreign key (idProducto) references PRODUCTO (idProducto)ON DELETE CASCADE
);
----------CREACION TABLA TIPOPAGO-------
CREATE TABLE TIPOPAGO(
idVenta int not null,
tipoPago char(1) not null,
cantidad money default (0) not null,
estatus char (1) default ('A'),
constraint chkEstatusTipoPago check (estatus in('A','M','P','B')),
constraint fkTipoPagoidVenta foreign key (idVenta) references VENTA (idVenta) ON DELETE CASCADE,
constraint pktipoPago primary key (idVenta,tipoPago),
constraint ckTipoPago check (tipoPago in('T','E'))
);
----------CREACION TABLA COMPRA-------
Create table COMPRA (
idCompra int NOT NULL,
total money NOT NULL,
fechaCompra date DEFAULT(getdate()) not null,
idSucursal int,
idProveedor int,
estatus char (1) default 'A' NOT NULL,
constraint chkEstatusCompra check (estatus in('A','M','P','B')),
CONSTRAINT pkidCompraCompra PRIMARY KEY (idCompra),
CONSTRAINT fkidSucursalCompra FOREIGN KEY (idSucursal)
REFERENCES SUCURSAL (idSucursal),
CONSTRAINT fkidProvedoorCompra FOREIGN KEY (idProveedor)
REFERENCES PROVEEDOR (idProveedor)
);
----------CREACION TABLA COMPRA_DETALLE-------
CREATE TABLE COMPRA_DETALLE(
idCompra int not null,
idProducto int not null,
cantidad int not null,
precio money not null,
estatus char (1) default ('A') not null,
constraint chkEstatusCompraDetalle check (estatus in('A','M','P','B')),
constraint fkCOMPRA_DETALLEidCompra  foreign key (idCompra) references COMPRA (idCompra) ON DELETE CASCADE,
constraint fkProductoCompra foreign key (idProducto) references PRODUCTO (idProducto)ON DELETE CASCADE,
constraint pkcompradetalle primary key (idCompra,idProducto)
);
----------CREACION TABLA EXISTENCIA-------
CREATE TABLE EXISTENCIA(
idProducto int not null,
idSucursal int NOT NULL,
cantidad int default (1) not null,
estatus char (1) default ('A') not null,
constraint chkEstatusExistencia check (estatus in('A','M','P','B')),
constraint fkExistenciaidProducto foreign key (idProducto) references PRODUCTO (idProducto) ON DELETE CASCADE,
constraint fkExistenciaidSucursal foreign key (idSucursal) references SUCURSAL (idSucursal) ON DELETE CASCADE,
constraint pkProductoSucursal primary key (idProducto,IdSucursal));



------------A CONTINUACION SE MUESTRAN STORES PROCEDURES QUE SIRVIRAN PARA INSERTAR DATOS A LAS TABLAS------
-------------STORE PROCEDURE ESTADOS-------------------
--INSERTAR
--ESTADO
create procedure spAgregarEstado
@idEstado int, 
@descripcion VARCHAR(50)
as
begin
IF((SELECT COUNT(e.idEstado) FROM ESTADO e WHERE e.idEstado = @idEstado))=1
 BEGIN
  PRINT('Ya existe un estado registrado con este numero')
  END 
ELSE
BEGIN
  INSERT INTO  ESTADO (idEstado,descripcion) VALUES(@idEstado, @descripcion);
    PRINT('Se ha agregado correctamente')
 END   
END
select*from ESTADO

--EXECUTE PARA INSERTAR ESTADOS-------
  EXECUTE spAgregarEstado 1,'Nuevo Leon'
  EXECUTE spAgregarEstado 2,'CDMX'
  EXECUTE spAgregarEstado 3,'Jalisco'
  EXECUTE spAgregarEstado 4,'Coahuila'
  EXECUTE spAgregarEstado 5,'Tamaulipas'
  EXECUTE spAgregarEstado 6,'Michoacan'
  EXECUTE spAgregarEstado 7,'Chiapas'
  EXECUTE spAgregarEstado 8,'Sinaloa'
  EXECUTE spAgregarEstado 9,'Yucatan'
  EXECUTE spAgregarEstado 10,'Sonora'
-------------STORE PROCEDURE CIUDAD-------------------
--INSERTAR
--CIUDAD
create  Procedure spAgregarCiudad  
@idCiudad INT, 
@descripcion VARCHAR(50), 
@idEstado INT
AS
BEGIN

IF (SELECT COUNT(c.idCiudad)  FROM CIUDAD c WHERE c.idCiudad = @idCiudad)=1
	BEGIN
		PRINT('Ya existe una ciudad registrado con este numero')
	END 
ELSE
	BEGIN 
		INSERT INTO CIUDAD (idCiudad, descripcion, idEstado) VALUES(@idCiudad, @descripcion, @idEstado);
		PRINT('Se ha agregado correctamente')
	END    
END 

---EXECUTE PARA INSERTAR DATOS-------
execute spAgregarCiudad 1,'Escobedo', 1
execute spAgregarCiudad 2,'Apodaca', 1
execute spAgregarCiudad 3,'Cadereyta', 1
execute spAgregarCiudad 4,'San Nicolas', 1
execute spAgregarCiudad 5,'Guadalupe', 1
execute spAgregarCiudad 6,'Monterrey', 1
execute spAgregarCiudad 7,'Coyoacan', 2
execute spAgregarCiudad 8,'Iztapalapa', 2
execute spAgregarCiudad 9,'Xochimilco', 2
execute spAgregarCiudad 10,'Azcapotzalco', 2
execute spAgregarCiudad 11,'Guadalajara', 3
execute spAgregarCiudad 12,'Zapopan', 3
execute spAgregarCiudad 13,'Tequila', 3
execute spAgregarCiudad 14,'Tonala', 3
execute spAgregarCiudad 15,'Lagos de Moreno', 3
execute spAgregarCiudad 16,'Saltillo', 4
execute spAgregarCiudad 17,'Ciudad Acuña', 4
execute spAgregarCiudad 18,'Torreón', 4
execute spAgregarCiudad 19,'Ciudad Victoria', 5
execute spAgregarCiudad 20,'Tampico', 5
execute spAgregarCiudad 21,'Reynosa', 5
execute spAgregarCiudad 22,'Morelia', 6
execute spAgregarCiudad 23,'Patzcuaro', 6
execute spAgregarCiudad 24,'Tuxla Gutierrez', 7
execute spAgregarCiudad 25,'Palenque', 7
execute spAgregarCiudad 26,'Culiacan', 8
execute spAgregarCiudad 27,'Mazatlan', 8
execute spAgregarCiudad 28,'Merida', 9
execute spAgregarCiudad 29,'Valladolid', 9
execute spAgregarCiudad 30,'Nogales', 10
execute spAgregarCiudad 31,'Ciudad Obregón', 10

-------------STORE PROCEDURE PROVEEDOR-------------------
--INSERTAR
--PROVEEDOR
create procedure spAgregarProveedor
@idProveedor int,
@nombre varchar(30),
@calle varchar(20),
@numExt varchar(5),
@colonia varchar(20),
@cp char(5),
@email varchar(30),
@telefono char(10),
@fechaReg date,
@app varchar(15),
@apm varchar(15),
@idCiudad int
AS
BEGIN

IF (SELECT COUNT(p.idProveedor)  FROM PROVEEDOR p  WHERE p.idProveedor = @idProveedor)=1
	BEGIN
		PRINT('Ya existe un proveedor registrado con este numero')
	END 
ELSE
	BEGIN 
		INSERT INTO PROVEEDOR (idProveedor, nombre,calle,numExt,colonia,cp,email,telefono,fechaReg,app,apm,idCiudad)
		VALUES(@idProveedor, @nombre,@calle,@numExt,@colonia,@cp,@email,@telefono,@fechaReg,@app,@apm,@idCiudad);
		PRINT('Se ha agregado correctamente')
	END   
END 

 ---EXECUTE PARA INSERTAR DATOS-------
    execute spAgregarProveedor 1,'Enrique','Mercurio','140','Acapulco','66040','Enrique@hotmail.com','8123456781','01/01/2019','Carrillo','Moreno',5
    execute spAgregarProveedor 2,'Angel','Sianuro','141','Acero','67190','Angel@hotmail.com','8123456782','05/03/2019','Escamilla','Villareal',6
    execute spAgregarProveedor 3,'Juan','Lopez M','145','Manzana','66360','Juan@gmail.com','8123456783','10/05/2018','Mata','Lopez',4
    execute spAgregarProveedor 4,'Francisco','Agua Fria','125','Mercurio','66010','Paco@hotmail.com','8123456784','05/05/2019','Martinez','Yee',6
    execute spAgregarProveedor 5,'Diego','Alfareros','896','Siempre Viva','66120','Rojo@gmail.com','8123456785','04/03/2017','Rojo','Milan',7
    execute spAgregarProveedor 6,'Alan ','Monterreal','567','Oro','66050','Piton_69@gmail.com','8123456786','09/05/2016','Pitones','De Leon',1
    execute spAgregarProveedor 7,'Israel','Miravista','245','Fierro','66050','Hot_69@hotmail.com','8123456787','06/06/2019','Hernandez','Gonzalez',1
    execute spAgregarProveedor 8,'Milton','Girasoles','190','Potasio','66030','Milton@gmail.com','8123456788','04/02/2019','Gonzalez','Guerrero',1
    execute spAgregarProveedor 9,'Joaquin','Anahuac','190','Canserbero','66070','JFortnite@gmail.com','8198765432','05/07/2015','Flores','Alcala',4
    execute spAgregarProveedor 10,'Irving','Ebanos','146','Golosos','66030','IGoloso@hotmail.com','8123455780','30/01/2015','De Leon','De la Garza',2
    
-------------STORE PROCEDURE MARCA-------------------
--INSERTAR
--MARCA
create procedure spAgregarMarca
@idMarca INT,
@descripcion VARCHAR(50)
AS
BEGIN
IF (SELECT COUNT(m.idMarca)  FROM MARCA m  WHERE m.idMarca = @idMarca)=1
  BEGIN
		PRINT('Ya existe una marca registrado con este numero')
  END   
ELSE
	BEGIN
		INSERT INTO MARCA (idMarca, descripcion) VALUES(@idMarca, @descripcion);
		PRINT('Se ha agregado correctamente')
	END 
  end
  
 ---EXECUTE PARA INSERTAR DATOS-------
  execute  spAgregarMarca 1,'SICO'
  execute  spAgregarMarca 2,'BAD DRAGON'
  execute  spAgregarMarca 3,'BAD BABY'
  execute  spAgregarMarca 4,'TRONCOSO'
  execute  spAgregarMarca 5,'MILTONTIP'
  execute  spAgregarMarca 6,'POWERSOFT'
  execute  spAgregarMarca 7,'GALLOENDUDA'
  execute  spAgregarMarca 8,'LTI'
  execute  spAgregarMarca 9,'EXXXTINCION'
  execute  spAgregarMarca 10,'PINKCHERRY'
-------------STORE PROCEDURE CLIENTE-------------------
--INSERTAR
--CLIENTE
create PROCEDURE spAgregarCliente
  @idCliente int,
  @nombre varchar(20),
  @app varchar(20),
  @apm varchar(20),
  @email varchar(30),
  @calle varchar(20),
  @colonia  varchar(20),
  @numExt varchar(5),
  @cp char(5),
  @celular char(10),
  @fecNac date,
  @idCiudad int
AS
BEGIN
IF (SELECT COUNT (C.idCliente) FROM CLIENTE C WHERE C.idCliente = @idCliente)=1
	BEGIN
		PRINT('Ya existe un cliente registrado con este numero')
	END 
ELSE
	BEGIN
		INSERT INTO CLIENTE (idCliente, nombre, app, apm, email, calle, numExt,colonia, cp, celular, fecNac, idCiudad)
		VALUES(@idCliente, @nombre, @app, @apm, @email, @calle, @numExt,@colonia, @cp, @celular, @fecNac, @idCiudad);
		PRINT('Se ha agregado correctamente')
	END
END

---EXECUTE PARA INSERTAR DATOS-------

EXECUTE SPAGREGARCLIENTE 1, 'eduardo', 'ramirez', 'gonzalez', 'eduardoramirez@gmail.com', 'san pedro', 'san nicolas','309', '65059', '8184537981', '09/04/1994', 1
EXECUTE SPAGREGARCLIENTE 2, 'roberto', 'rangel', NULL, 'robertorangel@gmail.com', 'palmas','san peter', '219', '65031', '8117534786', '12/12/1992', 1
EXECUTE SPAGREGARCLIENTE 3, 'angel', 'hernandez', 'castillo', 'angelhernandez@gmail.com', 'san juan','san lorenzo', '1456', '65354', '8134769002', '25/06/2000', 3
EXECUTE SPAGREGARCLIENTE 4, 'carlos', 'ruiz', NULL, 'carlosruiz@gmail.com', 'santa julia','papaya', '2302', '64064', '8281834100', '07/03/2001', 2
EXECUTE SPAGREGARCLIENTE 5, 'daniel', 'lopez', 'sifuentes', 'daniellopez@gmail.com', 'mercurio','guayaba', '317', '64120', '8134592112', '17/02/1999', 2
EXECUTE SPAGREGARCLIENTE 6, 'jair', 'guzman', 'quintero', 'jairguzman@gmail.com', 'san antonio','tomate', '354', '68903', '8120209136', '11/05/1997', 5
EXECUTE SPAGREGARCLIENTE 7, 'ivan', 'moreno', 'araiza', 'ivanmoreno@gmail.com', 'rubidio','morelos', '1024', '68491', '8195124907', '21/01/1995', 5
EXECUTE SPAGREGARCLIENTE 8, 'lorenzo', 'cardenaz', NULL, 'lorenzocardenaz@gmail.com', 'benito','indepe', '117', '65065', '8181189045', '09/10/1991', 1
EXECUTE SPAGREGARCLIENTE 9, 'america', 'carranza', 'muñoz', 'americacarranza@gmail.com', 'platino','san berna', '2367','66213', '8134218907', '10/09/1993', 2
EXECUTE SPAGREGARCLIENTE 10, 'luis', 'muñiz', 'arriaga', 'luismuñiz@gmail.com', 'cromo','fomerrey', '109', '68921', '8112457637', '15/07/2001', 5
EXECUTE SPAGREGARCLIENTE 11, 'fatima', 'garcia', NULL, 'fatimagarcia@gmail.com', 'vanadio','platano', '5519', '67217', '8155548712', '13/12/2000', 3
EXECUTE SPAGREGARCLIENTE 12, 'berenice', 'mata', 'lopez', 'berenicemata@gmail.com', 'juarez','papa', '601', '67916', '8134725809', '23/02/1992', 2
EXECUTE SPAGREGARCLIENTE 13, 'mario', 'arriaga', 'martinez', 'marioarriaga@gmail.com', 'san lorenzo','Papa Francisco', '7007', '67010', '8184422903', '22/11/1999', 4
EXECUTE SPAGREGARCLIENTE 14, 'citlaly', 'ruiz', 'quintero', 'citlalyruiz@gmail.com', 'san isidro','Morelos', '304', '64021', '8149248456', '30/12/1998', 3
EXECUTE SPAGREGARCLIENTE 15, 'maria', 'cortez' ,'lopez', 'mariacortez@gmail.com', 'plomo','Calcio', '1129', '66467', '8123236571', '12/05/1996', 2
--ESTE SERA EL CLIENTE QUE NO NECESITE REGISTRO Y SERA ANONIMO
EXECUTE SPAGREGARCLIENTE 16, 'anonimo', 'anonimo' ,'anonimo', 'anonimo', 'sin calle','sin colonia', '000', '00000', '0000000000', '12/05/1996', 1

-------------STORE PROCEDURE SUCURSAL-------------------
--INSERTAR
--SUCURSAL
create  PROCEDURE spAgregarSucursal
    @IdSucursal int,
    @Calle varchar(20),
    @NumExt varchar(5),
    @Colonia varchar(30),
    @Cp char(5),
    @Email varchar(30),
    @Telefono char(10),
    @IdCiudad int
AS
BEGIN
	IF(SELECT COUNT(s.idSucursal) FROM SUCURSAL s WHERE s.idSucursal=@IdSucursal)=1
		BEGIN
			PRINT('Ya existe una sucursal registrado con este numero')       
		END
     ELSE
		BEGIN
		 INSERT INTO SUCURSAL (IdSucursal,Calle,NumExt,Colonia,Cp,Email,Telefono,IdCiudad)
		  VALUES(@IdSucursal,@Calle,@NumExt,@Colonia,@Cp,@Email,@Telefono,@IdCiudad);
		 PRINT('Se ha agregado correctamente')
		END
END

---EXECUTE PARA INSERTAR DATOS-------
EXECUTE spAgregarSucursal 111,'Mimas','23423','Linda Vista','66612','orgasmos@outlook.com','8181808084',1
EXECUTE spAgregarSucursal 112,'Encelado','23342','Frausto','23425','sex@outlook.com','5542334322',5
EXECUTE spAgregarSucursal 113,'Tetis','25623','Concordia','23412','vintage@outlook.com','8184356324',2
EXECUTE spAgregarSucursal 114,'Marron','76443','Apodaca','54332','venusApo@outlook.com','8181808084',11
EXECUTE spAgregarSucursal 115,'Moscu','26723','Gudalupe','43234','venusGuadalupe@outlook.com','8181808084',3
EXECUTE spAgregarSucursal 116,'Marte','23643','Sendero','63212','sexShopSen@outlook.com','8153245678',9
EXECUTE spAgregarSucursal 117,'Venus','65423','Terminal','66612','Terminalporn@outlook.com','8154334564',6
EXECUTE spAgregarSucursal 118,'Andromeda','76443','Cantu','63423','org@outlook.com','8181808084',8
EXECUTE spAgregarSucursal 119,'Rea','45564','Industrial','63242','ventasSexShop@outlook.com','8154356456',1
EXECUTE spAgregarSucursal 110,'Lombardini','24543','Vicente Guerrero','62312','milton@outlook.com','8143456754',13

-------------STORE PROCEDURE Categoria-------------------
--INSERTAR
--Categoria
create Procedure spAgregarCategoria
@idCategoria INT,
@descripcion VARCHAR(25)
AS
BEGIN

IF(SELECT COUNT(c.idCategoria) FROM CATEGORIA c  WHERE c.idCategoria = @idCategoria)=1
		BEGIN
			PRINT('Ya existe una categoria registrado con este numero')       
		END  
  ELSE
		BEGIN
			INSERT INTO CATEGORIA (idCategoria, descripcion) VALUES(@idCategoria, @descripcion);
			PRINT('Se ha agregado correctamente')
		END  
END
  
        
---EXECUTE PARA INSERTAR DATOS-------    
    execute spAgregarCategoria 1,'Estimulacion'
    execute spAgregarCategoria 2,'Vibracion'
    execute spAgregarCategoria 3,'Comestibles'
    execute spAgregarCategoria 4,'Aceites'
    execute spAgregarCategoria 5,'Lubricantes'
    execute spAgregarCategoria 6,'Lenceria'
    execute spAgregarCategoria 7,'Disfraces'
    execute spAgregarCategoria 8,'Para ella'
    execute spAgregarCategoria 9,'Para el'
    execute spAgregarCategoria 10,'Juguetes'

-------------STORE PROCEDURE PRODUCTO-------------------
--INSERTAR
--PRODUCTO
create  procedure spAgregarProducto
@idProducto INT,
@descripcion varchar(50),
@precio MONEY,
@idMarca INT,
@idCategoria INT
AS
BEGIN
IF (SELECT COUNT(P.idProducto)  FROM PRODUCTO P  WHERE P.idProducto = @idProducto)=1
		BEGIN
			PRINT('Ya existe un producto registrado con este numero')       
		END    
  ELSE
		BEGIN
			INSERT INTO PRODUCTO (idProducto, descripcion,precio,idMarca,idCategoria)
			VALUES(@idProducto, @descripcion,@precio,@idMarca,@idCategoria);
			PRINT('Se ha agregado correctamente')
		END 
END
---EXECUTE PARA INSERTAR DATOS-------
execute spAgregarProducto 1,'Dildo',350.00,1,2
execute spAgregarProducto 2,'Anillo V',250.00,1,2
execute spAgregarProducto 3,'Lubricante',0490.00,2,5
execute spAgregarProducto 4,'Masturbador',1900.00,3,1
execute spAgregarProducto 5,'Conjunto Strappy',0445.00,4,6
execute spAgregarProducto 6,'Cuerda de Seda',470.00,7,10
execute spAgregarProducto 7,'Abrazadera de clitoris',340.00,7,8
execute spAgregarProducto 8,'Intensificador',0188.00,9,3
execute spAgregarProducto 9,'Trust Me',0843.00,5,10
execute spAgregarProducto 10,'Aceite base agua',0555.00,5,4
execute spAgregarProducto 11,'Conejita',1600.00,6,7
execute spAgregarProducto 12,'Retardador',0417.00,8,9
execute spAgregarProducto 13,'Condones',100.00,1,9

-------------STORE PROCEDURE EMPLEADO-------------------
--INSERTAR
--EMPLEADO
 alter procedure spAgregarEmpleado
@IdEmpleado INT,
@Nombre VARCHAR(20),
@ApellidoPaterno  VARCHAR(20),
@ApellidoMaterno  VARCHAR(20),
@Email  VARCHAR(30),
@Calle  VARCHAR(20),
@NumExt  CHAR(5),
@Col  VARCHAR(20),
@Cp  CHAR(5),
@Celular CHAR(10),
@fecNac DATE,
@idCiudad INT,
@IdJefe INT,
@IdSucursal INT,
@nombreUsuario varchar(80),
@contrasena varchar(80),
@rango char(1)
AS
BEGIN
IF (SELECT COUNT(Em.idEmpleado) FROM EMPLEADO Em WHERE Em.idEmpleado = @IdEmpleado)=1
	BEGIN
		PRINT('Ya existe un empleado registrado con este numero')   
	END
ELSE 	
begin
	IF(SELECT COUNT(idEmpleado) FROM EMPLEADO where nombreUsuario=@nombreUsuario)=1
	begin
		PRINT('Ya existe un empleado con ese usuario')   
		end
	Else
	begin
		INSERT INTO Empleado (IdEmpleado,Nombre, app,apm,Email,Calle,colonia,NumExt,Cp, Celular,fecNac,idCiudad,IdJefe,IdSucursal,nombreUsuario,contrasena,rango)
		VALUES(@IdEmpleado,@Nombre, @ApellidoPaterno,@ApellidoMaterno,@Email,@Calle,@Col,@NumExt,@Cp, @Celular,@fecNac,@idCiudad,@IdJefe,@IdSucursal,@nombreUsuario,@contrasena,@rango);
		PRINT('Se ha agregado correctamente')
		end
end
END 


select*from EMPLEADO

---EXECUTE PARA INSERTAR DATOS-------
EXECUTE spAgregarempleado 1,'Juan Alberto','Perez','Lopez','JuanMtz@gmail.com','Gonzalitos','Paricutin','123','67458','8281023658','28/10/95',10,1,111,'Camacho','123','A'
EXECUTE spAgregarempleado 2,'Francisco Javier','Rodriguez','Lisboa','franciscoj@gmail.com','General Trevino','Barragan','321','45687','8542459687','21/10/95',10,1,111,'1Camacho','123','B'
EXECUTE spAgregarempleado 3,'Angelica Laura','Hernandez','Garcia','angelicalaura@gmail.com','Aguistin','Roble','453','68745','1312457865','12/12/95',10,1,111,'2Camacho','123','B'
EXECUTE spAgregarempleado 11,'Diana Juana','Martinez','Morillo','dianita55@gmail.com','Emi Zapata','Manzano','452','68842','1346578945','04/10/95',1,11,113,'3Camacho','123','B'
EXECUTE spAgregarempleado 12,'Pedro Hector','Retta','Lubo','elpeter112@gmail.com','Constitucion','Arboleda','865','57854','5567984312','28/07/96',1,11,113,'4Camacho','123','B'
EXECUTE spAgregarempleado 13,'Hugo de Jesus','Reyna','Ramos','hugote99@gmail.com','Real','Constitucion','654','42158','4667984130','30/01/94',1,11,113,'5Camacho','123','B'
EXECUTE spAgregarempleado 21,'Luis Norberto','Garza','Ortiz','luisnobe@gmail.com','Nueva','Paricutin','524','21458','4619978453','12/11/93',3,21,115,'6Camacho','123','B'
EXECUTE spAgregarempleado 22,'Isaac','Pitones','Zambrano','isaac@gmail.com','Sol','Indepe','354','48975','4651379845','07/06/90',3,21,115,'7Camacho','123','B'
EXECUTE spAgregarempleado 23,'Daniel Ramiro','Garza','Garcia','danielnaruto@gmail.com','Espana','Valle Soleado','453','48724','2346157948','04/07/99',3,21,115,'8Camacho','123','B'
EXECUTE spAgregarempleado 31,'Cesar Alberto','Aguirre','Torres','elcesarsoske@gmail.com','San Juan','Paricutin','1523','97854','4613259784','28/10/89',2,31,119,'Camacho','123','B'
EXECUTE spAgregarempleado 32,'Francisco Israel','Araujo','Salazar','panchito@gmail.com','Fuente','Valle de Mitras','1323','98754','3124576378','28/12/96',2,31,119,'10Camacho','123','B'
EXECUTE spAgregarempleado 33,'Edgar Obed','Solis','Lopez','elegarobed12@gmail.com','Peral','Valle de Martin','345','54248','6987451321','28/10/92',2,31,119,'11Camacho','123','B'
EXECUTE spAgregarempleado 41,'Irvito','Ruiz','Rodriguez','irvitofornais@gmail.com','Rosales','Colo Colo','789','87544','4613287549','28/10/91',11,41,114,'12Camacho','123','B'
EXECUTE spAgregarempleado 42,'Lolito Susano','Fernandez','Martinez','lolito69@gmail.com','Via Lactea','Guadalupe','354','12354','1234657894','28/10/90',11,41,114,'13Camacho','123','B'
EXECUTE spAgregarempleado 43,'Naruto Hugo','Bravo','Rossi','narutorap3@gmail.com','Marte','Mar Azul','857','12345','6943125874','28/10/99',11,41,114,'14Camacho','123','B'
EXECUTE spAgregarempleado 51,'Abigail','Vargas','Rochi','Abi420@gmail.com','Andromeda','Mara Salvatrucha','978','36451','4613258794','28/10/98',9,51,116,'15Camacho','123','B'
EXECUTE spAgregarempleado 52,'Lizeth','Marquez','Lexington','LizzymcGuire@gmail.com','Lucifer','Francisco','6544','34458','2213064805','28/10/90',9,51,116,'16Camacho','123','B'
EXECUTE spAgregarempleado 53,'Francisco Daniel','Matthews','Lopez','yomero99@gmail.com','San Mateo','Pancho VIlla','357','34587','2100346747','28/10/87',9,51,116,'17Camacho','123','B'
EXECUTE spAgregarempleado 61,'Luis Coria','Yee','Pierce','coriacoria5@gmail.com','Iglesia','Revolucion','894','74511','1032645874','28/10/80',6,61,117,'18Camacho','123','B'
EXECUTE spAgregarempleado 62,'Victoria','Lira','Gallagher','vickylira@gmail.com','Amor','Mexico','478','88545','1234657890','28/10/95',6,61,117,'19Camacho','123','B'
EXECUTE spAgregarempleado 63,'Barbara','Socorro','Moore','barbs@gmail.com','Vino','Guatemala','652','88998','8281009886','28/10/79',6,61,117,'20Camacho','123','B'

-------------STORE PROCEDURE Existencia-------------------
--INSERTAR
---Agregar Existencia

create PROCEDURE spAgregarExistencia
(
 @IdSucursal INT,
 @IdProducto INT,
 @Cantidad INT
)
AS
BEGIN
IF(SELECT COUNT(*)  FROM EXISTENCIA E  WHERE E.idProducto = @IdProducto and E.IdSucursal = @IdSucursal)=1
	BEGIN 
		PRINT('Ya esta registrado con este numero') 
	END 
  ELSE
	BEGIN
		INSERT INTO EXISTENCIA (IdProducto,IdSucursal,Cantidad)
		VALUES(@IdProducto,@IdSucursal,@Cantidad);
		PRINT('Se ha agregado correctamente')
	END 
  END                                 
  ---EXECUTE PARA INSERTAR DATOS------- 
EXECUTE spAgregarExistencia 110,13,100
EXECUTE spAgregarExistencia 110,3,15
EXECUTE spAgregarExistencia 110,5,2
EXECUTE spAgregarExistencia 111,13,70
EXECUTE spAgregarExistencia 111,2,2
EXECUTE spAgregarExistencia 111,6,6
EXECUTE spAgregarExistencia 112,13,63
EXECUTE spAgregarExistencia 112,12,10
EXECUTE spAgregarExistencia 112,10,10
EXECUTE spAgregarExistencia 113,13,63
EXECUTE spAgregarExistencia 113,7,13
EXECUTE spAgregarExistencia 113,1,20
EXECUTE spAgregarExistencia 114,13,231
EXECUTE spAgregarExistencia 114,1,20
EXECUTE spAgregarExistencia 114,11,12
EXECUTE spAgregarExistencia 115,13,99
EXECUTE spAgregarExistencia 115,12,13
EXECUTE spAgregarExistencia 115,5,2
EXECUTE spAgregarExistencia 116,2,21
EXECUTE spAgregarExistencia 116,13,60
EXECUTE spAgregarExistencia 116,8,11
EXECUTE spAgregarExistencia 117,13,50
EXECUTE spAgregarExistencia 117,7,8
EXECUTE spAgregarExistencia 117,6,15
EXECUTE spAgregarExistencia 118,13,82
EXECUTE spAgregarExistencia 118,1,13
EXECUTE spAgregarExistencia 118,10,20
EXECUTE spAgregarExistencia 119,13,79
EXECUTE spAgregarExistencia 119,1,12
EXECUTE spAgregarExistencia 119,9,1
execute spAgregarExistencia 112,1,28
execute spAgregarExistencia 112,2,12
execute spAgregarExistencia 112,3,8
execute spAgregarExistencia 112,4,4
execute spAgregarExistencia 112,5,24
execute spAgregarExistencia 112,6,25
execute spAgregarExistencia 112,7,19
execute spAgregarExistencia 112,8,42
execute spAgregarExistencia 112,9,8

-------------STORE PROCEDURE COMPRA-------------------
--INSERTAR
--COMPRA
create procedure spAgregarCompra
@idCompra INT,
@total MONEY,
@fechaCompra DATE,
@idSucursal INT,
@idProveedor INT
as
begin

IF(SELECT COUNT(c.idCompra)  FROM COMPRA c WHERE c.idCompra=@idCompra)=1
	begin
		PRINT('Ya esta registrado con este numero') 
    end 
  ELSE
  begin
   INSERT INTO COMPRA (idCompra, total,fechaCompra ,idSucursal,idProveedor) 
   VALUES(@idCompra, @total,@fechaCompra ,@idSucursal,@idProveedor);
   PRINT('Se ha agregado correctamente')
  END 
end
---EXECUTE PARA INSERTAR DATOS-------
EXECUTE spAgregarCompra 1,10000.00,'04/05/2019',112,1
EXECUTE spAgregarCompra 2,3000.00,'06/07/2018',112,3
EXECUTE spAgregarCompra 3,4000.00,'03/09/2019',112,4
EXECUTE spAgregarCompra 4,8000.00,'04/10/2019',112,5
EXECUTE spAgregarCompra 5,11000.00,'04/08/2019',112,1
EXECUTE spAgregarCompra 6,12000.00,'04/06/2019',112,3
EXECUTE spAgregarCompra 7,9000.00,'04/05/2019',112,2
EXECUTE spAgregarCompra 8,8000.00,'04/02/2019',112,6
EXECUTE spAgregarCompra 9,7000.00,'04/01/2019',112,8
EXECUTE spAgregarCompra 10,5000.00,'04/03/2019',112,10


-------------STORE PROCEDURE COMPRA DETALLE-------------------
--INSERTAR
---Agregar COMPRA DETALLE
create procedure spAgregarCompraDetalle
 @idCompra int,
 @idProducto int,
 @cantidad int,
 @precio int
as
begin
if (SELECT COUNT(CD.idCompra)  FROM COMPRA_DETALLE CD  WHERE CD.idCompra = @idCompra and CD.idProducto=@idProducto)=1  
	begin
		PRINT('Ya esta registrado con este numero') 
	end  
  ELSE
	begin
		INSERT INTO COMPRA_DETALLE (idCompra, idProducto,cantidad,precio) 
		VALUES(@idCompra, @idProducto,@cantidad,@precio); 
		PRINT('Se ha agregado correctamente')
	END 
  end
  
---EXECUTE PARA INSERTAR DATOS-------   
    execute spAgregarCompraDetalle 1,1,28,10000
    execute spAgregarCompraDetalle 2,2,12,3000
    execute spAgregarCompraDetalle 3,3,8,4000
    execute spAgregarCompraDetalle 4,4,4,8000
    execute spAgregarCompraDetalle 5,5,24,11000
    execute spAgregarCompraDetalle 6,6,25,12000
    execute spAgregarCompraDetalle 7,7,19,9000
    execute spAgregarCompraDetalle 8,8,42,8000
    execute spAgregarCompraDetalle 9,9,8,7000
    execute spAgregarCompraDetalle 10,10,9,5000 

-------------STORE PROCEDURE VENTA-------------------
--INSERTAR
--VENTA
create procedure spAgregarVenta

@idVenta int,
@fecVen date,
@subTotal money,
@iva money,
@idCliente int,
@idEmpleado int,
@idSucursal int
as
begin
if(SELECT COUNT(v.idVenta)  FROM VENTA v WHERE v.idVenta = @idVenta)=1
	begin
		PRINT('Ya esta registrada la venta con este numero')
	end
  ELSE
	begin
		INSERT INTO VENTA (idVenta, fechaVenta, subTotal, iva, idCliente, idEmpleado,idSucursal)
		VALUES(@idVenta, @fecVen, @subTotal, @iva, @idCliente, @idEmpleado,@idSucursal);  
		PRINT('Se ha agregado correctamente')
	END 
END
---EXECUTE PARA INSERTAR DATOS-------
  EXECUTE spAgregarVenta 1,'04/05/2019',1000.50,160.50,4,3,111
  EXECUTE spAgregarVenta 2,'05/03/2019',1400.00,224.50,3,2,111
  EXECUTE spAgregarVenta 3,'31/12/2018',900.50,144.00,5,1,111
  EXECUTE spAgregarVenta 4,'25/05/2019',1200.00,192.00,2,3,111
  EXECUTE spAgregarVenta 5,'23/03/2019',1000.00,160.00,6,22,115
  EXECUTE spAgregarVenta 6,'14/06/2019',1200.00,192.00,8,23,115
  EXECUTE spAgregarVenta 7,'05/10/2019',1000.00,160.00,4,21,115
  EXECUTE spAgregarVenta 8,'09/03/2019',900.50,144.00,6,3,111
  EXECUTE spAgregarVenta 9,'25/07/2017',1400.00,224.50,9,61,117
  EXECUTE spAgregarVenta 10,'29/04/2019',1200.00,192.00,6,62,117
  EXECUTE spAgregarVenta 11,'29/04/2019',200.00,32.00,6,62,117
  EXECUTE spAgregarVenta 12,'30/04/2019',100.00,16.00,6,62,117
  
-------------STORE PROCEDURE DETALLE VENTA-------------------
--INSERTAR
--DETALLE VENTA
create procedure spAgregarDetalleVenta
@idVenta INT,
@idProducto INT,
@cantidad INT,
@precio MONEY
AS
begin
IF (SELECT COUNT(dv.idVenta)  FROM DETALLEVENTA dv WHERE dv.idVenta = @idVenta and dv.idProducto=@idProducto)=1
  BEGIN
	PRINT('Ya esta registrado con este numero')
  END
  ELSE
  begin
   INSERT INTO DETALLEVENTA (idVenta, idProducto, cantidad,precio)
    VALUES(@idVenta, @idProducto, @cantidad,@precio);
   	PRINT('Se ha agregado correctamente')
  END 
END
---EXECUTE PARA INSERTAR DATOS-------
  EXECUTE spAgregarDetalleVenta 1,5,3,333.50
  EXECUTE spAgregarDetalleVenta 2,5,4,466.66
  EXECUTE spAgregarDetalleVenta 3,2,3,300.16
  EXECUTE spAgregarDetalleVenta 4,9,2,600.00
  EXECUTE spAgregarDetalleVenta 5,11,3,333.33
  EXECUTE spAgregarDetalleVenta 6,2,1,1200.00
  EXECUTE spAgregarDetalleVenta 7,3,4,250.00
  EXECUTE spAgregarDetalleVenta 8,9,4,225.12
  EXECUTE spAgregarDetalleVenta 9,5,3,333.33
  EXECUTE spAgregarDetalleVenta 10,1,5,240.00
  EXECUTE spAgregarDetalleVenta 11,13,2,200.00
  EXECUTE spAgregarDetalleVenta 12,13,1,100.00

-------------STORE PROCEDURE TIPO PAGO-------------------
--INSERTAR
--Aregar TIPO PAGO
create  procedure spAgregarTipoPago
@idVenta int,
@tipoPago char(1),
@Cantidad int
as
begin
	if (SELECT COUNT(*) FROM TIPOPAGO t WHERE t.idVenta=@idVenta and t.tipoPago=@tipoPago)=1
	begin
		PRINT('Ya esta registrado con este numero')
	end  
  ELSE	
	begin
		INSERT INTO TIPOPAGO (idVenta, tipoPago,Cantidad) 
		VALUES(@idVenta, @tipoPago,@Cantidad);   
		PRINT('Se ha agregado correctamente') 
	END 
end
---EXECUTE PARA INSERTAR DATOS-------
  EXECUTE spAgregarTipoPago 1,'T',1000.00
  EXECUTE spAgregarTipoPago 1,'E',161.00
  EXECUTE spAgregarTipoPago 2,'E',1624.50
  EXECUTE spAgregarTipoPago 3,'E',1044.50
  EXECUTE spAgregarTipoPago 4,'T',1392.00
  EXECUTE spAgregarTipoPago 5,'E',1160.00
  EXECUTE spAgregarTipoPago 6,'T',1392.00
  EXECUTE spAgregarTipoPago 7,'E',1160.00
  EXECUTE spAgregarTipoPago 8,'T',1044.50
  EXECUTE spAgregarTipoPago 9,'E',1624.50
  EXECUTE spAgregarTipoPago 10,'T',1392.00



----------------------STORE PROCEDURE PARA BUSCAR UNA SUCURSAL------------------
--Buscar SUCURSAL
--Creacion del store
CREATE PROCEDURE spBuscarSucursal
   @IdSucursal int  
AS
BEGIN
     SELECT * FROM SUCURSAL WHERE idSucursal=@IdSucursal;
END


EXECUTE spBuscarSucursal 111

--------------------------------------------------------------------------------

---------------------Stores Actualizar---------------------------------
create PROCEDURE spActualizarProveedor
@idProveedor int,
@nombre varchar(30),
@calle varchar(20),
@numExt varchar(5),
@colonia varchar(20),
@cp char(5),
@email varchar(30),
@telefono char(10),
@fechaReg date,
@app varchar(15),
@apm varchar(15),
@idCiudad int
as
BEGIN 
 IF (SELECT COUNT(m.idProveedor)  FROM PROVEEDOR m WHERE m.idProveedor = @idProveedor) !=1
	BEGIN
		PRINT('No existe un número de proveedor con la clave enviada')
	END
ELSE 
BEGIN
  UPDATE PROVEEDOR SET estatus='M',nombre = @nombre, calle=@calle, numExt=@numExt, colonia=@colonia, cp=@cp, email=@email, telefono=@telefono, fechaReg=@fechaReg WHERE idProveedor= @idProveedor; 
  PRINT('Se ha actualizado correctamente')
 END 
END

 EXECUTE spActualizarProveedor 1,'Enrique','Mercurio','140','Acapulco','66040','Enrique@hotmail.com','8123456781','01/01/2019','Carrillo','Moreno',5

--CLIENTE
CREATE PROCEDURE spActualizarCliente
  @idCliente int,
  @nombre varchar(20),
  @app varchar(20),
  @apm varchar(20),
  @email varchar(30),
  @calle varchar(20),
  @colonia  varchar(20),
  @numExt varchar(5),
  @cp char(5),
  @celular char(10),
  @fecNac date,
  @idCiudad int
AS
BEGIN
IF (SELECT COUNT (C.idCliente)FROM Cliente C WHERE C.idCliente = @idCliente)!=1
begin
print('No existe ningun cliente con ese numero enviado');
end
ELSE
	begin
	UPDATE Cliente 
	SET estatus='M',colonia= @colonia,nombre = @nombre, app = @app, apm = @apm, email = @email, calle = @calle, numExt = @numExt, cp = @cp, celular = @celular, fecNac = @fecNac, idCiudad = @idCiudad where idCliente=@idCliente;
	PRINT('Cliente actualizado con exito');
	END 
END

EXECUTE spActualizarCliente 1, 'gerardo', 'lugo', 'franco', 'gerardolugo@gmail.com', 'bulgaria','texcoco', '1211', '61217', '8112452139', '01/01/1996', 3

--SUCURSAL
--Creacion del store
CREATE  PROCEDURE spActualizarSucursal
	@IdSucursal int,
    @Calle varchar(20),
    @NumExt varchar(5),
    @Colonia varchar(30),
    @Cp char(5),
    @Email varchar(30),
    @Telefono char(10),
    @IdCiudad int
AS
BEGIN

    if (SELECT COUNT(S.idsucursal) FROM SUCURSAL S WHERE S.idSucursal=@IdSucursal)!=1  
		begin
			print('No existe la sucursal');
		end
        ELSE
		begin
        UPDATE SUCURSAL SET estatus='M',calle=@Calle,numExt=@NumExt,colonia=@Colonia,cp=@Cp,email=@Email,telefono=@Telefono,idCiudad=@IdCiudad
        WHERE idSucursal=@IdSucursal;
        print('Ya se actualizo la sucursal');
    END
END

SELECT * FROM SUCURSAL;

EXECUTE spActualizarSucursal 10,'Francisco','34242','Mochis','34324','sexshopIndustrial@outlook.com','8180809308',24
EXECUTE spActualizarSucursal 114, 'Beni','43556','Zapopan', '23434', 'guadalupealtamirano@gmail.com', '8182824323',13
EXECUTE spActualizarSucursal 118, 'Solos','56445','10 de Marzo', '56465', 'genaroshop@gmail.com','8123453234',5
EXECUTE spActualizarSucursal 115, 'cristo','56463','10 de Junio', '54645', 'venusshop@gmail.com', '8181456534',7
EXECUTE spActualizarSucursal 113, 'Union','76543','Margaritas','56443', 'shopVenus@gmail.com', '8181234675',8

create procedure spActualizarEstado
@idEstado int, 
@descripcion VARCHAR(50)
as
begin
IF((SELECT COUNT(e.idEstado) FROM ESTADO e WHERE e.idEstado = @idEstado))!=1
 BEGIN
  PRINT('No existe un estado registrado con este numero')
  END 
ELSE
BEGIN
  UPDATE ESTADO SET estatus='M',descripcion= @descripcion WHERE idEstado= @idEstado;
    PRINT('Se ha actualizado correctamente')
 END   
END

EXECUTE spActualizarEstado 1,'Nuevo Leon'

CREATE Procedure spActualizarCiudad 
 @idCiudad INT, @descripcion VARCHAR(50), 
 @idEstado INT
AS
BEGIN

IF (SELECT COUNT(c.idCiudad)  FROM CIUDAD c WHERE c.idCiudad = @idCiudad)!=1
	BEGIN
		PRINT('No existe una ciudad registrado con este numero')
	END 
ELSE
	BEGIN 
		UPDATE CIUDAD SET estatus='M', descripcion= @descripcion, idEstado=@idEstado WHERE idCiudad=@idCiudad;
		PRINT('Se ha actualizado correctamente')
	END    
END 

---EXECUTE PARA INSERTAR DATOS-------
execute spActualizarCiudad 7,'Escobedo', 1


create procedure spActulizarMarca
@idMarca INT,
@descripcion VARCHAR(50)
AS
BEGIN
IF (SELECT COUNT(m.idMarca)  FROM MARCA m  WHERE m.idMarca = @idMarca)!=1
  BEGIN
		PRINT('No existe una marca registrado con este numero')
  END   
ELSE
	BEGIN
		UPDATE MARCA SET estatus='M',descripcion= @descripcion WHERE idMarca= @idMarca;
		PRINT('Se ha actualizado correctamente')
	END 
  end
  
 ---EXECUTE PARA INSERTAR DATOS-------
  execute  spActulizarMarca 10,'SICO'


create Procedure spActualizarCategoria
@idCategoria INT,
@descripcion VARCHAR(25)
AS
BEGIN

IF(SELECT COUNT(c.idCategoria) FROM CATEGORIA c  WHERE c.idCategoria = @idCategoria)!=1
		BEGIN
			PRINT('Ya existe una categoria registrado con este numero')       
		END  
  ELSE
		BEGIN
			UPDATE CATEGORIA SET estatus='M',descripcion= @descripcion  WHERE idCategoria= @idCategoria;
			PRINT('Se ha actualizado correctamente')
		END  
END
 
    SET SERVEROUTPUT ON;
    
---EXECUTE PARA INSERTAR DATOS-------    
    execute spActualizarCategoria 1,'Estimulacion'


create  procedure spActualizarProducto
@idProducto INT,
@descripcion varchar(50),
@precio MONEY,
@idMarca INT,
@idCategoria INT
AS
BEGIN
IF (SELECT COUNT(P.idProducto)  FROM PRODUCTO P  WHERE P.idProducto = @idProducto)!=1
		BEGIN
			PRINT('No existe un producto registrado con este numero')       
		END    
  ELSE
		BEGIN
			UPDATE PRODUCTO SET estatus='M',descripcion= @descripcion,precio= @precio, idMarca=@idMarca,idCategoria= @idCategoria WHERE idProducto=@idProducto;
			PRINT('Se ha actualizado correctamente')
		END 
END
---EXECUTE PARA INSERTAR DATOS-------
execute spActualizarProducto 1,'Dildo',350.00,1,2

Create procedure spActualizarEmpleado
@IdEmpleado INT,
@Nombre VARCHAR(20),
@ApellidoPaterno  VARCHAR(20),
@ApellidoMaterno  VARCHAR(20),
@Email  VARCHAR(30),
@Calle  VARCHAR(20),
@NumExt  CHAR(5),
@Col  VARCHAR(20),
@Cp  CHAR(5),
@Celular CHAR(10),
@FechadeNacimiento DATE,
@IdCuidad INT,
@IdJefe INT,
@IdSucursal INT
AS
BEGIN
IF (SELECT COUNT(Em.idEmpleado) FROM EMPLEADO Em WHERE Em.idEmpleado = @IdEmpleado)!=1
	BEGIN
		PRINT('No existe un empleado registrado con este numero')   
	END
ELSE 
	BEGIN
		UPDATE Empleado SET estatus='M',nombre= @Nombre, app= @ApellidoPaterno,apm= @ApellidoMaterno,
		email= @Email,calle=@Calle,colonia= @Col,numExt= @NumExt,cp=@Cp,celular= @Celular,
		fecNac=@FechadeNacimiento,idCiudad=@IdCuidad,idJefe=@IdJefe,idSucursal= @IdSucursal 
		WHERE idEmpleado=@IdEmpleado;
		PRINT('Se ha actualizado correctamente')
	END 
END

---EXECUTE PARA INSERTAR DATOS-------
EXECUTE spActualizarEmpleado 1,'Juan Alberto','Perez','Lopez','JuanMtz@gmail.com','Gonzalitos','Paricutin','123','67458','8281023658','28/10/95',10,1,111


CREATE PROCEDURE spActualizarExistencia
(
 @IdSucursal INT,
 @IdProducto INT,
 @Cantidad INT
)
AS
BEGIN
IF(SELECT COUNT(*)  FROM EXISTENCIA E  WHERE E.idProducto = @IdProducto and E.IdSucursal = @IdSucursal)!=1
	BEGIN 
		PRINT('No esta registrado con este numero') 
	END 
  ELSE
	BEGIN
		UPDATE EXISTENCIA SET estatus='M',cantidad=@Cantidad WHERE idProducto=@IdProducto AND idSucursal=@IdSucursal;
		PRINT('Se ha actualizado correctamente')
	END 
  END                                 
  ---EXECUTE PARA INSERTAR DATOS------- 
EXECUTE spActualizarExistencia 110,13,100

create procedure spActualizarCompra
@idCompra INT,
@total MONEY,
@fechaCompra DATE,
@idSucursal INT,
@idProveedor INT
as
begin

IF(SELECT COUNT(c.idCompra)  FROM COMPRA c WHERE c.idCompra=@idCompra)!=1
	begin
		PRINT('No esta registrado con este numero') 
    end 
  ELSE
  begin
   UPDATE COMPRA SET estatus='M',total= @total,fechaCompra=@fechaCompra,idSucursal=@idSucursal,idProveedor= @idProveedor WHERE idCompra=@idCompra;
   PRINT('Se ha agregado correctamente')
  END 
end
---EXECUTE PARA INSERTAR DATOS-------
EXECUTE spActualizarCompra 1,10000.00,'04/05/2019',112,1


create procedure spActualizarCompraDetalle
 @idCompra int,
 @idProducto int,
 @cantidad int,
 @precio int
as
begin
if (SELECT COUNT(CD.idCompra)  FROM COMPRA_DETALLE CD  WHERE CD.idCompra = @idCompra and CD.idProducto=@idProducto)!=1  
	begin
		PRINT('No esta registrado con este numero') 
	end  
  ELSE
	begin
		Update COMPRA_DETALLE set estatus='M',cantidad=@cantidad,precio=@precio WHERE idCompra = @idCompra and idProducto=@idProducto; 
		PRINT('Se ha agregado correctamente')
	END 
  end
  
---EXECUTE PARA INSERTAR DATOS-------   
    execute spActualizarCompraDetalle 1,1,28,10000

create procedure spActualizarVenta
@idVenta int,
@fecVen date,
@subTotal money,
@iva money,
@idCliente int,
@idEmpleado int,
@idSucursal int
as
begin
if(SELECT COUNT(v.idVenta)  FROM VENTA v WHERE v.idVenta = @idVenta)!=1
	begin
		PRINT('No esta registrada la venta con este numero')
	end
  ELSE
	begin
		update VENTA set estatus='M',fechaVenta=@fecVen, subTotal= @subTotal,iva= @iva,
		idCliente= @idCliente,idEmpleado= @idEmpleado,idSucursal= @idSucursal WHERE idVenta = @idVenta;  
		PRINT('Se ha agregado correctamente')
	END 
END
---EXECUTE PARA INSERTAR DATOS-------
  EXECUTE spActualizarVenta 1,'04/05/2019',1000.50,160.50,4,3,111
  

create procedure spActualizarDetalleVenta
@idVenta INT,
@idProducto INT,
@cantidad INT,
@precio MONEY
AS
begin
IF (SELECT COUNT(dv.idVenta)  FROM DETALLEVENTA dv WHERE dv.idVenta = @idVenta and dv.idProducto=@idProducto)!=1
  BEGIN
	PRINT('No esta registrado con este numero')
  END
  ELSE
  begin
   update DETALLEVENTA set estatus='M',cantidad= @cantidad, precio=@precio WHERE idVenta = @idVenta and idProducto=@idProducto;
   	PRINT('Se ha agregado correctamente')
  END 
END
---EXECUTE PARA INSERTAR DATOS-------
  EXECUTE spActualizarDetalleVenta 1,5,3,333.50



---------------------Stores Eliminar------------------------------------------------------------------------------------------
create PROCEDURE spEliminarProveedor
@idProveedor int
as
BEGIN 
 IF (SELECT COUNT(m.idProveedor)  FROM PROVEEDOR m WHERE m.idProveedor = @idProveedor) !=1
	BEGIN
		PRINT('No existe un número de proveedor con la clave enviada')
	END
ELSE 
BEGIN
  UPDATE PROVEEDOR SET estatus='B' WHERE idProveedor= @idProveedor; 
  PRINT('Se ha eliminado correctamente')
 END 
END

 EXECUTE spEliminarProveedor 1

--CLIENTE-------------------------------------------------------
CREATE PROCEDURE spEliminarCliente
  @idCliente int
AS
BEGIN
IF (SELECT COUNT (C.idCliente)FROM Cliente C WHERE C.idCliente = @idCliente)!=1
begin
print('No existe ningun cliente con ese numero enviado');
end
ELSE
	begin
	UPDATE Cliente 	SET estatus='B' where idCliente=@idCliente;
	PRINT('Cliente eliminado con exito');
	END 
END

EXECUTE spEliminarCliente 1
--SUCURSAL
--Creacion del store
CREATE  PROCEDURE spEliminarSucursal
	@IdSucursal int
AS
BEGIN

    if (SELECT COUNT(S.idsucursal) FROM SUCURSAL S WHERE S.idSucursal=@IdSucursal)!=1  
		begin
			print('No existe la sucursal');
		end
        ELSE
		begin
        UPDATE SUCURSAL SET estatus='B'
        WHERE idSucursal=@IdSucursal;
        print('Se ha eliminado la sucursal');
    END
END

create procedure spEliminarEstado
@idEstado int
as
begin
IF((SELECT COUNT(e.idEstado) FROM ESTADO e WHERE e.idEstado = @idEstado))!=1
 BEGIN
  PRINT('No existe un estado registrado con este numero')
  END 
ELSE
BEGIN
  UPDATE ESTADO SET estatus='B' WHERE idEstado= @idEstado;
    PRINT('Se ha eliminado correctamente')
 END   
END



CREATE Procedure spEliminarCiudad 
 @idCiudad INT
AS
BEGIN

IF (SELECT COUNT(c.idCiudad)  FROM CIUDAD c WHERE c.idCiudad = @idCiudad)!=1
	BEGIN
		PRINT('No existe una ciudad registrado con este numero')
	END 
ELSE
	BEGIN 
		UPDATE CIUDAD SET estatus='B'WHERE idCiudad=@idCiudad;
		PRINT('Se ha eliminado correctamente')
	END    
END 


create procedure spEliminarrMarca
@idMarca INT
AS
BEGIN
IF (SELECT COUNT(m.idMarca)  FROM MARCA m  WHERE m.idMarca = @idMarca)!=1
  BEGIN
		PRINT('No existe una marca registrado con este numero')
  END   
ELSE
	BEGIN
		UPDATE MARCA SET estatus='B' WHERE idMarca= @idMarca;
		PRINT('Se ha eliminado correctamente')
	END 
  end

create Procedure spEliminarCategoria
@idCategoria INT
AS
BEGIN

IF(SELECT COUNT(c.idCategoria) FROM CATEGORIA c  WHERE c.idCategoria = @idCategoria)!=1
		BEGIN
			PRINT('Ya existe una categoria registrado con este numero')       
		END  
  ELSE
		BEGIN
			UPDATE CATEGORIA SET estatus='B' WHERE idCategoria= @idCategoria;
			PRINT('Se ha eliminado correctamente')
		END  
END 
  

create  procedure spEliminarProducto
@idProducto INT
AS
BEGIN
IF (SELECT COUNT(P.idProducto)  FROM PRODUCTO P  WHERE P.idProducto = @idProducto)!=1
		BEGIN
			PRINT('No existe un producto registrado con este numero')       
		END    
  ELSE
		BEGIN
			UPDATE PRODUCTO SET estatus='B' WHERE idProducto=@idProducto;
			PRINT('Se ha eliminado correctamente')
		END 
END


Create procedure spEliminarEmpleado
@IdEmpleado INT
AS
BEGIN
IF (SELECT COUNT(Em.idEmpleado) FROM EMPLEADO Em WHERE Em.idEmpleado = @IdEmpleado)!=1
	BEGIN
		PRINT('No existe un eliminado registrado con este numero')   
	END
ELSE 
	BEGIN
		UPDATE Empleado SET estatus='B'
		WHERE idEmpleado=@IdEmpleado;
		PRINT('Se ha eliminado correctamente')
	END 
END


CREATE PROCEDURE spEliminarExistencia
(
 @IdSucursal INT,
 @IdProducto INT
)
AS
BEGIN
IF(SELECT COUNT(*)  FROM EXISTENCIA E  WHERE E.idProducto = @IdProducto and E.IdSucursal = @IdSucursal)!=1
	BEGIN 
		PRINT('No esta registrado con este numero') 
	END 
  ELSE
	BEGIN
		UPDATE EXISTENCIA SET estatus='B' WHERE idProducto=@IdProducto AND idSucursal=@IdSucursal;
		PRINT('Se ha eliminado correctamente')
	END 
  END                                 

create procedure spEliminarCompra
@idCompra INT
as
begin

IF(SELECT COUNT(c.idCompra)  FROM COMPRA c WHERE c.idCompra=@idCompra)!=1
	begin
		PRINT('No esta registrado con este numero') 
    end 
  ELSE
  begin
   UPDATE COMPRA SET estatus='B' WHERE idCompra=@idCompra;
   PRINT('Se ha eliminado correctamente')
  END 
end
---EXECUTE PARA INSERTAR DATOS-------
EXECUTE spActualizarCompra 1,10000.00,'04/05/2019',112,1


create procedure spEliminarCompraDetalle
 @idCompra int,
 @idProducto int 
as
begin
if (SELECT COUNT(CD.idCompra)  FROM COMPRA_DETALLE CD  WHERE CD.idCompra = @idCompra and CD.idProducto=@idProducto)!=1  
	begin
		PRINT('No esta registrado con este numero') 
	end  
  ELSE
	begin
		Update COMPRA_DETALLE set estatus='B' WHERE idCompra = @idCompra and idProducto=@idProducto; 
		PRINT('Se ha eliminado correctamente')
	END 
  end
  
---EXECUTE PARA INSERTAR DATOS-------   
    execute spActualizarCompraDetalle 1,1,28,10000

create procedure spEliminarVenta
@idVenta int
as
begin
if(SELECT COUNT(v.idVenta)  FROM VENTA v WHERE v.idVenta = @idVenta)!=1
	begin
		PRINT('No esta registrada la venta con este numero')
	end
  ELSE
	begin
		update VENTA set estatus='B' WHERE idVenta = @idVenta;  
		PRINT('Se ha eliminado correctamente')
	END 
END

create procedure spEliminarDetalleVenta
@idVenta INT,
@idProducto INT
AS
begin
IF (SELECT COUNT(dv.idVenta)  FROM DETALLEVENTA dv WHERE dv.idVenta = @idVenta and dv.idProducto=@idProducto)!=1
  BEGIN
	PRINT('No esta registrado con este numero')
  END
  ELSE
  begin
   update DETALLEVENTA set estatus='B' WHERE idVenta = @idVenta and idProducto=@idProducto;
   	PRINT('Se ha eliminado correctamente')
  END 
END

---------------------------------Acceso-----------
create procedure spAcceso
@nombreUsuario varchar(80),
@contrasena   varchar(80)
as 
begin
select nombre from EMPLEADO where nombreUsuario=@nombreUsuario and contrasena=@contrasena
end




--------------------------------VISTAS------------------------------------------
--Esta vista une los datos de ciudad con estado
CREATE VIEW REGION
AS
SELECT
CIUDAD.idCiudad,
CIUDAD.DESCRIPCION AS CIUDAD,
ESTADO.idEstado,
ESTADO.descripcion AS ESTADO
FROM CIUDAD, ESTADO
WHERE ESTADO.idEstado = CIUDAD.idEstado
ORDER BY ESTADO.idEstado ASC;
--------------------------------------------------------------------------------
--Esta vista muestra los productos con su categoria
CREATE VIEW CLASIFICACION_PRODUCTO
AS
SELECT
PRODUCTO.idProducto,
PRODUCTO.descripcion,
PRODUCTO.precio,
CATEGORIA.idCategoria,
CATEGORIA.descripcion AS CATEGORIA
FROM PRODUCTO, CATEGORIA
WHERE CATEGORIA.idCategoria = PRODUCTO.idCategoria
ORDER BY CATEGORIA.idCategoria, PRODUCTO.idProducto ASC;
--------------------------------------------------------------------------------
--Esta vista muestra las sumas de las cantidades de las formas de pago(T y E)
CREATE VIEW FORMASPAGO
AS
SELECT T.TIPOPAGO, SUM(T.CANTIDAD) AS CANTIDAD
FROM VENTA V, TIPOPAGO T
WHERE
T.IDVENTA=V.IDVENTA AND
T.TIPOPAGO='E'
GROUP BY T.TIPOPAGO
UNION
SELECT  T.TIPOPAGO, SUM(T.CANTIDAD) AS CANTIDAD
FROM  VENTA V, TIPOPAGO T
WHERE
T.IDVENTA=V.IDVENTA AND
T.TIPOPAGO='T'
GROUP BY T.TIPOPAGO;

Create trigger Debitar_Stock
   on DetalleVenta
   for Insert
   as
   Update EXISTENCIA set cantidad=EX.cantidad-DV.cantidad
   from EXISTENCIA as EX 
   inner join VENTA as V on V.idSucursal=EX.idSucursal
   inner join DETALLEVENTA AS DV ON DV.idProducto=Ex.idProducto
   inner join DETALLEVENTA ON DV.idVenta=V.idVenta
 
Create trigger Regresar_Stock
   on DetalleVenta
   for Update
   as
     Update EXISTENCIA set cantidad=EX.cantidad+DV.cantidad
   from EXISTENCIA as EX 
   inner join VENTA as V on V.idSucursal=EX.idSucursal
   inner join DETALLEVENTA AS DV ON DV.idProducto=Ex.idProducto
   inner join DETALLEVENTA ON DV.idVenta=V.idVenta
   WHERE DV.estatus='B'

Create trigger Regresar_StockEliminado
   on DetalleVenta
   for Delete
   as
     Update EXISTENCIA set cantidad=EX.cantidad+DV.cantidad
   from EXISTENCIA as EX 
   inner join VENTA as V on V.idSucursal=EX.idSucursal
   inner join DETALLEVENTA AS DV ON DV.idProducto=Ex.idProducto
   inner join DETALLEVENTA ON DV.idVenta=V.idVenta


Create trigger Actualizar_Stock
   on DetalleVenta
   for Update
   as 
   Update EXISTENCIA set cantidad=EX.cantidad+D.cantidad
   from EXISTENCIA as EX 
   inner join VENTA as V on V.idSucursal=EX.idSucursal
   inner join DETALLEVENTA AS DV ON DV.idProducto=Ex.idProducto
   inner join DETALLEVENTA ON DV.idVenta=V.idVenta
   inner join  DELETED as D on D.idProducto=EX.idProducto and D.idVenta= V.idVenta
   WHERE DV.estatus='M'

    Update EXISTENCIA set cantidad=EX.cantidad-D.cantidad
   from EXISTENCIA as EX 
   inner join VENTA as V on V.idSucursal=EX.idSucursal
   inner join DETALLEVENTA AS DV ON DV.idProducto=Ex.idProducto
   inner join DETALLEVENTA ON DV.idVenta=V.idVenta
   inner join  INSERTED as D on D.idProducto=EX.idProducto and D.idVenta= V.idVenta
   WHERE DV.estatus='M'


 select *from existencia 
 select *from DETALLEVENTA
  select *from VENTA

 EXECUTE spActualizarDetalleVenta 1,2,0,333.50
 EXECUTE spAgregarDetalleVenta 1,2,1,333.50