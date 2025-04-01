%macro Replace(Input, Output, old, new);
	
	proc contents data= &Input. out = contents noprint; run;
	
%mend;