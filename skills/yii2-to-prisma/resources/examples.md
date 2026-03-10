# Yii2 to Prisma Transformation Examples

This document contains specialized examples for complex query scenarios.

## 1. Nested Joins and Conditional Selecting

**Yii2:**
```php
$data = Invoice::find()
    ->joinWith(['client', 'items.product'])
    ->where(['invoice.status' => 'paid'])
    ->andWhere(['client.type' => 'company'])
    ->select(['invoice.id', 'invoice.amount', 'client.name'])
    ->asArray()
    ->all();
```

**Prisma:**
```typescript
const data = await prisma.invoice.findMany({
  where: {
    status: 'paid',
    client: {
      type: 'company',
    },
  },
  select: {
    id: true,
    amount: true,
    client: {
      select: {
        name: true,
      },
    },
    items: {
      include: {
        product: true,
      },
    },
  },
});
```

## 2. In-place Aggregations

**Yii2:**
```php
$sum = Order::find()
    ->where(['customer_id' => $id])
    ->sum('total');
```

**Prisma:**
```typescript
const aggregations = await prisma.order.aggregate({
  where: {
    customer_id: id,
  },
  _sum: {
    total: true,
  },
});
const sum = aggregations._sum.total;
```

## 3. Complex OR and AND logic

**Yii2:**
```php
$query->where(['or', 
    ['status' => 'active'], 
    ['and', ['status' => 'pending'], ['>', 'created_at', $limit]]
]);
```

**Prisma:**
```typescript
const results = await prisma.item.findMany({
  where: {
    OR: [
      { status: 'active' },
      {
        AND: [
          { status: 'pending' },
          { created_at: { gt: limit } },
        ],
      },
    ],
  },
});
```
