 select * from bd_sample.tbl_facturas; 
 select * from bd_sample.tbl_productos;
 select * from bd_sample.tbl_subscriptores;
 select * from bd_sample.tbl_items_factura; 
 
 
 # Agregar un subscriptor nuevo: 
 insert into bd_sample.tbl_subscriptores(
	codigo_subscriptor, nombres, apellidos
 ) values ( 
	'202100000', 'JORGE LUIS','HERNANDEZ'
 );
 
 #filtrar suscriptores
 
 SELECT * 
 FROM bd_sample.tbl_subscriptores
 where codigo_subscriptor ='202100000';
 
 # anio mes -- 202201
 /*
	 facturas con consumo > 59 desc 10%
     facturas con consumo < 60 desc  0%
 */
 select 
	date_format(fecha_emision,'%Y%m') aniomes,
	fecha_emision, 
    isv_total,
    totapagar, 
    if( totapagar > 59, totapagar*0.1, 0 ) descuento,
    if( totapagar > 59,  totapagar - totapagar*0.1, 0 ) ajuste 
 from bd_sample.tbl_facturas 
 where date_format(fecha_emision,'%m') in ('01','02','03')
 order by totapagar desc ;
 
 /*
	  SQL Joins 
 */
 
 select * from bd_sample.tbl_productos;
 
 create table bd_sample.t_prod_vendidos (
	idproducto integer , fecha date 
 );
 
 select * from bd_sample.t_prod_vendidos;
  
 
 insert into bd_sample.t_prod_vendidos ( idproducto, fecha) 
 values (1, CURRENT_DATE()),
	    (1, CURRENT_DATE()),
        (2, CURRENT_DATE()),
        (2, CURRENT_DATE()),
        (3, CURRENT_DATE()),
        (1, CURRENT_DATE());
 /*
	
 */
 
 
 select
	*
 from bd_sample.t_prod_vendidos t1
 left join bd_sample.tbl_productos t2 
 on t1.idproducto = t2.id_producto
 union all
 
  select
	*
 from bd_sample.t_prod_vendidos t1
 right join bd_sample.tbl_productos t2 
 on t1.idproducto = t2.id_producto
 where t1.idproducto is null 
 ;
 
 /*
	funciones de agregacion
 */
 select  
	id_subscriptor,
	avg( totapagar ) promedio ,
	min( totapagar ) minimo, 
	max( totapagar ) maximo, 
	count(*) cantidad,
	sum( totapagar ) suma 
 from bd_sample.tbl_facturas
 group by id_subscriptor
 having sum( totapagar ) > 100 ;
  
 
 
 