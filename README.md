# SAS Replace Macro

# Overview
It is not uncommon to see variables coded in an odd way to convey some sort of meaning. For example, rather than allowing missing values in data collect, the variables may be coded with 999. When counting missing values, rather than doing conditional checks for these values it is often easier to replace them with the actual missing value. Most softwares have built in functions to check for these, thereby making analysis a bit easier.

This function offers a simple way of finding and replacing those coded values with a value of your choosing and creates a new dataset with the name of your choosing.

# Set-up
<ol>
<li> Clone the Github repository.</li>

```
    git clone https://github.com/kiphandwerker/SASReplace.git
```

<li>Upload the files to SAS OnDemand or SAS program of choice.
<li> SAS OnDemand should run this macro just fine. However if you are running this on some other SAS product (ie Enterprise), you may need to wrap the SQL query in the following:

```sas
%let vl = %sysfunc(dosubl(%nrstr(
    PROC-SQL-QUERY-HERE
)));
```
</ol>

# Usage
Here we will walk through the application of this macro step by step:

## Example 1

<ol>
<li> Take the data set below as a simple example:

```sas
data test;
input ID Name$ Age;
datalines;
1 Brandy   999
2 Tom      34
3 999      57
4 Keith    61
5 Steve    19
6 Emily    999
7 999      37
8 Caroline 42
9 Andy     999
10 999     27
;
run;
```

As you can see, rather than having missing values, they are coded as 999. This is mesy and we would like to fix it.

<li> Read in the macro.

```sas
%include "../Replace.sas";
```
<li>Call the macro.

```sas
%Replace(Input = test, 
        Output = testnew, 
        Old = 999, 
        New = '');
```
The Replace() macro takes in 4 arguements:
<ul>
    <li> <strong>Input: </strong> The name of the datafile you want to read in.
    <li> <strong>Output:</strong> The name of the new datafile you want to output.
    <li> <strong>Old:</strong> The value to be replaced.
    <li> <strong>New:</strong> The value you want to replace <strong>Old</strong> with. 
</ul> 

Note: Make sure to replace the path with the appripriate location of the file.
<li>Print the data

```sas
title 'Old data';
proc print noobs data=test;run;
title 'New data';
proc print noobs data=testnew;run;
```
</ol>


## Example 2

<ol>
<li> Here is another example, but this time missing values are replaced with -4.


Let's do the same thing as before but change them to 999 because why not.

```sas
data test;
input ID Name$ Score;
datalines;
1 Brandy   3
2 Tom      7
3 Sarah    -4
4 Keith    5
5 Steve    2
6 Emily    -4
7 Rachel   10
8 Caroline 9
9 Andy     -4
10 Tony    1
;
run;
```

<li> Read in the macro.

<li> Call the macro.

```sas
%Replace(Input = test, 
        Output = testnew, 
        Old = -4, 
        New = 999);
```
<li>Print the data

```sas
title 'Old data';
proc print noobs data=test;run;
title 'New data';
proc print noobs data=testnew;run;
```
</ol>

## Example 3
<ol>
<li> Here is another example, but this time missing values are replaced with -4.


Let's just change the Score columns because a weight change of -4 is important, where as a -4, for whatever reason, indicated missing.  

```sas
data test;
input ID Name$ Score Weightchange;
datalines;
1 Brandy   3  -10
2 Tom	   7  -4
3 Sarah   -4  4
4 Keith    5  -7
5 Steve    2  5
6 Emily   -4  -4
7 Rachel   10 -2
8 Caroline 9  3
9 Andy    -4  -4
10 Tony    1  -2
;
run;
```

<li> Read in the macro.

<li> Call the macro.

```sas
%Replace(Input = test, 
        Output = testnew, 
        Old = -4, 
        New = ., 
        cols = Score);
```
<li>Print the data

```sas
title 'Old data';
proc print noobs data=test;run;
title 'New data';
proc print noobs data=testnew;run;
```
</ol>