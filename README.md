<h1>XReport</h1>

<p style="text-align=justify;">This template enables report customization with a flexible layout that maintain all
sections in an specific position of the document.</p>

It  has  the  capability  of  setting up a global report header, which will only be
displayed in the first page of the report, as well as an aside section that will be
repeated in each page containing records.

The main table has header and footer sections that repeats on each page.

Each  page may include  as many lines  as defined in the  template setup. To modify 
this value, you  can customize the global Range variable value in the  OnInitReport 
trigger. If the dataset  has not enough rows to fill the page, blanks lines will be
added until the page is complete, so the footer of the table stays at the bottom of
the document.

This  template  also  has  subtotals  and totals sections, located between the main
table  and  the  footers. You can customize the source tables for the corresponding
dataitems or set up an specific range for the default Integer table.

You  may  want to use a fixed size for those sections. To achieve this, you'll need
to  increase the height of the corresponding row in the layout to the desired size,
as well as set up the range of the Integer table for the dataitem for that section.
That  will  generate as many rows as the specified range, but you can just hide all
rows except for the first one in the layout.
