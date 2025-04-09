%macro Replace(Input, Output, old, new, cols=All);

    /* Get metadata about the dataset */
    proc contents data=&Input. out=contents(keep=name type) noprint; run;

    /* Create macro variables for numeric and character variable names */
    proc sql noprint;
        select name into :num_vars separated by ' '
        from contents
        where type = 1;

        select name into :char_vars separated by ' '
        from contents
        where type = 2;
    quit;

    /* Create macro variable for columns of interest */
    %if %upcase(&cols) = ALL %then %do;
        %let cols_to_change = &num_vars. &char_vars.;
    %end;
    %else %do;
        %let cols_to_change = &cols.;
    %end;

data &Output.;
    set &Input.;
    
    length varname $32;  /* Declare varname as a character variable */

    /* Handle numeric variables */
    array nums {*} &num_vars.;
    do i = 1 to dim(nums);
        call vname(nums{i}, varname);
        if indexw("&cols_to_change", varname) then do;
            if nums{i} = &old. then nums{i} = &new.;
        end;
    end;

    /* Handle character variables */
    array chars {*} &char_vars.;
    do j = 1 to dim(chars);
        call vname(chars{j}, varname);
        if indexw("&cols_to_change", varname) then do;
            if chars{j} = "&old." then chars{j} = "&new.";
        end;
    end;

    drop i j varname;
run;

    proc datasets library=work nolist;
        delete contents;
    quit;

%mend;