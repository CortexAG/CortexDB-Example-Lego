Manual Import Configuration
============================

Manual editing of the import configurations allows the use of extensive
functions and settings. Configuration takes place via xml files, which are 
read and processed by the ImPlex. The call is made via the call parameters 
of the ImPlex.

In this case, a separate import configuration file has to be created for 
each source (csv, xml file, Cortex access or other).

Furthermore, several dataset types can be defined as destinations within 
a configuration so that several datasets can be created from one source.

!!! warning "Changes to the Implex as of version 4.0"
    With version 4.0, the identifiers for the parameters in the import configurations change. As of this version, a configuration and the call is only possible with English identifiers. Old configurations must therefore be adapted!

Call parameter Implex.jar
--------------------------

ImPlex importer is a console-based Java application. This can be called
manually as well as via scheduled system services. The following call 
parameters are available for this.

On Windows systems, note that the entries for the installed Java must be 
specified within the environment variables.

Call:

    java -jar Implex.jar [OPTIONS] ... [DEFINITIONS_FILE] ...

Options:

    -i, --import        Use subsequent import definition (XML) files.
    -l, --link          Resolve link definition.
    -s, --simulate      Action simulation. There will be no writing processes running in the server.
    -v, --verbose       All log messages output in addition to the console.
    -h, --help          Call this help

The following switches should only be used by experts:

    -e, --emulate       Writes in a definition for the import mode,
                        the internal representation of the first dataset read
                        in a file and then exits the program 
                        (only for the development of reader modules).
    -d, --delay [NUMBER]  Number of datasets, after which always a log 
                        message to be output (default: 200)
    --server [IP:PORT]  Here you can specify a database server
                        (Ex.: 127.0.0.1:29000)
    --source [FILE]    If the reader module allows it, a source file 
                        name can be specified here
                        (depending on the reading module)
    --getinfo [FILE]   Liefert gefolgt von einem JSON-Dateinamen eine 
                        Modulspezifische Information 
                        (depending on the reading module)
    -- start [NUMBER]     Starts with the import from the given dataset
    -- end [NUMBER]       Reads as many datasets as indicated

Any number of definition files can be specified consecutively and several 
options can be specified in any order.

!!! note "Notes"
    The parameter -s (simulation) has a global effect on all modes transferred in the call!

The parameters `--start` and `--end` only work for csv and xml imports.

### Java Call Parameters

If the call is made manually or via a script, it may be necessary to pass
country-specific parameters to Java so that, for example, numbers and 
currencies are imported correctly.

The Java call is then extended with the following information:

    -Duser.country=DE -Duser.language=de

The call then includes completely the jar file of the Implex and
other parameters. For example, you can also pass the import and 
source files:

    java -jar -Duser.country=DE -Duser.language=de Implex.jar -i --server localhost:29000 --source www/Implex/sourceFile.xml ./www/implex/Import-Config.xml

The example shows the call of the Implex.jar with additional,
country-specific Java parameters and the Implex parameters for
the source and import configuration file.

General Definitions
-----------------------

The structure of an import configuration is basically divided into
three main areas via which various settings are possible. Within this
xml file, the respective adjustments have to be made in the "Global",
"ReaderModul" and "ImportSection" areas.

The "Global" area defines access to the database, the "ReaderModul" access 
to the source data, and the "ImportSection" defines the field assignment
from source to target fields.

``` 
<?xml version="1.0" encoding="UTF-8"?>
 <CtxImport>
 <Global>
    <LoginIP>[.......]</LoginIP>
        <LoginPort>[.......]</LoginPort>
    <LoginUser>[.......]</LoginUser>
    <LoginPW>[.......]</LoginPW>
    <ImportModus>[.......]</ImportModus>
 </Global>

 <ReaderModul typ="[.......]">
      [.......]
 </ReaderModul>

 <ImportSection datensatztyp="[.......]">
    [.......]
 </ImportSection>

 </CtxImport>
```

In the "Global" area you configure the access data for your database
and enter the desired "ImportMode" there. Here you can choose between 
"n" (new), "u" (update) or "nu" or "un" (for "update, otherwise new").

According to the above possibilities, the area "Global" can be configured 
as an example:

``` 
<CtxImport>
 <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29001</LoginPort>
    <LoginUser>admin</LoginUser>
    <LoginPW>adm#13qzy2!</LoginPW>
    <ImportModus>nu</ImportModus>
 </Global>
```

