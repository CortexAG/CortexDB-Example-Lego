Manuelle Importkonfiguration
============================

Über die manuelle Bearbeitung der Import-Konfigurationen ist die Nutzung
weitreichender Funktionen und Einstellungen möglich. Die Konfiguration
erfolgt über xml-Dateien, die vom ImPlex gelesen und verarbeitet werden.
Der Aufruf erfolgt hierbei über die Aufrufparameter des
ImPlex.

Hierbei gilt, dass für jede Quelle (csv-, xml-Datei, Cortex-Zugriff oder
andere) eine separate Import-Konfigurationsdatei zu erstellen ist.

Weiterhin können innerhalb einer Konfiguration mehrere Datensatztypen
als Ziel definiert werden, so dass aus einer Quelle mehrere Datensätze
entstehen können.

!!! warning "Änderungen des Implex ab Version 4.0"
    Mit der Version 4.0 ändern sich die Bezeichner für die Parameter in den Import-Konfigurationen. Ab dieser Version ist eine Konfiguration und der Aufruf nur mit englischen Bezeichnern möglich. Alte Konfigurationen müssen daher zwingend angepasst werden!

Aufrufparameter Implex.jar
--------------------------

Bei dem Importprogramm ImPlex handelt es sich um eine konsolen-basierte
Java-Anwendung. Diese kann sowohl manuell, als auch über zeitgesteuerte
Systemdienste aufgerufen werden. Hierfür stehen nachfolgende
Aufrufparameter zur Verfügung.

Unter Windows-Systemen ist zu beachten, dass innerhalb der
Umgebungsvariablen die Einträge für das installierte Java angegeben sein
müssen.

Aufruf:

    java -jar Implex.jar [OPTIONEN] ... [DEFINITIONS_DATEI] ...

Optionen:

    -i, --import        Nachfolgende Importdefinitionsdateien (XML) verwenden.
    -l, --link          Link-Definition auflösen.
    -s, --simulate      Aktion simulieren. Es werden keine Schreibvorgänge
                        im Server ausgeführt.
    -v, --verbose       Alle Logmeldungen zusätzlich auf Konsole ausgeben.
    -h, --help          Diese Hilfe aufrufen

Die folgenden Schalter sollten nur von Experten eingesetzt werden:

    -e, --emulate       Schreibt bei einer Definition für den Modus Import,
                        die interne Repräsentation des ersten gelesenen 
                        Datensatzes in eine Datei an und beendet dann das Programm 
                        (nur zur Entwicklung von Reader Modulen).
    -d, --delay [ZAHL]  Anzahl Datensätze, nach den immer eine Logmeldung 
                        ausgegeben werden soll (Standard: 200)
    --server [IP:PORT]  Hier kann ein Datenbankserver angegeben werden 
                        (Bsp.: 127.0.0.1:29000)
    --source [DATEI]    Wenn das Lesemodul es zulässt, kann hier ein 
                        Quelldateiname angegeben werden 
                        (abhängig vom Lesemodul)
    --getinfo [DATEI]   Liefert gefolgt von einem JSON-Dateinamen eine 
                        Modulspezifische Information 
                        (Abhängig von Lesemodul)
    -- start [ZAHL]     Beginnt mit dem Import ab dem angegebenen Datensatz
    -- end [ZAHL]       Liest soviele Datensätze, wie angegeben

Es können beliebig viele Definitions-Dateien hintereinander angegeben
werden und es können in beliebiger Reihenfolge mehrere Optionen
angegeben werden.

!!! note "Hinweise"
    Der Parameter -s (Simulation) wirkt sich global auf alle im Aufruf übergebenen Modi aus!

Die Parameter `--start` und `--end` funktionieren nur für csv- und
xml-Importe.

### Java Aufrufparameter

Erfolgt der Aufruf manuell oder über ein Script, kann es notwendig sein,
landesspezifische Parameter an Java zu übergeben, damit bspw. Zahlen und
Währungen korrekt importiert werden.

Der Java-Aufruf wird dann um folgende Angaben erweitert:

    -Duser.country=DE -Duser.language=de

Vollständig umfasst der Aufruf dann die Jar-Datei des Implex und weitere
Parameter. Beispielsweise können so auch die Import- und Quelldatei
übergeben werden:

    java -jar -Duser.country=DE -Duser.language=de Implex.jar -i --server localhost:29000 --source www/Implex/sourceFile.xml ./www/implex/Import-Config.xml

Das Beispiel zeigt den Aufruf der Implex.jar mit zusätzlichen,
landesspezfischen Java-Parametern und den Implex-Parametern für die
Quell- und Import-Konfigurationsdatei.

Allgemeine Definitionen
-----------------------

Die Struktur einer Import-Konfiguration gliedert sich grundsätzlich in
drei Hauptbereiche über die verschiedene Einstellungen möglich sind.
Innerhalb dieser xml-Datei sind in den Bereichen "Global",
"ReaderModul" und "ImportSection" die entsprechenden Anpassungen
vorzunehmen.

Der Bereich "Global" definiert den Zugriff auf die Datenbank, das
"ReaderModul" den Zugriff auf die Quelldaten und die "ImportSection"
definiert die Feldzuweisung von Quell- zu Zielfeldern.

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

