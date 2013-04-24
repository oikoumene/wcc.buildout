Data Storage
============

Generally, all data are stored in the ``var`` directory of the buildout. So, if
you are backing up the data, copying the whole ``var`` directory would be best
as it usually would be immediately reusable in a new buildout on another
server.

ZODB Related Storage Directories
--------------------------------

``./var/filestorage``
    This stores the Data.fs file of ZODB. Data.fs is pretty much the whole
    database contents, except files attachments, which are stored as BLOBs in
    blobstorage

``./var/blobstorage``
    This stores the BLOB contents of ZODB.

``./var/blobcache``
    Zope instances will cache BLOBs queried from the ZEO server here. While
    this is just a cache, it is still recommended to include it together when
    copying the ``var`` directory as the Zope instances might still be trying
    to find the cache.

Logs
----

``./var/log/instance{,2,3,4}.log``
    These are the process logs of the instances. Any tracebacks / alerts are
    outputed into these logs

``./var/log/instance{,2,3,4}-Z2.log``
    These are the HTTP access logs on requests that hit the instances

``./var/log/zeoserver.log``
    This is the ZEO server process log. Usually theres nothing much in here
    unless something went terribly wrong with the ZEO server.


