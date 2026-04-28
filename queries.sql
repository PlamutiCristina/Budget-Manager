-- 1. Display all expenses greater than 500 RON
SELECT * FROM cheltuieli
WHERE suma > 500;
 
-- 2. Display income from 'Salariu' (Salary) or 'Chirie' (Rent) categories
SELECT v.id_venit, u.nume, u.prenume, c.denumire, v.suma
FROM venituri v
JOIN utilizatori u ON v.id_utilizator = u.id_utilizator
JOIN categorii c ON v.id_categorie = c.id_categorie
WHERE c.denumire IN ('Salariu','Chirie');
 
-- 3. Total expenses per user, filtering those with total spending over 1000
SELECT u.nume, u.prenume, SUM(ch.suma) AS total_cheltuieli
FROM cheltuieli ch
JOIN utilizatori u ON ch.id_utilizator = u.id_utilizator
GROUP BY u.nume, u.prenume
HAVING SUM(ch.suma) > 1000;
 
-- 4. Incomes recorded in the last 25 days
SELECT *
FROM venituri
WHERE data_venit BETWEEN SYSDATE - 25 AND SYSDATE;
 
-- 5. Sum of expenses grouped by category, including categories with no expenses
SELECT c.denumire, NVL(SUM(ch.suma),0) AS suma_totala
FROM categorii c
LEFT JOIN cheltuieli ch ON c.id_categorie = ch.id_categorie
GROUP BY c.denumire;
 
-- 6. Total income per user with classification using CASE
SELECT u.nume, u.prenume, SUM(v.suma) AS total_venit,
       CASE 
           WHEN SUM(v.suma) > 2200 THEN 'Bine'
           ELSE 'Normal'
       END AS clasificare
FROM venituri v
JOIN utilizatori u ON v.id_utilizator = u.id_utilizator
GROUP BY u.nume, u.prenume;
 
-- 7. Sum of expenses by category, using DECODE to rename 'Mancare' to 'Alimente'
SELECT DECODE(c.denumire, 'Mancare', 'Alimente', c.denumire) AS categorie,
       SUM(ch.suma) AS total_cheltuieli
FROM cheltuieli ch
JOIN categorii c ON ch.id_categorie = c.id_categorie
GROUP BY DECODE(c.denumire, 'Mancare', 'Alimente', c.denumire); 

-- 8. Incomes for users who have total expenses greater than 1000
SELECT v.*
FROM venituri v
WHERE v.id_utilizator IN (
    SELECT id_utilizator
    FROM cheltuieli
    GROUP BY id_utilizator
    HAVING SUM(suma) > 1000
);
 
-- 9. Categories with income but no recorded expenses
SELECT DISTINCT id_categorie FROM venituri
MINUS
SELECT DISTINCT id_categorie FROM cheltuieli;
 
-- 10. Combine all records from income and expenses (Union of all unique entries)
SELECT DISTINCT * FROM venituri
UNION
SELECT DISTINCT * FROM cheltuieli;
 
-- 11. Incomes with formatted dates and extracted month
SELECT id_venit, id_utilizator, id_categorie,
      TO_CHAR(data_venit,'DD-MON-YYYY') AS data_formatata,
       EXTRACT(MONTH FROM data_venit) AS luna
FROM venituri; 

-- 12. Users with income higher than the average of all recorded incomes
SELECT u.nume, u.prenume, v.suma
FROM venituri v
JOIN utilizatori u ON v.id_utilizator = u.id_utilizator
WHERE v.suma > (SELECT AVG(suma) FROM venituri);
 
-- 13. Create an index on the expense amount for performance optimization
CREATE INDEX idx_chelt_suma ON cheltuieli(suma);
 
-- 14. Create or update a view for high incomes (over 2200)
CREATE OR REPLACE VIEW venituri_mari AS
SELECT *
FROM venituri
WHERE suma > 2200;
SELECT * FROM venituri_mari;
 
-- 15. Total expenses, count of transactions, and days elapsed since the oldest expense per user
SELECT u.nume, u.prenume,
       SUM(ch.suma) AS total_cheltuieli,
      COUNT(ch.data_cheltuiala) AS zile_cu_cheltuieli,
       TRUNC(SYSDATE - MIN(ch.data_cheltuiala)) AS zile_de_la_cea_mai_veche_cheltuiala
FROM cheltuieli ch
JOIN utilizatori u ON ch.id_utilizator = u.id_utilizator
GROUP BY u.nume, u.prenume; 

-- 16. The first expense for each user and its corresponding category
SELECT u.nume,
       u.prenume,
       c.denumire AS categorie,
      ch.data_cheltuiala,
       ch.suma
FROM cheltuieli ch
JOIN utilizatori u ON u.id_utilizator = ch.id_utilizator
JOIN categorii c ON c.id_categorie = ch.id_categorie
WHERE ch.data_cheltuiala = (
    SELECT MIN(ch2.data_cheltuiala)
    FROM cheltuieli ch2
    WHERE ch2.id_utilizator = ch.id_utilizator
); 

-- 17. Users whose last name starts with 'P' and have expenses recorded in December
SELECT DISTINCT u.nume, u.prenume
FROM utilizatori u
JOIN cheltuieli ch ON ch.id_utilizator = u.id_utilizator
WHERE u.nume LIKE 'P%'
 AND EXTRACT(MONTH FROM ch.data_cheltuiala) = 12;
 
-- 18. Display the first 3 letters of each user's last name
SELECT nume, SUBSTR(prenume, 1, 3) AS primele_3_litere 
FROM utilizatori;
