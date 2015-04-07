* STAT 427
* Group 8
* WIE Program

* Data #5 
* GOAL:
Evaluate
-	Is campussi/campuspgpa/AcademicIdex associated with EngGPA?

******************
*  READ IN DATA  *
******************;

proc import datafile='C:\Users\jinggu2\Desktop\dataset5.xls'
            out=work.rawdata5
			dbms=xls replace;
	getnames=yes;
run;


proc freq data=work.rawdata5;
  tables initialterm gender/ nocum;
run;


proc sort data=work.rawdata5
          out=work.sort_dataset5;
   by initialterm;
run;

data dataset5(rename=(LastEngrCumGPA=EngGPA
                      LastUIUCCumGPA=UIUCGPA));
	set work.sort_dataset5;
	drop code_id campussi campuspgpa academicindex;
	if degreeterm ~=' ' and degreeterm = LastUIUCterm then degree=1;
	else degree=0;
	index=sum(campussi,campuspgpa,academicindex);
	if index ~=. and LastEngrCumGPA ~=.;
run;

* proc contents data=work.dataset5;
* run;

* create new datasets for different terms;

data term20128 term20138 term20148;
     set work.dataset5;
	 if initialterm=120128 then output term20128;
	 else if initialterm=120138 then output term20138;
	 else if initialterm=120148 then output term20148;
run;



**********************
*  ANALYSIS OF DATA  *
**********************;

proc freq data=term20128;
   tables index;
run;

proc freq data=term20138;
   tables index;
run;

proc freq data=term20148;
   tables index;
run;




********************
* for term 2012_08 *
********************;

proc means data=term20128;
  var index;
run;

proc sort data=term20128
          out=term20128_sorted;
	by index;
run;

data term20128_modified;
   set term20128;
   if index>4;
run;
* 1277 obs;

proc univariate data=term20128_modified noprint;
   var index;
   output out=percentile20128 pctlpts=25 50 75 100 pctlpre=P;
run; 
* min=63, max=107;
* 25%=83, 50%=88, 75%=91, 100%=107;

/*data term20128_1 term20128_2 term20128_3 term20128_4;
   set term20128_modified;
   if index <= 83 then output term20128_1;
   else if 83 < index <=88 then output term20128_2;
   else if 88 < index <=91 then output term20128_3;
   else if 91 < index then output term20128_4;
run;*/

data term20128final;
   set term20128_modified;
   if index <= 83 then Quantile=1;
   else if 83 < index <=88 then Quantile=2;
   else if 88 < index <=91 then Quantile=3;
   else if 91 < index then Quantile=4;
   if index <= 83 then Group=1;
   else Group=2;
run;
*Index;
proc sort data=term20128final;by Quantile;run;
proc means data=term20128final;
   by Quantile;
   var index;
   output out=index20128 mean=mean stderr=stderr;
run;
data reshape20128_1;
   set index20128;
   lower=mean-stderr;
   upper=mean+stderr;
run;
title 'Plot Means with StdErr Bars for AI 2012';
proc sgplot data=reshape20128_1 noautolegend;                                                                                                  
   scatter x=Quantile y=mean / yerrorlower=lower                                                                                            
                           yerrorupper=upper                                                                                            
                           markerattrs=(color=blue symbol=CircleFilled);                                                                
   series x=Quantile y=mean / lineattrs=(color=blue pattern=2);                                                                                                                                           
run;      
title;
*EngGPA;
proc means data=term20128final;
   by Quantile;
   var EngGPA;
   output out=GPA20128 mean=mean stderr=stderr;
run;
data reshape20128_2;
   set GPA20128;
   lower=mean-stderr;
   upper=mean+stderr;
run;
title 'Plot Means with StdErr Bars for GPA 2012';
proc sgplot data=reshape20128_2 noautolegend;                                                                                                  
   scatter x=Quantile y=mean / yerrorlower=lower                                                                                            
                           yerrorupper=upper                                                                                            
                           markerattrs=(color=blue symbol=CircleFilled);                                                                
   series x=Quantile y=mean / lineattrs=(color=blue pattern=2);                                                                                                                                           
run;      
title;

* scatterplot of GPA and AI;
title 'Scatterplot Grouping by Quantiles 2012';
proc sgplot data=term20128final;
  reg x=Index y=EngGPA / group=Quantile;
run;
title;

* scatterplot of GPA and AI;
title 'Scatterplot Grouping by Quantiles 2012';
proc sgplot data=term20128final;
  reg x=Index y=EngGPA / group=Group;
run;
title;


********************
* for term 2013_08 *
********************;

proc means data=term20138;
  var index;
run;
* 1361 obs;

proc univariate data=term20138 noprint;
   var index;
   output out=percentile20138 pctlpts=25 50 75 100 pctlpre=P;
run; 
* min=62, max=107;
* 25%=84, 50%=88, 75%=92, 100%=107;

/*data term20128_1 term20128_2 term20128_3 term20128_4;
   set term20128_modified;
   if index <= 83 then output term20128_1;
   else if 83 < index <=88 then output term20128_2;
   else if 88 < index <=91 then output term20128_3;
   else if 91 < index then output term20128_4;
run;*/

