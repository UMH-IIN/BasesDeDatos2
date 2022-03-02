drop procedure sp_ciclos;
 

delimiter //
CREATE PROCEDURE sp_ciclos(
    in p_max int 
)
BEGIN
    declare i int default 0;  
    declare  v_codigo_subscriptor varchar(15); 
	declare lista varchar(2000);
    
    set lista = "";
    
    while i < p_max do 
		set i = i+1;
        /*
		select  codigo_subscriptor  into  v_codigo_subscriptor 
		from bd_sample.tbl_subscriptores where id_subscriptor = i; 
        
        set lista = concat(lista,',',v_codigo_subscriptor);
        */
    end while;
    select lista ;
 
/*
    ciclo: loop 
		set i = i + 1; 
        if i = p_max then 
			leave ciclo;
        end if; 
    end loop;  
    select i ;
    
 
    ciclo: loop 
		set i = i + 1; 
        if i < p_max then 
			iterate ciclo;
        end if;
        leave ciclo;
    end loop;  
    select i ;
*/
END;


call sp_ciclos( 4 );

select * from bd_sample.tbl_subscriptores 


drop PROCEDURE sp_upd_subscriptores ;

delimiter //
CREATE PROCEDURE sp_upd_subscriptores(
    in p_inicio int,
    in p_final 	int 
)
BEGIN
    declare  i int default 0;  
	declare  v_id_subscriptor int default 0; 
	declare  v_codigo_subscriptor int; 
	declare  v_nombres varchar(25) ;
	declare  v_apellidos varchar(25); 
    declare  v_edad	int;
    declare  v_grupoetario varchar(25);
    
    select p_final; 
    
    set i = p_inicio; 
    
    while i < p_final + 1 do 
		select 
			codigo_subscriptor, 	nombres,	apellidos,	edad,	grupoetario
		into 
			v_codigo_subscriptor, 	v_nombres,	v_apellidos,	v_edad,	v_grupoetario
		from bd_sample.tbl_subscriptores where id_subscriptor = i; 
        
        CALL bd_sample.sp_crear_subscriptor(
			v_id_subscriptor		, # p_id_subscriptor  
			v_codigo_subscriptor	, # p_codigo_subscriptor 
			v_nombres				, # p_nombres 			 
			v_apellidos				, #p_apellidos 		
			v_edad, 
			null 
		);
		set i = i+1; 
    end while;
    
END;

call sp_upd_subscriptores(
   10, 15
)