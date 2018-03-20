Configuration Files
=====================

The database server is configured via the so-called "ini files". Therefore,
the access to system-specific directory and/or database structures is 
omitted (for example, Windows Registry). As a result, an installation by
copying or shifting a server by moving is very easy. The structure and 
contents of the necessary ini files are listed and explained below.

For the database server the ctxserver.ini and for the HTTP server
the ctxhttpd.ini are necessary.

CortexDB-Server 
---------------

All server parameters (port, backup path, backup schedule, etc.) are set
in ctxserver.ini in the server directory. The structure is divided into blocks
(each with a title in square brackets) and parameters (listed below the blocks).

Changes to the parameters are read in each time the database server is restarted.

The following list shows the various parameters and explains their meaning.
Optionally (depending on the application area) it is possible to define further settings.
As a rule, therefore, the described settings are sufficient.

``` 
[SETTINGS]
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


### Configuration Block: SETTINGS

This block is for the global server settings:

| Parameter                         | Description                                                                         |
| --------------------------------- | ----------------------------------------------------------------------------------- |
| basepath=                         | Path in which the data of the server are located (database files)                   |
| port=                             | tcp-ip-Port, which is used for server access                                        |
| bindonlylocalhost=                | 0=no, 1=only access from the local computer is allowed                              |
| AgentManagerAutoStart=            | 1=Agent Manager starts automatically when the server starts                         |
| SocketTimeout=                    | After expiration of this time in sec, a socket connection will be closed automatically  |
| disablechh                        | (de)activates the change history in the subdirectory chh (1=on, 0=off)              |

For the use of SSD storage media and larger databases, it may be useful to use the database index and the reorganization on the SSD during runtime. As a rule, the index is kept in the working memory. With the following parameters, this can be used by the SSD.

| Parameter                         | Description                                                                         |
| --------------------------------- | ----------------------------------------------------------------------------------- |
| fidxtemppath=                     | During the reorganization, the temporary data for index generation is stored in the specified path |
| fidxpath=                         | Load all indexes for the runtime of the database from the specified directory                 |
| DisableFidxMem=                   | Do not load field indexes into the memory (1=on; 0=off)                            |
| ReorgMaxMem=                      | Maximum memory while the sorting of all indexes during the reorganization in MB (default 256MB).<br />Note: With a RAM of more than 16GB, a guideline of 2GB has been proven.                            |

### Configuration Block: BACKUP

The server can create one automatic backup per day. The necessary settings for it are made in this block:

| Parameter                         | Description                                                   |
| --------------------------------- | ----------------------------------------------------------------- |
| backuppath=                       | Path in which the backups are written or from which they are read when restoring (also for manual backups) |
| MaxBackupCount=                   | Number of backups to keep before deleting the oldest backup file        |
| 0=                                | Time on Sunday for which a backup is to be created       |
| 1=                                | Time on Monday                                                |
| 2=                                | Time on Tuesday                                             |
| 3=                                | Time on Wednesday                                             |
| 4=                                | Time on Thursday                                         |
| 5=                                | Time on Friday                                               |
| 6=                                | Time on Saturday                                              |


### Configuration Block: SUGGESTIONS

For a database, files can be supplied with suggestion data used in interactive use. As a result, new entries are presented with cross-field suggestions that the user can employ. This makes faster and error-free data entry possible. Such data must first be created and stored for the database server from an existing database.

| Parameter                         | Description                                                 |
| --------------------------------- | ------------------------------------------------------------- |
| Suggestname=                      | Path and file name under which the suggest file is found  |
| ...                               | ...                                                           |

Each "Suggestname" is freely definable. Thus, for example, for article data the entry "article" can be stored with the corresponding path.

If new default files are set up after setting up a database, the database server should be stopped, the Suggestname=  should be entered into the ctxserver.ini and then the server be restarted. It must be ensured that the files can be read by the server.

### Configuration Block: HTTPSRV

A CortexDB database contains the functions of a web server. This eliminates
the need to install a separate web server in a single environment. If several 
databases are operated or multiple users access a database, it is recommended 
to use the Cortex HTTP server.

The configuration block listed here therefore describes the settings for the 
integrated web server in a stand-alone environment (without a separate web server).
This can be deactivated if necessary (see the first parameter).

| Parameter                              |  Description                    |
| -------------------------------------- | --------------------------------- |
| Enable=1                               | 1: active, 2: inactive           |
| Port=80                                | HTTP port for browser access |
| SslPort=443                            | HTTPS port for browser access|
| BindOnlyLocalHost=0                    | 1 = only accessible from the local computer, 0 for all |
| SslCertPem=127.0.0.1.pem               | Certificate for HTTPS access  |
| LogHttpSrv=1                           | Create log file for HTTP(S) access |
| HttpServerThreads=22                   |                                   |
| HttpRoot=www                           | Root directory for own files (HTML, php) |
| HttpAuth=0                             | Standard authentication or database authentication without browser support |
| WebClientName=Cortex-WebClient         | The name of the database in the title bar of the browser, is also used by the HTTP server with Enable = 0 |
| DefaultUrl=%V/i/CtxWebClient/index.php | %V=HTTPS, %v=HTTP |
| PhpSessDir=ab                          | The directory in which the PHP sessions of the logged-in users are stored (must be unique for each DB) |
| HttpDefaultUrlOnly=0                   | Login only with the default URL     |

### Configuration Block: UNIPLEX

In this block, default settings are set for the use of the CortexUniplex.

| Parameter                         | Description                     |
| --------------------------------- | --------------------------------- |
| EnableApiList                     | (Dis-)Enables the use of server-side JavaScript in lists |

HTTP-Server 
-----------

If a separate HTTP server is operated in a multi-server environment, then this too
must be configured via the corresponding ini file. The configuration blocks and parameters
can be found in the file "ctxhttpd.ini".

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

This file allows the configuration of several so-called "virtual hosts" 
for the use with subdirectories of a URL. The outsourcing of all servers on
different hardware is possible. The activation of the HTTP server to these 
databases may need to be done via internal firewall rules.

!!! note "Note"
	It should be noted that in the ctxserver.ini in the \ [CTXSRV \]  block the option "Enable" is deactivated, because the internal HTTP server of the CortexDB is no longer needed.


### Configuration Block: HTTPSRV

| Parameter                         | Description                  |
| --------------------------------- | --------------------------------- |
| Port=80                           | HTTP port for browser access  |
| SslPort=443                       | HTTPS port for browser access |
| BindOnlyLocalHost=0               | 1=only accessible from the local computer, 0 for all |
| SslCertPem=127.0.0.1.pem          | Certificate for HTTPS access |
| LogHttpSrv=1                      | Create log file for HTTP(S) access; 1=active |
| HttpRoot=www                      | Root directory for additional HTML, PHP files (and more formats) |
| CtxSrv=127.0.0.1:29000            | Default server and port of the CortexDB |
| HttpAuth=0                        | 0=database authentication, 1=http authorization |
| WebClientName=Database name       | is passed to php as a "\ _SERVER" variable |
| DefaultUrl=%V/i/CtxWebClient/inde | \% V stands for HTTPS% v for HTTP |
| x.php                             |                                   |
| HttpDefaultUrlOnly=0              | on the HTTP port only respond on the /  |
| PhpSessDir=tmpdev                 | is used as a session directory for the default URL |
| HttpServerThreads=22              |                                   |
| vhosts=demo                       | All names specified under vhosts must follow as sections that define the parameters of the respective CortexDB. |

### Configuration block for a virtual host

The parameters in the configuration block of a virtual host correspond to the aforementioned parameters of the global settings.

``` 
[demo]
HttpRoot=www
CtxSrv=127.0.0.1:29001
HttpAuth=0
WebClientName=DemoDB
PhpSessDir=demo
DefaultUrl=%V/i/UniPlex/index.php
```

Several so-called "virtual hosts" within a configuration are possible. 
This allows access to various databases via a central web server. 
The name of the "virtual host" is then written only after the actual address.

The call for the above example is:

    http://www.mein-server.de/demo

The distributed operation of different database servers and the web server
is therefore conceivable for different hardware systems.