data term20138final;
   set term20138;
   if index <= 84 then Quantile=1;
   else if 84 < index <=88 then Quantile=2;
   else if 88 < index <=92 then Quantile=3;
   else if 92 < index then Quantile=4;
   if index <= 84 then Group=1;
   else Group=2;
run;
 
* for 25%;
proc means data=term20138_1;
   var index EngGPA;
run;

* for 50%;
proc means data=term20138_2;
   var index EngGPA;
run;

* for 75%;
proc means data=term20138_3;
   var index EngGPA;
run;

* for 100%;
proc means data=term20138_4;
   var index EngGPA;
run;


proc sort data=term20138final;by Quantile;run;
proc means data=term20138final;
   by Quantile;
   var index;
   output out=index20138 mean=mean stderr=stderr;
run;
data reshape20138_1;
   set index20138;
   lower=mean-stderr;
   upper=mean+stderr;
run;
title 'Plot Means with StdErr Bars for AI 2013';
proc sgplot data=reshape20138_1 noautolegend;                                                                                                  
   scatter x=Quantile y=mean / yerrorlower=lower                                                                                            
                           yerrorupper=upper                                                                                            
                           markerattrs=(color=blue symbol=CircleFilled);                                                                
   series x=Quantile y=mean / lineattrs=(color=blue pattern=2);                                                                                                                                           
run;      
title;

proc means data=term20138final;
   by Quantile;
   var EngGPA;
   output out=GPA20138 mean=mean stderr=stderr;
run;
data reshape20138_2;
   set GPA20138;
   lower=mean-stderr;
   upper=mean+stderr;
run;
title 'Plot Means with StdErr Bars for GPA 2013';
proc sgplot data=reshape20138_2 noautolegend;                                                                                                  
   scatter x=Quantile y=mean / yerrorlower=lower                                                                                            
                           yerrorupper=upper                                                                                            
                           markerattrs=(color=blue symbol=CircleFilled);                                                                
   series x=Quantile y=mean / lineattrs=(color=blue pattern=2);                                                                                                                                           
run;      
title;

* scatterplot of GPA and AI;
title 'Scatterplot Grouping by Quantiles 2013';
proc sgplot data=term20138final;
  reg x=Index y=EngGPA / group=Quantile;
run;
title;

* scatterplot of GPA and AI;
title 'Scatterplot Grouping by Quantiles 2013';
proc sgplot data=term20138final;
  reg x=Index y=EngGPA / group=Group;
run;
title;


********************
* for term 2014_08 *
********************;

proc means data=term20148;
  var index;
run;
* 1362 obs;

proc univariate data=term20148 noprint;
   var index;
   output out=percentile20148 pctlpts=25 50 75 100 pctlpre=P;
run; 
* min=69, max=108;
* 25%=87, 50%=91, 75%=94, 100%=108;

data term20148final;
   set term20148;
   if index <= 87 then Quantile=1;
   else if 87 < index <=91 then Quantile=2;
   else if 91 < index <=94 then Quantile=3;
   else if 94 < index then Quantile=4;
   if index <= 87 then Group=1;
   else Group=2;
run;
 
* for 25%;
proc means data=term20128_1;
   var index EngGPA;
run;

* for 50%;
proc means data=term20128_2;
   var index EngGPA;
run;

* for 75%;
proc means data=term20128_3;
   var index EngGPA;
run;

* for 100%;
proc means data=term20128_4;
   var index EngGPA;
run;


proc sort data=term20148final;by Quantile;run;
proc means data=term20148final;
   by Quantile;
   var index;
   output out=index20148 mean=mean stderr=stderr;
run;
data reshape20148_1;
   set index20148;
   lower=mean-stderr;
   upper=mean+stderr;
run;
title 'Plot Means with StdErr Bars for AI 2014';
proc sgplot data=reshape20148_1 noautolegend;                                                                                                  
   scatter x=Quantile y=mean / yerrorlower=lower                                                                                            
                           yerrorupper=upper                                                                                            
                           markerattrs=(color=blue symbol=CircleFilled);                                                                
   series x=Quantile y=mean / lineattrs=(color=blue pattern=2);                                                                                                                                           
run;      
title;

proc means data=term20148final;
   by Quantile;
   var EngGPA;
   output out=GPA20148 mean=mean stderr=stderr;
run;
data reshape20148_2;
   set GPA20148;
   lower=mean-stderr;
   upper=mean+stderr;
run;
title 'Plot Means with StdErr Bars for GPA 2014';
proc sgplot data=reshape20148_2 noautolegend;                                                                                                  
   scatter x=Quantile y=mean / yerrorlower=lower                                                                                            
                           yerrorupper=upper                                                                                            
                           markerattrs=(color=blue symbol=CircleFilled);                                                                
   series x=Quantile y=mean / lineattrs=(color=blue pattern=2);                                                                                                                                           
run;      
title;

* scatterplot of GPA and AI;
title 'Scatterplot Grouping by Quantiles 2014';
proc sgplot data=term20148final;
  reg x=Index y=EngGPA / group=Quantile;
run;
title;

* scatterplot of GPA and AI;
title 'Scatterplot Grouping by Quantiles 2014';
proc sgplot data=term20148final;
  reg x=Index y=EngGPA / group=Group;
run;
title;







