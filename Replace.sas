%macro Replace(Input, Output, old, new);
	
	proc contents data= &Input. out = contents noprint; run;
	
	proc sql noprint;
		select name into: num_vars separated by ' ' 
		from contents
		where type = 1;
		
		select name into: num_vars separated by ' ' 
		from contents
		where type = 2;
	quit;
	
%mend;