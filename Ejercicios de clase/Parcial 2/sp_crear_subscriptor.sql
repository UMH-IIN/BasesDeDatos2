 /*
    Procedimiento almacenado para crear un subscriptor en la base de datos. 
 */

#eliminar procedimiento
DROP procedure IF EXISTS `SP_CREAR_SUBSCRIPTOR`;

# Crear procedimiento 
DELIMITER //
CREATE  PROCEDURE  bd_sample.SP_CREAR_SUBSCRIPTOR (
	in p_id_subscriptor 	int, 
    in p_codigo_subscriptor int,
    in p_nombres 			varchar(25),
    in p_apellidos 			varchar(25)
 )
BEGIN 
    #definir variables 
	declare  v_id_subscriptor int; 
	declare  v_codigo_subscriptor int; 
	declare  v_nombres varchar(25) ;
	declare  v_apellidos varchar(25); 
    
    #asignar valores de parametros a variables 
    set v_id_subscriptor 		= p_id_subscriptor;
	set v_codigo_subscriptor	= p_codigo_subscriptor; 
    set v_nombres				= p_nombres;
    set v_apellidos				= p_apellidos;
    
    #crear nuevo subscriptor 
	insert into bd_sample.tbl_subscriptores ( 
		id_subscriptor, codigo_subscriptor, nombres, apellidos 
	) values (
		v_id_subscriptor, v_codigo_subscriptor, v_nombres, v_apellidos
	);
    
    commit;
 END; 


# Ejecutar procedimiento 
CALL bd_sample.sp_crear_subscriptor(
	0, 						# p_id_subscriptor  
	202211111,    			# p_codigo_subscriptor 
    'LEONEL',				# p_nombres 			 
    'MESSI' 				#p_apellidos 		 
);

 