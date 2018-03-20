Function and more
=================

The following overview serves as an aid to the use of the import functions as well as information about the import speed and 
shows further options for data import.

Functions
----------

The functions listed can be requested within an import configuration (xml configuration file) in order to convert, check or connect source data with other information.

### Conversion functions

The following functions convert a string to another type. The following target types are available:

- Double
- Float
- Int
- Long

``` 
cdouble(String in) 
cfloat(String in) 
cint(String in) 
clong(Object in) 
``` 

In contrast, any other data types can be converted to a string.

	cstring(Object in) 

Convert any date format to the database's own format.

	date(String format, String in) 

### More functions

perform AND operation on two boolean values.

	AND(Boolean v1, Boolean v2) 

Connect two input strings to a result string (concatenate).

	concat(String s1, String s2) 

Returns the quotient of two numeric values.

	DIV(v1, v2) 

Returns whether the passed string has the length 0.

	empty(String in) 

Checks if the input string (str1) ends with the test string (end)

	endsWith(String str1, String end) 

Tests whether two strings are equal.

	equals(String str1, String str2) 

Returns the extension of a given file name

	file_extension(String file) 

Returns the file name without the extension of a file, free of path information

	file_woext(String file) 

Imports a file (sFileName)

	file(String sFileName) 

Returns the filename of a file, free of path information

	filename(String file) 

Returns the absolute path of a file

	filepath(String file) 

!!! example "findFirst"
    These functions are only available in Implex version 4.0 and finds the first position of a character (optionally from a specific position) and returns the position as Int
``` 
findFirst(in, match)
findFirst(in, match, startPos)
``` 

!!! example "findLast"
    These functions are only available in Implex version 4.0 and finds the last position of a character (optionally from a specific position) and returns the position as Int
``` 
findLast(in, match)
findLast(in, match, startPos)
``` 

Returns if ifclause == true, otherwise elsedo

	iif(Boolean ifclause, then, elsedo) 

Returns the length of a string

	length(String str) 

Converts a string to lowercase

	lower(String val) 

Subtracts two numeric values from each other.

	MINUS(v1, v2) 

Returns the product of the two numerical values.

	MUL(v1, v2) 

For standardization of a house number.

	normHnr(String in) 

Returns the passed Boolean value negated.

	NOT(Boolean in) 

Tests whether two strings are not equal.

	notequals(String str1, String str2) 

Performs the OR operation on two Boolean values

	OR(Boolean v1, Boolean v2) 

Returns a string with the input string characters right-aligned by
padding the left side with blanks

	pad_left(String in, Integer len) 

Returns a string in which the input string characters are left 
justified by padding the right side with blanks

	pad_right(String in, Integer len) 

Returns a string with the input string characters aligned
right-justified by padding the left side with the specified 
character

	pad_left(String in, String char, Integer len) 

Returns a string in which the input string characters are left
justified by padding the right side with the specified character

	pad_right(String in, String char, Integer len) 

Adds the two numeric values.

	PLUS(v1, v2) 

Replaces a search string in the input string with a replacement string.

	replace(String sIn, String sSeek, String sRepl) 

Returns all characters from the input string starting at the desired
start character beginning.

	rsubstring(String in, Integer start) 

Returns the nth element from the decomposed input string.

	split(String src, String splitStr, Integer n) 

Returns the file name incl. the extension of the called import file

	sourceFileName() 

Returns a substring with the specified length from the input start
position from the input string.

	substring(String in, Integer start, Integer len) 

Converts a CORTEX date format string to a CORTEX Internal Long timestamp.

	time(String date) 

The call without parameters returns the current, minute-exact time stamp.
For use as history information, a conversion with the Date function is necessary.

	time()

Performs a trim on a string.

	trim(String in) 

Converts a string to uppercase.

	upper(String val) 

### Variables in the configuration

Especially with extensive import configurations, it is helpful if already
defined values can be reused by variables. There are four basic functions 
available for this purpose.

For text values, variables can be set and read via two functions:

	getVar(String Name)
	setVar(String Name, String Value)

Numeric values (double) can be set and read with an extended function:

	getVarDouble(String Name)
	setVarDouble(String Name, String Value)

It should be noted that variables can only be used on the right side of the equals sign of the value assignment. On the left side of the equals sign (for example, for the determination of a historical date) the use is not possible.

Speed
---------------

Of course, the speed of the import of course depends on the hardware used.
SSD storage media are typically significantly faster than hard drives; Importing
without references is faster than updating existing datasets.

### Import mode of the server

The database server can be switched to the so-called "import mode" during
startup in order to speed up data import. In this case, the data to be imported
is imported without creating the administrative structures (including the index).
Only after the actual data import, the server is terminated, restarted and reorganized
to build these structures. This makes sense, for example, if importing substantial
amounts of data via the first import and then only supplementary information.

The general procedure for importing via import mode is divided into the following steps:

- Stop the running database server
- Manually start the database server with the parameter "-m"
- Perform the import
- After the import, quit the database server and start it regularly
- Perform a reorganization via remote admin