The areas "ReaderModul" and "ImportSection" depend on the respective data source.

**Note:**

From a data source, multiple datasets of different dataset types can be created 
(e.g., from a person, a person dataset and an address dataset). All you need to do
is create the "ImportSection" multiple times.

Gen. Definition from Implex 4.0
------------------------------
``` 
	<Global>
		<LoginIP>localhost</LoginIP>				<!-- IP or server name -->
		<LoginPort>40000</LoginPort>				<!-- database port; also via parameter for implex available -->
		<LoginUser>admin</LoginUser>				<!-- user -->
		<LoginPW>admin</LoginPW>					<!-- password -->
		<ImportMode>u</ImportMode>					<!-- import mode; n, u, nu/un for new and/or update-->
	</Global>

	<ReaderModul type="csv">
		<Filename>./www/import-data/train.csv</Filename>	<!-- relative path to implex in bin directory -->
		<Seperator>,</Seperator>							<!-- field separator -->
		<Delimiter>"</Delimiter>							<!-- field delimiter -->
		<RepDelimiter>;</RepDelimiter>						<!-- seperator for repeated content in one field; e.g.: "email 1; email 2; email 3; ..." -->
		<ColumnMode>HEADER</ColumnMode>						<!-- column mode HEADER, NUMERISCH, ABC -->
		<Charset>UTF-8</Charset>
	</ReaderModul>

	<ImportSection recordtype="Pass">
		<Reference>PID</Reference>							<!-- reference to find datasets if update is necessary -->
		<Field>...=...</Field>
	</ImportSection>
``` 

Import of csv files
----------------------

The manual configuration for importing csv files consists of an xml 
configuration file for the import program "ImPlex". This file is divided
into several sections to ensure login to the database, reading of the sources
("reader module") and mapping between source and destination. The structure 
of this configuration file is basically the same for each import and therefore
differs only in the respective parameters for sources, reader module and
destination mapping.

As explained in the section for the ImPlex plugin, csv files consist of single
values separated by a uniform delimiter. In addition, the individual values are
often surrounded by so-called "field delimiters".

Usually, the first line of such a file contains the column headings (field identifiers).
If this is not the case, is in the "ReaderModule" section of the configuration file,
change the "ColumnMode" value. Here are the possibilities "HEADER" (if the first line
contains the identifiers), "NUMERIC" or "ABC" available.

Example of a csv file (semicolon separated values):

    "Name";"Vorname";"Ort";"HobbyNr";"Hobbies"
    "Meier";"Max";"Hamburg";"1,2";"Fußball,Hockey"
    "Müller";"Sandra";"Bielefeld";"1,2";"Tanzen,Reiten"

Example of a csv file (tab-separated values):

    "Name"    "Vorname"    "Ort"    "HobbyNr"    "Hobbies"
    "Meier"    "Max"    "Hamburg"    "1,2"    "Fußball,Hockey"
    "Müller"    "Sandra"    "Bielefeld"    "1,2"    "Tanzen,Reiten"
    
### Reader module for csv files

The example of a csv file shows two datasets to be imported with the respective field
labels in the first row. The following section for the "ReaderModul" field therefore 
shows the corresponding Configuration settings (for semicolon-separated values):

```xml
<ReaderModul typ="csv">
    <Filename>/Data/import/2013Mai.csv</Filename>
    <FieldSeparator>;</FieldSeparator>
    <FieldDelimiter>"</FieldDelimiter>
    <RepeatingDelimiter>,</RepeatingDelimiter>
    <ColumnMode>HEADER</ColumnMode>
    <Charset>UTF-8</Charset>
</ReaderModul>
```

Note that specifying the file name must include the whole path to the file.

Furthermore, make sure that you specify the correct character set ("charset") 
of the import file. Otherwise umlauts will not be imported correctly. There are 
three settings for you to choose from: UTF-8, windows-1251 and ISO-8859-1.

If other characters are used instead of semicolons for the separation
of the values, these must be entered with the `FieldSeparator` specification. 
The special case of tabs (tab characters) requires the use of the
Expressions**.

Example configuration block for tab-separated values:

```xml
<ReaderModul typ="csv">
    <Fieldname>/Data/import/2013Mai.csv</Fieldname>
    <FieldSeparator></FieldSeparator>
    <FieldDelimiter>"</FieldDelimiter>
    <RepeatingDelimiter>,</RepeatingDelimiter>
    <ColumnMode>HEADER</ColumnMode>
    <Charset>UTF-8</Charset>
</ReaderModul>
```

