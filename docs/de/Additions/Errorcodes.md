Fehlercodes
===========

Fehlercodes werden im Rahmen des Datenbank-Betriebes immer als negative Zahl ausgegeben. Die vorliegende Liste gibt eine Auswahl der häufigsten Fehler wieder. Damit und mit den beschriebenen Konfigurationen ist die Lokalisierung und Behebung von Fehlern möglich.

    0     DSV_OK                 =>  alles Ok

    -1    DSV_ERROR              =>  fataler Fehler;
                                     möglicherweise System-/Datenträger-Fehler

    -1010 DSV_LICENSE_ERROR      =>  Lizenzfehler; falsche Lizenz installiert

    -1011 DSV_STDID_ERROR        =>  tritt in Verbindung mit Slave-Datenbanken
                                     bei Nutzung einer falsche Lizenz auf

    -900  DSV_PARAMERROR         =>  Fehler bei der Übergabe von Parametern
                                     während der Softwareentwicklung

    -902  DSV_NOCTXCLHANDLE      =>  Zugriff per ungültigem Handle
                                     Zugriff mit altem Session-Handle

    -905  DSV_LOGIN_ERROR        =>  Login-Fehler; div. Gründe
                                     evtl. falscher Benutzer; Passwort 

    -909  DSV_LOGIN_USERNOTFOUND =>  Benutzerkonto nicht vorhanden 

    -911  DSV_LOGIN_PWERROR      =>  Während der Benutzer-Anmeldung wurde
                                     ein falsches Passwort eingegeben

    -915  DSV_LOGIN_KEYERR       =>  Bei Nutzung des Public/Private-Key-
                                     Verfahrens für die Benutzeranmeldung
                                     ist ein Fehler im Schlüssel aufgetreten

    -916  DSV_BASE_NOTOPEN       =>  Ampel auf gelb oder rot 

    -918  DSV_LOCKED             =>  Server-Locks konnten nicht gelöst werden

    -919  DSV_SELFLOCKED         =>  siehe „-918“

    -921  DSV_LOGIN_PHPAPPNOPERM =>  Es existiert kein Benutzer „php“ in der 
                                     Datenbank und/oder dieser hat
                                     keinerlei php-Rechte

    -922  DSV_LOGIN_APPNOPERM    =>  Das Anwenderkonto besitzt keine Rechte 
                                     für die aufgerufene Datenbank-Funktion
                                     oder -Erweiterung

    -923  DSV_LOGIN_ALLWAYSLOGIN =>  erneuter Login-Versuch mit einem bereits 
                                     angemeldeten Benutzerkonto

    -924  DSV_LOGIN_LICTIMEOVER  =>  Das Lizenzdatum wurde überschritten,
                                     die Lizenz ist somit nicht mehr gültig

    -925  DSV_LICENSE_OVERLOAD   =>  Bei dem Import einer Lizenz wurden
                                     weniger Benutzerrechte aktiviert,
                                     als bisher zugewiesen

!!! note "Hinweis"
	Treten kritische Fehler auf und schaltet der Server daher automatisch auf "Stop", ist umgehend der Datenbank-Support zu involvieren.

Fehlercodes bei der Nutzung einer Suggest-Datei
-----------------------------------------------

Die Fehlercodes bei der Nutzung einer "Suggest"-Datei beziehen sich auf den Zugriff der Quell-Datei für die automatische Vervollständigung von Eingaben während der Nutzung der Anwendung CortexUniplex. Diese Quelldatei muss im Serververzeichnis (bzw. dem in der Konfiguration angegebenen Pfad) hinterlegt und in der Konfiguration einer Satzart konfiguriert werden.

    -1201    DSV_SUGG_FILEREADERROR => Datei kann nicht gelesen werden
    -1203    DSV_SUGG_FILEOPENERROR => Datei kann nicht geöffnet werden
    -1206    DSV_SUGG_SYNNOTFOUND   => Feld wurde in Quelldatei nicht gefunden
    -1208    DSV_SUGG_VERSIONERROR  => die falsche Dateiversion wird genutzt

Treten diese oder ähnliche Fehler, beginnend mit "DSV_SUGG..." auf, ist umgehend der Datenbank-Support zu benachrichtigen, da grundlegende Einstellungen und/oder die erzeugte Datei fehlerhaft sind.