In dem Bereich "Global" konfigurieren Sie die Zugangsdaten zu Ihrer
Datenbank und geben dort den gewünschten "ImportModus" an. Hier wählen
Sie zwischen "n" (neu), "u" (update) oder "nu" bzw. "un" (für
"update, sonst neu").

Entsprechend der genannten Möglichkeiten kann der Bereich "Global"
beispielhaft konfiguriert werden:

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

Die Bereiche "ReaderModul" und "ImportSection" sind von der jeweiligen
Datenquelle abhängig.

**Hinweis:**

Aus einer Datenquelle können mehrere Datensätze unterschiedlicher
Datensatztypen erstellt werden (z.B. aus einer Person ein Personen- und
ein Adressdatensatz). Dafür braucht nur die "ImportSection" mehrfach
angelegt werden.

Allg. Definition ab Implex 4.0
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

Import von csv-Dateien
----------------------

Die manuelle Konfiguration für den Import von csv-Dateien besteht aus
einer xml-Konfigurationsdatei für das Importprogramm "ImPlex". Diese
Datei ist in mehrere Abschnitte unterteilt, um den Login zur Datenbank,
das Lesen der Quellen ("Reader-Modul") und das Mapping zwischen Quelle
und Ziel sicherzustellen. Der Aufbau dieser Konfigurationsdatei ist
grundsätzlich für jeden Import gleich und unterscheidet sich
dementsprechend nur in den jeweiligen Parametern für Quellen,
Reader-Modul und Ziel-Mapping.

Wie bereits im Abschnitt für das
ImPlex-Plugin erläutert, bestehen
csv-Dateien aus Einzelwerten, die durch ein einheitliches Trennzeichen
voneinander getrennt sind. Zudem werden die Einzelwerte häufig durch
sog. "Feldbegrenzer" eingefasst.

Üblicherweise befinden sich in der ersten Zeile einer solchen Datei die
Spaltenüberschriften (Feldbezeichner). Ist dieses nicht der Fall, ist in
der Konfigurationsdatei im Abschnitt "ReaderModul" der Wert für den
"SpaltenModus" zu ändern. Hier stehen die Möglichkeiten "HEADER" (wenn
die erste Zeile die Bezeichner enthält), "NUMERISCH" oder "ABC" zur
Verfügung.

Beispiel einer csv-Datei (per Semikolon getrennte Werte):

    „Name“;“Vorname“;“Ort“;“HobbyNr“;“Hobbies“
    „Meier“;“Max“;“Hamburg“;“1,2“;“Fußball,Hockey“
    „Müller“;“Sandra“;“Bielefeld“;“1,2“;“Tanzen,Reiten“

Beispiel einer csv-Datei (per Tab getrennte Werte):

    „Name“    “Vorname“    “Ort“    “HobbyNr“    “Hobbies“
    „Meier“    “Max“    “Hamburg“    “1,2“    “Fußball,Hockey“
    „Müller“    “Sandra“    “Bielefeld“    “1,2“    “Tanzen,Reiten“

### Reader-Modul für csv-Dateien

Das Beispiel einer csv-Datei zeigt zwei zu importierende Datensätze mit
den jeweiligen Feldbezeichnern in der ersten Zeile. Der nachfolgende
Abschnitt für den Bereich "ReaderModul" zeigt daher die dazu passenden
Konfigurationseinstellungen (für Semikolon-getrennte Werte):

```xml
<ReaderModul typ="csv">
    <Dateiname>/Data/import/2013Mai.csv</Dateiname>
    <FeldTrenner>;</FeldTrenner>
    <FeldBegrenzer>"</FeldBegrenzer>
    <WdhlTrenner>,</WdhlTrenner>
    <SpaltenModus>HEADER</SpaltenModus>
    <Charset>UTF-8</Charset>
</ReaderModul>
```

Beachten Sie, dass die Angabe des Dateinamens den absoluten Pfad zu der
Datei beinhalten muss.

Weiterhin ist darauf zu achten, dass Sie den richtigen Zeichensatz
("Charset") der Importdatei angeben. Ansonsten werden Umlaute nicht
korrekt importiert. Hierfür stehen Ihnen drei Einstellungen zur Auswahl:
UTF-8, windows-1251 und ISO-8859-1.

Werden für die Trennung der Werte anstatt Semikolons andere Zeichen
verwendet, sind diese bei der Angabe `FeldTrenner` einzutragen. Der
Spezialfall von Tabulatoren (Tab-Zeichen) erfordert die Nutzung des
Ausdrucks **.

Beispiel Konfigurationsblock für Tab-getrennte Werte:

```xml
<ReaderModul typ="csv">
    <Dateiname>/Data/import/2013Mai.csv</Dateiname>
    <FeldTrenner></FeldTrenner>
    <FeldBegrenzer>"</FeldBegrenzer>
    <WdhlTrenner>,</WdhlTrenner>
    <SpaltenModus>HEADER</SpaltenModus>
    <Charset>UTF-8</Charset>
</ReaderModul>
```