If the examples shown so far are combined as a configuration file,
the xml file is as follows:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29001</LoginPort>
    <LoginUser>admin</LoginUser>
    <LoginPW>adm#13qzy2!</LoginPW>
    <ImportMode>nu</ImportMode>
</Global>
<ReaderModul typ="csv">
    <Filename>/Data/import/2013Mai.csv</Filename>
    <Fieldseparator>;</Fieldseparator>
    <FieldDelimiter>"</FieldDelimiter>
    <RepDelimiter>,</RepDelimiter>
    <ColumnMode>HEADER</ColumnMode>
    <Charset>UTF-8</Charset>
</ReaderModul>
<ImportSection datasettype="[.......]">
    [.......]
</ImportSection>
</CtxImport>
```


### Import section for csv files

Within the "ImportSection" you define the field assignments and references
for the import. Here you can also save field contents as history information
and use advanced features (such as defining cases based on specific content
or modifying content).

For the csv example listed above, the following import section can be used
if database fields with the synonyms "perName", "perVorn" and "perAloc" exist:

```xml
<ImportSection datasettype="PERS">
    <Reference>perName</Reference>
    <Field>perName=getChar('Name')</Field>
    <Field>perFirstname=getChar('First name')</Field>
    <Field>perCity=getChar('City')</Field>
