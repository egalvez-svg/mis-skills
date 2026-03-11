# Skill: Yii2 Model to Prisma Schema

This skill provides a systematic approach to transforming Yii2 `ActiveRecord` models into Prisma Schema definitions for NestJS projects.

## Overview
Instead of relying solely on database introspection, this skill helps you preserve the logic, relations, and metadata already defined in your PHP models.

## How to use
1. Open a Yii2 model file (`.php`).
2. Use the rules defined in [SKILL.md](./SKILL.md) to map:
    - Tables and Models.
    - Data Types.
    - Relationships (`hasOne`, `hasMany`).
    - Constraints (`unique`, `required`, `default`).

## Installation
To install this skill in your local Antigravity environment, run the provided `install.ps1` script:

```powershell
.\install.ps1
```

## Authors
- Developed by: Eduardo Galvez
- Purpose: Streamlining Yii2 to NestJS migrations.
