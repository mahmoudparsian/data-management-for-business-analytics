# Student Exercises — WHERE vs HAVING

Use the `sales` table:

```sql
CREATE TABLE sales (
  id INT PRIMARY KEY,
  product VARCHAR(30),
  country VARCHAR(20),
  quantity INT,
  price DECIMAL(10,2),
  sale_date DATE
);
```

(Assume there are multiple rows for products across USA, Canada, Germany, etc.)

---

## Part A — WHERE (Rows)

1) Show all sales from **USA**.  
2) Show all rows where **price > 20**.  
3) Show sales made in **2024** only. *(Hint: `YEAR(sale_date)`)*  
4) Show rows for **product = 'Notebook'** and **quantity >= 5**.

---

## Part B — HAVING (Groups)

5) For each **product**, show **total quantity** sold.  
6) Show **products** whose **total quantity** sold is **> 10**.  
7) Show **countries** whose **total revenue** *(SUM(quantity*price))* is **>= 300**.  
8) Show **products** whose **average price** is **between 5 and 50**.

---

## Part C — WHERE + HAVING Together

9) For **Germany** only, show **products** where total quantity **>= 3**.  
10) For **2024** only, show **countries** whose total revenue **> 500**.
