create database test;
use test;
CREATE TABLE cont_condition (
    cond_id INT,
    attr VARCHAR(100)
);
insert into cont_condition values(1, 'tracker'),(2, 'variable'),(3,' discount tracker 1'),(4, 'discount tracker 2'),(5,' fixed');
SELECT 
    *
FROM
    cont_condition;
CREATE TABLE acc_rel (
    acc_no INT,
    cond_id INT
);
insert into acc_rel values (123,1),(123,5),(456,1),(456,3),(789,2),(789,4),(321,5);
SELECT 
    *
FROM
    acc_rel;
CREATE TABLE product (
    product_id INT,
    rate VARCHAR(10),
    frate INT,
    track_margin INT,
    term INT
);
insert into product values (1,'tracker',null,1,1),(2,'tracker',null,1,2),(3,'tracker',null,2,null),(4,'fixed',3,null,2),(5,'fixed',4,null,3),(6,'variable',null,null,null);
SELECT 
    *
FROM
    product;
CREATE TABLE switch (
    acc_no INT,
    open_date VARCHAR(20),
    switch_date VARCHAR(20),
    pre_id INT,
    post_id INT
);
insert into switch values (456,'01/05/2006','01/05/2007',1,4),(789,'01/06/2006','01/06/2008',2,3),(321,'01/07/2006','01/07/2008',4,6),(123,'01/08/2006','01/08/2008',4,3),(789,'01/06/2006','01/06/2009',3,1);
SELECT 
    *
FROM
    switch;
show tables;
SELECT 
    cond_id
FROM
    cont_condition
WHERE
    LOWER(attr) LIKE '%tracker%';
SELECT DISTINCT
    b.acc_no
FROM
    cont_condition AS a
        INNER JOIN
    acc_rel AS b ON a.cond_id = b.cond_id
WHERE
    LOWER(a.attr) LIKE '%tracker%';
SELECT 
    COUNT(DISTINCT b.acc_no) AS total_switches
FROM
    product AS a
        INNER JOIN
    switch AS b ON a.product_id = b.post_id
WHERE
    LOWER(rate) = 'tracker';
CREATE TABLE temp (
    acc_no INT
);
insert into temp select distinct b.acc_no from cont_condition as a inner join acc_rel as b on a.cond_id=b.cond_id where lower(a.attr) like '%tracker%';
SELECT DISTINCT
    b.acc_no
FROM
    temp AS a
        INNER JOIN
    switch AS b ON a.acc_no = b.acc_no
WHERE
    post_id NOT IN (SELECT 
            product_id
        FROM
            product
        WHERE
            LOWER(rate) = 'tracker');
