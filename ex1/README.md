# Greenmask config example

## Version

This example was prepared for a hackernoon article about Greenmask. It shows how to use Greenmask to create a simple
configuration file for a simple project. It
uses [dynamic parameters](https://greenmask.io/v0.2beta1/built_in_transformers/dynamic_parameters/) for resolving
functional dependencies between
columns. [And deterministic transformations](https://greenmask.io/v0.2beta1/built_in_transformers/transformation_engines/)
based on the `hash` engine for transforming PK and FK columns.

This config build for [greenmask v0.2.0b release](https://github.com/GreenmaskIO/greenmask/releases/tag/v0.2.0b1) and
PostgreSQL 16

## How to run

1. Run greenmask container

`docker-compose run greenmask`

2. Run validate command to check the result

`greenmask --config config.yml validate`

### Warning

The FK and PK transformation provided is just an example. Although they work, they cannot guarantee uniqueness. We have
a work-in-progress feature request related to
the [unique transformations feature](https://github.com/GreenmaskIO/greenmask/issues/111).
