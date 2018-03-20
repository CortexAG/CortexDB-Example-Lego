Python-examples
================

Similar to the PHP examples, you get here the same functions based on Python.

Via the individual menu items you can access the respective contents and
compare them with the PHP examples.

Portal Query
-------------

Analogous to the PHP example for the portal query, it is used with the
help of Python.

``` 
import urllib2
import json


###  url to call the CortexUniplexAPI in the right database
url = "http://localhost/i/UniPlexDataservice/updjsr.php"

### Request-ID to identitfy the right returned json object
requestID = 1

### Begin: User-Handle

### Setting headers for CortexUniplexAPI
headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
}

### data object to request the user login for the CortexUniplexAPI
data = { 
    "method" :  "getLogin",
    "requestid" : requestID,
    "param" : {
        "user": 'admin',
        "pass": "admin",
        "app": "UniplexDataservice"
    }
}

# Build POST data
postdata = json.dumps(data).encode()

# Create request object
req = urllib2.Request(url, postdata, headers)

# Send request
f = urllib2.urlopen(req)
ret = json.loads(f.read())

UsrHdl = ret['result']['data']['UpdJsrHdl']

### End: User-Handle

### Begin: portal call

data = { 
    "method" :  "getPortalRows",
    "requestid" : requestID,
    "param" : {
        "portal": 'Training-simple',
        "UpdJsrHdl": UsrHdl
    }
}

postdata = json.dumps(data).encode()
req = urllib2.Request(url, postdata, headers)

f = urllib2.urlopen(req)
ret = json.loads(f.read())

### End: portal call

### print result
print ret
``` 


Portal List
-----------

``` 
import urllib2
import json


###  url to call the CortexUniplexAPI in the right database
url = "http://localhost/i/UniPlexDataservice/updjsr.php"

### Request-ID to identitfy the right returned json object
requestID = 1

### Begin: User-Handle

### Setting headers for CortexUniplexAPI
headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
}

### data object to request the user login for the CortexUniplexAPI
data = { 
    "method" :  "getLogin",
    "requestid" : requestID,
    "param" : {
        "user": 'admin',
        "pass": "admin",
        "app": "UniplexDataservice"
    }
}

# Build POST data
postdata = json.dumps(data).encode()

# Create request object
req = urllib2.Request(url, postdata, headers)

# Send request
f = urllib2.urlopen(req)
ret = json.loads(f.read())

UsrHdl = ret['result']['data']['UpdJsrHdl']

### End: User-Handle

### Begin: portal list call

data = { 
    "method" :  "getPortalRowListData",
    "requestid" : requestID,
    "param" : {
        "portal": 'Training-simple',
        "UpdJsrHdl": UsrHdl,
        "group": "Parts",
        "row": "Types"
    }
}

postdata = json.dumps(data).encode()
req = urllib2.Request(url, postdata, headers)

f = urllib2.urlopen(req)
ret = json.loads(f.read())

### End: portal list call

### print result
print ret
``` 

Python example with class
--------------------------

