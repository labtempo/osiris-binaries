#Osiris Binaries

This is a fork of the [labtempo/osiris-binaries](https://github.com/labtempo/osiris-binaries) original repository.

This has the intent to organize the OSIRIS API jars and expose them as a open and free maven repository to the world,
so everyone can import the OSIRIS API by just adding the following lines into pom.xml:

Add this maven repository:
```
<!-- osiris-binaries repository -->
	<repositories>
		<repository>
			<id>osiris-binaries</id>
			<name>osiris-binaries</name>
			<url>https://github.com/aghigo/osiris-binaries/tree/master/API/mvn-repo</url>
		</repository>
	</repositories>
```

Add OSIRIS API jars as dependencies:
```
<dependencies>
		<!-- OSIRIS API -->
		<dependency>
			<groupId>br.uff.labtempo.osiris</groupId>
			<artifactId>Osiris</artifactId>
			<version>1.6.0</version>
		</dependency>
		<!-- OSIRIS API -->
		<dependency>
			<groupId>br.uff.labtempo.osiris</groupId>
			<artifactId>OsirisUtils</artifactId>
			<version>1.6.0</version>
		</dependency>
</dependencies>
```

Jars are versioned using [Semantic Versioning](http://semver.org/) ([RFC-2119](https://tools.ietf.org/html/rfc2119)).

======

## Changelog

### 20151207(07/12/2015) v.1.6.0

- resolvidos 3 bugs no blending do VirtualSensorNet: no agendador de tarefas, nos parâmetros repetidos e trocados
- incluído busca de link com query strings omcp://virtualsensornet.osiris/link/?sensor={id}&collector={id}&network={id}
- pequenas alterações na api 

### 20151104(04/11/2015) v.1.5.0

- atualização da API
- correção do bug do virtualsensornet no consumo de memoria e armazenamento de revisões
- descoberto bug de valores strings
- sensornet ainda não corrigido o armazenamento de revisões

### 20150722(22/07/2015) v.1.4.0

- Tentativa de sanar o bug do loop ao incializar os módulos 
- mudanças internas no omcp
- mudanças em algumas propriedades da api
- criação de exchanges de forma automatizada pelo sensornet e virtualsensornet

### 20150427(09/05/2015) v.1.3.0

- implementado a busca de histórico no SensorNet e VirtualSensorNet

### 20150427(27/04/2015) v.1.2.0

- blending funcionando no virtualsensornet síncrona e assincronamente
- adição de exemplos dos módulos de função para o blending
- adição de um grupo de exemplos de requisições para o virtualsensornet
- mudanças na api
- remoção de fila temporária no omcp quando requisitando pelo cliente 

### 20150419(19/04/2015) v.1.1.0

 - Segundo build dos jars da API do OSIRIS (Osiris-20150419.jar e OsirisUtils-20150419.jar)

### 20150413(13/04/2015) v.1.0.0

 - Primeiro build dos jars da API do OSIRIS (Osiris-20150413.jar e OsirisUtils-20150413.jar)