The manual start of the server usually takes place in a system console (the so-called "terminal").
In Windows, run the cmd.exe application and then start the database server in the database directory:

    ctxserver64.exe -m

or with 32-bit systems:

    ctxserver32.exe -m

For the reorganization, start the remote admin and click on the item
"Reorganization" (top right in the mask). During this execution, no
working within the database is possible, as this is the first time the
administrative structures are established (or corrected).

Should there be a database which the first import and regularly recurring
consists of large data sets (hundreds of millions or billions), please 
contact us for answers to more in-depth questions.

### Filter function

Within an import configuration, it is possible to configure a filter that
only allows the import of specific datasets. Invalid datasets are excluded
from the outset and not skipped.

Within the *ImportSection*, only one additional parameter is added, which
defines the filter. The following example shows the application for excluding
certain datasets during the import:

    <ImportSection datasettype="Pers">

      <FilterFunction>
        getChar('P_id')!=''
      </FilterFunction>

      <Reference>PersID</Reference>

      <Field>PersID=getChar('P_id')</Field>
      <Field>FirstName=getChar('FirstName')</Field>
      <Field>Nam=getChar('Name')</Field>

    </ImportSection>

The example shown here excludes all datasets for which there is no dataset ID
from the source system. Only if the return of the filter function returns "*true*" 
will the dataset be imported. A combination of several functions is therefore also possible:

    <ImportSection datasettype="Pers">

      <FilterFunction>
        AND(getChar('P_id')!='',getChar('Name')!='')
      </FilterFunction>

      <Reference>PersID</Reference>

      <Field>PersID=getChar('P_id')</Field>
      <Field>Vor=getChar('FirstName')</Field>
      <Field>Nam=getChar('Name')</Field>

    </ImportSection>

### Formation of a hash value

As a supplement to the reference import - ie the update of existing data - 
the use of a hash field is possible. When importing csv files, ImPlex
supports the creation of a hash value over the dataset and writes this hash value
in a separate field. If a new import is performed, the hash value is searched for
in the database before the reference search. If this is found, there is no change;
If the value does not exist, the reference picks up and an existing dataset is 
updated (or a new dataset is created).

In order to use this function, it is necessary to supplement the import configuration
in block "*ImportSection*" and to use an additional field.

      <ImportSection datasettype="MyDS">
        <HashFilter>hashfld</HashFilter>
        <Reference>myRefFl</Reference>
        <Field>myField1=getChar('field1')</Field>
        <Field>myField2=getChar('field2')</Field>
        <Field>myFieldX=getChar('...')</Field>
      </ImportSection>

The hash value is stored in the "*hashfld*" field in this example and 
compared with it when imported again. All further configurations for further
fields remain as they are. It is not necessary for the hash value to create 
another line with an import configuration.

Delta-Import 
------------

The delta import enables the automatic processing of non-changed datasets.
For this purpose, the imPlex import tool includes the so-called "delta list", 
in which after processing the source file, only the datasets that have not
been updated are noted. These remaining datasets (delta list) can then be 
processed by four different methods.

### Modes of the delta list

The delta import can use four settings for the delta list.

``` 
c = clear -  set all values except the current contents of the reference fields to empty from today's date
l = delete - irretrievable deletion of the complete dataset
a = archive - archiving by type of CortexUniplex
w = recoverable delete - recoverable delete in the manner of the CortexUniplex
```

**Example**

The following example shows a configuration using the delta list to update
existing datasets based on the reference and to delete the non-updated datasets 
(irrevocably).

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29000</LoginPort>
    <LoginUser>import-user</LoginUser>
    <LoginPW>userpasswd</LoginPW>
    <ImportMode>u</ImportMode>
    <DeltaList>l</DeltaList>
  </Global>

  <ReaderModul typ="csv">
    <FileName>import-file.csv</FileName>
    <FieldSeparator>,</FieldSeparator>
    <FieldDelimiter>"</FieldDelimiter>
    <RepDelimiter>,</RepDelimiter>
    <ColumnMode>HEADER</ColumnMode>
    <Charset>ISO-8859-1</Charset>
  </ReaderModul>

  <ImportSection datensatztyp="Pers">
    <Reference>Name</Reference>
    <Field>Name=LastName</Field>
    <Field>Fir=FirstName</Field>
  </ImportSection>

</CtxImport>
```

**Note:**

The delta list uses only the information of the specified reference field. 
The dataset type is not considered. If the reference field is used in
different dataset types, all datasets that do not belong to the configured
type in the "Import Section" are deleted.

### Delta import for repeating fields

Repeating fields as well as complete datasets can be updated via Delta
import. This has the consequence that those repeating fields are deleted when
they are no longer present in the source.

**Example**

``` 
<RepGroup start="Hobbies">
    <Field deltalist='d'>PeHob = getChar(Hobby)</Field>
</RepGroup>
```

In this example, the contents of a person's field hobby are read from an
XML file. If a hobby is stored in the database, but the source is no 
longer delivered, the field is removed.

**Note:**

The combination of the deltalist parameter and specifying a reference,
as well as using the delta list in multiple fields of a repeating field
group, can produce unexpected results and should be sufficiently tested 
before final use.
