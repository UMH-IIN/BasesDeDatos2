
 /*
	Cuales meses se emitieron facturas solo con producto 
 */
select date_format(fecha_emision,'%m')
from bd_sample.tbl_facturas 
where  numero_items = 1 ;


/*
	Elabore una consulta para obtener el siguiente detalle de facturas para el mes de febrero, ordenado por total a pagar descendentemente
    el codigo de subscriptor, nombre completo, fecha emision, numero de items, total a pagar 
    Cuales son los primeros 3 codigos de subsciptor con mayor consumo en el mes de febrero?  
*/

select 
	b.codigo_subscriptor, 
    concat(b.nombres, ' ' ,b.apellidos) nombre ,
    a.fecha_emision, 
    a.numero_items,
    a.isv_total,
    a.subtotal,
    a.totapagar
from bd_sample.tbl_facturas a 
left join bd_sample.tbl_subscriptores b 
on a.id_subscriptor = b.id_subscriptor 
where date_format(fecha_emision,'%m') = '02'
order by a.totapagar desc ;

/*
	Escriba una consulta sql para extrar los nombres de productos que no se vendieron en el mes de mayo
    cual fue el resultado obtenido 
*/
select *
from (
	select b.* 
	from bd_sample.tbl_facturas a 
	left join bd_sample.tbl_items_factura b 
	on a.id_factura = b.id_factura 
	where date_format(fecha_emision,'%m') = '05'
)  a 
right join bd_sample.tbl_productos b 
on a.id_producto = b.id_producto 
where a.id_producto is null 
