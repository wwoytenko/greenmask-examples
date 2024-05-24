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

## Transformation config

```yaml
  transformation: # List of tables to transform
    - schema: "public"
      name: "account"
      transformers:
        - name: "RandomInt"
          params:
            column: "id"
            engine: hash
            min: 1
            max: 100

        - name: "RandomChoice"
          params:
            column: "gender"
            values:
              - "M"
              - "F"

        - name: "RandomPerson"
          params:
            columns:
              - name: "first_name"
                template: "{{ .FirstName }}"
              - name: "last_name"
                template: "{{ .LastName }}"
          dynamic_params:
            gender:
              column: gender

        - name: "RandomEmail"
          params:
            column: "email"
            engine: "hash"
            keep_original_domain: true
            keep_null: false
            local_part_template: "{{ first_name | lower }}.{{ last_name | lower }}"

        - name: "RandomDate"
          params:
            column: "birth_date"
            min: '{{ now | tsModify "-30 years" | .EncodeValue }}' # 1994
            max: '{{ now | tsModify "-18 years" | .EncodeValue }}' # 2006

        - name: "RandomDate"
          params:
            column: "created_at"
            max: "{{ now | .EncodeValue }}"
            truncate: "day"
          dynamic_params:
            min:
              column: "birth_date"
              template: '{{ .GetValue | tsModify "18 years" | .EncodeValue }}'

    - schema: "public"
      name: "orders"
      transformers:

        - name: "RandomInt"
          params:
            column: "account_id"
            engine: hash
            min: 1
            max: 100
        #            max: 2147483647

        - name: "NoiseNumeric"
          params:
            column: "total_price"
            decimal: 2
            min_ratio: 0.1
            max_ratio: 0.9

        - name: "NoiseDate"
          params:
            column: "created_at"
            max_ratio: "6 day"
            min_ratio: "1 day"
            truncate: "day"

        - name: "RandomDate"
          params:
            column: "paid_at"
            max: '{{ now | .EncodeValue }}'
            truncate: "day"
          dynamic_params:
            min:
              column: "created_at"
```

## How to run

1. Run greenmask container

`docker-compose run greenmask`

2. Run validate command to check the result

`greenmask --config config.yml validate`

### Warning

The FK and PK transformation provided is just an example. Although they work, they cannot guarantee uniqueness. We have
a work-in-progress feature request related to
the [unique transformations feature](https://github.com/GreenmaskIO/greenmask/issues/111).
