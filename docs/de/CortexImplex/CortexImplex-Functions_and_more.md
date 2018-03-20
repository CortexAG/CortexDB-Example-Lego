Funktion und mehr
=================

Nachfolgende Übersicht dient als Hilfe zur Nutzung der Importfunktionen, wie auch als Information zur Importgeschwindigkeit und zeigt weitere Möglichkeiten des Datenimportes auf.

Funktionen
----------

Die aufgeführten Funktionen können innerhalb einer Importkonfiguration (xml Konfigurationsdatei) angewedet werden, um Quelldaten zu konvertieren, zu prüfen oder mit anderen Infromationen zu verbinden.

### Konvertierungsfunktionen

Die folgenden Funktionen konvertieren einen String in einen anderen Typ. Es stehen folgende Zieltypen zur Verfügung:

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

Im Gegensatz dazu können beliebige andere Datentypen in einen String konvertiert werden.

	cstring(Object in) 

Ein beliebiges Datumsformat in das Datenbank-eigene Format konvertieren.

	date(String format, String in) 

### weitere Funktionen

AND Operation auf zwei boole'sche Werte ausführen.

	AND(Boolean v1, Boolean v2) 

Zwei Eingabestrings zu einem Ergebnisstring verbinden (concatenate).

	concat(String s1, String s2) 

Liefert den Quotienten zweier numerischer Werte.

	DIV(v1, v2) 

Gibt zurück, ob der übergebene String die Länge 0 besitzt.

	empty(String in) 

Prüft, ob der Eingabstring (str1) mit dem Prüfstring (end) endet

	endsWith(String str1, String end) 

Prüft, ob zwei Strings gleich sind.

	equals(String str1, String str2) 

Liefert die Erweiterung eines übergebenen Dateinamens

	file_extension(String file) 

Liefert den Dateinamen ohne Erweiterung einer Datei zurück, befreit von
Pfadangaben

	file_woext(String file) 

