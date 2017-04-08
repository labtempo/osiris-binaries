## Osiris Binaries

* This is a fork of the [labtempo/osiris-binaries](https://github.com/labtempo/osiris-binaries) original repository.
* Contais the jars of the OSIRIS API (Osiris and OsirisUtils) exposed as a Maven artifacts to ease the project dependency import.
* Contais the binaries of the OMCP Server deamons for the SensorNet and VirtualSensorNet modules.
* Contains the infrastructure folder with scripts that helps the deployment of the OSIRIS database (PostgreSQL), Queue (RabbitMQ) and OMCP Servers - required to use the framework - in development/staging/production environments.

## Using the OSIRIS API as Maven dependency

The OSIRIS API jars now are exposed as a Maven repository so one can import the library into its project by
just adding the following lines into the respective pom.xml file:

First clone this repository into your local machine
```
cd ~
mkdir osiris
cd ~/osiris
git clone https://github.com/aghigo/osiris-binaries
```

Then add the repository into pom.xml:
```
		<repository>
			<id>osiris-binaries</id>
			<name>osiris-binaries</name>
			<url>file://<local_path_to>/osiris-binaries/api/mvn-repo</url>
		</repository>
```

Add the dependencies into pom.xml:
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
Finally, install the dependencies into your local maven repository (~/.m2 folder):
```
cd <path_to_your_java_project_pom_xml_folder>/
mvn clean install -U
```
Jars versioning based on [Semantic Versioning](http://semver.org/) specification ([RFC-2119](https://tools.ietf.org/html/rfc2119))

## Local Development environment setup (Ubuntu 16.04 64-bit)

You can setup a local environment to run and use the OSIRIS framework, with all containers running in the same host by just running a single script:

```
cd osiris-binaries/infrastructure
sudo ./run.sh
```

## Distributed Staging/Production environment setup (Ubuntu 16.04 64-bit)

You can set up a distributed environment for OSIRIS Framework.
For production purposes, where each container (RabbitMQ, SensorNet database, SensorNet OMCP, VirtualSensorNet database, VirtualSensorNet OMCP) should run on separatedly hosts.

Please do the following steps in the presented order:

If you don't have Docker installed (do that on all hosts):
```
cd osiris-binaries/infrastructure
. ./install_docker.sh
```

If you don't have PostgreSQL Client (psql) installed (do that on the SensorNet and VirtualSensorNet database hosts):
```
cd osiris-binaries/infrastructure
. ./install_postgresql_client.sh
```

RabbitMQ:
```
cd osiris-binaries/infrastructure/rabbitmq
make build
make run
```

SensorNet database (PostgreSQL)
```
cd osiris-binaries/infrastructure/sensornet-postgresql
make run
```

SensorNet OMCP Server (Provide the RabbitMQ and SensorNet database IP addresses when asked)
```
cd osiris-binaries/infrastructure/sensornet-omcp
make config
make build
make run
```
VirtualSensorNet database (PostgreSQL)
```
cd osiris-binaries/infrastructure/virtualsensornet-postgresql
make run
```
VirtualSensorNet OMCP Server (Provide the RabbitMQ and VirtualSensorNet database IP addresses when asked)
```
cd osiris-binaries/infrastructure/virtualsensornet-omcp
make config
make build
make run
```

## Binaries Changelog

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

## About

This is part of the Undergraduate Thesis for the Bachelor of [Computer Information Systems](http://www.ic.uff.br/index.php/en-GB/) course at [Universidade Federal Fluminense](http://uff.br/),
Which consists in creating a user-friendly Web Interface the manage the [OSIRIS framework](https://github.com/labtempo/osiris/wiki) modules: ([SensorNet](https://github.com/labtempo/osiris/wiki/2.1-M%C3%B3dulo-SensorNet) and [VirtualSensorNet](https://github.com/labtempo/osiris/wiki/2.2-M%C3%B3dulo-VirtualSensorNet)).

## Authors

* [Andre Ghigo](https://github.com/aghigo)
* [Felippe Mauricio](https://github.com/felippemauricio)

## Credits
* [Raphael Guerra](http://www2.ic.uff.br/~rguerra/), Professor.
* [Felipe Ralph](https://github.com/println), creator of the [OSIRIS Framework](https://github.com/labtempo/osiris/wiki).
