[![Build Status](https://travis-ci.org/baydet/Pichi.svg?branch=master)](https://travis-ci.org/baydet/Pichi)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# Pichi

This is yet another look on the problem of mapping JSON to your app's model objects. It uses different ideas from 
 - [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)
 - [Genome](https://github.com/LoganWright/Genome)
 - [RestKit](https://github.com/RestKit/RestKit)

### Implementation details

####Map

The root part of this library is [`Map`](https://github.com/baydet/Pichi/blob/master/Pichi/Map.swift) protocol. It declares high level abstraction over JSON. This protocol allows to:
 - access children through `subscript` 
 - returns current JSON raw value with `value<T>()` method
There are also two groups of operators (for `JSONBasicConvertable` and `TransformType` protocols) which allows to interact with `Map` protocol.

####FromJSONMap
Implementation of `Map` protocol based on struct which allows transform raw JSON to your model objects using `<->` operators
 
####ToJSONMap
Implementation of `Map` protocol based on class which allows transform objects to JSON with `<->` operators.

####JSONBasicConvertable
This protocol is used for simple swift's data types (Int, String, Bool etc.)

####TransformType
This protocol is used for tranforming to/from JSON of more complex objects (NSDate, arrays, dictionarys)
