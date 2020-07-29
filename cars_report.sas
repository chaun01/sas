/* Report */
title "Cars Report";
data cars_update;
    set sashelp.cars;
    if MSRP<20000 then Cost_Group=1;
    else if MSRP<40000 then Cost_Group=2;
    else if MSRP<60000 then Cost_Group=3;
    else Cost_Group=4;
    Markup = MSRP - Invoice;
    keep Make Model Type Origin MSRP Cost_Group Markup;
run;

proc print data=sashelp.cars;
    where Type="Sedan" and Origin = "USA";
run;

proc print data=sashelp.cars;
    where Type="SUV" and Origin = "USA";
run;

proc print data=sashelp.cars;
    where Type="Sports" and Origin = "USA";
run;

/* Bar Chart */
ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=SASHELP.CARS;
	title height=14pt "Mean Mileage by Type and Origin";
	vbar Type / response=MPG_City group=Origin groupdisplay=cluster datalabel 
		stat=mean dataskin=sheen;
	xaxis display=(nolabel);
	yaxis grid;
run;

ods graphics / reset;
title;

/* Scatter Plot */
ods graphics / reset width=6in height=4in imagemap;

proc sgplot data=SASHELP.CARS;
	title height=14pt "Vehicle Statistics";
	scatter x=Horsepower y=MPG_City / group=Origin 
		markerattrs=(symbol=circlefilled size=12) transparency=0.75;
	xaxis grid;
	yaxis grid;
	keylegend / location=inside;
run;

ods graphics / reset;
title;
