# Homework 10 - Optimization 2

By: Lorenzo Cesconetto 

---

## 1. Why are negative numbers more expensive to store than positive numbers?

---

Negative numbers representation in binary consist of mostly ones. Since  bits are zero by default, the machine has to flip many more bits than when dealing with positive numbers. 

---
## 2. Test the following statements in Remix, which is cheaper and why?

```
result = numerator / demoninator;
```

```
assembly {
  result := div(numerator, demoninator)
}
```
---

The second (assembly) is cheaper because it skips the zero division check.
