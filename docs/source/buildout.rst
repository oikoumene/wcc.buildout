Buildout
==========

The instances and the zeoserver are installed through zc.buildout. It is an
automated builder tool which builds a self-contained Python environment for
running the Zope/Plone services. 

Buildout downloads the eggs from pypi, install them into the directory and
generate any necessary scripts defined by the eggs and the buildout recipes.

For more info on buildout, load https://pypi.python.org/pypi/zc.buildout/


Deployment
----------

To deploy the Plone infrastructure to a directory, just run these commands::

  cd /some/path/
  git clone http://dev.inigo-tech.com/git/wcc.buildout.git
  cd wcc.buildout/
  cp site.cfg.sample site.cfg
  python2.6 bootstrap.py 
  ./bin/buildout -vv -c deployment.cfg

.. note::

   Site specific configuration can be edited in site.cfg

.. note::
    
   Python 2.6 is recommended, but it should also work with Python 2.7.

The commands above will build the buildout and generate the necessary scripts
to start the services.

Scripts
-------

.. warning::

    Due to how buildout replaces the scripts whenever it is run, the 'restart'
    command on ``zeoserver`` and ``instance`` is only usable if 
    ``./bin/buildout``  was not ran after the services have started. If you
    want to restart the services after running ``./bin/buildout``, use the 
    'stop' and 'start' commands instead, else things might behave weirdly 
    afterwards.

``./bin/zeoserver``
    This is the control script to start and stop the ZEO service. 

    Starting::
       
        ./bin/zeoserver start

    Stopping::

        ./bin/zeoserver stop

    Restarting::

        ./bin/zeoserver restart

``./bin/instance{,2,3,4}``
    These are the control scripts to start and stop the Zope instances

    Starting::

        ./bin/instance start

    Stopping::

        ./bin/instance stop

    Restarting::

        ./bin/zeoserver restart

``./bin/munin{,2,3,4}``
    These are the monitoring hooks for Munin. To integrate, refer to
    https://pypi.python.org/pypi/munin.zope/

``./bin/zeopack``
    ZODB keeps old write transactions around to allow undoing. However, this 
    will mean, after a period of time, the ZODB database might grow to be quite
    big. Use this command to pack the database and remove transactions older 
    than 30 days.

``./bin/repozo``
    This is a script to help with incremental backup of the ZODB. Check out 
    the ``--help`` parameter for documentation
