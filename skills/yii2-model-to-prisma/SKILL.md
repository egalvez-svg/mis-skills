# Skill: Yii2 Model to Prisma Schema

This skill provides rules and examples for transforming Yii2 PHP models (`ActiveRecord`) directly into Prisma model definitions (`schema.prisma`) for NestJS projects.

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
- **hasOne**: 
  ```prisma
  profile Profile?
  ```
- **hasMany**:
  ```prisma
  posts Post[]
  ```

---

## Conversion Example

### Input: `User.php` (Yii2)
```php
class User extends ActiveRecord {
    public static function tableName() { return 'user'; }
    public function rules() {
        return [
            [['username', 'email'], 'required'],
            [['username', 'email'], 'unique'],
        ];
    }
    public function getProfile() {
        return $this->hasOne(Profile::class, ['user_id' => 'id']);
    }
}
```

### Output: `schema.prisma`
```prisma
model User {
  id       Int      @id @default(autoincrement())
  username String   @unique
  email    String   @unique
  profile  Profile?

  @@map("user")
}
```
