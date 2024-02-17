/// <summary>
/// Esta  plantilla  permite personalizar informes con un diseño adaptable que mantiene
/// las distintas secciones del cuerpo en una determinada posición del documento.
/// 
/// Cuenta  con la posibilidad de establecer una cabecera  global del informe, que solo
/// se mostrará en la primera página, así como con una sección lateral que se repite en
/// cada página que muestre registros.
/// 
/// La  tabla principal cuenta con secciones  de cabecera y pie, que se repiten en cáda
/// página.
/// 
/// Cada página puede incluir tantas líneas como se definan en la configuración de este
/// informe.  Para ello, puede personalizar el valor de la variable "Lines Per Page" en
/// el trigger OnInitReport. En caso de que el DataSet no contenga registros suficiente
/// para llenar la página, se generarán tantas líneas en blanco como sea necesario para
/// hacerlo, de modo que el pie de la tabla siga alineado al final del documento.
/// 
/// La plantilla cuenta  con secciones de subtotales y totales, situadas entre la tabla
/// y el pie de la misma, sin embargo, solo se mostrarán  si contienen registros. Puede 
/// agregar registros a estas secciones  asignando las tablas necesarias a sus dataitem
/// correspondientes, o configurando manualmente el rango de la tabla Integer.
/// 
/// Es posible que desee establecer  un tamaño fijo para una de las dos secciones antes
/// mencionadas.  Para ello puede aumentar el tamaño de la sección deseada en el diseño
/// del informe y configurar su propiedad Hidden para  que oculte todas las filas salvo
/// la primera.
/// 
/// </summary>
report 50100 XReport
{
    ApplicationArea = All;
    Caption = 'XReport';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'src/report/layout/XReport.rdl';

    dataset
    {
        // Dataitem maestro.
        //
        // Puede  reemplazar la  tabla  Integer con la  tabla deseada  y congigurar sus
        // propios filtros, campos y triggers.
        //
        // Las columnas Offset y Range son necesarias para poder calcular los distintos
        // parámetros  del informe desde el diseño del mismo. Permiten  el acceso a las
        // variables a las que refieren desde el código incrustado.
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(Offset; "Report Header Lines") { }
            column(Range; "Lines Per Page") { }

            // Dataitem principal.
            //
            // Puede  reemplazar la tabla Integer con la tabla deseada y configurar sus
            // propios filtros, campos y triggers.
            //
            // La  columna Child_No es necesaria  para  calcular la  visibilidad de las
            // líneas de este dataitem, sin embargo, puede modificar la expresión de la
            // misma.
            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 36));

                column(Child_No; Number) { }
            }

            // Dataitem auxiliar.
            //
            // Este dataitem se encarga de generar las filas en blanco que se requieran
            // hasta completar la página.
            //
            // La  columna Blank_No es necesaria  para  calcular la  visibilidad de las
            // líneas de este dataitem.
            dataitem(Blank; Integer)
            {
                column(Blank_No; Number) { }

                trigger OnPreDataItem()
                begin
                    SetBlankRange;
                end;
            }

            // Dataitem de sección.
            //
            // Puede  reemplazar la tabla Integer con la tabla deseada y configurar sus
            // propios filtros, campos y triggers.
            //
            // La columna Subtotal_No es necesaria para calcular la  visibilidad de las
            // líneas de este dataitem, sin embargo, puede modificar la expresión de la
            // misma.
            dataitem(Subtotal; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 2));

                column(Subtotal_No; Number) { }

                trigger OnPreDataItem()
                begin
                    // Evita generar filas residuales si el dataitem no contiene datos.
                    if IsEmpty then CurrReport.Break;
                end;
            }

            // Dataitem de sección.
            //
            // Puede  reemplazar la tabla Integer con la tabla deseada y configurar sus
            // propios filtros, campos y triggers.
            //
            // La  columna  Total_No  es necesaria para calcular la  visibilidad de las
            // líneas de este dataitem, sin embargo, puede modificar la expresión de la
            // misma.
            dataitem(Total; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 4));

                column(Total_No; Number) { }

                trigger OnPreDataItem()
                begin
                    // Evita generar filas residuales si el dataitem no contiene datos.
                    if IsEmpty then CurrReport.Break;
                end;
            }
        }

        // Dataitem auxiliar.
        //
        // Este dataitem se encarga de generar las secciones laterales que se requieran
        // en funcion del número de páginas que ocupen las líneas del informe.
        //
        // La columna Aside_No es necesaria  para calcular la visibilidad de las líneas
        // de este dataitem.
        dataitem(Aside; Integer)
        {
            column(Aside_No; Number) { }

            trigger OnPreDataItem()
            begin
                SetAsideRange;
            end;
        }
    }

    // Configuración de la plantilla.
    trigger OnInitReport()
    begin
        "Report Header Lines" := 4;
        "Lines Per Page" := 44;
    end;

    var
        "Report Header Lines": Integer;
        "Lines Per Page": Integer;

    /// <summary>
    /// Cuenta  el número de  líneas total del  informe, teniendo  en cuenta  todas las
    /// secciones necesarias.
    /// </summary>
    /// <returns>El número total de líneas del informe.</returns>
    local procedure CountLines(): Integer
    begin
        exit("Report Header Lines" + Child.Count + Subtotal.Count + Total.Count)
    end;

    /// <summary>
    /// Calcula  el  número de lineas en  blanco a añadir  en función de los parámetros
    /// definidos en la configuración de la plantilla.
    /// </summary>
    /// <returns>The number of blank lines to add.</returns>
    local procedure CalcBlanks(): Integer
    begin
        exit(("Lines Per Page" - (CountLines mod "Lines Per Page")) mod "Lines Per Page");
    end;

    /// <summary>
    /// Establece el rango del dataitem auxiliar que genera las líneas en blanco.
    /// </summary>
    local procedure SetBlankRange()
    begin
        Blank.SetRange(Number, 1, CalcBlanks);

        if Blank.IsEmpty then CurrReport.Break;
    end;

    /// <summary>
    /// Establece el rango del dataitem auxiliar que genera las secciones laterales.
    /// </summary>
    local procedure SetAsideRange()
    begin
        Aside.SetRange(Number, 1, (CountLines + CalcBlanks) div "Lines Per Page");
    end;
}