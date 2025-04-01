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

	data &Output. (drop = i j);
		set &Input.;
		array num_vars{*} &num_vars.;
		array char_vars{*} &char_vars.;

		do i = 1 to dim(num_vars);
			if num_vars{i} = &old. then
			num_vars{i} = &new.;
		end;

		do j = 1 to dim(char_vars);
			if char_vars{j} = &old. then
			char_vars{j} = &new.;
		end;

	run;
%mend;