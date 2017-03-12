#Osiris Binaries

This is a fork of the [labtempo/osiris-binaries](https://github.com/labtempo/osiris-binaries) original repository.
This repository contais the jars for the OSIRIS API and the OMCP Server deamons for the SensorNet and VirtualSensorNet modules.

The OSIRIS API jars are exposed as a Maven repository so one can import them into its project by
just adding the following lines into the pom.xml file:

First clone this repository into your local machine

Add the repository:
```
		<repository>
			<id>osiris-binaries</id>
			<name>osiris-binaries</name>
			<url>file://<path_to>/osiris-binaries/tree/master/api/mvn-repo</url>
		</repository>
```

Add the dependencies:
```
		<dependency>
			<groupId>br.uff.labtempo.osiris</groupId>
			<artifactId>Osiris</artifactId>
			<version>1.6.0</version>
		</dependency>

		<dependency>
			<groupId>br.uff.labtempo.osiris</groupId>
			<artifactId>OsirisUtils</artifactId>
			<version>1.6.0</version>
		</dependency>
```

The Jars version numbering are following the [Semantic Versioning](http://semver.org/) ([RFC-2119](https://tools.ietf.org/html/rfc2119))
======

## Environment

You can use Docker to configure a local environment for development purposes with the help of the following script:
```
cd <path_to>/osiris-binaries/infrastructure/development
./run.sh
```
This will raise up an localhost instance of RabbitMQ, PostgreSQL with SensorNet and VirtualSensorNet databases and the OMCP server deamons for SensorNet and VirtualSensorNet modules.

======

## Changelog

### 20151207(07/12/2015) v.1.6.0

- solved 3 bugs in VirtualSensorNet blending: in task scheduler and repeated and changed parameters.
- included link search with query strings omcp://virtualsensornet.osiris/link/?sensor={id}&collector={id}&network={id} 
- Little changes in the api

### 20151104(04/11/2015) v.1.5.0

- API update
- Bug fix in VirtualSensorNet memory comsumption and revision storage.
- Solved bug of string values.
- SensorNet not yet solved the revision storage.

### 20150722(22/07/2015) v.1.4.0

- Try to fix the bug on module initialization loop.
- Internal changes in OMCP
- Changes in some API properties
- Exchange creation of automatized form by SensorNet and VirtualSensorNet

### 20150427(09/05/2015) v.1.3.0

- Implemented history search in SensorNet and VirtualSensorNet

### 20150427(27/04/2015) v.1.2.0

- Blending working on VirtualSensorNet synchronous and asynchronously=
- Adding function module examples for blending
- Adding request example groups for VirtualSensorNet
- Changes in API
- removal of temporary queue on OMCP when requested by the client

### 20150419(19/04/2015) v.1.1.0

 - Second build of OSIRIS API jars (Osiris-20150419.jar e OsirisUtils-20150419.jar)

### 20150413(13/04/2015) v.1.0.0

 - First build of OSIRIS API jars (Osiris-20150413.jar e OsirisUtils-20150413.jar)
