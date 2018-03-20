Konfigurationsdateien
=====================

Der Datenbank-Server wird über sog. "ini-Dateien" konfiguriert. Daher
wird auf den Zugriff systemspezifischer Verzeichnis- und/oder
Datenbankstrukturen verzichtet (z.B. Windows-Registry). Dadurch ist eine
Installation durch Kopieren oder ein Verlagern eines Servers durch
Verschieben sehr einfach möglich. Im Nachfolgenden werden Aufbau und
Inhalte der notwendigen ini-Dateien aufgeführt und erläutert.

Für den Datenbank-Server ist die ctxserver.ini und für den HTTP-Server
die ctxhttpd.ini notwendig.

CortexDB-Server 
---------------

Alle Serverparameter (Port, Datensicherungspfad, Sicherungszeitplan
etc.) werden in der ctxserver.ini im Serververzeichnis festgelegt. Der
Aufbau untergliedert sich in Blöcke (jeweils mit einem Titel in eckigen
Klammern) und Parameter (unterhalb der Blöcke aufgeführt).

Änderungen an den Parametern werden bei jedem Neustart des
Datenbank-Servers eingelesen.

Die nachfolgende Aufstellung zeigt die verschiedenen Parameter auf und
erläutert deren Bedeutung. Optional (je nach Anwendungsbereich) ist es
möglich, dass weitere Einstellungen definiert werden. Im Regelfall sind
daher die beschriebenen Einstellungen ausreichend.

``` 
[EINSTELLUNG]
basepath=.\daten
port=29000
bindonlylocalhost=0
AgentManagerAutoStart=0
SocketTimeout=500
disablechh=1

fidxtemppath=./tmp
fidxpath=./data
DisableFidxMem=1
ReorgMaxMem=512

[BACKUP]
backuppath=.\backup
MaxBackupCount=1
0=01:00
6=02:00

[SUGGESTIONS]
adrde=.\suggest\adrde.dat,1

[HTTPSRV]
Enable=1
Port=80
SslPort=443
BindOnlyLocalHost=0
SslCertPem=127.0.0.1.pem
LogHttpSrv=1
HttpServerThreads=22
HttpRoot=www
HttpAuth=0
WebClientName=Cortex-WebClient
DefaultUrl=%V/i/CtxWebClient/index.php
PhpSessDir=ab
HttpDefaultUrlOnly=0

[UNIPLEX]
EnableApiList=1
```


### Konfigurationsblock: EINSTELLUNG

Dieser Block dient für die globalen Servereinstellungen:

| Parameter                         | Beschreibung                                                                        |
| --------------------------------- | ----------------------------------------------------------------------------------- |
| basepath=                         | Pfad in dem die Daten des Servers liegen (Datenbank-Dateien)                        |
| port=                             | tcp-ip-Port, der für den Serverzugriff verwendet wird                               |
| bindonlylocalhost=                | 0=nein, 1=nur Zugriffe vom lokalen Rechner erlaubt                                  |
| AgentManagerAutoStart=            | 1=Agentmanager wird beim Serverstart automatisch gestartet                          |
| SocketTimeout=                    | Nach Ablauf dieser Zeit in sec wird eine Socket-Verbindung automatisch geschlossen  |
| disablechh                        | (de-)aktiviert die change history im Unterverzeichnis chh (1=an; 0=aus)             |

Für die Nutzung von SSD-Speichermedien und größeren Datenbanken kann es sinnvoll sein, den Datenbank-Index und die Reorganisation auf den SSD während der Laufzeit zu nutzen. Im Regelfall wird der Index im Arbeitsspeicher gehalten. Mit folgenden Parametern, kann dieser von der SSD genutzt werden.

| Parameter                         | Beschreibung                                                                        |
| --------------------------------- | ----------------------------------------------------------------------------------- |
| fidxtemppath=                     | Während der Reorganisation werden die die temporären Daten zur Indexerzeugung in dem angegebenen Pfad abgelegt                     |
| fidxpath=                         | Alle Indexe für die Laufzeit der Datenbank aus dem angegebenen Verzeichnis laden                 |
| DisableFidxMem=                   | Feldindexe nicht in den Arbeitsspeicher laden (1=on; 0=off)                            |
| ReorgMaxMem=                      | Maximaler Arbeitsspeicher bei der Sortierung aller Indexe während der Reorganisation in MB (default 256MB).<br />Hinweis: Bei einem Arbeitsspeicher von mehr als 16GB hat sich ein Richtwert von 2GB bewährt. Bei weniger Arbeitsspeicher sollten 512MB nicht überschritten werden                            |

