Error codes
===========

Error codes are always output as a negative number during database operation. The list below shows a selection of the most common mistakes. This and the described configurations make it possible to localize and correct errors.

    0     DSV_OK                 =>  everything ok

    -1    DSV_ERROR              =>  fatal error;
                                     possibly system/disk error

    -1010 DSV_LICENSE_ERROR      =>  license error; wrong license installed

    -1011 DSV_STDID_ERROR        =>  occurs in connection with slave databases when using a wrong license

    -900  DSV_PARAMERROR         =>  error while passing the parameters during the software development

    -902  DSV_NOCTXCLHANDLE      =>  access by invalid handle access with old session handle

    -905  DSV_LOGIN_ERROR        =>  login-error; various reasons
                                     possibly wrong user; password 

    -909  DSV_LOGIN_USERNOTFOUND =>  user account not available

    -911  DSV_LOGIN_PWERROR      =>  during the user login an incorrect password was entered

    -915  DSV_LOGIN_KEYERR       =>  an error has occurred in the key when using the public/private key procedure for user login

    -916  DSV_BASE_NOTOPEN       =>  traffic light on yellow or red

    -918  DSV_LOCKED             =>  server locks could not be resolved

    -919  DSV_SELFLOCKED         =>  see „-918“

    -921  DSV_LOGIN_PHPAPPNOPERM =>  there is no user "php" in the database and/or it has no php rights

    -922  DSV_LOGIN_APPNOPERM    =>  the user account has no rights for the called database function or extension

    -923  DSV_LOGIN_ALLWAYSLOGIN =>  another login attempt using an already logged in user account

    -924  DSV_LOGIN_LICTIMEOVER  =>  the license date has been exceeded, the license is no longer valid

    -925  DSV_LICENSE_OVERLOAD   =>  when importing a license, fewer user rights were activated than previously assigned

!!! note "Note"
	If critical errors occur and the server therefore automatically switches to "Stop", the database support is to be involved immediately.

Error codes when using a suggest file
-----------------------------------------------

The error codes when using a "Suggest" file refer to the access to the source file for the automatic completion of inputs while using the CortexUniplex application. This source file must be stored in the server directory (the path is specified in the configuration) and configured in the configuration of a record type.

    -1201    DSV_SUGG_FILEREADERROR => File cannot be read
    -1203    DSV_SUGG_FILEOPENERROR => File cannot be opened
    -1206    DSV_SUGG_SYNNOTFOUND   => Field was not found in source file
    -1208    DSV_SUGG_VERSIONERROR  => the wrong file version is used

If these or similar errors occur, starting with "DSV_SUGG ...", please contact the database support immediately, as the basic settings and/or the generated file are incorrect.
