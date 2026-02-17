CREATE TABLE utilizatori (
    id_utilizator NUMBER(6) PRIMARY KEY,
    nume VARCHAR2(50) NOT NULL,
    prenume VARCHAR2(50) NOT NULL
);

CREATE TABLE categorii (
    id_categorie NUMBER(6) PRIMARY KEY,
    denumire VARCHAR2(50) NOT NULL
);


CREATE TABLE venituri (
    id_venit NUMBER(6) PRIMARY KEY,
    id_utilizator NUMBER(6) NOT NULL,
    id_categorie NUMBER(6) NOT NULL,
    data_venit DATE NOT NULL,
    suma NUMBER(10,2) CHECK (suma > 0),
    CONSTRAINT fk_venit_utilizator FOREIGN KEY (id_utilizator)
        REFERENCES utilizatori(id_utilizator),
    CONSTRAINT fk_venit_categorie FOREIGN KEY (id_categorie)
        REFERENCES categorii(id_categorie)
);

CREATE TABLE cheltuieli (
    id_cheltuiala NUMBER(6) PRIMARY KEY,
    id_utilizator NUMBER(6) NOT NULL,
    id_categorie NUMBER(6) NOT NULL,
    data_cheltuiala DATE NOT NULL,
    suma NUMBER(10,2) CHECK (suma > 0),
    CONSTRAINT fk_chelt_utilizator FOREIGN KEY (id_utilizator)
        REFERENCES utilizatori(id_utilizator),
    CONSTRAINT fk_chelt_categorie FOREIGN KEY (id_categorie)
        REFERENCES categorii(id_categorie)
);

CREATE SEQUENCE seq_utilizatori START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_categorii START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_venituri START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_cheltuieli START WITH 1 INCREMENT BY 1;


INSERT INTO utilizatori (id_utilizator, nume, prenume)
VALUES (seq_utilizatori.NEXTVAL, 'Plamuti', 'Elena-Cristina');

INSERT INTO utilizatori (id_utilizator, nume, prenume)
VALUES (seq_utilizatori.NEXTVAL, 'Popescu', 'Maria');

INSERT INTO utilizatori (id_utilizator, nume, prenume)
VALUES (seq_utilizatori.NEXTVAL, 'Ionescu', 'Mihaela');

INSERT INTO categorii (id_categorie, denumire)
VALUES (seq_categorii.NEXTVAL, 'Salariu');

INSERT INTO categorii (id_categorie, denumire)
VALUES (seq_categorii.NEXTVAL, 'Chirie');

INSERT INTO categorii (id_categorie, denumire)
VALUES (seq_categorii.NEXTVAL, 'Transport');

INSERT INTO categorii (id_categorie, denumire)
VALUES (seq_categorii.NEXTVAL, 'Mancare');

INSERT INTO categorii (id_categorie, denumire)
VALUES (seq_categorii.NEXTVAL, 'Facturi');

INSERT INTO venituri (id_venit, id_utilizator, id_categorie, data_venit, suma)
VALUES (seq_venituri.NEXTVAL, 1, 1, TO_DATE('2025-12-01','YYYY-MM-DD'), 2500);

INSERT INTO venituri (id_venit, id_utilizator, id_categorie, data_venit, suma)
VALUES (seq_venituri.NEXTVAL, 2, 1, TO_DATE('2025-12-05','YYYY-MM-DD'), 2000);

INSERT INTO venituri (id_venit, id_utilizator, id_categorie, data_venit, suma)
VALUES (seq_venituri.NEXTVAL, 3, 1, TO_DATE('2025-12-07','YYYY-MM-DD'), 2200);

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 1, 2, TO_DATE('2025-12-02','YYYY-MM-DD'), 1200); 

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 1, 3, TO_DATE('2025-12-03','YYYY-MM-DD'), 150); 

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 1, 4, TO_DATE('2025-12-04','YYYY-MM-DD'), 600);

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 1, 5, TO_DATE('2025-12-05','YYYY-MM-DD'), 120); 

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 2, 2, TO_DATE('2025-12-02','YYYY-MM-DD'), 700); 

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 2, 3, TO_DATE('2025-12-03','YYYY-MM-DD'), 180); 

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 2, 4, TO_DATE('2025-12-04','YYYY-MM-DD'), 500); 

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 2, 5, TO_DATE('2025-12-05','YYYY-MM-DD'), 200); 

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 3, 2, TO_DATE('2025-12-02','YYYY-MM-DD'), 600);

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 3, 3, TO_DATE('2025-12-03','YYYY-MM-DD'), 120);

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 3, 4, TO_DATE('2025-12-04','YYYY-MM-DD'), 700);

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 3, 5, TO_DATE('2025-12-05','YYYY-MM-DD'), 150); 

ALTER TABLE cheltuieli ADD CONSTRAINT chk_suma_chelt CHECK (suma > 0);
ALTER TABLE venituri ADD CONSTRAINT chk_suma_venit CHECK (suma > 0);
ALTER TABLE cheltuieli ADD descriere VARCHAR2(100);

CREATE TABLE test_table (
    id_test NUMBER PRIMARY KEY,
    denumire VARCHAR2(50)
);

INSERT INTO utilizatori (id_utilizator, nume, prenume)
VALUES (seq_utilizatori.NEXTVAL, 'Test', 'User');

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 4, 2, TO_DATE('2025-12-10','YYYY-MM-DD'), 100);

INSERT INTO cheltuieli (id_cheltuiala, id_utilizator, id_categorie, data_cheltuiala, suma)
VALUES (seq_cheltuieli.NEXTVAL, 4, 3, TO_DATE('2025-12-11','YYYY-MM-DD'), 50);

ALTER TABLE cheltuieli DROP COLUMN descriere;
DROP TABLE test_table;

UPDATE venituri
SET suma = 2600
WHERE id_venit = 1;

DELETE FROM cheltuieli
WHERE id_utilizator = 4;

DELETE FROM utilizatori
WHERE id_utilizator = 4;

MERGE INTO venituri v
USING (
    SELECT 1 AS id_utilizator,
           1 AS id_categorie,
           TO_DATE('2025-12-01','YYYY-MM-DD') AS data_venit,
           2700 AS suma
    FROM dual
) src
ON (v.id_utilizator = src.id_utilizator 
    AND v.data_venit = src.data_venit)

WHEN MATCHED THEN
    UPDATE SET v.suma = src.suma

WHEN NOT MATCHED THEN
    INSERT (id_venit, id_utilizator, id_categorie, data_venit, suma)
    VALUES (seq_venituri.NEXTVAL,
            src.id_utilizator,
            src.id_categorie,
            src.data_venit,
            src.suma);
