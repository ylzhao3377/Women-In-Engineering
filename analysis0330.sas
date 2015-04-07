*analysis of female vs. male;
ods rtf file='C:\stat427\analysis0330.rtf';
libname stat427 'C:\stat427';
*set new data set;
data stat427.compare;
  length college $ 15 retention 5.3 year $ 4;
  infile 'C:\stat427\female_male.csv' dlm=';' dsd missover;
  input college $ retention year $;
run;

*descriptive statistics;
*boxplot for female vs. male in different colleges;
proc sgplot data=stat427.compare;
  vbox retention/category=college; 
  title 'boxplot for female vs. male grouping by college';
run;

*one-way balanced anova for female-male vs. college;
proc anova data=stat427.compare;
  class college;
  model retention=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model for male:retention vs college';
run;

*one-way balanced anova for female-male vs. college(Engineering and Business);
data stat427.compare1;
  set stat427.compare;
  where college in ('Engineering' 'Business');
run;
proc anova data=stat427.compare1;
  class college;
  model retention=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:retention vs college(Engineering and Business)';
run;

*one-way balanced anova for female-male vs. college(Engineering and ACES);
data stat427.compare2;
  set stat427.compare;
  where college in ('Engineering' 'ACES');
run;
proc anova data=stat427.compare2;
  class college;
  model retention=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:retention vs college(Engineering and ACES)';
run;

*one-way balanced anova for female-male vs. college(Engineering and ALS);
data stat427.compare3;
  set stat427.compare;
  where college in ('Engineering' 'ALS');
run;
proc anova data=stat427.compare3;
  class college;
  model retention=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:retention vs college(Engineering and ALS)';
run;

*one-way balanced anova for female-male vs. college(Engineering and FAA);
data stat427.compare4;
  set stat427.compare;
  where college in ('Engineering' 'FAA');
run;
proc anova data=stat427.compare4;
  class college;
  model retention=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:retention vs college(Engineering and FAA)';
run;

*one-way balanced anova for female-male vs. college(Engineering and LAS);
data stat427.compare5;
  set stat427.compare;
  where college in ('Engineering' 'LAS');
run;
proc anova data=stat427.compare5;
  class college;
  model retention=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:retention vs college(Engineering and LAS)';
run;

*one-way balanced anova for female-male vs. college(Engineering and Education);
data stat427.compare6;
  set stat427.compare;
  where college in ('Engineering' 'Education');
run;
proc anova data=stat427.compare6;
  class college;
  model retention=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:retention vs college(Engineering and Education)';
run;

*set new data set;
data stat427.urm;
  length college $ 15 urm 5.3 nonurm 5.3 between 5.3 year $ 4;
  infile 'C:\stat427\urm.csv' dlm=';' dsd missover;
  input college $ urm nonurm between year $;
run;
*proc print data=stat427.urm;
*run;

*descriptive statistics;
*boxplot for urm vs. nonurm in different colleges;
proc sgplot data=stat427.urm;
  vbox urm/category=college; 
  title 'boxplot for urm grouping by college';
run;
proc sgplot data=stat427.urm;
  vbox nonurm/category=college; 
  title 'boxplot for nonurm grouping by college';
run;
proc sgplot data=stat427.urm;
  vbox between/category=college; 
  title 'boxplot for urm vs. nonurm grouping by college';
run;


*one-way balanced anova for urm retention rate vs. college;
proc anova data=stat427.urm;
  class college;
  model urm=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:urm retention vs college';
run;

*one-way balanced anova for nonurm vs. colleges;
proc anova data=stat427.urm;
  class college;
  model nonurm=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:nonurm vs college';
run;

*one-way balanced anova for urm-nonurm vs. colleges;
proc anova data=stat427.urm;
  class college;
  model between=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:urm-nonurm vs college';
run;

*one-way balanced anova for urm-nonurm vs. college(Engineering and ACES);
data stat427.urm1;
  set stat427.urm;
  where college in ('Engineering' 'ACES');
run;
proc anova data=stat427.urm1;
  class college;
  model between=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:urm-nonurm vs college(Engineering and ACES)';
run;

*one-way balanced anova for urm-nonurm vs. college(Engineering and ALS);
data stat427.urm2;
  set stat427.urm;
  where college in ('Engineering' 'ALS');
run;
proc anova data=stat427.urm2;
  class college;
  model between=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:urm-nonurm vs college(Engineering and ALS)';
run;

*one-way balanced anova for urm-nonurm vs. college(Engineering and Business);
data stat427.urm3;
  set stat427.urm;
  where college in ('Engineering' 'Business');
run;
proc anova data=stat427.urm3;
  class college;
  model between=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:urm-nonurm vs college(Engineering and Business)';
run;

*one-way balanced anova for urm-nonurm vs. college(Engineering and Education);
data stat427.urm4;
  set stat427.urm;
  where college in ('Engineering' 'Education');
run;
proc anova data=stat427.urm4;
  class college;
  model between=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:urm-nonurm vs college(Engineering and Education)';
run;

*one-way balanced anova for urm-nonurm vs. college(Engineering and FAA);
data stat427.urm5;
  set stat427.urm;
  where college in ('Engineering' 'FAA');
run;
proc anova data=stat427.urm5;
  class college;
  model between=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:urm-nonurm vs college(Engineering and FAA)';
run;

*one-way balanced anova for urm-nonurm vs. college(Engineering and LAS);
data stat427.urm6;
  set stat427.urm;
  where college in ('Engineering' 'LAS');
run;
proc anova data=stat427.urm6;
  class college;
  model between=college;
  ods select OverallANOVA ModelANOVA;
  title 'one-way model:urm-nonurm vs college(Engineering and LAS)';
run;

ods rtf close;

