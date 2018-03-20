Examples with AngularJS
=======================

AngularJS is a Javascript library for the development of user interfaces, 
which is currently combined with other libraries (e.g., Bootstrap, JQuery, etc.).
This library greatly simplifies and speeds development. As a rule, database queries
require an intermediate layer to execute certain functions. Usually, other libraries
and programming languages are used (for example, Java, nodeJS, etc.).

The CortexDB allows immediate use of AngularJS through the CortexUniplexAPI and 
a configured database. Ideally, therefore, the intermediate layer can be omitted.

![Version:3.0.14;Date:17.01.2018; Name:Model.CTX-JS-Angular-MVC](AngularJS-CommunicationSchema.png)

The examples given here therefore show in the simplest possible way how to access
 a CortexDB via CortexUniplexAPI.

Note that the basic parameters are the same as the other examples (php and python).
The JSON objects are therefore to be processed as in the general explanation.

 

!!! note "Note"
	The use of the CortexUniplexAPI takes place in a user context. Parallel use of multiple sessions in the same user context is not possible.

As a rule, functions are provided by using AngularJS via services or directives.
The examples shown here only show a part of an overall application, so that you
can easily copy them into your own source code.

### getLogin

This code snippet logs on to the specified user. The username and password are
usually requested in the form of a Login mask. If the login was successful, a user
handle will be returned, along with other information, so that all further inquiries
can be made via the CortexUniplexAPI. This user handle should therefore be stored 
in a global variable (or object).

``` 
this.login = function() {

    var sDsURI = "https://my-server.com/i/UniPlexDataservice/updjsr.php";

    var locObj = {
                  "method": "getLogin",
                  "requestid": 1,
                  "param": {
                      "user": "myUserName",
                      "pass": "myUserPass",
                      "app": "UniplexDatasservice"
                  }
    };

    $http.post(sDsURI,JSON.stringify(locObj)).success(function(response) {
        if(response['result']['rc']===0) {
            . . . 
        }
    });
};
```

 

### getLogout

Similar to the login, the logout is done with the user handle. After a successful
logout, no further query can take place with the user handle. Only with a new login 
(and thus with a new user handle), the user can continue working.

``` 
this.logout = function() {

   var sDsURI = "https://my-server.com/i/UniPlexDataservice/updjsr.php";

   var locObj = {
                "method": "getLogout",
                "requestid": 2,
                "param": {
                    "UpdJsrHdl": this.userHdl //Variable for user handle
                }
    };

    $http.post(sDsURI,JSON.stringify(locObj)).success(function(response){
         if(response['result']['rc']===0) {
             . . . 
         }
    });
};
```

### getPortalList

This code snippet returns all portals of the logged in user.

``` 
this.getPortals = function() {

    var sDsURI = "https://my-server.com/i/UniPlexDataservice/updjsr.php";

    var locObj = {
        "method": "getPortalList",
        "requestid": 3,
        "param": {
            "UpdJsrHdl": this.userHdl // variable for user handle
        }
    };

    $http.post(sDsURI,JSON.stringify(locObj)).success(function(response) {
     if(response['result']['rc']===0) {
 		. . .
        }
    });
};
```
