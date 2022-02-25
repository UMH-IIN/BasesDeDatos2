
DROP procedure IF EXISTS `SP_CREAR_SUBSCRIPTOR`;

DELIMITER //
CREATE  PROCEDURE  bd_sample.SP_CREAR_SUBSCRIPTOR (
	in p_id_subscriptor 	int, 
    in p_codigo_subscriptor int,
    in p_nombres 			varchar(25),
    in p_apellidos 			varchar(25),
    in p_edad				int, 
    in p_grupo				varchar(25)  
 )
BEGIN 
	declare  v_id_subscriptor int default 0; 
	declare  v_codigo_subscriptor int; 
	declare  v_nombres varchar(25) ;
	declare  v_apellidos varchar(25); 
    declare  v_edad	int;
    declare  v_grupo varchar(25);
    
    set v_id_subscriptor 		= p_id_subscriptor;
	set v_codigo_subscriptor	= p_codigo_subscriptor; 
    set v_nombres				= p_nombres;
    set v_apellidos				= p_apellidos;
    set v_edad					= p_edad;
    set v_grupo					= p_grupo;
    
    #evaluamos si el subscriptores
	select codigo_subscriptor into v_codigo_subscriptor 
    from bd_sample.tbl_subscriptores
	WHERE codigo_subscriptor = v_codigo_subscriptor;
    
    #evaluar el grupo 
    case 
		when v_edad < 15 then  				set v_grupo = 'nino';
		when v_edad between 15 and 25 then 	set v_grupo = 'joven';
		when v_edad between 26 and 59 then 	set v_grupo = 'adulto';
        when v_edad >= 60 then				set v_grupo = 'adulto mayor';
        else set v_grupo = 'otro';
	end case;
    
    if v_codigo_subscriptor is null then 
		insert into bd_sample.tbl_subscriptores ( 
			id_subscriptor, codigo_subscriptor, nombres, apellidos , edad, grupoetario
		) values (
			v_id_subscriptor, v_codigo_subscriptor, v_nombres, v_apellidos, v_edad, v_grupo
		);   
	else
		update bd_sample.tbl_subscriptores  set 
						nombres 	= v_nombres,
                        apellidos 	= v_apellidos,
                        edad		= v_edad,
                        grupoetario = v_grupo
		where codigo_subscriptor = v_codigo_subscriptor;
    end if; 
    
    commit;
 END; 