### Konfigurationsblock: BACKUP

Der Server kann pro Tag ein automatisches Backup erstellen. In diesem Block werden die dafür notwendigen Einstellungen vorgenommen:

| Parameter                         | Beschreibung                                                      |
| --------------------------------- | ----------------------------------------------------------------- |
| backuppath=                       | Pfad in dem die Backups geschrieben oder aus dem sie beim Wiederherstellen gelesen werden (auch für manuelle Backups) |
| MaxBackupCount=                   | Anzahl vorzuhaltener Backups, bevor die jeweils älteste Backup-Datei gelöscht wird        |
| 0=                                | Uhrzeit am Sonntag, zu dem ein Backup erstellt werden soll        |
| 1=                                | Uhrzeit am Montag                                                 |
| 2=                                | Uhrzeit am Dienstag                                               |
| 3=                                | Uhrzeit am Mittwoch                                               |
| 4=                                | Uhrzeit am Donnerstag                                             |
| 5=                                | Uhrzeit am Freitag                                                |
| 6=                                | Uhrzeit am Samstag                                                |


### Konfigurationsblock: SUGGESTIONS

Für eine Datenbank können Dateien mit Vorschlagsdaten mitgeliefert werden, die bei der interaktiven Nutzung herangezogen werden. Dadurch werden bei Neueingaben feldübergreifende Vorschläge präsentiert, die der Anwender nutzen kann. Dadurch ist eine schnellere und fehlerfreiere Dateneingabe möglich. Solche Daten müssen für den Datenbank-Server zuvor aus einem vorhandenen Datenbestand erzeugt und hinterlegt werden.

| Parameter                         | Beschreibung                                                  |
| --------------------------------- | ------------------------------------------------------------- |
| Suggestname=                      | Pfad und Dateiname, unter dem die Suggestdatei gefunden wird  |
| ...                               | ...                                                           |

Jeder "Suggestname" ist frei definierbar. So kann bspw. für Artikel-Daten der Eintrag "Artikel" mit dem entsprechenden Pfad hinterlegt sein.

Sollten nach Einrichtung einer Datenbank neue Vorschlagsdateien eingerichtet werden, so ist der Datenbank-Server zu stoppen, in der ctxserver.ini der Suggestname= einzutragen und danach der Server neu zu starten. Es muss sichergestellt werden, dass die Dateien vom Server gelesen werden können

### Konfigurationsblock: HTTPSRV

Eine CortexDB-Datenbank beinhaltet die Funktionen eines Webservers.
Dadurch kann in einer Einzelumgebung auf die Installation eines
separaten Webservers verzichtet werden. Werden mehrere Datenbanken
betrieben oder greifen mehrere Benutzer auf eine Datenbank zu, ist die
Nutzung des Cortex-eigenen HTTP-Servers zu empfehlen.

Der hier aufgeführte Konfigurationsblock beschreibt daher die
Einstellungen für den integrierten Webserver in einer
stand-alone-Umgebung (ohne separaten Webserver). Dieser kann bei Bedarf
deaktiviert werden (siehe den ersten Parameter).

| Parameter                              | Beschreibung                      |
| -------------------------------------- | --------------------------------- |
| Enable=1                               | 1: aktiv, 2: inaktiv              |
| Port=80                                | HTTP-Port für den Browserzugriff  |
| SslPort=443                            | HTTPS-Port für den Browserzugriff |
| BindOnlyLocalHost=0                    | 1=nur vom lokalen Rechner zugreifbar, 0 für alle |
| SslCertPem=127.0.0.1.pem               | Zertifikat für den HTTPS-Zugriff  |
| LogHttpSrv=1                           | Log Datei für den HTTP(S) Zugriff erstellen |
| HttpServerThreads=22                   |                                   |
| HttpRoot=www                           | Root-Verzeichnis für eigene Dateien (HTML, php) |
| HttpAuth=0                             | Standard-Authentifizierung oder Datenbank-Authentifizierung ohne Browser-Support |
| WebClientName=Cortex-WebClient         | Name der Datenbank in der Titelzeile des Browsers, wird auch bei Enable=0 vom HTTP-Server benutzt |
| DefaultUrl=%V/i/CtxWebClient/index.php | %V=HTTPS, %v=HTTP |
| PhpSessDir=ab                          | Verzeichnis, in dem die PHP-Sessions der eingeloggten User gespeichert werden (muß für jede DB einmalig sein) |
| HttpDefaultUrlOnly=0                   | Login nur mit der Default-URL     |

### Konfigurationsblock: UNIPLEX

