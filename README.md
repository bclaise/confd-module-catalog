# confd-module-catalog

An example implementation of the [draft-openconfig-netmod-model-catalog](https://tools.ietf.org/html/draft-openconfig-netmod-model-catalog-00) using the Tail-f/Cisco [ConfD](http://www.tail-f.com/management-agent/) management agent.

You need a locally installed ConfD with appropriate northbound APIs (e.g. NETCONF, REST) enabled in the configuration. Start by sourcing the `confdrc` file in the top level ConfD installation into your environment:

```
$ source ./confdrc
```

Then use the `Makefile` in this repository to `start`, `stop` ConfD as well as to `clean` out the environment and rebuild `all`, e.g.:

```
$ make all start
```

This should give you a running instance of ConfD with the catalog YANG modules loaded. You can now use the REST interface to query, update and delete data in the catalog. E.g. the following will put some initial data (pulled from the IANA [YANG Parameters](http://www.iana.org/assignments/yang-parameters/yang-parameters.xhtml) repository) into the running server for you to play with:

```
$ curl -u admin:admin -T initial.xml -X POST http://127.0.0.1:8008/api/config/organizations
```

You can now query the server for content, like:

```
$ curl -u admin:admin http://127.0.0.1:8008/api/config/organizations?deep
```

To stop ConfD and reset the environment (clean the database):

```
$ make stop clean
```