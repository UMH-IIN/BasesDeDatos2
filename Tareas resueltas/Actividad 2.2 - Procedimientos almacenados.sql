/*
	-------------------- 		EJERCICIO 1 	--------------------------
*/
delimiter //
CREATE PROCEDURE sp_guardar_subscriptor(
	in p_idSubscriptor int,
    in p_codSubscriptor int,
    in p_nombSubscriptor varchar(25),
    in p_apeSubscriptor varchar(25)
)
BEGIN
	declare v_idSubscriptor 	int;
    declare v_codSubscriptor 	int;
    declare v_nombSubscriptor 	varchar(25);
    declare v_apeSubscriptor 	varchar(25);
	
    #Asignar variables
    set v_idSubscriptor = p_idSubscriptor;
    set v_codSubscriptor = p_codSubscriptor;
    set v_nombSubscriptor = p_nombSubscriptor;
    set v_apeSubscriptor = p_apeSubscriptor;
    
    #Actualizar subscriptores
    update tbl_subscriptores set 
			codigo_subscriptor	=	v_codSubscriptor, 
            nombres				=	v_nomSubscriptor,
            apellidos			=	v_codSubscriptor
    where id_subscriptor=v_idSubscriptor;
	commit; 
END;
/*
	-------------------- 		EJERCICIO 2 	--------------------------
*/

DELIMITER // 
create procedure bd_sample.sp_guardar_producto (
    in p_id_producto     	int,
    in p_nombre 			varchar (25),
    in p_descripcion 		varchar (25),
    in p_precio_costo 		decimal (12,2),
    in p_precio_venta 		decimal (12,2) 
)
BEGIN  
	declare  v_id_producto 		int;
	declare  v_nombre			varchar (25);
	declare  v_descripcion 		varchar (25);
	declare  v_precio_costo 	decimal (12,2);
   	declare  v_precio_venta 	decimal (12,2);
    
    set v_id_producto       = p_id_producto;
    set v_nombre			= P_nombre;
    set  v_descripcion		= p_descripcion;
    set  v_precio_costo		= p_precio_costo;    
    set v_precio_venta 		= p_precio_venta * 1.25;
    
	insert into bd_sample.tbl_productos (
	id_producto, nombre, descripcion, precio_costo, precio_venta
	) values (
	v_id_producto, v_nombre, v_descripcion, v_precio_costo, v_precio_venta
	);

	commit;
END;
/*
	-------------------- 		EJERCICIO 3 	--------------------------
*/
DELIMITER //
create procedure bd_sample.sp_guardar_factura (
    in p_id_factura 			int,
    in p_fecha_emision			datetime,
    in p_id_subscriptor			int,
    in p_numero_items			int,
    in p_isv_total			decimal(12,2),
    in p_subtotal			decimal(12,2)
) 
BEGIN 
    declare v_id_factura 		int;
    declare v_fecha_emision		datetime;
    declare v_id_subscriptor	int;
    declare v_numero_items		int;
    declare v_isv_total			decimal(12,2);
    declare v_subtotal			decimal(12,2);
    declare v_totapagar			decimal(12,2);

    set v_id_factura 		=  	p_id_factura; 
    set v_fecha_emision		=	p_fecha_emision;
    set v_id_subscriptor	=	p_id_subscriptor;
    set v_numero_items		=	p_numero_items;
    set v_isv_total			=	p_isv_total;
    set v_subtotal			=	p_subtotal;
    set v_totapagar			=	p_totapagar;
    
	insert into bd_sample.tbl_facturas ( 
		id_factura, fecha_emision, id_subscriptor, numero_items, isv_total, subtotal, totapagar
    )values( 
		v_id_factura, v_fecha_emision, v_id_subscriptor, v_numero_items, v_isv_total, v_subtotal, v_totapagar
    );

	COMMIT;
END;

/*
	-------------------- 		EJERCICIO 4 	--------------------------
*/

DELIMITER //
# crear procedimiento
CREATE PROCEDURE bd_sample.SP_PROCESAR_FACTURA(
	in p_id_factura      	int,  
	in p_id_producto        int,
    in p_cantidad           int       
) 
BEGIN
	#definir variables 
	declare v_id_factura      	int;  
	declare v_id_producto       int;
	declare v_cantidad 	        int;
    declare v_items 	        int;
	declare v_isv_producto      decimal(12,2) default 0;
	declare v_total_producto    decimal(12,2) default 0;
	declare v_subtotal_prod     decimal(12,2) default 0;
	declare v_precio_venta      decimal(12,2) default 0;
    
	#asignar valores de parametros a variables 
	set v_id_factura 		= p_id_factura;  
	set v_id_producto       = p_id_producto;
	set v_cantidad 	        = p_cantidad;
    
    #obtener precio de venta del producto 
	select precio_venta into v_precio_venta  
	from bd_sample.tbl_productos 
	where id_producto = v_id_producto; 
    
	insert bd_sample.tbl_items_factura (
		id_factura,		id_producto,	cantidad
	) values (
		v_id_factura,	v_id_producto,	v_cantidad
	);
     
    set v_subtotal_prod 	= (v_precio_venta*v_cantidad);
    set v_isv_producto		= (v_subtotal_prod*0.15);
    set v_total_producto	= v_subtotal_prod + v_isv_producto; 
    
    # Actualizar factura 
	update  bd_sample.tbl_facturas Set 
		numero_items 	= 	numero_items + v_cantidad,
		fecha_emision 	=	now(),
		isv_total   	=  	isv_total + v_isv_producto,
		subtotal    	=   subtotal  + v_subtotal_prod,
		totapagar		=   totapagar + v_total_producto
	where id_factura = v_id_factura; 
  
/*
    # Otra forma utilizando consultas sql
	select  
		sum( a.cantidad ) items, 
		sum( a.cantidad * b.precio_venta ) subtotal,
        sum( a.cantidad * b.precio_venta ) * 0.15 isv, 
		sum( a.cantidad * b.precio_venta ) * 1.15 total 
	into 
		v_items, 
        v_subtotal_prod, 
        v_isv_producto, 
        v_total_producto
	from bd_sample.tbl_items_factura a 
	left join bd_sample.tbl_productos b 
	on a.id_producto = b.id_producto 
	where a.id_factura = v_id_factura ;

    # Actualizar factura 
	update  bd_sample.tbl_facturas Set 
		numero_items 	= 	v_items,
		fecha_emision 	=	now(),
		isv_total   	=  	v_isv_producto,
		subtotal    	=   v_subtotal_prod,
		totapagar		=   v_total_producto
	where id_factura = v_id_factura; 
 */
	commit;
END;


/*
	

*/






