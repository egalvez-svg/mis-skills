# Yii2 Model to Prisma Conversion Examples

This document provides various scenarios for transforming Yii2 models into Prisma model definitions.

## Basic User and Profile Example

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

---

## One-to-Many Relationship

### Input: `Post.php` (Yii2)
```php
class Post extends ActiveRecord {
    public static function tableName() { return 'post'; }
    public function getAuthor() {
        return $this->hasOne(User::class, ['id' => 'author_id']);
    }
}
```

### Output: `schema.prisma`
```prisma
model Post {
  id       Int    @id @default(autoincrement())
  authorId Int    @map("author_id")
  author   User   @relation(fields: [authorId], references: [id])

  @@map("post")
}
```