</ImportSection>
```

The abbreviation of the dataset is defined as parameter for the "ImportSection" 
(in the example shown "PERS"). The subsequent field assignments thus refer to 
this dataset type. Possibly, new datasets are created if the reference cannot
find an update dataset and the import mode has been set to "nu" or "n".

If you want to update existing datasets, it is necessary to specify a reference
field. This is determined by the "Reference" entry.

You then assign all other source fields to a target by creating a "Field" entry
for each assignment. The assignment always consists of destination = source.

Example:

```xml
<Field>perName=getChar('Name')</Field>
```

In this example, the target field "perName" is assigned the value from the "Name"
field. Note that the source fields are always enclosed with the "getChar" function.


### Use of functions

There are several functions available for the configuration with which you can change
the contents as required. A complete overview can be found in the section "Import functions".
The following example therefore only shows a selection of possibilities.

``` 
<ImportSection datasettype="PERS">
  <Reference>perName</Reference>
  <Field>perName=getChar('Name')</Field>
  <Field>perVorn=getChar('First name')</Field>
  <Field>perAOrt=getChar('City')</Field>
  <Field>Quelle=file_woext(sourceFileName()</Field>
  <Field>perGes=iif(getChar('First name')== 'Max','M','W')</Field>
  <Field>perSuch=getChar('First name')+getChar('Name')</Field>
</ImportSection>
```

The mapped functions use different data and generate new information. 
The source is formed from the file name without file extension ("2013May.csv"
becomes "2013May"). In addition, a case distinction based on the first name
is carried out by "iif". In the case of "Max" the "perGes" field (for gender)
gets the value "M", otherwise "W". In addition, the source fields first name
and name are combined to a value and written in the field "perSuch".

Note: When performing arithmetic operations, note that the source values must
first be declared as numerical values ("casting"). You can do this, for example,
with the functions "cint" or "cfloat". For other types as well, an adaptation may
be necessary (for example for the conversion of numbers into text).

### Repeat fields and repeating field groups

In the field configuration, you can define that a field should be stored multiple
times within a dataset (for example, hobby or e-mail address). These so-called 
"repeating fields" can also be grouped together (for example, the bank details 
with account, bank code, IBAN, \ ...). You can therefore import the corresponding 
data from the source via the import function into the database.

The csv file shown above shows the hobbies and a number of hobbies that together
form a repeating field group and must be configured accordingly. The number and 
name of the hobbies should now be imported into the sentence type of the person 
as a repeating field group. To do this, add the following information to the 
"ImportSection":

``` 
<RepGroup>
  <Field>HobNr  = getChar('HobbyNr')</Field>
  <Field>HobBez = getChar('Hobbies')</Field>
</RepGroup>
```

This defines the first indication of the number and the hobbies as a group; 
then the second information, etc. In the case of a single repeating field withou
further grouping, write the individual field into the repeating field group.

``` 
<RepGroup>
  <Field>HobBez = getChar('Hobbies')</Field>
</RepGroup>
```

This means that you can also include several repeat fields and repeating field groups in one dataset.

**Note:**

A group of fields can be updated if there is a reference to a leading field and
the group that is no longer in the source can be deleted.

For this purpose, an extension of the above example is necessary

```xml
<RepGroup reference="1">
  <Field deltaliste="d">HobNr  = getChar('HobbyNr')</Field>
  <Field>HobBez = getChar('Hobbies')</Field>
</RepGroup>
```

The "reference" attribute activates the referencing of the group. The first
field is always the reference field to update the group.

The "deltaliste" attribute specifies that the entry must be in the database! 
So all information from the source is imported and the entries are removed 
from the database that are not in the source.

**Attention!** - The combination of all attributes can potentially result
in thoughtless changes. A previous test is therefore recommended.

### Complete example of the csv import configuration shown above

If the examples shown so far are combined as a configuration file,
the xml file is as follows:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29001</LoginPort>
    <LoginUser>admin</LoginUser>
    <LoginPW>adm#13qzy2!</LoginPW>
    <ImportModus>nu</ImportMode>
  </Global>
  <ReaderModul typ="csv">
    <FileName>/Data/import/2013Mai.csv</FileName>
    <FieldSeparator>;</FieldSeparator>
    <FieldDelimiter>"</FieldDelimiter>
    <RepSeparator>,</RepSeparator>
    <ColumnMode>HEADER</ColumnMode>
    <Charset>UTF-8</Charset>
  </ReaderModul>
  <ImportSection datasettype="PERS">
    <Reference>perName</Reference>
    <Field>perName=getChar('Name')</Field>
    <Field>perFirstname=getChar('FirstName')</Field>
    <Field>perCity=getChar('Ort')</Field>
    <Field>Source=file_woext(sourceFileName()</Field>
    <Field>perGes=iif(getChar('FirstName')== 'Max','M','W')</Field>
    <Field>perSearcg= getChar('FirstName')+getChar('Name')</Field>
    <RepGroup reference='1'>
      <Field>HobNr  = getChar('HobbyNr')</Field>
      <Field>HobBez = getChar('Hobbies')</Field>
    </RepGroup>
  </ImportSection>
</CtxImport>
```
Import of xml files
----------------------

With the help of the manual import configuration of the ImPlex an import
of xml-files is possible. Due to the different complexity of this type of 
source files, a guided configuration via plugin has not yet been implemented.

Xml files are a standardized format whose content is mapped as a text-based, 
hierarchical structure. The content consists of so-called "elements", 
"element attributes" and "element contents", which in turn can contain 
further elements and attributes.

Example of a simple xml file:

```xml
<?xml version="1.0" ?>
<Elementname Attribute1=“1“ Attribute2=“abc“>
  <Element>Element-Contents</Element>
</Elementname>
```

Based on the example in the manual csv import section, an xml file with the same contents can be used as a source:

```xml
<?xml version="1.0" ?>
<People>
    <Person Nr=“1“ Gender=“M“ GebDat=“19670812“>
        <Name>Meier</Name>
        <FirstName>Max</FirstName>
        <Hobbies>
            <Hobby HobbyNr=“1“>Football</Hobby>
            <Hobby HobbyNr=“2“>Hockey</Hobby>
        </Hobbies>
    </Person>
    <Person Nr=“2“ Gender=“W“ GebDat=“19781103“>
        <Name>Müller</Name>
        <FirstName>Sandra</FirstName>
        <Hobbies>
            <Hobby HobbyNr=“1“>Dancing</Hobby>
            <Hobby HobbyNr=“2“>Horse riding</Hobby>
        </Hobbies>
    </Person>
</People>
```

Each content of an element and each value of an attribute can be used 
by the Import function of the ImPlex. There is a syntax for querying 
these values.

In general, the basic structure of the configuration file with the  
"Global", "ReaderModul" and "ImportSection" areas also applies here. 
The database and login parameters will be set with the global
scope; the "ReaderModul" area defines the reading parameters and the
"ImportSection" the field assignment.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>[....]</LoginIP>
    <LoginPort>[....]</LoginPort>
    <LoginUser>[....]</LoginUser>
    <LoginPW>[....]</LoginPW>
    <ImportMode>[....]</ImportMode>
  </Global>
```

The structure of the global area shown above may look like this, for example:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29000</LoginPort>
    <LoginUser>importuser</LoginUser>
    <LoginPW>myPassWd</LoginPW>
    <ImportMode>nu</ImportMode>
  </Global>
```

In the "ReaderModul" area, you specify the source file, the main entry element for
reading out the datasets and the element of a dataset.

```xml
<ReaderModul typ="xml">
    <IN_FILE>[....]</IN_FILE>
    <MAIN_TAG>[....]</MAIN_TAG>
    <DATASET_TAG>[....]</DATASET_TAG>
</ReaderModul>
```

Example based on the xml file above:

```xml
<ReaderModul typ="xml">
    <IN_FILE>/Path/to/Source/2013Mai.xml</IN_FILE>
    <MAIN_TAG>People</MAIN_TAG>
    <DATASET_TAG>Person</DATASET_TAG>
</ReaderModul>
```

All information within the "Person" element is therefore treated as a 
dataset. Note that the path to the source file is given as an absolute path.

Thus the structure of the configuration file to import for reading an xml data 
source is divided into the three areas mentioned:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
    <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29001</LoginPort>
    <LoginUser>importuser</LoginUser>
    <LoginPW>myPasswd</LoginPW>
    <ImportMode>nu</ImportMode>
</Global>
<ReaderModul typ="xml">
    <IN_FILE>/Path/to/Source/2013Mai.xml</IN_FILE>
    <MAIN_TAG>People</MAIN_TAG>
    <DATASET_TAG>Person</DATASET_TAG>
</ReaderModul>
<ImportSection datasettype="[....]">
    <FilterFunction>[....]</FilterFunction>
    <Reference>[....]</Reference>
    <Field>[....] = [....]</Field>
    <RepGroup start="[....]">
        <Field>[....] = [....]</Field>
    </RepGroup>
</ImportSection>
</CtxImport>
```

In the "ImportSection" you can now make the field assignments. To do this
you access individual elements and attribute values via a defined syntax.

### Syntax for accessing contents of an xml file

Starting from the definition in the "ReaderModule", the import mechanism 
goes through the xml source file and identifies a dataset.

The configuration of the reader module shown above with the entries "MAIN\_TAG" 
and "DATASET\_TAG" defines the entry point in a dataset. "People" is here 
regarded as enclosing element for further contents and "person" as individual 
datasets, by which is integrated.

```xml
<?xml version="1.0" ?>
<People>
    <Person Nr=“1“ Gender=“M“ BirthD=“19670812“>
        <Name>Meier</Name>
        <FirstName>Max</FirstName>
        <Hobbies>
            <Hobby HobbyNr=“1“>Football</Hobby>
            <Hobby HobbyNr=“2“>Hockey</Hobby>
        </Hobbies>
    </Person>
    <Person Nr=“2“ Gender=“W“ BirthD=“19781103“>
        <Name>Müller</Name>
        <FirstName>Sandra</FirstName>
        <Hobbies>
            <Hobby HobbyNr=“1“>Dancing</Hobby>
            <Hobby HobbyNr=“2“>Horse riding</Hobby>
        </Hobbies>
    </Person>
</People>
```

To access specific information for each dataset, a field is accessed by *"getChar"*
as with csv sources. The following example shows the transfer of the "Name" field to the
corresponding database field.

```xml
<ImportSection datasettype="PERS">
    <Field>PerNam = getChar('Name')</Field>
</ImportSection>
</CtxImport>
```

The simple use of the field name leads to the direct use of an element content.

To use attributes of an element, the "\ #" character (hash) is necessary. Thus,
for example, the person number, gender or date of birth can be taken over:

```xml
<ImportSection datasettype="PERS">
    <Field>PerNam = getChar('Name')</Field>
    <Field>PerGen = getChar('#Gender')</Field>
    <Field>PerNum = getChar('#Nr')</Field>
    <Field>PerBirth = getChar('#BirthD')</Field>
</ImportSection>
</CtxImport>
```

If an element is used multiple times (for example, "Hobby"), this must be imported
within a repeating group. The combination with other fields of the same group is 
possible accordingly:

```xml
<ImportSection datasettype="PERS">
    <Field>PerNam = getChar('Name')</Field>
    <Field>PerGen = getChar('#Gender')</Field>
    <Field>PerNum = getChar('#Nr')</Field>
    <Field>PerBirth = getChar('#BirthDate')</Field>
    <RepGroup start="Hobbies.Hobby">
        <Field>HobNr = getChar('#HobbyNr')</Field>
        <Field>Hobby = getChar()</Field>
    </RepGroup>
</ImportSection>
</CtxImport>
```

As can be seen in this example, the "hobby" element is integrated and a single "hobby"
is used. To access a child element, the character "." (Point) is used. Every single child
element is thus read and imported.

In addition, the "Hobby" field is read out directly. For this the "*getChar()*" function
is used without further parameters.

**Note:** Regardless of the above examples, it is possible to combine the of use "\ #" and 
"." , if deeper-nested structures are present. An access via "Hobbies.Hobby \ #HobbyNr" 
would be possible.

Import from a CortexDB
-------------------------

Within your database, you can change the contents of datasets as well
as the complete data model with the help of this import function. The data
source and destination are thus the same database. In general, the source is
made up of a list definition and the datasets of a selection or a dataset type. 
The datasets are then prepared based on the list configuration. This also allows
you to use calculated list contents for changing the datasets.

Because a list definition is used as the basis for this import function,
the global settings and the "ImportSection" are identical to the csv import. 
Only the area for the settings of the "ReaderModul" must be adjusted accordingly. 
The "ReaderModule" must be assigned the "ctx" type. This configuration block
then contains the entries for the list definitions ("ListDef") and the dataset
type or selection.

If you want to change all the datasets of a dataset type, specify the dataset type setting:

```xml
<ReaderModul type="ctx">
  <ListDef>[.......]</ListDef>
  <Datasettype>[....]</Datasettype>
</ReaderModul>
```

If only the datasets of a previously saved selection are to be changed, the specification 
for the selection name must be set:

```xml
<ReaderModul typ="ctx">
  <ListDef>[.......]</ListDef>
  <Selection>[....]</Selection>
</ReaderModul>
```

Note that you can update the datasets based on the dataset ID. This eliminates
the need to specify a reference because a dataset is already found uniquely. 
The source field for the ID is therefore specified in the configuration as
 "*\ # IId*".

The following example shows the update of all datasets of a dataset type based on
the dataset ID and a created list:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29001</LoginPort>
    <LoginUser>admin</LoginUser>
    <LoginPW>adm#13qzy2!</LoginPW>
    <ImportMode>u</ImportMode>
  </Global>
  <ReaderModul type="ctx">
    <ListDef>Personslist</ListDef>
    <Datasettype>PERS</Datasettype>
  </ReaderModul>
  <ImportSection datasettype="PERS">
    <Reference></Reference>
    <IId>getChar('#IId')</IId>
    <Field>perName=getChar('Name')</Field>
    <Field>perVorn=getChar('FirstName')</Field>
    <Field>perAOrt=getChar('City')</Field>
    <Field>perSuch=getChar('FirstName')+getChar('Name')</Field>
  </ImportSection>
</CtxImport>
```


!!! note "Notes"
    Note that in this example in the "ImportSection" the reference remains empty because the following specification is automatically treated as a reference:

```xml
<IId>getChar('#IId')</IId>
```

Alternatively, you can also display the system field "Dataset ID" in
the list definition and enter it in the mentioned IId node:

```xml
<IId>getChar('Datensatz-ID')</IId>
```

It should be noted here that the second option may be processed faster
than the first one mentioned.
 

Note also that the used list is processed sequentially per dataset. 
The use of calculated fields is therefore only conditionally possible. 
Cross-list calculations can therefore not be used.

### Repeating fields

Repeating fields can be written and modified from the Implex version 2.0.10.
To determine the version used, use the following Implex call:

```xml
java -jar Implex.jar --version
```

The general form for importing a repeating field from a list definition consists
of the "repeating group" node with a start attribute and then contains a field
specification:

```xml
<RepGroup start="___WDHL___">
    <Field deltalist="d">Synonym=getChar('sourceField')</Field>
</RepGroup>
```

Please note that the start attribute contains the value "\_\_\_WDHL\_\_\_" 
(three underscores before and after WDHL). This determines that the content of the node 
is treated as a repeating field.

In addition, you can specify the deltalist = "d" attribute for the field. 
Thus, when updating the dataset, only the field contents that are supplied as 
data remain. The content that is not in the source will be removed.


!!! note "Notes"
    Note that the effects of each parameter on repeating field groups can have unexpected effects. Upgrading groups is therefore not recommended.

It should also be noted that the source field (ie: getChar ('sourceField') \ ...)
must be a "real" database returnee. The content of this field can be overwritten by
JavaScript; relevant here is the type of the field, so that the ImPlex can determine
that a repeating field is read. An object set by JavaScript is not sufficient at this point.

Referencing per Linker 
---------------------------

As described in the section for manual linker execution, it is possible within the database
for relations between datasets to be established via so-called "reference fields"
to depict one another. The execution with the help of the plugin allows this at any time. 
Via a configuration file, the Java application ImPlex can also be called up via system services
in order to generate the references regularly and automatically.

The configuration file for the linker, like the import configurations, is an xml file. This 
consists of the two basic sections "Global" for the login parameters and "Linker" for the actual configuration.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>_IP-Address_</LoginIP>
    <LoginPort>_DB-Port_</LoginPort>
    <LoginUser>_UserAccount_</LoginUser>
    <LoginPW>_Password_</LoginPW>
    <ImportMode>u</ImportMode>
  </Global>

  <Linker>
    <Link>...=...</Link>
  </Linker>
</CtxImport>
```

In the section "Linker" the assignment of the corresponding field is made. 
Here you define which field in a dataset (to the left of the equal sign)
should be referenced to a target. It should be noted here that a target field 
is specified, but a valid link points to a complete dataset. If the target
field is therefore used in several dataset types, corresponding fields or 
additional parameters must be set (see examples below).

Example with login and simple destination field assignment:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29000</LoginPort>
    <LoginUser>importusr</LoginUser>
    <LoginPW>importpwd</LoginPW>
    <ImportMode>u</ImportMode>
  </Global>
  <Linker>
    <Link>lPerFir=FirNam</Link>
  </Linker>
</CtxImport>
```

In the example shown here, the content of the field with the synonym "lPerFir"
is searched for in the field "FirNam". If exactly one dataset is found, 
the reference resolution occurs.

### Optional source fields 

If another field was filled during data import and the actual reference field left blank,
the filled field can be used as an optional source field. The content of this field
so it is searched and the final link is written in the reference field. The content in
the optional source field is retained.

```xml
<Linker>
  <Link optSource="myFirN">lPerFir=FirNam</Link>
</Linker>
```

### Optional source and destination dataset types

If the same fields are used in different dataset types, unique links may not be unique 
to the linker. To ensure this, the specification of source and destination dataset types
is appropriate. These are specified as an attribute:

```xml
<Linker>
  <Link souurceType="Pers" destinationType="Firm">lPerFir=FirNam</Link>
</Linker>
```

The combination with optional source fields is here
of course possible:

```xml
<Linker>
  <Link sourceType="Pers" destinationType="Firm" optSource="myFirN">lPerFir=FirNam</Link>
</Linker>
```

### More details for the destination search

To find a unique target dataset, multiple fields can be specified. The linker 
then finds the content of the unresolved reference field (or optional source field)
 within the database and resolves the reference if the combination of fields returns 
 a unique dataset.

For example, the source field could have multiple contents (separated by commas):

``` 
Argus Publishing, 30916, Hannover
```

Within the database, the linker now has to search for the contents of the company name,
zip code, and location in the appropriate fields to uniquely find a dataset. To further
restrict it further, the source and destination types are specified.

```xml
<Linker>
  <Link sourceType="Pers" destinationType="Firm" optSource="myFirN">lPerFir=FirNam,FirPostCode,FirCity</Link>
</Linker>
```

Please note that this type of configuration naturally leads to a longer search,
since several fields have to be checked. Therefore, in large volumes of data, it may
be significantly faster to capture a unique value in an optional source field that was
stored within a field as a unique reference in the destination dataset.

### Supplementary filter parameters 

In addition to the configurations shown above, it is possible to specify further filter 
parameters. These are simply listed after the search fields:

```xml
<Linker>
  <Link sourceType="Pers" destinationType="Firm" optSource="myFirN">lPerFir=FirNam,FirPostCode,FirCity,FirActv=yes</Link>
</Linker>
```

In the example shown here, therefore, the link would only be set (resolved) if the following criteria apply:

- The link field is used in dataset type "Pers"
- The reference should refer to the dataset type "Firm"
- there is an optional source field "myFirN"
- The optional source field has the content for company name, postal code and city in exactly the same order, separated by commas
- the target datasets have in the field with the synonym "FirActv"
     the entry "yes"

Only if these criteria are completely correct will the reference be set.