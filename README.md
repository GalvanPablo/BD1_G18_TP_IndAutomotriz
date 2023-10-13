# BD1_G18_TP_IndAutomotriz

Para ejecutar todos los scripts, abrir la terminal y situarse en la ruta del repo:  
`cd ruta\BD1_G18_TP_IndAutomotriz`  
*ruta es donde esta la carpeta, ej C:\Mis Proyectos\BD1_G18_TP_IndAutomotriz

Ejecutar: `mysql -u root -p`  
*Cambiar root por el usuario correspondiente.

Una vez dentro de mysql en la terminal, ejecutar lo siguiente:

### Creacion de DB

`SOURCE BD1_IndAutomotriz.sql`  

### Seleccion de DB
`USE bd1_ind_automotriz`  

Luego ejecutar los bloques segun sea necesario:

## Stored procedures
`SOURCE FNSP\ABMs\concesionario\baja_concesionario.sql`  
`SOURCE FNSP\ABMs\concesionario\Alta_concesionario_direccion.sql`  
`SOURCE FNSP\ABMs\concesionario\Modificar_concesionario.sql`  

`SOURCE FNSP\ABMs\detalle pedido\alta_detalle_pedido.sql`  
`SOURCE FNSP\ABMs\detalle pedido\baja_detalle_pedido.sql`  
`SOURCE FNSP\ABMs\detalle pedido\modificacion_detalle_pedido.sql`  

`SOURCE FNSP\ABMs\direcciones\ciudad_alta_sp.sql`  
`SOURCE FNSP\ABMs\direcciones\direccion_alta_sp.sql`  
`SOURCE FNSP\ABMs\direcciones\pais_alta_sp.sql`  
`SOURCE FNSP\ABMs\direcciones\provincia_alta_sp.sql`  

`SOURCE FNSP\ABMs\insumo\sp_alta_insumo.sql`  
`SOURCE FNSP\ABMs\insumo\sp_baja_insumo.sql`  
`SOURCE FNSP\ABMs\insumo\sp_modificar_insumo.sql`  

`SOURCE FNSP\ABMs\pedido\pedido_alta_sp.sql`  
`SOURCE FNSP\ABMs\pedido\pedido_baja_sp.sql`  
`SOURCE FNSP\ABMs\pedido\pedido_modificacion_sp.sql`  

`SOURCE FNSP\ABMs\proveedor\proveedor_alta_sp.sql`  
`SOURCE FNSP\ABMs\proveedor\proveedor_baja_sp.sql`  
`SOURCE FNSP\ABMs\proveedor\proveedor_modificacion_sp.sql`  
<br>

---

## Uso ABMs
### Altas
`SOURCE Uso ABMs\proveedor\proveedor_alta.sql`  
`SOURCE Uso ABMs\insumo\test_sp_alta_insumo.sql`  
`SOURCE Uso ABMs\concesionario\prueba_alta_concesionario.sql`  
`SOURCE Uso ABMs\pedido\pedido_alta.sql`  
`SOURCE Uso ABMs\detalle pedido\prueba_alta_detalle_pedido.sql`  

<br>

### Modificaciones

`SOURCE Uso ABMs\concesionario\prueba_modificacion_concesionario.sql`  
`SOURCE Uso ABMs\detalle pedido\prueba_modificacion_detalle_pedido.sql`  
`SOURCE Uso ABMs\insumo\test_sp_modificar_insumo.sql`  
`SOURCE Uso ABMs\pedido\pedido_modificacion.sql`  
`SOURCE Uso ABMs\proveedor\proveedor_modificacion.sql`  
<br>

### Bajas
`SOURCE Uso ABMs\concesionario\prueba_baja_concesionario.sql`  
`SOURCE Uso ABMs\detalle pedido\prueba_baja_detalle_pedido.sql`  
`SOURCE Uso ABMs\insumo\test_sp_baja_insumo.sql`  
`SOURCE Uso ABMs\pedido\pedido_baja.sql`  
`SOURCE Uso ABMs\proveedor\proveedor_baja.sql`  
<br>

---

## Uso de Stored procedures
`SOURCE \Uso de FNSP\generar_vehiculo_segun_pedido.sql`  

## Datos
`SOURCE Datos\INSERT - Pedido y detalle.sql`  
`SOURCE Datos\INSERTS - Marca - Modelo - Linea de montaje.sql`  
`SOURCE Datos\INSERTS - Proveedor - Compra.sql`  
<br>

---