 

select * from bd_facts.tbl_asesores; 
select * from bd_facts.tbl_productos;
select * from bd_facts.tbl_clientes;
select * from bd_facts.tbl_facturas; 

/*
	Escriba una consulta sql combinando las tablas asesores y clientes, para obtener 
    los numeros id de los asesores que no tienen clientes asignados. 
*/
select 
	a.numeroid, 
    concat( a.nombres, ' ' , a.apellidos ) nombrecompleto , 
    b.idCliente 
from bd_facts.tbl_asesores a 
left join bd_facts.tbl_clientes b 
on a.idAsesor = b.idAsesor
where b.idcliente is null ; 


/*
	Cree una consulta sql para obtener el nombre de cliente, idfactura, fecha de emision y fecha de vencimiento
    de facturas que estan vencidas por falta de pago.  
*/
select 
    a.idfactura, 
	a.idCliente, a.tipopago, a.fechaemision, a.fechaVencimiento, 
    upper( b.nombrecompleto ) nombrecompleto
from bd_facts.tbl_facturas a  
left join bd_facts.tbl_clientes b 
on a.idcliente = b.idcliente 
where a.estado = 'PENDIENTE' 
and fechavencimiento < curdate();
 
 /*
	Cree una transaccion que realice lo siguiente:
    -- Asignar un asesor a un cliente, actualizando el campo idasesor en la tabla clientes. 
    -- Actualizar el campo cantclientes en la tabla asesores, segun la cantidad de clientes que tenga el asesor. 
    
    Necesita las variables de entrada: idasesor, idcliente. 
    
    -- ejecute la transaccion con los siguientes valores: 
    Al cliente 101 asigne el asesor 14. 
    Al cliente 128 asigne el asesor 1.  
 */

	set @idcliente = 128; 
	set @idasesor = 1;
    set @clientes = 0; 
    
	update bd_facts.tbl_clientes  set idasesor = @idasesor 
	where idcliente = @idcliente;
    
    select count(*) into @clientes 
    from bd_facts.tbl_clientes where idAsesor = @idasesor;
    
    update bd_facts.tbl_asesores set cantclientes = @clientes
    where idasesor =  @idasesor; 
    
    commit; 

 
 
 
 