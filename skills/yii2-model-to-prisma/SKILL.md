---
name: yii2-model-to-prisma
description: Transforms Yii2 ActiveRecord models into Prisma Schema definitions.
author: Eduardo Galvez
---

# Yii2 Model to Prisma Schema Skill

This skill provides rules for transforming Yii2 PHP models (`ActiveRecord`) directly into Prisma model definitions (`schema.prisma`) for NestJS projects.

## Transformation Rules

### 1. Model Definition
- **Model Name**: Use the class name in `PascalCase`.
- **Table Mapping**: Use `@@map("table_name")` with the value returned by `tableName()`.

### 2. Attributes and Data Types
| PHP / DB Type | Prisma Type | Notes |
| :--- | :--- | :--- |
| `int`, `integer` | `Int` | Add `@id @default(autoincrement())` for PK. |
| `string`, `varchar`, `text` | `String` | |
| `boolean`, `tinyint(1)` | `Boolean` | |
| `decimal`, `float` | `Decimal` | |
| `datetime`, `timestamp` | `DateTime` | |

### 3. Constraints (from `rules()`)
- `required` -> Remove the `?` from the type (e.g., `String`).
- `unique` -> Add the `@unique` attribute.
- `default` -> Add `@default(value)`.

### 4. Relationships
- **hasOne**: `profile Profile?`
- **hasMany**: `posts Post[]`

See [examples.md](./resources/examples.md) for detailed transformation scenarios.