Werden die bisher gezeigten Beispiele als Konfigurationsdatei
zusammengefügt, stellt sich die xml-Datei wie folgt dar:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29001</LoginPort>
    <LoginUser>admin</LoginUser>
    <LoginPW>adm#13qzy2!</LoginPW>
    <ImportModus>nu</ImportModus>
</Global>
<ReaderModul typ="csv">
    <Dateiname>/Data/import/2013Mai.csv</Dateiname>
    <FeldTrenner>;</FeldTrenner>
    <FeldBegrenzer>"</FeldBegrenzer>
    <WdhlTrenner>,</WdhlTrenner>
    <SpaltenModus>HEADER</SpaltenModus>
    <Charset>UTF-8</Charset>
</ReaderModul>
<ImportSection datensatztyp="[.......]">
    [.......]
</ImportSection>
</CtxImport>
```


### Import-Sektion für csv-Dateien

Innerhalb der "ImportSection" legen Sie die Feldzuweisungen und
Referenzen für den Import fest. Hier können Sie zudem Feldinhalte als
Verlaufsinformation speichern und weitergehende Funktionen nutzen (z.B.
Fallunterscheidungen anhand bestimmter Inhalte oder die Änderung von
Inhalten definieren).

Zu dem oben aufgeführten csv-Beispiel kann die nachfolgende
Import-Section dienen, wenn Datenbankfelder mit den Synonymen
"perName", "perVorn" und "perAOrt" vorhanden sind:

```xml
<ImportSection datensatztyp="PERS">
    <Referenz>perName</Referenz>
    <Feld>perName=getChar('Name')</Feld>
    <Feld>perVorn=getChar('Vorname')</Feld>
    <Feld>perAOrt=getChar('Ort')</Feld>