Importiert eine Datei (sFileName

	file(String sFileName) 

Liefert den Dateinamen einer Datei zurück, befreit von Pfadangaben

	filename(String file) 

Liefert den absolute Pfad einer Datei zurück

	filepath(String file) 

!!! example "findFirst"
    Diese Funktionen ist erst ab Implex-Version 4.0 verfügbar und findet die erste Position eines Zeichens (optional ab einer bestimten Stelle) und gibt die Position als Int zurück
``` 
findFirst(in, match)
findFirst(in, match, startPos)
``` 

!!! example "findLast"
    Diese Funktionen ist erst ab Implex-Version 4.0 verfügbar und findet die letzte Position eines Zeichens (optional ab einer bestimten Stelle) und gibt die Position als Int zurück
``` 
findLast(in, match)
``` 

Liefert then, wenn ifclause == true, sonst elsedo

	iif(Boolean ifclause, then, elsedo) 

Liefert die Länge eines Strings

	length(String str) 

Wandelt einen String in Kleinbuchstaben um

	lower(String val) 

Subtrahiert zwei numerische Werte voneinander.

	MINUS(v1, v2) 

Liefert das Produkt der beiden numerischen Werte.

	MUL(v1, v2) 

Zur Normierung einer Hausnummer.

	normHnr(String in) 

Gibt den übergebenen boole'schen Wert negiert zurück.

	NOT(Boolean in) 

Prüft, ob zwei Strings ungleich sind.

	notequals(String str1, String str2) 

Führt die OR Operation auf zwei boole'sche Werte aus.

	OR(Boolean v1, Boolean v2) 

Gibt einen String zurück, bei dem die Zeichen des Eingabestrings
rechtsbündig ausgerichtet sind, indem die linke Seite mit Leerzeichen
aufgefüllt wird

	pad_left(String in, Integer len) 

Gibt einen String zurück, bei dem die Zeichen des Eingabestrings
linksbündig ausgerichtet sind, indem die rechte Seite mit Leerzeichen
aufgefüllt wird

	pad_right(String in, Integer len) 

Gibt einen String zurück, bei dem die Zeichen des Eingabestrings
rechtsbündig ausgerichtet sind, indem die linke Seite mit dem
angegebenen Zeichen aufgefüllt wird

	pad_left(String in, String char, Integer len) 

Gibt einen String zurück, bei dem die Zeichen des Eingabestrings
linksbündig ausgerichtet sind, indem die rechte Seite mit dem
angegebenen Zeichen aufgefüllt wird

	pad_right(String in, String char, Integer len) 

Addiert die beiden numerischen Werte.

	PLUS(v1, v2) 

Ersetzt einen Suchstring im Eingabestring durch einen Ersatzstring.

	replace(String sIn, String sSeek, String sRepl) 

Liefert von dem Eingabestring alle Zeichen, ab dem gewünschten
Startzeichen start.

	rsubstring(String in, Integer start) 

Liefert das n-te Element aus dem zerlegten Eingabestring.

	split(String src, String splitStr, Integer n) 

Liefert den Dateinamen inkl. Extension der aufgerufenen Importdatei

	sourceFileName() 

Liefert von dem Eingabestring einen Teilstring mit der angegebenen Länge
ab der übergebenen Startposition.

	substring(String in, Integer start, Integer len) 

Wandelt ein String im CORTEX Datumsformat in einen CORTEX Internen Long
Zeitstempel um.

	time(String date) 

Der Aufruf ohne Parameter liefert den aktuellen, minutengenauen Zeitstemptel.
Für eine Nutzung als Verlaufsinformation ist eine Konvertierung mit der
Date-Funktion notwendig.

	time()

Führt einen trim auf einen String aus.

	trim(String in) 

Wandelt einen String in Großbuchstaben um.

	upper(String val) 

### Variablen in der Konfiguration

Insbesondere bei umfangreichen Importkonfigurationen ist es hilfreich,
wenn bereits definierte Werte per Variable weiterverwendet werden
können. Hierfür stehen vier grundlegende Funktionen zur Verfügung.

Für Textwerte können Variablen über zwei Funktionen gesetzt und gelesen
werden:

	getVar(String Name)
	setVar(String Name, String Value)

Numerische Werte (double) können mit einer erweiterten Funktion gesetzt
und gelesen werden:

	getVarDouble(String Name)
	setVarDouble(String Name, String Value)

Zu beachten ist hiebei, dass Variablen nur rechtsseitig vom Gleichheitszeichen der Wertzuweisung verwendet werden können. Linksseitig vom Gleichheitszeichen (z.B. für die Bestimmung eines Verlaufsdatums) ist die Verwendung nicht möglich.

Geschwindigkeit
---------------

Grundsätzlich hängt die Geschwindigkeit des Importes natürlich von der
eingesetzten Hardware ab. SSD-Speichermedien sind typischerweise
erheblich schneller als Festplatten; Ein Import ohne Referenzen
schneller, als das Update vorhandener Datensätze.

### Import-Modus des Servers

Der Datenbankserver kann beim Starten in den sog. "Import-Modus"
geschaltet werden, um den Datenimport zu beschleunigen. Hierbei werden
die zu importierenden Daten eingelesen, ohne die Verwaltungsstrukturen
(u.a. den Index) anzulegen. Erst nach dem eigentlichen Datenimport wird
der Server beendet, erneut gestartet und reorganisiert, um diese
Strukturen aufzubauen. Dieses ist beispielsweise sinnvoll, wenn über den
Erstimport erhebliche Datenmengen und danach nur noch ergänzende
Informationen importiert werden.

Der generelle Ablauf zum Importieren über den Import-Modus gliedert sich
in folgende Schritte:

-   Den laufenden Datenbankserver beenden
-   Manuell den Datenbankserver mit dem Parameter "-m" starten
-   Den Import durchführen
-   Nach dem Import den Datenbankserver beenden und regulär starten
-   Per Remote-Admin eine Reorganistion ausführen

Der manuelle Start des Servers erfolgt üblicherweise in einer
Systemkonsole (das sog. "Terminal"). Unter Windows führen Sie hierfür
die Anwendung "cmd.exe" aus und starten dann den Datenbankserver in
dem Datenbankverzeichnis:

    ctxserver64.exe -m

oder bei 32-Bit Systemen:

    ctxserver32.exe -m

Für die Reorganisation starten Sie den Remote-Admin und klicken den
Punkt "Reorganistion" (oben rechts in der Maske). Während dieser
Durchführung ist kein Arbeiten innerhalb der Datenbank möglich, da
hiermit erst die Verwaltungsstrukturen aufgebaut (bzw. korrigiert)
werden.

Sollte es sich um einen Datenbestand handeln, der zum Erstimport und
regelmäßig wiederkehrend aus umfangreichen Datensätzen besteht (mehrere
hundert Millionen oder Milliarden), stehen wir Ihnen gerne für
tiefergehende Fragen zur Verfügung.

### Filterfunktion

Innerhalb einer Import-Konfiguration ist es möglich, dass ein Filter
konfiguriert wird, der nur den Import bestimmter Datensätze erlaubt.
Ungültige Datensätze werden von vornherein ausgeschlossen und nicht
übersprungen.

Innerhalb der *ImportSection* wird hierfür nur ein weiterer Parameter
ergänzt, über den der Filter festgelegt wird. Folgendes Beispiel zeigt
die Anwendung für den Ausschluss bestimmter Datensätze während des
Importes:

    <ImportSection datensatztyp="Pers">

      <FilterFunktion>
        getChar('P_id')!=''
      </FilterFunktion>

      <Referenz>PersID</Referenz>

      <Feld>PersID=getChar('P_id')</Feld>
      <Feld>Vor=getChar('Vorname')</Feld>
      <Feld>Nam=getChar('Name')</Feld>

    </ImportSection>

Das hier gezeigte Beispiel schließt ale Datensätze aus, für die aus dem
Quellsystem keine Datensatz-ID vorliegt. Nur wenn die Rückgabe der
Filterfunktion "*Wahr*" ergibt, wird der Datensatz importiert. Eine
Kombination mehrer Funktionen ist daher auch möglich:

    <ImportSection datensatztyp="Pers">

      <FilterFunktion>
        AND(getChar('P_id')!='',getChar('Name')!='')
      </FilterFunktion>

      <Referenz>PersID</Referenz>

      <Feld>PersID=getChar('P_id')</Feld>
      <Feld>Vor=getChar('Vorname')</Feld>
      <Feld>Nam=getChar('Name')</Feld>

    </ImportSection>

### Bildung eines Hash-Wertes

Als Ergänzung des Referenz-Importes - also der Aktualisierung
vorhandener Daten - ist die Nutzung eines Hash-Feldes möglich. Der
ImPlex unterstützt beim Import von csv-Dateien die Bildung eines
Hash-Wertes über den Datensatz und schreibt diesen Hash-Wert in ein
separates Feld. Erfolgt ein erneuter Import, wird vor der Referenz-Suche
der Hashwert in der Datenbank gesucht. Wird dieser gefunden, liegt keine
Änderung vor; Ist der Wert nicht vorhanden, greift die Referenz und ein
vorhandener Datensatz wird aktualisiert (bzw. ein neuer Datensatz
angelegt).

Um diese Funktion zu nutzen, ist eine Ergänzung der Importkonfiguration
im Block "*ImportSection*" und die Nutzung eines zusätzlichen Feldes
notwendig.

      <ImportSection datensatztyp="MyDS">
        <HashFilter>hashfld</HashFilter>
        <Referenz>myRefFl</Referenz>
        <Feld>myField1=getChar('field1')</Feld>
        <Feld>myField2=getChar('field2')</Feld>
        <Feld>myFieldX=getChar('...')</Feld>
      </ImportSection>

Der Hash-Wert wird in diesem Beispiel im Feld "*hashfld*" abgelegt und
bei einem erneuten Import damit verglichen. Alle weiteren
Konfigurationen für weitere Felder bleiben so bestehen, wie sie sind. Es
ist nicht notwendig, dass für den Hash-Wert eine weitere Zeile mit einer
Import-Konfiguration angelegt wird.

Delta-Import 
------------

Der Delta-Import ermöglicht die automatische Bearbeitung
nicht-geänderter Datensätze. Dafür führt das Import-Werkzeug ImPlex die
sog. "Delta-Liste" mit, in der nach der Abarbeitung der Quelldatei nur
noch die Datensätze vermerkt sind, die keine Aktualisierung erfahren
haben. Diese restlichen Datensätze (Delta-Liste) können dann nach vier
unterschiedlichen Methoden abgearbeitet werden.

### Modi der Delta-Liste

Der Delta-Import kann vier Einstellungen für die Delta-Liste nutzen.

``` 
c = clear -  alle Werte, außer den aktuellen Inhalten der Referenzfelder
             ab dem heutigen Datum auf leer setzen
l = löschen - unwiederrufliches Löschen des kompletten Datensatzes
a = archivieren - Archivieren nach Art des CortexUniplex
w = wiederherstellbar Löschen - wiederherstellbares Löschen nach Art des CortexUniplex
```

**Beispiel**

Das nachfolgende Beispiel zeigt eine Konfiguration mit der Nutzung der
Delta-Liste, um vorhandene Datensätze anhand der Referenz zu
aktualisieren und die nicht aktualisierten Datensätze zu löschen
(unwiderruflich).

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CtxImport>
  <Global>
    <LoginIP>127.0.0.1</LoginIP>
    <LoginPort>29000</LoginPort>
    <LoginUser>import-user</LoginUser>
    <LoginPW>userpasswd</LoginPW>
    <ImportModus>u</ImportModus>
    <DeltaListe>l</DeltaListe>
  </Global>

  <ReaderModul typ="csv">
    <Dateiname>import-file.csv</Dateiname>
    <FeldTrenner>,</FeldTrenner>
    <FeldBegrenzer>"</FeldBegrenzer>
    <WdhlTrenner>,</WdhlTrenner>
    <SpaltenModus>HEADER</SpaltenModus>
    <Charset>ISO-8859-1</Charset>
  </ReaderModul>

  <ImportSection datensatztyp="Pers">
    <Referenz>Name</Referenz>
    <Feld>Name=LastName</Feld>
    <Feld>Vor=FirstName</Feld>
  </ImportSection>

</CtxImport>
```

**Hinweis:**

Die Delta-Liste nutzt ausschließlich die Information des angegebenen
Referenz-Feldes. Der Datensatztyp wird nicht berücksichtigt. Wird das
Referenzfeld in unterschiedlichen Datensatztypen verwendet, werden alle
Datensätze gelöscht, die nicht zu dem konfigurierten Typ in der
"Import-Section" gehören.

### Delta-Import für Wiederholfelder

Wiederholfelder können ebenso wie komplette Datensätze per Deltaimport
aktualisiert werden. Dieses hat zur Folge, das diejenigen
Wiederholfelder gelöscht werden, wenn diese nicht mehr in der Quelle
vorliegen.

**Beispiel**

``` 
<WiederholGruppe start="Hobbies">
    <Feld deltaliste='d'>PeHob = getChar(Hobby)</Feld>
</WiederholGruppe>
```

In diesem Beispiel wird aus einer XML-Datei die Inhalte zu dem Feld
Hobby einer Person gelesen. Ist bereit ein Hobby in der Datenbank
gespeichert, wird über die Quelle aber nicht mehr geliefert, wird das
Feld entfernt.

**Hinweis:**

Die Kombination vom Parameter "deltaliste" und der Angabe einer
Referenz, sowie die Verwendung der Deltaliste in mehrere Feldern einer
Wiederholfeldgruppe kann zu unerwarteten ergebnissen führen und sollte
vor der endgültigen Verwendung ausreichend getestet werden.