``` 
'''
A Python library for working with CortexUniplexAPI

'''
import functools
import json
import logging
import os
import urllib
import urllib2
import urlparse

logger = logging.getLogger(__name__)

class UniPlexDataserviceException(Exception): pass

class UniPlexDataservice(object):
    '''

    '''
    def __init__(self, api_url):
        '''

        '''
        self.api_url = api_url
        self.auth = ''
        self.requestid = 1

    def req(self, data=None):
        '''
        A thin wrapper around urllib2 to send requests and return the response

        If the current instance contains an authentication token it will be
        attached to the request as a custom header.

        :rtype: dictionary

        '''
        headers = {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }

        handler=urllib2.HTTPHandler(debuglevel=0)
        opener = urllib2.build_opener(handler)
        urllib2.install_opener(opener)

        # Build POST data
        if data != None:
            postdata = json.dumps(data).encode()

        # Create request object
        req = urllib2.Request(self.api_url, postdata, headers)

        # Send request
        try:
            f = urllib2.urlopen(req)
            ret = json.loads(f.read())
        except (urllib2.HTTPError, urllib2.URLError) as e:
            logger.debug('Error with request ' + str(e), exc_info=True)
            ret = 
        except AttributeError:
            logger.debug('Error converting response from JSON', exc_info=True)
            ret = 

        return ret

    def getInfo(self):
        data = { 
          "method" :  "getInfo",
          "requestid" : 1,
          "param" : {"UpdJsrHdl": self.auth
          }
        }

        returns = self.req(data)
        if returns['requesterror'] == 0:
            print 'getInfo succes'
            
        return returns


    def login(self, user, password):
        '''
        TODO : requestid
        '''

        data = { 
          "method" :  "getLogin",
          "requestid" : self.getRequestID(),
          "param" : {"user": user,
          "pass": password,
          "app": "UniplexDataservice"
          }
        }

        returns = self.req(data)
        if returns['requesterror'] == 0:
            # print 'Login succes'
            self.auth = returns['result']['data']['UpdJsrHdl']
        return self.auth

    def logout(self):
        '''
        TODO : requestid
        '''

        data = { 
          "method" :  "getLogout",
          "requestid" : self.getRequestID(),
          "param" : 
        }

        returns = self.req(data)
        if returns['requesterror'] == 0:
            # print 'Logout succes'
            self.auth = ''
        # print returns
        return self.auth

    def clearCache(self):
        pass

    def getRequestID(self):
        self.requestid += 1
        return self.requestid

    def getPortalList(self):
        '''
        TODO : requestid
        '''

        data = { 
          "method" :  "getPortalList",
          "requestid" : self.getRequestID(),
          "param" : 
        }

        returns = self.req(data)
        # if returns['requesterror'] == 0:
        #     print 'Get Portal list  success'
        # for lists in returns['result']['data']:
        #     print lists['n']
        return returns


    def getPortalRows(self, portaliid):
        '''
        TODO : requestid
        '''

        data = { 
          "method" :  "getPortalRows",
          "requestid" : self.getRequestID(),
          "param" : {"UpdJsrHdl": self.auth,
          "portaliid": portaliid}
        }

        returns = self.req(data)
        # if returns['requesterror'] == 0:
        #     print 'Get Portal rows succes'
        return returns

    def getPortalResult(self, portaliid):

        data = { 
          "method" :  "getPortalResult",
          "requestid" : self.getRequestID(),
          "param" : {"UpdJsrHdl": self.auth,
          "portaliid": portaliid}
        }

        returns = self.req(data)
        # if returns['requesterror'] == 0:
        #     print 'Get Portal rows succes'
        return returns


    def getPortalRowData(self, portaliid, rownr):

        data = { 
          "method" :  "getPortalRowData",
          "requestid" : self.getRequestID(),
          "param": {"UpdJsrHdl": self.auth,
          "portaliid": portaliid,
          "rownr": rownr
          }
        }

        returns = self.req(data)
        # if returns['requesterror'] == 0:
        #     print 'Get Portal rows succes'
        return returns
``` 

### Python-Script (based on Class):

``` 
from dataservice import UniPlexDataservice
import pprint

### Instantiate the connector to UniplexDataService class
connector = UniPlexDataservice('http://localhost/i/UniPlexDataservice/updjsr.php')

### Call the login method so we obtain the UpdJsrHdl handler
connector.login('admin', 'admin')

### get the Portal list
portalList = connector.getPortalList()['result']['data']


### Create a dictionary so we can store all found portals
portalListDict = 
i = 0


### We store the name('n') and the id('i') of each portal 
### so we can access them later
for item in portalList:
    portalListDict[i] = 
    portalListDict[i]['i'] = item['i'].encode('utf-8')
    portalListDict[i]['n'] = item['n'].encode('utf-8')
    i += 1

### Get Portal Rows (of first portal)
portalRows = connector.getPortalRows(portalListDict[1]['i'])['result']['data']

### print Portal Rows
pprint.pprint(portalRows)

connector.logout()
``` 