</ImportSection>
```

Als Parameter für die "ImportSection" wird das Kürzel des Datensatztyps
festgelegt (in dem gezeigten Beispiel "PERS"). Die nachfolgenden
Feldzuweisungen beziehen sich damit auf diese Satzart. Ggf. werden neue
Datensätze angelegt, wenn anhand der Referenz kein Datensatz für eine
Aktualisierung gefunden werden kann und der "ImportModus" auf "nu"
oder "n" gesetzt wurde.

Wenn Sie vorhandene Datensätze aktualisieren möchten, ist es notwendig,
dass Sie ein Referenzfeld angeben. Dieses legen Sie über den Eintrag
"Referenz" fest.

Alle weiteren Quellfelder weisen Sie dann einem Ziel zu, indem Sie für
jede Zuweisung einen Eintrag "Feld" erstellen. Die Zuweisung besteht
dann immer aus Ziel = Quelle.

Beispiel:

```xml
<Feld>perName=getChar('Name')</Feld>
```

Bei diesem Beispiel wird dem Zielfeld "perName" der Wert aus dem Feld
"Name" zugewiesen. Beachten Sie, dass die Quellefelder in jedem Fall
mit der Funktion "getChar" umschlossen werden.


### Nutzung von Funktionen

Für die Konfiguration stehen Ihnen mehrere Funktionen zur Verfügung mit
deren Hilfe Sie die Inhalte beliebig ändern können. Eine komplette
Übersicht erhalten Sie im Abschnitt
"Importfunktionen". Das folgende
Beispiel zeigt daher nur eine Auswahl der Möglichkeiten.

``` 
<ImportSection datensatztyp="PERS">
  <Referenz>perName</Referenz>
  <Feld>perName=getChar('Name')</Feld>
  <Feld>perVorn=getChar('Vorname')</Feld>
  <Feld>perAOrt=getChar('Ort')</Feld>
  <Feld>Quelle=file_woext(sourceFileName()</Feld>
  <Feld>perGes=iif(getChar('Vorname')== 'Max','M','W')</Feld>
  <Feld>perSuch=getChar('Vorname')+getChar('Name')</Feld>
</ImportSection>
```

Die abgebildeten Funktionen greifen auf verschiedene Daten zurück und
erzeugen neue Informationen. Die Quelle wird so aus dem Dateinamen ohne
Dateiendung gebildet (aus "2013Mai.csv" wird so "2013Mai"). Ergänzend
dazu wird per "iif" eine Fallunterscheidung anhand des Vornamens
durchgeführt. Im Falle von "Max" erhält das Feld "perGes" (für
Geschlecht) den Wert "M", ansonsten "W". Ergänzend dazu werden die
Quellefelder Vorname und Name zu einem Wert zusammengefügt und in das
Feld "perSuch" geschrieben.

Hinweis: Beachten Sie bei Rechenoperationen, dass die Quellwerte zuvor
als numerische Werte deklariert werden müssen ("casting"). Dieses
führen Sie beispielsweise mit den Funktionen "cint" oder "cfloat"
durch. Auch für weitere Typen ist ggf. eine Anpassung durchzuführen
(z.B. für die Umwandlung von Zahlen in Text).

### Wiederholfelder und Wiederholfeldgruppen

In der Feldkonfiguration können Sie definieren, dass ein Feld mehrfach
innerhalb eines Datensatzes gespeichert werden soll (z.B. Hobby oder
eMail-Adresse). Diese sog. "Wiederholfelder" können zudem als eine
Gruppe zusammengefasst werden (z.B. die Bankverbindung mit Konto, BLZ,
IBAN,\...). Die entsprechenden Daten können Sie daher auch über die
Import-Funktion in die Datenbank aus einer Quelle einlesen.

In der oben gezeigten csv-Datei sind die Hobbies und eine Nummer der
Hobbies ersichtlich, die zusammen eine Wiederholfeldgruppe bilden und
entsprechend konfiguriert werden müssen. Die Nummer und die Bezeichnung
der Hobbies sollen nun als Wiederholfeldgruppe in die Satzart der Person
importiert werden. Dafür ergänzen Sie die "ImportSection" um folgende
Angaben:

``` 
<WiederholGruppe>
  <Feld>HobNr  = getChar('HobbyNr')</Feld>
  <Feld>HobBez = getChar('Hobbies')</Feld>
</WiederholGruppe>
```

Damit werden jeweils die erste Angabe der Nummer und des Hobbies als
eine Gruppe definiert; dann je die zweiten Angaben usw. Im Falle eines
einzelnen Wiederholfeldes ohne weitere Gruppierung schreiben Sie das
einzelne Feld in die Wiederholfeldgruppe.

``` 
<WiederholGruppe>
  <Feld>HobBez = getChar('Hobbies')</Feld>
</WiederholGruppe>
```

Somit können Sie auch mehrere Wiederholfelder und Wiederholfeldgruppen
in einem Datensatz aufnehmen.

**Hinweis:**

Eine Gruppe von Feldern kann aktualisiert werden, wenn eine Referenz auf
ein führendes Feld vorliegt und es kann die Gruppe gelöscht werden, die
nicht mehr in der Quelle vorhanden ist.

Hierfür ist eine Erweiterung des oben genannten Beispiels notwendig

```xml
<WiederholGruppe referenz="1">
  <Feld deltaliste="d">HobNr  = getChar('HobbyNr')</Feld>
  <Feld>HobBez = getChar('Hobbies')</Feld>
</WiederholGruppe>
```

Das Attribut "referenz" aktiviert die Referenzierung der Gruppe.
Hierbei gilt immer das erste Feld als Referenzfeld, um die Gruppe zu
aktualisieren.

Das Attribut "deltaliste" legt fest, dass der Eintrag in der Datenbank
vorhanden sein muss! Es werden also alle Informationen aus der Quelle
importiert und die Einträge aus der Datenbank entfernt, die nicht in der
Quelle vorhanden sind.

**Vorsicht!** - Die Kombination aller
Attribute kann möglicherweise unbedachte Änderungen nach sich ziehen.
Ein vorheriger Test ist daher empfehlenswert.

### Vollständiges Beispiel der oben gezeigten Konfiguration für den csv-Import

Werden die bisher gezeigten Beispiele als Konfigurationsdatei
zusammengefügt, stellt sich die xml-Datei wie folgt dar:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29001</LoginPort>
    <LoginUser>admin</LoginUser>
    <LoginPW>adm#13qzy2!</LoginPW>
    <ImportModus>nu</ImportModus>
  </Global>
  <ReaderModul typ="csv">
    <Dateiname>/Data/import/2013Mai.csv</Dateiname>
    <FeldTrenner>;</FeldTrenner>
    <FeldBegrenzer>"</FeldBegrenzer>
    <WdhlTrenner>,</WdhlTrenner>
    <SpaltenModus>HEADER</SpaltenModus>
    <Charset>UTF-8</Charset>
  </ReaderModul>
  <ImportSection datensatztyp="PERS">
    <Referenz>perName</Referenz>
    <Feld>perName=getChar('Name')</Feld>
    <Feld>perVorn=getChar('Vorname')</Feld>
    <Feld>perAOrt=getChar('Ort')</Feld>
    <Feld>Quelle=file_woext(sourceFileName()</Feld>
    <Feld>perGes=iif(getChar('Vorname')== 'Max','M','W')</Feld>
    <Feld>perSuch= getChar('Vorname')+getChar('Name')</Feld>
    <WiederholGruppe referenz='1'>
      <Feld>HobNr  = getChar('HobbyNr')</Feld>
      <Feld>HobBez = getChar('Hobbies')</Feld>
    </WiederholGruppe>
  </ImportSection>
</CtxImport>
```
Import von xml-Dateien
----------------------

Mit Hilfe der manuellen Importkonfiguration des ImPlex ist ein Import
von xml-Dateien möglich. Durch die unterschiedliche Komplexität dieser
Art von Quelldateien wurde eine geführte Konfiguration per Plugin bisher
nicht umgesetzt.

Bei xml-Dateien handelt es sich um ein standardisiertes Format, deren
Inhalt in Form einer textbasierten, hierarchischen Struktur abgebildet
wird. Der Inhalt besteht aus sog. "Elementen", "Element-Attributen"
und "Element-Inhalten", die wiederum weitere Elemente und Attribute
beinhalten können.

Beispiel einer einfachen xml-Datei:

```xml
<?xml version="1.0" ?>
<Elementname Attribut1=“1“ Attribut2=“abc“>
  <Element>Element-Inhalt</Element>
</Elementname>
```

Ausgehend von dem Beispiel im Abschnitt "manueller csv-Import" kann eine xml-Datei mit den gleichen Inhalten als Quelle genutzt werden:

```xml
<?xml version="1.0" ?>
<People>
    <Person Nr=“1“ Geschlecht=“M“ GebDat=“19670812“>
        <Name>Meier</Name>
        <Vorname>Max</Vorname>
        <Hobbies>
            <Hobby HobbyNr=“1“>Fußball</Hobby>
            <Hobby HobbyNr=“2“>Hockey</Hobby>
        </Hobbies>
    </Person>
    <Person Nr=“2“ Geschlecht=“W“ GebDat=“19781103“>
        <Name>Müller</Name>
        <Vorname>Sandra</Vorname>
        <Hobbies>
            <Hobby HobbyNr=“1“>Tanzen</Hobby>
            <Hobby HobbyNr=“2“>Reiten</Hobby>
        </Hobbies>
    </Person>
</People>
```

Jeder Inhalt eines Elementes und jeder Wert eines Attributes kann von
der Import-Funktion des ImPlex genutzt werden. Hierfür steht eine Syntax
zur Abfrage dieser Werte zur Verfügung.

Generell gilt auch hier der grundlegende Aufbau der Konfigurationsdatei
mit den Bereichen "Global", "ReaderModul" und "ImportSection". Mit
dem globalen Bereich werden die Datenbank und Login-Parameter
festgelegt; der Bereich "ReaderModul" definiert die Lese-Parameter und
die "ImportSection" die Feldzuweisung.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>[....]</LoginIP>
    <LoginPort>[....]</LoginPort>
    <LoginUser>[....]</LoginUser>
    <LoginPW>[....]</LoginPW>
    <ImportModus>[....]</ImportModus>
  </Global>
```

Der oben gezeigte Aufbau des globalen Bereiches kann beispielhaft wie
folgt aussehen:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29000</LoginPort>
    <LoginUser>importuser</LoginUser>
    <LoginPW>myPassWd</LoginPW>
    <ImportModus>nu</ImportModus>
  </Global>
```

In dem Bereich "ReaderModul" legen Sie die Quelldatei, das
Haupt-Einstiegselement zum Auslesen der Datensätze und das Element eines
Datensatzes fest.

```xml
<ReaderModul typ="xml">
    <IN_FILE>[....]</IN_FILE>
    <MAIN_TAG>[....]</MAIN_TAG>
    <DATASET_TAG>[....]</DATASET_TAG>
</ReaderModul>
```

Beispiel anhand der o.g. xml-Datei:

```xml
<ReaderModul typ="xml">
    <IN_FILE>/Pfad/zur/Quelle/2013Mai.xml</IN_FILE>
    <MAIN_TAG>People</MAIN_TAG>
    <DATASET_TAG>Person</DATASET_TAG>
</ReaderModul>
```

Alle Informationen innerhalb des "Person"-Elementes werden daher als
ein Datensatz behandelt. Beachten Sie hierbei, dass der Pfad zur
Quelldatei als absoluter Pfad angegeben wird.

Der Aufbau der Konfigurationsdatei für den Import zum Lesen einer
xml-Datenquelle gliedert sich somit in die drei genannten Bereiche:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
    <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29001</LoginPort>
    <LoginUser>importuser</LoginUser>
    <LoginPW>myPasswd</LoginPW>
    <ImportModus>nu</ImportModus>
</Global>
<ReaderModul typ="xml">
    <IN_FILE>/Pfad/zur/Quelle/2013Mai.xml</IN_FILE>
    <MAIN_TAG>People</MAIN_TAG>
    <DATASET_TAG>Person</DATASET_TAG>
</ReaderModul>
<ImportSection datensatztyp="[....]">
    <FilterFunktion>[....]</FilterFunktion>
    <Referenz>[....]</Referenz>
    <Feld>[....] = [....]</Feld>
    <WiederholGruppe start="[....]">
        <Feld>[....] = [....]</Feld>
    </WiederholGruppe>
</ImportSection>
</CtxImport>
```

In der "ImportSection" können Sie nun die Feldzuweisungen vornehmen.
Dazu greifen Sie auf einzelne Elemente und Attribut-Werte über eine
definierte Syntax zu.

### Syntax für den Zugriff auf Inhalte einer xml-Datei

Ausgehend von der Festlegung im "ReaderModul" durchläuft der
Import-Mechanismus die xml-Quelldatei und identifiziert einen Datensatz.

Die oben gezeigte Konfiguration des Reader-Moduls mit den Einträgen
"MAIN\_TAG" und "DATASET\_TAG" legt den Einsprungspunkt in einen
Datensatz fest. "People" gilt hier als umschließendes Element für
weitere Inhalte und "Person" als Einzeldatensätze, durch die interiert
wird.

```xml
<?xml version="1.0" ?>
<People>
    <Person Nr=“1“ Geschlecht=“M“ GebDat=“19670812“>
        <Name>Meier</Name>
        <Vorname>Max</Vorname>
        <Hobbies>
            <Hobby HobbyNr=“1“>Fußball</Hobby>
            <Hobby HobbyNr=“2“>Hockey</Hobby>
        </Hobbies>
    </Person>
    <Person Nr=“2“ Geschlecht=“W“ GebDat=“19781103“>
        <Name>Müller</Name>
        <Vorname>Sandra</Vorname>
        <Hobbies>
            <Hobby HobbyNr=“1“>Tanzen</Hobby>
            <Hobby HobbyNr=“2“>Reiten</Hobby>
        </Hobbies>
    </Person>
</People>
```

Um bei jedem Datensatz an eine bestimmte Information zu gelangen, wird
wie bei csv-Quellen per *"getChar"* auf ein Feld zugegriffen. Das
folgende Beispiel zeigt die Übernahme des Feldes "Name" in das
entsprechende Datenbankfeld.

```xml
<ImportSection datensatztyp="PERS">
    <Feld>PerNam = getChar('Name')</Feld>
</ImportSection>
</CtxImport>
```

Die einfache Nutzung des Feldnamens führt zur direkten Nutzung eines
Element-Inhaltes.

Um Attribute eines Elementes zu nutzen, ist das "\#"-Zeichen (Hash)
notwendig. Somit können also beispielsweise auch die Person-Nr, das
Geschlecht oder Geburtsdatum übernommen werden:

```xml
<ImportSection datensatztyp="PERS">
    <Feld>PerNam = getChar('Name')</Feld>
    <Feld>PerGes = getChar('#Geschlecht')</Feld>
    <Feld>PerNum = getChar('#Nr')</Feld>
    <Feld>PerGeb = getChar('#GebDat')</Feld>
</ImportSection>
</CtxImport>
```

Wird ein Element mehrfach genutzt (z.B. "Hobby"), ist dieses innerhalb
einer Wiederholgruppe zu importieren. Die Kombination mit weiteren
Feldern der selben Gruppe ist entsprechend möglich:

```xml
<ImportSection datensatztyp="PERS">
    <Feld>PerNam = getChar('Name')</Feld>
    <Feld>PerGes = getChar('#Geschlecht')</Feld>
    <Feld>PerNum = getChar('#Nr')</Feld>
    <Feld>PerGeb = getChar('#GebDat')</Feld>
    <WiederholGruppe start="Hobbies.Hobby">
        <Feld>HobNr = getChar('#HobbyNr')</Feld>
        <Feld>Hobby = getChar()</Feld>
    </WiederholGruppe>
</ImportSection>
</CtxImport>
```

Wie in diesem Beispiel zu sehen ist, wird innerhalb des Elements
"Hobby" interiert und auf ein einzelnes "Hobby" zurückgegriffen. Um
auf ein Kind-Element zuzugreifen, wird das Zeichen "." (Punkt)
genutzt. Jedes einzelne Kind-Element wird somit gelesen und importiert.

Ergänzend dazu wird das Feld "Hobby" direkt ausgelesen. Hierfür wird
die Funktion "*getChar()*" ohne weitere Parameter verwendet.

**Hinweis:** Unabhängig von den o.g.
Beispielen ist es möglich, die Nutzung von "\#" und "." zu
kombinieren, wenn tiefergeschachtelte Strukturen vorliegen. Ein Zugriff
per "Hobbies.Hobby\#HobbyNr" wäre also möglich.

Import aus einer CortexDB
-------------------------

Innerhalb Ihrer Datenbank können Sie Inhalte von Datensätzen und auch
das komplette Datenmodell mit Hilfe dieser Import-Funktion ändern. Bei
der Daten-Quelle und dem Ziel handelt es sich somit um dieselbe
Datenbank. Generell setzt sich dafür die Quelle aus einer
Listendefinitionen und den Datensätzen einer Selektion oder eines
Datensatztyps zusammen. Die Datensätze werden dann auf Basis der
Listenkonfiguration aufbereitet. Dadurch können Sie auch berechnete
Listeninhalte für die Änderung der Datensätze nutzen.

Dadurch, dass für diese Import-Funktion eine Listendefinition als
Grundlage herangezogen wird, sind die globalen Einstellungen und die
"ImportSection" identisch mit dem csv-Import. Nur der Bereich für die
Einstellungen des "ReaderModul" ist entsprechend anzupassen. Dem
"ReaderModul" ist der Typ "ctx" zuzuweisen. Dieser Konfigurationsblock
enthält dann die Angaben für die Listendefinitionen ("ListDef") und den
Datensatztypen oder Selektion.

Wenn alle Datensätze eines Datensatztyps geändert werden sollen, ist die
Angabe für den Datensatztyp zu setzen:

```xml
<ReaderModul typ="ctx">
  <ListDef>[.......]</ListDef>
  <Datensatztyp>[....]</Datensatztyp>
</ReaderModul>
```

Sollen nur die Datensätze einer zuvor gespeicherten Selektion geändert
werden, ist die Angabe für den Selektionsnamen zu setzen:

```xml
<ReaderModul typ="ctx">
  <ListDef>[.......]</ListDef>
  <Selektion>[....]</Selektion>
</ReaderModul>
```

Beachten Sie, dass eine Aktualisierung der Datensätze anhand der
Datensatz-ID durchgeführt werden kann. Damit entfällt die Angabe einer
Referenz, weil ein Datensatz bereits eindeutig gefunden wird. Das
Quellfeld für die ID wird daher in der Konfiguration als "*\#IId*"
angegeben.

Das nachfolgende Beispiel zeigt die Aktualisierung aller Datensätze
einer Satzart anhand der Datensatz-ID und einer erstellten Liste:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29001</LoginPort>
    <LoginUser>admin</LoginUser>
    <LoginPW>adm#13qzy2!</LoginPW>
    <ImportModus>u</ImportModus>
  </Global>
  <ReaderModul typ="ctx">
    <ListDef>Personenliste</ListDef>
    <Datensatztyp>PERS</Datensatztyp>
  </ReaderModul>
  <ImportSection datensatztyp="PERS">
    <Referenz></Referenz>
    <IId>getChar('#IId')</IId>
    <Feld>perName=getChar('Name')</Feld>
    <Feld>perVorn=getChar('Vorname')</Feld>
    <Feld>perAOrt=getChar('Ort')</Feld>
    <Feld>perSuch=getChar('Vorname')+getChar('Name')</Feld>
  </ImportSection>
</CtxImport>
```


!!! note "Hinweise"
    Beachten Sie, dass in diesem Beispiel in der "ImportSection" die Referenz leer bleibt, weil folgende Angabe automatisch als Referenz behandelt wird:

```xml
<IId>getChar('#IId')</IId>
```

Alternativ können Sie in der Listendefinition auch das Systemfeld
"Datensatz-ID" einblenden und dieses in dem genannten IId-Knoten
eintragen:

```xml
<IId>getChar('Datensatz-ID')</IId>
```

Hier ist zu beachten, dass die zweite Möglichkeit ggf. schneller
abgearbeitet wird, als die zuerst genannte.\
 

Beachten Sie ferner, dass die genutzte Liste sequentiell je Datensatz
abgearbeitet wird. Die Nutzung von berechneten Feldern ist also nur
bedingt möglich. Listen-übergreifende Berechnungen können daher nicht
genutzt werden.

### Wiederholfelder

Wiederholfelder können ab der Implex-Version 2.0.10 geschrieben und
geändert werden. Um die eingesetzte Version festzustellen verwenden Sie
folgenden Implex-Aufruf:

```xml
java -jar Implex.jar --version
```

Die allgemeine Form für den Import eines Wiederholfeldes aus einer
Listendefinition besteht aus dem Knoten "WiederholGruppe" mit einem
start-Attribut und beinhaltet dann eine Feld-Angabe:

```xml
<WiederholGruppe start="___WDHL___">
    <Feld deltaliste="d">Synonym=getChar('soureField')</Feld>
</WiederholGruppe>
```

Hier ist zu beachten, dass das start-Attribut den Wert
"\_\_\_WDHL\_\_\_" beinhaltet (drei Unterstriche vor und hinter WDHL).
Dadurch wird festgelegt, dass der Inhalt des Knotens als Wiederholfeld
zu behandelt ist.

Ergänzend dazu können Sie das Attribut deltaliste="d" für das Feld
angeben. Damit bleiben bei einer Aktualisierung des Datensatzes nur die
Feldinhalte bestehen, die als Daten geliefert werden. Die Inhalte, die
nicht in der Quelle vorliegen, werden entfernt.


!!! note "Hinweise"
    Beachten Sie hierbei, dass die Auswirkungen der einzelnen Parameter bei Wiederholfeld-Gruppen unerwartete Auswirkungen haben kann. Eine Aktualisierung von Gruppen wird daher nicht empfohlen.

Weiterhin ist zu beachten, dass das Quellfeld (also:
getChar('sourceField')\...) ein "echtes" Datenbank-Wiederhofeld sein
muss. Der Inhalt dieses Feldes kann per JavaScript überschrieben werden;
relevant ist hierbei der Typ des Feldes, damit der ImPlex feststellen
kann, dass ein Wiederholfeld gelesen wird. Ein per JavaScript gesetztes
Objekt reicht an dieser Stelle nicht aus.

Verweisauflösung per Linker 
---------------------------

Wie im Abschnitt für die manuelle
Linker-Ausführung beschrieben, ist
es innerhalb der Datenbank möglich, dass über sog. "Verweisfelder"
Relationen zwischen Datensätzen hergestellt werden, um Beziehungen
untereinander abzubilden. Die Ausführung mit Hilfe des Plugins
ermöglicht dieses zu jeder Zeit. Über eine Konfigurationsdatei kann die
Java-Applikation ImPlex auch über Systemdienste aufgerufen werden, um
die Verweise regelmäßig und automatisch herzustellen.

Bei der Konfigurationsdatei für den Linker handelt es sich wie bei den
Import-Konfigurationen um eine xml-Datei. Diese besteht aus den zwei
grundlegenden Abschnitten "Global" für die Login-Parameter und
"Linker" für die eigentliche Konfiguration.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>_IP-Adresse_</LoginIP>
    <LoginPort>_DB-Port_</LoginPort>
    <LoginUser>_Benutzerkonto_</LoginUser>
    <LoginPW>_Passwort_</LoginPW>
    <ImportModus>u</ImportModus>
  </Global>

  <Linker>
    <Link>...=...</Link>
  </Linker>
</CtxImport>
```

Im Abschnitt "Linker" wird die Zuweisung des entsprechenden Feldes
vorgenommen. Hier wird definiert, über welches Feld in einem Datensatz
(links vom Gleichheitszeichen) auf ein Ziel verwiesen werden soll. Zu
beachten ist hierbei, dass ein Zielfeld angegeben wird, ein gültiger
Link aber auf einen kompletten Datensatz zeigt. Wenn das Zielfeld also
in mehreren Datensatztypen verwendet wird, sind entsprechende Felder
oder zusätzliche Parameter zu setzen (siehe untenstehende Beispiele).

Beispiel mit Login und einfacher Zielfeld-Zuweisung:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29000</LoginPort>
    <LoginUser>importusr</LoginUser>
    <LoginPW>importpwd</LoginPW>
    <ImportModus>u</ImportModus>
  </Global>
  <Linker>
    <Link>lPerFir=FirNam</Link>
  </Linker>
</CtxImport>
```

In dem hier gezeigten Beispiel wird der Inhalt vom Feld mit dem Synonym
"lPerFir" in dem Feld "FirNam" gesucht. Wird genau ein Datensatz
gefunden, erfolgt die Verweis-Auflösung.

### optionale Quellfelder 

Wurde während des Datenimportes ein anderes Feld gefüllt und das
eigentliche Verweisfeld leer gelassen, kann das gefüllte Feld als
optionales Quellfeld herangezogen werden. Der Inhalt aus diesem Feld
wird also gesucht und der endgültige Link in das Verweisfeld
geschrieben. Der Inhalt in dem optionalen Quellfeld bleibt dabei
erhalten.

```xml
<Linker>
  <Link optQuelle="myFirN">lPerFir=FirNam</Link>
</Linker>
```

### optionale Quell- und Ziel-Datensatztypen 

Werden dieselben Felder in unterschiedlichen Datensatztypen verwendet,
sind eindeutige Links für den Linker möglicherweise nicht eindeutig
festzustellen. Um dieses sicherzustellen, eigenet sich die Angabe von
Quell- und Ziel-Datensatztypen. Diese werden als Attribut angegeben:

```xml
<Linker>
  <Link quellTyp="Pers" zielTyp="Firm">lPerFir=FirNam</Link>
</Linker>
```

Die Kombination mit optionalen Quellfeldern ist hierbei
selbstverständlich möglich:

```xml
<Linker>
  <Link quellTyp="Pers" zielTyp="Firm" optQuelle="myFirN">lPerFir=FirNam</Link>
</Linker>
```

### mehrere Angaben für die Zielsuche 

Um einen eindeutigen Zieldatensatz zu finden, können mehrere Felder
angegeben werden. Der Linker sucht dann den Inhalt des noch nicht
aufgelösten Verweisfeldes (oder des optionalen Quellfeldes) innerhalb
der Datenbank und löst den Verweis auf, wenn die Kombination der Felder
einen eindeutigen Datensatz zurückliefert.

Beispielsweise könnten das Quellfeld mehrere Inhalte (durch Komma
getrennt) aufweisen:

``` 
Argus Verlag, 30916, Hannover
```

Innerhalb der Datenbank muss der Linker nunmehr die Inhalte für den
Firmennamen, die Postleitzahl und den Ort in den entsprechenden Feldern
suchen, um eindeutig einen Datensatz zu finden. Um es weiterhin noch
genauer einzuschränken, werden Quell- und Ziel-Typ angegeben.

```xml
<Linker>
  <Link quellTyp="Pers" zielTyp="Firm" optQuelle="myFirN">lPerFir=FirNam,FirPLZ,FirOrt</Link>
</Linker>
```

Beachten Sie hierbei, dass diese Art der Konfiguration natürlich zu
einer längeren Suche führt, da mehrere Felder überprüft werden müssen.
In umfangreichen Datenbeständen wäre es daher unter Umständen erheblich
schneller, in einem optionalen Quellfeld einen eindeutigen Wert zu
erfassen, der innerhalb eines Feldes als eindeutige Referenz im
Zieldatensatz gespeichert wurde.

### Ergänzende Filterparameter 

Ergänzend zu den oben gezeigten Konfigurationen besteht die Möglichkeit,
weitere Filterparameter anzugeben. Diese werden einfach hinter die
Suchfelder aufgeführt:

```xml
<Linker>
  <Link quellTyp="Pers" zielTyp="Firm" optQuelle="myFirN">lPerFir=FirNam,FirPLZ,FirOrt,FirActv=yes</Link>
</Linker>
```

In dem hier gezeigten Beispiel würde der Link daher nur gesetzt
(aufgelöst) werden, wenn folgende Kriterien zutreffen:

-   das Linkfeld wird im Datensatztyp "Pers" genutzt
-   der Verweis soll auf den Datensatztyp "Firm" verweisen
-   es existiert ein optionales Quellfeld "myFirN"
-   das optionale Quellfeld besitzt die Inhalt für Firnemname,
    Postleitzahl und Ort in genau der Reihenfolge, durch Komma getrennt
-   die Zieldatensätze besitzen in dem Feld mit dem Synonym "FirActv"
    den Eintrag "yes"

Nur wenn diese Kriterien vollständig zutreffen, wird der Verweis
gesetzt.