In diesem Block werden Standardeinstellungen für die Nutzung des CortexUniplex
gesetzt.

| Parameter                         | Beschreibung                      |
| --------------------------------- | --------------------------------- |
| EnableApiList                     | (De-)Aktiviert die Nutzung von serverseitigem JavaScript in Listen |

HTTP-Server 
-----------

Wird in einer Mehrserver-Umgebung ein separater HTTP-Server betrieben,
ist auch dieser über die entsprechende ini-Datei zu konfigurieren. Die
Konfigurationsblöcke und Parameter finden sich in der Datei
"ctxhttpd.ini".

``` 
[HTTPSRV]
Port=81
SslPort=444
BindOnlyLocalHost=0
SslCertPem=ssl_127.0.0.1.pem
LogHttpSrv=1
HttpRoot=www
CtxSrv=127.0.0.1:29000
;HttpAuth=1
WebClientName=UniPlex
DemoDB DefaultUrl=%V/i/UniPlex/index.php
HttpDefaultUrlOnly=0
;Rewrite=/i/ctxwcl
PhpSessDir=ab
vhosts=demo
[demo]
HttpRoot=www
CtxSrv=127.0.0.1:29001
HttpAuth=0
WebClientName=DemoDB
PhpSessDir=demo
DefaultUrl=%V/i/UniPlex/index.php
```

Diese Datei erlaubt die Konfiguration mehrerer sog. "virtueller Hosts"
für die Nutzung über Unterverzeichnisse einer URL. Hierbei ist die
Auslagerung alle Server auf unterschiedlicher Hardware möglich. Eine
Freischaltung des HTTP-Servers auf diese Datenbanken muss ggf. über
interne Firewall-Regeln erfolgen.

!!! note "Hinweis"
	An dieser Stelle ist zu beachten, dass in der ctxserver.ini im Block \[CTXSRV\] die Option "Enable" deaktiviert ist, da der interne HTTP-Server der CortexDB nicht mehr benötigt wird.


### Konfigurationsblock: HTTPSRV

| Parameter                         | Beschreibung                      |
| --------------------------------- | --------------------------------- |
| Port=80                           | HTTP-Port für den Browserzugriff  |
| SslPort=443                       | HTTPS-Port für den Browserzugriff |
| BindOnlyLocalHost=0               | 1=nur vom lokalen Rechner zugreifbar, 0 für alle |
| SslCertPem=127.0.0.1.pem          | Zertifikat für den HTTPS-Zugriff  |
| LogHttpSrv=1                      | Log Datei für den HTTP(S) Zugriff erstellen; 1=aktiv |
| HttpRoot=www                      | Root-Verzeichnis für ergänzende HTML-, PHP-Dateien (und weiter Formate) |
| CtxSrv=127.0.0.1:29000            | Standard-Server und -Port der CortexDB |
| HttpAuth=0                        | 0=Datenbankauthentifizierung, 1=http-Authorisierung |
| WebClientName=Datenbankname       | wird als „\_SERVER"-Variable an php übergeben |
| DefaultUrl=%V/i/CtxWebClient/inde | \%V steht fuer HTTPS %v fuer HTTP |
| x.php                             |                                   |
| HttpDefaultUrlOnly=0              | am HTTP-Port nur auf die / antworten |
| PhpSessDir=tmpdev                 | wird als Session-Verzeichnis für die Default-URL verwendet |
| HttpServerThreads=22              |                                   |
| vhosts=demo                       | Alle unter vhosts angegebenen Namen müssen als Sektionen folgen, in denen die Parameter der jeweiligen CortexDB festgelegt sind. |

### Konfigurationsblock für einen virtual host

Die Parameter in dem Konfigurationsblock eines virtual host entsprechen
den vorgenannten Parametern der globalen Einstellungen.

``` 
[demo]
HttpRoot=www
CtxSrv=127.0.0.1:29001
HttpAuth=0
WebClientName=DemoDB
PhpSessDir=demo
DefaultUrl=%V/i/UniPlex/index.php
```

Mehrere sog. "virtual host" innerhalb einer Konfiguration sind möglich.
Dadurch kann der Zugriff auf verschiedene Datenbanken über einen
zentralen Webserver bereitgestellt werden. Der Name des "virtual host"
wird dann nur hinter die eigentliche Adresse geschrieben.

Der Aufruf für o.g. Beispiel lautet daher:

    http://www.mein-server.de/demo

Der verteilte Betrieb von verschiedenen Datenbank-Servern und des
Webservers ist daher auf verschiedene Hardware-Systeme denkbar.

