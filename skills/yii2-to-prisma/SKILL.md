---
name: yii2-to-prisma
description: Transforms Yii2 Active Record and Query Builder queries into Prisma Client syntax.
author: Eduardo Galvez
---

# Yii2 to Prisma Transformation Skill

This skill provides a systematic approach to convert PHP Yii2 database queries into TypeScript/JavaScript Prisma Client queries.

## Query Syntax Mapping

### 1. Basic Operations

| Yii2 (PHP) | Prisma (TypeScript) | Comment |
| :--- | :--- | :--- |
| `User::find()` | `prisma.user.findMany()` | Basic multi-row fetch |
| `User::findOne($id)` | `prisma.user.findUnique({ where: { id: $id } })` | Fetch by ID |
| `User::find()->count()` | `prisma.user.count()` | Count |
| `User::find()->exists()` | `prisma.user.findFirst({ select: { id: true } }) !== null` | Existence check |

### 2. Filters (where)

| Yii2 | Prisma |
| :--- | :--- |
| `->where(['id' => 1])` | `where: { id: 1 }` |
| `->andWhere(['status' => 1])` | `where: { AND: [ { status: 1 } ] }` (or just merge if simple) |
| `->orWhere(['status' => 1])` | `where: { OR: [ { status: 1 } ] }` |
| `->where(['>', 'age', 18])` | `where: { age: { gt: 18 } }` |
| `->where(['in', 'id', [1, 2]])` | `where: { id: { in: [1, 2] } }` |
| `->where(['like', 'name', 'john'])` | `where: { name: { contains: 'john', mode: 'insensitive' } }` |

### 3. Relations

| Yii2 | Prisma |
| :--- | :--- |
| `->joinWith('profile')` | `include: { profile: true }` |
| `->with(['posts', 'comments'])` | `include: { posts: true, comments: true }` |
| `->select(['id', 'email'])` | `select: { id: true, email: true }` |

### 4. Pagination and Sorting

| Yii2 | Prisma |
| :--- | :--- |
| `->orderBy('created_at DESC')` | `orderBy: { created_at: 'desc' }` |
| `->limit(10)` | `take: 10` |
| `->offset(20)` | `skip: 20` |

## Transformation Rules

1. **CamelCase Conversion**: Ensure that field names in Yii2 (often snake_case) are mapped correctly to the Prisma schema (often camelCase).
2. **Boolean Mapping**: Yii2 often uses `0` and `1` for booleans. Prisma uses `true` and `false`.
3. **Date Handling**: Yii2 might use Unix timestamps or SQL dates. Prisma uses JS `Date` objects.
4. **Nested Relations**: Yii2 `joinWith` can be nested using dot notation (`->joinWith('a.b')`). Prisma uses nested `include`.

## Examples

### Complex Query

**Yii2:**
```php
$results = Product::find()
    ->select(['id', 'name', 'price'])
    ->joinWith('category')
    ->where(['category.slug' => 'electronics'])
    ->andWhere(['>', 'price', 100])
    ->orderBy('price DESC')
    ->limit(5)
    ->all();
```

**Prisma:**
```typescript
const results = await prisma.product.findMany({
  select: {
    id: true,
    name: true,
    price: true,
    category: true, // Assuming relation exists
  },
  where: {
    category: {
      slug: 'electronics',
    },
    price: {
      gt: 100,
    },
  },
  orderBy: {
    price: 'desc',
  },
  take: 5,
});
```
