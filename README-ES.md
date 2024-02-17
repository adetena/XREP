<h1>XReport</h1>

Esta  plantilla  permite personalizar informes con un diseño adaptable que mantiene
las distintas secciones del cuerpo en una determinada posición del documento.

Cuenta  con la posibilidad de establecer una cabecera  global del informe, que solo
se mostrará en la primera página, así como con una sección lateral que se repite en
cada página que muestre registros.

La  tabla principal cuenta con secciones  de cabecera y pie, que se repiten en cáda
página.

Cada página puede incluir tantas líneas como se definan en la configuración de este
informe.  Para ello, puede personalizar el valor de la variable Range en el trigger
OnInitReport.  En  caso  de  que  el DataSet no contenga registros suficientes para
llenar  la  página, se  generarán  tantas  líneas en blanco como sea necesario para
hacerlo, de modo que el pie de la tabla siga alineado al final del documento.

La plantilla cuenta  con secciones de subtotales y totales, situadas entre la tabla
y el pie de la misma, sin embargo, solo se mostrarán  si contienen registros. Puede 
agregar registros a estas secciones  asignando las tablas necesarias a sus dataitem
correspondientes, o configurando manualmente el rango de la tabla Integer.

Es posible que desee establecer  un tamaño fijo para una de las dos secciones antes
mencionadas.  Para ello puede aumentar el tamaño de la sección deseada en el diseño
del informe y configurar su propiedad Hidden para  que oculte todas las filas salvo
la primera.
