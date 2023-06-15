--SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "Funkcje";
--DROP table Funkcje;
--DROP table Bandy;
--DROP table Kocury;

drop table Funkcje cascade constraints;
drop table Bandy cascade constraints;
drop table Kocury cascade constraints;
drop table Wrogowie cascade constraints;
drop table Wrogowie_kocurow cascade constraints;

CREATE TABLE Funkcje (
    funkcja VARCHAR2(10) CONSTRAINT fu_fu_pk PRIMARY KEY,
    min_myszy NUMBER(3) CONSTRAINT fu_min_ch CHECK(min_myszy > 5),
    max_myszy NUMBER(3) CONSTRAINT fu_max_ch CHECK(200 > max_myszy),
    CONSTRAINT fu_max_min_ch CHECK(max_myszy >= min_myszy)
    );

CREATE TABLE Bandy (
    nr_bandy NUMBER(2) CONSTRAINT ba_nr_pk PRIMARY KEY,
    nazwa VARCHAR2(20) CONSTRAINT ba_na_nn NOT NULL,
    teren  VARCHAR2(15) CONSTRAINT ba_te_un UNIQUE,
    szef_bandy VARCHAR2(15) CONSTRAINT ba_sz_un UNIQUE
    );
    
CREATE TABLE Kocury (
    imie VARCHAR2(15) CONSTRAINT ko_im_nn NOT NULL,
    plec VARCHAR2(1) CONSTRAINT ko_pl_ch CHECK (plec in ('M','D')),
    pseudo VARCHAR2(15) CONSTRAINT ko_ps_pk PRIMARY KEY, 
    funkcja VARCHAR2(10) constraint ko_fu_fk references Funkcje(funkcja),
    szef VARCHAR2(15) constraint ko_sz_fk references Kocury(pseudo),        
    w_stadku_od DATE default sysdate,
    przydzial_myszy NUMBER(3),
    myszy_extra NUMBER(3),            
    nr_bandy NUMBER(2) constraint ko_nr_fk references Bandy(nr_bandy)
    );                                   
    
ALTER TABLE Bandy 
add CONSTRAINT ba_sz_fk foreign key(szef_bandy) REFERENCES Kocury(pseudo);  

--ALTER TABLE Bandy 
--add CONSTRAINT ba_sz_un UNIQUE (szef_bandy);

--DESC Bandy;
--DESC Kocury;


create table Wrogowie (
   imie_wroga VARCHAR2(15) constraint wr_im_pk Primary Key,
   stopien_wrogosci NUMBER(2) 
   constraint wr_st_ch check(stopien_wrogosci between 1 and 10),
   gatunek VARCHAR2(15), 
   lapowka VARCHAR2(20)   
   );

create table Wrogowie_kocurow (
    pseudo VARCHAR2(15) 
    CONSTRAINT wr_ko_ps_pk REFERENCES Kocury(pseudo),
    imie_wroga VARCHAR2(15) 
    CONSTRAINT wr_ko_im_pk REFERENCES Wrogowie(imie_wroga),
    data_incydentu DATE constraint wr_dat_nn NOT NULL,
    opis_incydentu VARCHAR2(50)
);
                                            

INSERT ALL
INTO Funkcje VALUES ('SZEFUNIO',90,110)
INTO Funkcje VALUES ('BANDZIOR',70,90)
INTO Funkcje VALUES ('LOWCZY',60,70)
INTO Funkcje VALUES ('LAPACZ',50,60)
INTO Funkcje VALUES ('KOT',40,50)
INTO Funkcje VALUES ('MILUSIA',20,30)
INTO Funkcje VALUES ('DZIELCZY',45,55)
INTO Funkcje VALUES ('HONOROWA',6,25)
SELECT 1 FROM dual;

--INSERT ALL requires a SELECT subquery. To get around that, 
--SELECT 1 FROM DUAL is used to give a single row of dummy data

INSERT ALL
INTO Wrogowie VALUES ('KAZIO',10,'CZLOWIEK','FLASZKA')
INTO Wrogowie VALUES ('GLUPIA ZOSKA',1,'CZLOWIEK','KORALIK')
INTO Wrogowie VALUES ('SWAWOLNY DYZIO',7,'CZLOWIEK','GUMA DO ZUCIA')
INTO Wrogowie VALUES ('BUREK',4,'PIES','KOSC')
INTO Wrogowie VALUES ('DZIKI BILL',10,'PIES',NULL)
INTO Wrogowie VALUES ('REKSIO',2,'PIES','KOSC')
INTO Wrogowie VALUES ('BETHOVEN',1,'PIES','PEDIGRIPALL')
INTO Wrogowie VALUES ('CHYTRUSEK',5,'LIS','KURCZAK')
INTO Wrogowie VALUES ('SMUKLA',1,'SOSNA',NULL)
INTO Wrogowie VALUES ('BAZYLI',3,'KOGUT','KURA DO STADA')
SELECT 1 FROM dual;

--¿eby dodaæ trzeba wy³¹czyæ relacje na chwilê

ALTER TABLE Bandy DISABLE CONSTRAINT ba_sz_fk;


INSERT ALL
INTO Bandy VALUES (1,'SZEFOSTWO','CALOSC','TYGRYS')
INTO Bandy VALUES (2,'CZARNI RYCERZE','POLE','LYSY')
INTO Bandy VALUES (3,'BIALI LOWCY','SAD','ZOMBI')
INTO Bandy VALUES (4,'LACIACI MYSLIWI','GORKA','RAFA')
INTO Bandy VALUES (5,'ROCKERSI','ZAGRODA',NULL)
SELECT 1 FROM dual;

--tak samo jak wczesniej

ALTER TABLE Kocury DISABLE CONSTRAINT ko_sz_fk;


INSERT ALL
INTO Kocury VALUES ('JACEK','M','PLACEK','LOWCZY','LYSY','2008-12-01',67,NULL,2)
INTO Kocury VALUES ('BARI','M','RURA','LAPACZ','LYSY','2009-09-01',56,NULL,2)
INTO Kocury VALUES ('MICKA','D','LOLA','MILUSIA','TYGRYS','2009-10-14',25,47,1)
INTO Kocury VALUES ('LUCEK','M','ZERO','KOT','KURKA','2010-03-01',43,NULL,3)
INTO Kocury VALUES ('SONIA','D','PUSZYSTA','MILUSIA','ZOMBI','2010-11-18',20,35,3)
INTO Kocury VALUES ('LATKA','D','UCHO','KOT','RAFA','2011-01-01',40,NULL,4)
INTO Kocury VALUES ('DUDEK','M','MALY','KOT','RAFA','2011-05-15',40,NULL,4)
INTO Kocury VALUES ('MRUCZEK','M','TYGRYS','SZEFUNIO',NULL,'2002-01-01',103,33,1)
INTO Kocury VALUES ('CHYTRY','M','BOLEK','DZIELCZY','TYGRYS','2002-05-05',50,NULL,1)
INTO Kocury VALUES ('KOREK','M','ZOMBI','BANDZIOR','TYGRYS','2004-03-16',75,13,3)
INTO Kocury VALUES ('BOLEK','M','LYSY','BANDZIOR','TYGRYS','2006-08-15',72,21,2)
INTO Kocury VALUES ('ZUZIA','D','SZYBKA','LOWCZY','LYSY','2006-07-21',65,NULL,2)
INTO Kocury VALUES ('RUDA','D','MALA','MILUSIA','TYGRYS','2006-09-17',22,42,1)
INTO Kocury VALUES ('PUCEK','M','RAFA','LOWCZY','TYGRYS','2006-10-15',65,NULL,4)
INTO Kocury VALUES ('PUNIA','D','KURKA','LOWCZY','ZOMBI','2008-01-01',61,NULL,3)
INTO Kocury VALUES ('BELA','D','LASKA','MILUSIA','LYSY','2008-02-01',24,28,2)
INTO Kocury VALUES ('KSAWERY','M','MAN','LAPACZ','RAFA','2008-07-12',51,NULL,4)
INTO Kocury VALUES ('MELA','D','DAMA','LAPACZ','RAFA','2008-11-01',51,NULL,4)
SELECT 1 FROM dual;

--powrót do pierwotengo stanu

ALTER TABLE Kocury ENABLE CONSTRAINT ko_sz_fk;
ALTER TABLE Bandy ENABLE CONSTRAINT ba_sz_fk;

INSERT ALL
INTO Wrogowie_Kocurow VALUES ('TYGRYS','KAZIO','2004-10-13','USILOWAL NABIC NA WIDLY')
INTO Wrogowie_Kocurow VALUES ('ZOMBI','SWAWOLNY DYZIO','2005-03-07','WYBIL OKO Z PROCY')
INTO Wrogowie_Kocurow VALUES ('BOLEK','KAZIO','2005-03-29','POSZCZUL BURKIEM')
INTO Wrogowie_Kocurow VALUES ('SZYBKA','GLUPIA ZOSKA','2006-09-12','UZYLA KOTA JAKO SCIERKI')
INTO Wrogowie_Kocurow VALUES ('MALA','CHYTRUSEK','2007-03-07','ZALECAL SIE')
INTO Wrogowie_Kocurow VALUES ('TYGRYS','DZIKI BILL','2007-06-12','USILOWAL POZBAWIC ZYCIA')
INTO Wrogowie_Kocurow VALUES ('BOLEK','DZIKI BILL','2007-11-10','ODGRYZL UCHO')
INTO Wrogowie_Kocurow VALUES ('LASKA','DZIKI BILL','2008-12-12','POGRYZL ZE LEDWO SIE WYLIZALA')
INTO Wrogowie_Kocurow VALUES ('LASKA','KAZIO','2009-01-07','ZLAPAL ZA OGON I ZROBIL WIATRAK')
INTO Wrogowie_Kocurow VALUES ('DAMA','KAZIO','2009-02-07','CHCIAL OBEDRZEC ZE SKORY')
INTO Wrogowie_Kocurow VALUES ('MAN','REKSIO','2009-04-14','WYJATKOWO NIEGRZECZNIE OBSZCZEKAL')
INTO Wrogowie_Kocurow VALUES ('LYSY','BETHOVEN','2009-05-11','NIE PODZIELIL SIE SWOJA KASZA')
INTO Wrogowie_Kocurow VALUES ('RURA','DZIKI BILL','2009-09-03','ODGRYZL OGON')
INTO Wrogowie_Kocurow VALUES ('PLACEK','BAZYLI','2010-07-12','DZIOBIAC UNIEMOZLIWIL PODEBRANIE KURCZAKA')
INTO Wrogowie_Kocurow VALUES ('PUSZYSTA','SMUKLA','2010-11-19','OBRZUCILA SZYSZKAMI')
INTO Wrogowie_Kocurow VALUES ('KURKA','BUREK','2010-12-14','POGONIL')
INTO Wrogowie_Kocurow VALUES ('MALY','CHYTRUSEK','2011-07-13','PODEBRAL PODEBRANE JAJKA')
INTO Wrogowie_Kocurow VALUES ('UCHO','SWAWOLNY DYZIO','2011-07-14','OBRZUCIL KAMIENIAMI')
SELECT 1 FROM dual;


--zad1

SELECT imie_wroga "WROG", opis_incydentu "PRZEWINA" FROM Wrogowie_kocurow
WHERE data_incydentu BETWEEN to_date('2009-01-01') AND to_date('2009-12-31');

--zad2

SELECT imie, funkcja, to_char(w_stadku_od, 'yyyy-mm-dd') "Z NAMI OD" FROM Kocury
WHERE w_stadku_od BETWEEN to_date('2005-09-01') AND to_date('2007-07-31')
AND plec = 'D';

--zad3

SELECT imie_wroga "WROG", gatunek, stopien_wrogosci "STOPIEN WROGOSCI" 
FROM Wrogowie
WHERE lapowka IS NULL
ORDER BY stopien_wrogosci;

--zad4

SELECT imie || ' zwany ' || pseudo ||' (fun. '||funkcja||
') lowi myszki w bandzie '|| nr_bandy || ' od ' || 
TO_CHAR(w_stadku_od, 'YYYY-MM-DD') "WSZYSTKO O KOCURACH"
FROM Kocury
WHERE plec = 'M'
ORDER BY w_stadku_od DESC, pseudo;

--zad5

SELECT pseudo, 
REGEXP_REPLACE(REGEXP_REPLACE(pseudo,'A','#',1,1), 'L', '%', 1, 1) 
"Po wymianie A na # oraz L na %"
FROM Kocury
WHERE pseudo LIKE '%A%'
AND pseudo LIKE '%L%'; 

--zad6

SELECT imie, TO_CHAR(w_stadku_od, 'YYYY-MM-DD') "W stadku",
ROUND(przydzial_myszy/1.1) "Zjadal", 
TO_CHAR(ADD_MONTHS(w_stadku_od, 6), 'YYYY-MM-DD') "Podwyzka",
przydzial_myszy "Zjada"  
FROM Kocury
--WHERE (trunc(current_date) - w_stadku_od) > 0013-00-00
WHERE extraCT(YEAR FROM CURRENT_DATE) - extraCT(YEAR FROM w_stadku_od) >= 13
AND extraCT(MONTH FROM w_stadku_od) >= 3 
AND extraCT(MONTH FROM w_stadku_od) <= 9
ORDER BY przydzial_myszy DESC
;

--zad7

SELECT imie, przydzial_myszy*3 "MYSZY KWARTALNIE", NVL(myszy_extra, 0)*3 
"KWARTALNE DODATKI"
FROM KOCURY
WHERE przydzial_myszy >= 55 AND przydzial_myszy > 2*NVL(myszy_extra, 0)
;

--zad8

SELECT imie,  
CASE 
WHEN 12*(przydzial_myszy + NVL(myszy_extra, 0)) < 660 then 'Ponizej 660'
WHEN 12*(przydzial_myszy + NVL(myszy_extra, 0)) = 660 then 'LIMIT'
ELSE TO_CHAR(12*(przydzial_myszy + NVL(myszy_extra, 0)))
END "Zjada rocznie"
FROM Kocury
;

--zad9
--NEXT_DAY returns the date of the first weekday named by char that is later than the date date


SELECT pseudo, TO_CHAR(w_stadku_od, 'YYYY-MM-DD') "W STADKU", 
CASE  
WHEN extraCT(DAY FROM w_stadku_od) <= 15 
--je¿eli ostatnia œroda ju¿ by³a to bierzemy ostatni¹ œrodê z nastepnego miesiaca
AND NEXT_DAY(LAST_DAY(TO_DATE('2022-10-25')), 3) - 7 <= TO_DATE('2022-10-25')
then to_char(NEXT_DAY(LAST_DAY(ADD_MONTHS(TO_DATE('2022-10-25'), 1)), 3) - 7, 'yyyy-mm-dd')
WHEN extraCT(DAY FROM w_stadku_od) > 15
then to_char(NEXT_DAY(LAST_DAY(ADD_MONTHS(TO_DATE('2022-10-25'), 1)), 3) - 7, 'yyyy-mm-dd')
else to_char(NEXT_DAY(LAST_DAY(TO_DATE('2022-10-25')), 3) - 7, 'yyyy-mm-dd')
END "WYPLATA"
FROM Kocury
;

SELECT pseudo, TO_CHAR(w_stadku_od, 'YYYY-MM-DD') "W STADKU", 
CASE  
WHEN extraCT(DAY FROM w_stadku_od) <= 15 
--je¿eli ostatnia œroda ju¿ by³a to bierzemy ostatni¹ œrodê z nastepnego miesiaca
AND NEXT_DAY(LAST_DAY(TO_DATE('2022-10-27')), 3) - 7 <= TO_DATE('2022-10-27')
then to_char(NEXT_DAY(LAST_DAY(ADD_MONTHS(TO_DATE('2022-10-27'), 1)), 3) - 7, 'yyyy-mm-dd')
WHEN extraCT(DAY FROM w_stadku_od) > 15
then to_char(NEXT_DAY(LAST_DAY(ADD_MONTHS(TO_DATE('2022-10-27'), 1)), 3) - 7, 'yyyy-mm-dd')
else to_char(NEXT_DAY(LAST_DAY(TO_DATE('2022-10-27')), 3) - 7, 'yyyy-mm-dd')
END "WYPLATA"
FROM Kocury
;

--zad10
--grupujemy po pseudonimie i zliczamy iloœæ wystapieñ

SELECT pseudo || ' - ' || 
CASE 
    WHEN COUNT(pseudo)=1 then 'Unikalny'
    ELSE 'Nieunikalny'
END "Unikalnosc atr. PSEUDO"    
FROM Kocury
GROUP BY pseudo
;

--w councie mo¿e byæ co chcemy bo to nie jest wybieranie atrybutów
-- tu gdzie jest pseudo mo¿e byæ * i szef
--count na atrybut na który na³o¿ony jest indeks dziala najszybciej
--odsiewamy grupy z nullami (szef nie jest obowi¹zkowy)

SELECT szef || ' - ' || 
CASE 
    WHEN COUNT(pseudo)=1 then 'Unikalny'
    ELSE 'Nieunikalny'
END "Unikalnosc atr. SZEF"    
FROM Kocury
GROUP BY szef
HAVING szef IS NOT NULL
;

--zad11
--ile wrogow ma dany pseudonim ****
SELECT pseudo "Pseudonim", count(pseudo) "Liczba wrogow", 'litwrra'
FROM wrogowie_kocurow
GROUP BY pseudo
HAVING count(pseudo) >= 2
;

--zad12
--maksymalny przydzia³ z danej grupy MAX
SELECT 'Liczba kotow= ' || COUNT(Kocury.pseudo) || ' lowi jako ' || funkcja ||
' i zjada max. ' || MAX(NVL(przydzial_myszy,0) + NVL(myszy_extra, 0)) || ' myszy miesiecznie'
FROM Kocury
WHERE  Kocury.plec = 'D' 
GROUP BY funkcja
HAVING funkcja IS NOT NULL AND funkcja != 'szefunio' AND
AVG(NVL(przydzial_myszy,0)+NVL(myszy_extra,0)) > 50
;

--zad13

SELECT  nr_bandy "Nr bandy", plec "Plec", 
MIN(NVL(przydzial_myszy, 0)) "Minimalny przydzial"
FROM Kocury
GROUP BY nr_bandy, plec
;

--zad14
--pseudoatrybut level
SELECT level "Poziom", pseudo "Pseudonim", funkcja "Funkcja", nr_bandy "Nr bandy"
FROM Kocury
WHERE plec = 'M'
START WITH funkcja = 'BANDZIOR'
CONNECT BY PRIOR pseudo=szef 
;
 
--zad15

SELECT SYS_CONNECT_BY_PATH('', '===>') || (level-1) || '             ' || imie
"Hierarchia", DECODE(szef, null, 'Sam sobie panem', szef) "Pseudo szefa",
funkcja "Funkcja"
FROM Kocury
WHERE myszy_extra > 0
CONNECT BY PRIOR pseudo = szef
START WITH szef IS NULL
;

--zad16

--trzeba u¿yæ rpad bo idziemy od do³u drzewa

SELECT RPAD(' ', 4 * (LEVEL - 1), ' ') || pseudo "Droga sluzbowa"
FROM Kocury
START WITH extraCT(YEAR FROM CURRENT_DATE) - extraCT(YEAR FROM w_stadku_od) > 13
            AND NVL(myszy_extra, 0) = 0
            AND plec = 'M'        
CONNECT BY PRIOR szef=pseudo 
;  

--zad 17

SELECT pseudo "POLUJE W POLU", przydzial_myszy "PRZYDZIAL MYSZY" , nazwa "BANDA"
FROM Kocury JOIN Bandy ON Kocury.nr_bandy = Bandy.nr_bandy
WHERE teren in ('POLE', 'CALOSC') AND przydzial_myszy > 50
;
--zad 18
 
SELECT K1.imie, to_char(K1.w_stadku_od, 'yyyy-mm-dd') "POLUJE OD"
FROM Kocury K1, Kocury K2
WHERE K2.imie = 'JACEK' AND K1.w_stadku_od<K2.w_stadku_od
ORDER BY K1.w_stadku_od DESC
;

--zad 19
--a

SELECT k1.imie, k1.funkcja, NVL(k2.imie, ' ') "Szef 1", NVL(k3.imie, ' ') "Szef 2", NVL(k4.imie, ' ') "Szef 3"
FROM Kocury k1 LEFT JOIN Kocury k2 ON k1.szef = k2.pseudo or k1.szef = NULL
                LEFT JOIN Kocury k3 on k2.szef = k3.pseudo or k2.szef = NULL
                LEFT JOIN Kocury k4 ON k3.szef = k4.pseudo or k3.szef = NULL            
WHERE k1.funkcja = 'KOT' OR k1.funkcja = 'MILUSIA'                
;

--b
 
SELECT *
FROM
(
    SELECT CONNECT_BY_ROOT imie imie_root, imie, CONNECT_BY_ROOT funkcja "Funkcja", LEVEL lev
    FROM Kocury
    CONNECT BY PRIOR szef = pseudo
    START WITH funkcja IN ('KOT', 'MILUSIA')
)
PIVOT
(
    MAX(imie) FOR lev IN (2 "Szef 1", 3  "Szef 2", 4 "Szef 3")
)
;
  
--c
--tak Ÿle, wtedy sys_connect_by_path wtedy nie zadzia³a
SELECT imie, funkcja, SYS_CONNECT_BY_PATH(imie, ' | ') "IMIONA KOLEJNYCH SZEFÓW"
FROM Kocury 
connect by prior szef = pseudo
start with funkcja IN ('KOT', 'MILUSIA')               
;
--to nam nie odfiltruje tych z hierarchi bo SYS_CONNECT_BY_PATH nie zostanie przefiltrowane
--usuwamy imie liœcia dlatego rtrim
SELECT imie, funkcja, REVERSE(RTRIM(SYS_CONNECT_BY_PATH(REVERSE(imie), ' | '), imie)) "IMIONA KOLEJNYCH SZEFÓW"
FROM Kocury 
WHERE funkcja = 'KOT'
      OR funkcja = 'MILUSIA'
CONNECT BY PRIOR pseudo = szef
START WITH szef IS NULL;

--zad20

select imie, nazwa, wk.imie_wroga, stopien_wrogosci "Ocena wroga", 
to_char(data_incydentu, 'YYYY-MM-DD') "Data inc."
from kocury k join wrogowie_kocurow wk on k.pseudo = wk.pseudo
              join bandy b on k.nr_bandy = b.nr_bandy
              join wrogowie w on wk.imie_wroga = w.imie_wroga
where data_incydentu > to_date('2007-01-01', 'YYYY-MM-DD')
and plec = 'D'
;

--zad21
--czemu w tym pierwszym select distinct nie zadzia³a?
--chyba dlatego ¿e jesli jeden kot ma wielu wrogów to utworzy siê wiele wierszy 
--a i tak ka¿dy z nich bêdzie unikalny

select nazwa "Nazwa bandy", count(distinct k.pseudo) "Koty z wrogami"
from bandy b
join kocury k on k.nr_bandy = b.nr_bandy
join wrogowie_kocurow wk on k.pseudo = wk.pseudo
group by nazwa
;
--????????????????????????????????????????????????????????????
select distinct nazwa "Nazwa bandy", k.pseudo "Koty z wrogami"
from bandy b
join kocury k on k.nr_bandy = b.nr_bandy
join wrogowie_kocurow wk on k.pseudo = wk.pseudo

;
--nie trzeba distinct jeden kot ma jednego wroga
select nazwa "Nazwa bandy", count(pseudo) "Koty z wrogami"
from bandy b
join kocury k on k.nr_bandy = b.nr_bandy
where pseudo IN (select pseudo from wrogowie_kocurow )
group by nazwa
;

--zad22
select k.funkcja, k.pseudo, count(k.pseudo) "Liczba wrogow"
from kocury k
join wrogowie_kocurow wk on k.pseudo = wk.pseudo
group by k.pseudo, k.funkcja
having count(k.pseudo) > 1
;

--zad23

select imie, 12 * (przydzial_myszy + NVL(myszy_extra, 0)) "DAWKA ROCZNA", 'powyzej 864' "DAWKA"
from kocury 
where 12 * (przydzial_myszy + NVL(myszy_extra, 0)) > 864 AND NVL(myszy_extra,0) > 0

union all

select imie, 12* (przydzial_myszy + NVL(myszy_extra, 0)) "DAWKA ROCZNA", '864' "DAWKA"
from kocury 
where 12 * (przydzial_myszy + NVL(myszy_extra, 0)) = 864 AND NVL(myszy_extra,0) > 0

union all

select imie, 12 * (przydzial_myszy + NVL(myszy_extra, 0)) "DAWKA ROCZNA", 'ponizej 864' "DAWKA"
from kocury 
where 12* (przydzial_myszy + NVL(myszy_extra, 0)) < 864 AND NVL(myszy_extra,0) > 0
; 

--zad24
--kocury z nullem 

select b.nr_bandy, nazwa, teren
from bandy b
left join kocury k on k.nr_bandy = b.nr_bandy
group by b.nr_bandy, nazwa, teren
having count(pseudo) = 0
;
-- mo¿na where imie jest null 
 
select b.nr_bandy, b.nazwa, b.teren
from bandy b
left join kocury k on k.nr_bandy = b.nr_bandy

MINUS

select b.nr_bandy, b.nazwa, b.teren
from bandy b
join kocury k on k.nr_bandy = b.nr_bandy
;

--zad25
--It find all possible pairs and retains only those pairs where first field is 
--less than second field. So your max value will not appear in the first field 
--as it is not less that any other value.

--czemu potrzebny jest dwa razy filtr milusia?
--bo najpierw szukamy grupy milusi które nie maj¹ maksymalnej wartoœci
-- a potem szukamy tej milusi z maksymalna wartoœcia

--to dzia³a
select imie, funkcja, przydzial_myszy
from kocury  
where przydzial_myszy >= 3*
(select k2.przydzial_myszy from Kocury k2 join bandy c on k2.nr_bandy = c.nr_bandy
    where k2.pseudo not in                   --maxa nie ma w wartoœciach mniejszych od maxa
    (select A.pseudo from Kocury A, Kocury B --znajdujemy wartoœci mniejsze od max
    where A.przydzial_myszy < B.przydzial_myszy AND A.funkcja = 'MILUSIA' AND B.funkcja = 'MILUSIA')
    AND funkcja = 'MILUSIA' and teren in ('SAD', 'CALOSC'))
;    

select A.przydzial_myszy from Kocury A, Kocury B --znajdujemy wartoœci mniejsze od max
where A.przydzial_myszy < B.przydzial_myszy AND A.funkcja = 'MILUSIA' AND B.funkcja = 'MILUSIA';

--zad26
-- dwa podzapytania znajduj¹ce funkcje z min i max avg przydzia³em

select funkcja, round(avg(przydzial_myszy + NVL(myszy_extra, 0)))
"Srednio najw. i najm. myszy"
from kocury
group by funkcja
having (avg(przydzial_myszy + NVL(myszy_extra, 0))) in
(
    (select max(AV) from 
        (select avg(przydzial_myszy + NVL(myszy_extra, 0)) as AV
        from kocury
        where funkcja != 'SZEFUNIO'
        group by funkcja)
    ),
    (
    select min(AV) from 
        (select avg(przydzial_myszy + NVL(myszy_extra, 0)) as AV
        from kocury
        group by funkcja)
    )
)
;

--czemu to nie dzia³a? bo s¹ dwie kolumny 
select funkcja, round(avg(przydzial_myszy + NVL(myszy_extra, 0)))
"Srednio najw. i najm. myszy"
from kocury
group by funkcja
having (avg(przydzial_myszy + NVL(myszy_extra, 0))) in
    (select max(AV), min(AV) from 
        (select avg(przydzial_myszy + NVL(myszy_extra, 0)) as AV
        from kocury
        where funkcja != 'SZEFUNIO'
        group by funkcja)
    )

;

--zad27a

--Czy kotow ktore maja wiecej myszy niz obecnie sprawdzany kot jest mniej niz 6
-- bo wtedy on trafia do wyniku

select pseudo, przydzial_myszy + NVL(myszy_extra, 0) zjada
from Kocury K
where (select count(DISTINCT przydzial_myszy + NVL(myszy_extra, 0)) 
      from Kocury
      where przydzial_myszy + NVL(myszy_extra, 0) > K.przydzial_myszy + NVL(K.myszy_extra, 0)) < 12
order by zjada desc;

--zad27b
--musi byæ po przydziale bo pseudo jest unikalne 
--musza byc dwa selecty bo inaczej najpierw filtruje a potem sortuje

select pseudo, przydzial_myszy + NVL(myszy_extra, 0) "ZJADA"
from Kocury 
where przydzial_myszy + NVL(myszy_extra, 0) in 
    (select * from 
        (select distinct przydzial_myszy + NVL(myszy_extra, 0) 
        from Kocury
        order by 1 desc) 
    where rownum <= 6)
;

-- tak nie mo¿e byæ bo to najpierw filtruje a potem sortuje

select pseudo, przydzial_myszy + NVL(myszy_extra, 0) "ZJADA"
from Kocury 
where przydzial_myszy + NVL(myszy_extra, 0) in 
    (select distinct przydzial_myszy + NVL(myszy_extra, 0) from Kocury      
      where rownum <= 6
      ORDER BY 1 DESC)
;
    
--zad27c

select distinct k.pseudo, k.przydzial_myszy + NVL(k.myszy_extra, 0) zjada
from Kocury k, Kocury k2
where k.przydzial_myszy + NVL(k.myszy_extra, 0) >= k2.przydzial_myszy + NVL(k2.myszy_extra, 0) --gdy zajmuj¹ to samo miejsce
group by k.pseudo, k.przydzial_myszy + NVL(k.myszy_extra, 0)
having (select count(distinct przydzial_myszy + NVL(myszy_extra, 0)) from kocury) - (select count(pseudo) from kocury where k.pseudo = pseudo) < 11--od ilu kotów ma wiêkszy
order by 2 desc;

select distinct k.pseudo, min(k.przydzial_myszy + NVL(k.myszy_extra, 0)) zjada
from Kocury k join Kocury k2
on k.przydzial_myszy + NVL(k.myszy_extra, 0) >= k2.przydzial_myszy + NVL(k2.myszy_extra, 0) --gdy zajmuj¹ to samo miejsce
group by k.pseudo
having count(distinct k.przydzial_myszy + NVL(k.myszy_extra, 0)) < 6 --od ilu kotów ma wiêkszy
order by 2 desc;

select k.pseudo, min(k.przydzial_myszy + NVL(k.myszy_extra, 0)) zjada
from Kocury k join Kocury k2
on k.przydzial_myszy + NVL(k.myszy_extra, 0) >= k2.przydzial_myszy + NVL(k2.myszy_extra, 0) --gdy zajmuj¹ to samo miejsce
group by k.pseudo, k.przydzial_myszy + NVL(k.myszy_extra, 0)
having (select count(pseudo) from kocury where k.pseudo = pseudo) < 6 --od ilu kotów ma wiêkszy
order by 2 desc;


--zad27d
select pseudo, zjada
from (select pseudo, przydzial_myszy + NVL(myszy_extra, 0) zjada,
     DENSE_RANK()
     OVER (
     ORDER BY przydzial_myszy + NVL(myszy_extra, 0) desc) pozycja
     from Kocury)
where pozycja < 7     
;

--zad28

select to_char(extract(YEAR from W_STADKU_OD)) "ROK", count(*) "LICZBA WSTAPIEN"  --tochar 
from KOCURY
group by extract(YEAR from W_STADKU_OD)
having count(*) in ((select distinct min(COUNT(pseudo))--od góry bierzemy pierwsza najmniejsza wartosc
                     from Kocury
                     group by extract(YEAR from w_stadku_od)
                     having count(pseudo) > (
                                    select avg(count(extract(YEAR from w_stadku_od)))
                                    from Kocury
                                    group by extract(YEAR from w_stadku_od)
                                    )             
                    ),
                    (select distinct max(COUNT(pseudo)) --pierwsza najwieksza wartosc   
                     from Kocury
                     group by extract(YEAR from w_stadku_od)
                     having count(pseudo) < (
                                    select avg(count(extract(YEAR from w_stadku_od))) --œrednia
                                    from Kocury
                                    group by extract(YEAR from w_stadku_od)
                                    )
                    )        
                   )
union
select 'Srednia', round(avg(count(*)),7)
from Kocury
group by extract(YEAR from w_stadku_od)
order by "LICZBA WSTAPIEN";

                             

--zad29a

select k1.imie, MAX(NVL(k1.przydzial_myszy, 0) + NVL(k1.myszy_extra, 0)) zjada, k1.nr_bandy,
       to_char(AVG(NVL(k2.przydzial_myszy, 0) + NVL(k2.myszy_extra, 0)), '99.99')
from Kocury k1 JOIN Kocury k2 ON k1.nr_bandy = k2.nr_bandy  --bêdzie tyle wierszy ile ludzi w bandzie
where k1.plec = 'M'                                          --a w k2 ka¿dy ma inny przydzia³!!
group by k1.imie, k1.nr_bandy
having MAX(NVL(k1.przydzial_myszy, 0) + NVL(k1.myszy_extra, 0)) < AVG(NVL(k2.przydzial_myszy, 0) + NVL(k2.myszy_extra, 0))
;
--tu musi byæ max albo min bo dzia³amy na grupach (i tak zwróc¹ tê sam¹ wartoœæ)

--za pomoc¹ with
with S as
    (select nr_bandy, AVG(NVL(przydzial_myszy,0) + NVL(myszy_extra,0)) sredni
     from Kocury
     group by nr_bandy)
select k.imie, NVL(przydzial_myszy,0) + NVL(myszy_extra,0) , k.nr_bandy, S.sredni
from Kocury k join S on k.nr_bandy = S.nr_bandy 
where (NVL(przydzial_myszy,0) + NVL(myszy_extra,0)) < S.sredni and k.plec = 'M'
;

select nr_bandy, AVG(NVL(przydzial_myszy,0) + NVL(myszy_extra,0)) sredni
from Kocury
group by nr_bandy;
--zad29b
--b!

select imie, NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0) "ZJADA", k.nr_bandy, 
       to_char(srednia, '99.99') srednia
from Kocury k JOIN (select nr_bandy, AVG(NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0)) srednia
                    from Kocury 
                    group by nr_bandy) b 
                on k.nr_bandy = b.nr_bandy
                and przydzial_myszy + NVL(myszy_extra, 0) < srednia
where plec = 'M' 
;

--zad29c
select imie,  NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0) "ZJADA", nr_bandy,
    (select AVG(NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0))
    from Kocury
    group by nr_bandy
    having nr_bandy = k.nr_bandy) "SREDNIA BANDY"
from Kocury k 
where plec = 'M' and NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0) <
    (select AVG(NVL(przydzial_myszy, 0) + NVL(myszy_extra, 0))
    from Kocury
    group by nr_bandy
    having nr_bandy = k.nr_bandy)
;

--zad30
--nie mo¿na w where tylko trzeba w zagnie¿d¿onym select

select imie, w_stadku_od, nr_bandy, (min(w_stadku_od) over (partition by nr_bandy)) staz
from kocury;
        
select imie, to_char(w_stadku_od, 'yyyy-mm-dd') || ' <--- NAJSTARSZY STAZEM W BANDZIE ' || nazwa "WSTAPIL DO STADKA"
FROM (select imie, w_stadku_od, nazwa, (min(w_stadku_od) over (partition by k.nr_bandy)) staz
        from kocury k join bandy b on k.nr_bandy = b.nr_bandy)
where w_stadku_od = staz
union 
select imie, to_char(w_stadku_od, 'yyyy-mm-dd') || ' <--- NAJMLODSZY STAZEM W BANDZIE ' || nazwa "WSTAPIL DO STADKA"
FROM (select imie, w_stadku_od, nazwa, (max(w_stadku_od) over (partition by k.nr_bandy)) maxs
        from kocury k join bandy b on k.nr_bandy = b.nr_bandy)
where w_stadku_od = maxs
union 
select imie, to_char(w_stadku_od, 'yyyy-mm-dd') "WSTAPIL DO STADKA"
FROM (select imie, w_stadku_od, (max(w_stadku_od) over (partition by k.nr_bandy)) maxs,
        (min(w_stadku_od) over (partition by k.nr_bandy)) mins
        from kocury k join bandy b on k.nr_bandy = b.nr_bandy)
where w_stadku_od != maxs and w_stadku_od != mins
;

--zad31
--z with (niepotrzebne) 
with P as 
(select b.nr_bandy, b.nazwa, AVG(NVL(przydzial_myszy,0)) srednip, MIN(NVL(przydzial_myszy,0)) minp, 
    MAX(NVL(przydzial_myszy,0)) maxp, NVL(count(k.pseudo), 0) koty, 
    NVL((select count(k1.pseudo) from kocury k1 where NVL(k1.myszy_extra, 0) > 0 and k1.nr_bandy = b.nr_bandy
        group by k1.nr_bandy), 0) koty_z_dod -- niepotrzebne mo¿na count(myszy_extra)
from Bandy b join Kocury k on b.nr_bandy = k.nr_bandy
group by b.nazwa, b.nr_bandy)
select imie, pseudo, funkcja, P.nazwa, P.srednip, P.maxp, P.minp, P.koty, P.koty_z_dod
FROM Kocury k2 JOIN P ON P.nr_bandy = k2.nr_bandy;

create or replace view Kotki(nazwa, srednip, minp, maxp, koty, koty_z_dod)
as
select nazwa, AVG(NVL(przydzial_myszy,0)), MIN(NVL(przydzial_myszy,0)) minp, 
    MAX(NVL(przydzial_myszy,0)) maxp, count(pseudo), count(myszy_extra) 
from Bandy b join Kocury k on b.nr_bandy = k.nr_bandy
group by nazwa;

select * from kotki;

select pseudo, imie, funkcja, NVL(przydzial_myszy,0), 
'OD ' || Kotki.minp || ' DO ' || Kotki.maxp "GRANICE SPOZYCIA", to_char(w_stadku_od, 'yyyy-mm-dd') "LOWI OD"
FROM Kocury k JOIN Kotki ON Kotki.nazwa = (select nazwa from bandy b where b.nr_bandy = k.nr_bandy group by nazwa)
where pseudo = '&pseudonim';

--ZAD32
-- perspektywa nie mo¿e mieæ nawet NVL!!!
create or replace view Doswiadczeni (pseudo, plec, przydzial_myszy, myszy_extra, nr_bandy)
as
select pseudo, plec, przydzial_myszy, myszy_extra, nr_bandy
from Kocury 
where pseudo in
    (select pseudo 
    from Kocury join Bandy on Kocury.nr_bandy = Bandy.nr_bandy
    where nazwa = 'CZARNI RYCERZE'
    order by w_stadku_od 
    fetch first 3 rows only)
or pseudo in
    (select pseudo 
    from Kocury join Bandy on Kocury.nr_bandy = Bandy.nr_bandy
    where nazwa = 'LACIACI MYSLIWI'
    order by w_stadku_od 
    fetch first 3 rows only);
    
    
select pseudo, plec, przydzial_myszy "Myszy przed podw.", 
       NVL(myszy_extra, 0) "extra przed podw."
from Doswiadczeni;

update Doswiadczeni
set przydzial_myszy = przydzial_myszy + DECODE(plec, 'D', 0.1 * (select min(przydzial_myszy) from Kocury), 10),
    myszy_extra = NVL(myszy_extra, 0) + 0.15 * (select AVG(NVL(myszy_extra, 0)) 
                                                from Kocury 
                                                where Kocury.nr_bandy = Doswiadczeni.nr_bandy);

select pseudo, plec, przydzial_myszy "Myszy po podw.", 
       NVL(myszy_extra, 0) "extra po podw."
from Doswiadczeni;

ROLLBACK;

--zad33a

select sum(przydzial_myszy + NVL(myszy_extra, 0)) 
from Kocury k join bandy on k.nr_bandy = bandy.nr_bandy
where funkcja = 'SZEFUNIO' and nazwa = 'SZEFOSTWO'
group by nazwa;
having nazwa = 'BIALI LOWCY';

--grupujemy te¿ po nr_bandy bo inaczej 
--TO CHAR bo nie zrobimy uniona

--a
SELECT decode(plec, 'Kotka', ' ', nazwa)nazwa, plec, ile, szefunio, bandzior, lowczy, lapacz, kot, milusia, dzielczy, suma
from (select nazwa,
             decode(PLEC, 'D', 'Kotka', 'Kocur') plec,
             to_char(count(pseudo)) ile,
             to_char(sum(decode(FUNKCJA,'SZEFUNIO', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) szefunio,
             to_char(sum(decode(FUNKCJA, 'BANDZIOR', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) bandzior,
             to_char(sum(decode(FUNKCJA, 'LOWCZY', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) lowczy,
             to_char(sum(decode(FUNKCJA, 'LAPACZ', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) lapacz,
             to_char(sum(decode(FUNKCJA, 'KOT', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) kot,
             to_char(sum(decode(FUNKCJA, 'MILUSIA', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) milusia,
             to_char(sum(decode(FUNKCJA, 'DZIELCZY', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) dzielczy,
             to_char(sum(NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0))) suma
from KOCURY natural join BANDY
group by NAZWA, plec
union
select 'Z----------------', '--------', '----------', '-----------', '-----------', '----------', '----------', '----------', '----------', '----------', '----------'
from dual
union
SELECT 'ZJADA RAZEM' nazwa, ' ' plec, ' ' ile,
             to_char(sum(decode(FUNKCJA, 'SZEFUNIO', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) szefunio,
             to_char(sum(decode(FUNKCJA, 'BANDZIOR', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) bandzior,
             to_char(sum(decode(FUNKCJA, 'LOWCZY', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) lowczy,
             to_char(sum(decode(FUNKCJA, 'LAPACZ', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) lapacz,
             to_char(sum(decode(FUNKCJA, 'KOT', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) kot,
             to_char(sum(decode(FUNKCJA, 'MILUSIA', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) milusia,
             to_char(sum(decode(FUNKCJA, 'DZIELCZY', NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0),0))) dzielczy,
             to_char(sum(NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0))) suma
from Kocury natural join BANDY
order by 1,2);


--b
select * from
              (select nazwa, decode(PLEC, 'D', 'Kotka' , 'Kocur') plec, FUNKCJA, (NVL(PRZYDZIAL_MYSZY,0) + nvl(MYSZY_extra, 0)) przydzial
                from KOCURY natural join BANDY K1)
pivot (
    sum(NVL(przydzial,0))
    for FUNKCJA
    IN ('SZEFUNIO', 'BANDZIOR', 'LOWCZY', 'LAPACZ', 'KOT', 'MILUSIA', 'DZIELCZY')
    )
union
select * from
              (select 'Zjada razem ' nazwa, ' ' plec, FUNKCJA, (NVL(PRZYDZIAL_MYSZY,0) + nvl(MYSZY_extra, 0)) przydzial
              from KOCURY natural join BANDY)
pivot (
    sum(NVL(przydzial,0))     --element agregacji (funkcja wyliczeniowa)
    for FUNKCJA                       --for X dane na podstawie ktorych maj¹ powstac kolumny
    IN ('SZEFUNIO', 'BANDZIOR', 'LOWCZY', 'LAPACZ', 'KOT', 'MILUSIA', 'DZIELCZY') --in (y1,y2) jakie kolumny maj¹ powstaæ na podstawie danych z kolumny X
    );
    
    
--LISTA 3

--zad34

SET SERVEROUTPUT ON
DECLARE
    liczba NUMBER;
    fun Kocury.funkcja%TYPE ;
BEGIN
    SELECT count(pseudo), min(funkcja) into liczba, fun
    From Kocury
    Where funkcja = '&nazwa_funkcji';
    if liczba > 0 then dbms_output.put_line('Znaleziono kota pelniacego funkcje ' || fun);
    else DBMS_OUTPUT.PUT_LINE('Nie znaleziono');
    end if;
end;
/

--zad35
/* Napisaæ blok PL/SQL, który wyprowadza na ekran nastêpuj¹ce informacje o kocie 
o pseudonimie wprowadzonym z klawiatury (w zale¿noœci od rzeczywistych danych):
-	'calkowity roczny przydzial myszy >700'
-	'imiê zawiera litere A'
-	'maj jest miesiacem przystapienia do stada'
-	'nie odpowiada kryteriom'.
Powy¿sze informacje wymienione s¹ zgodnie z hierarchi¹ wa¿noœci. 
*/

DECLARE
    imie Kocury.imie%TYPE;
    przydzial Number;
    miesiac number;
    found BOOLEAN default false;
BEGIN
    Select  imie, (nvl(przydzial_myszy,0)+nvl(myszy_extra,0))*12, extract(month from w_stadku_od)
    INTO imie, przydzial, miesiac
    From Kocury
    Where pseudo = upper('&pseudo');

    If przydzial > 700 then dbms_output.put_line(imie || ' calkowity przydzial myszy > 700');
                            found := true;
    END IF;
    if miesiac = 5 then dbms_output.put_line(imie || ' maj jest miesiacem przystapienia do stada');
                        found := true;
    END IF;
    if imie LIKE '%A%' THEN DBMS_OUTPUT.PUT_LINE(imie || ' imie zawiera litere A');
                            found := true;
    END IF;
    IF not found then dbms_output.put_line(imie || ' nie odpowiada kryteriom');
    END IF;
    Exception
    when no_data_found then dbms_output.put_line('Nie znaleziono takiego kota');
    when others then dbms_output.put_line(sqlerrm);
END;
/

--zad36

DECLARE
  suma_przydzialow number default 0;
  liczba_zmian number default 0;

    cursor kursor is
        SELECT pseudo, PRZYDZIAL_MYSZY, FUNKCJA FROM KOCURY 
        order by PRZYDZIAL_MYSZY for update of PRZYDZIAL_MYSZY; --zabezpieczenie blokujemy rekordy w kursorze
                                                                --(nawet jak zmienimy przydzia³ to sortowanie sie nie zmieni)   
    cursor max_funkcji is 
        select max_myszy from funkcje f join kocury k on  
        f.funkcja = k.funkcja order by k.przydzial_myszy;

  wiersz kursor%ROWTYPE; -- struktura zgodna z kursorem
  maxf max_funkcji%ROWTYPE;
BEGIN
  SELECT SUM(PRZYDZIAL_MYSZY) into suma_przydzialow from KOCURY; --dotychczasowe przydzia³y
    -- potrzebujemy dwóch pêtli jedna która otwiera i zamyka kursory
    --a druga przechodz¹ca po wszystkich kotach, bada czy suma przydzialow > 1050
    
    <<zewn>>LOOP
        open kursor;
        open max_funkcji;
        loop
        fetch kursor into wiersz;     --aktualny wiersz kursora
        exit when kursor%notfound;    --gdy dojdziemy do koñca

        fetch max_funkcji into maxf;

        IF (1.1*wiersz.PRZYDZIAL_MYSZY <= maxf.max_myszy) then --je¿eli podwy¿ka dalej jest mniejsza od 
                                                              -- dopuszczalnego przydzialu
          UPDATE KOCURY
              SET PRZYDZIAL_MYSZY = round(1.1*wiersz.PRZYDZIAL_MYSZY)
              where wiersz.PSEUDO=PSEUDO;

              liczba_zmian:=liczba_zmian+1;
              suma_przydzialow:=suma_przydzialow + round(0.1*wiersz.PRZYDZIAL_MYSZY);
              
        elsif (wiersz.PRZYDZIAL_MYSZY != maxf.max_myszy) then --je¿eli przekroczymy to ustawiamy max_myszy
          UPDATE KOCURY
              SET PRZYDZIAL_MYSZY=maxf.max_myszy
              where wiersz.PSEUDO=PSEUDO;
              liczba_zmian:=liczba_zmian+1;
              suma_przydzialow:=suma_przydzialow + (maxf.max_myszy-wiersz.PRZYDZIAL_MYSZY);
        end if;
      exit zewn when suma_przydzialow>1050;
    end loop ;
    close kursor;
    close max_funkcji;  
    end loop zewn;
   
  dbms_output.put_line('Calk. przydzial w stadku ' || suma_przydzialow);
  dbms_output.put_line('Zmian - ' || liczba_zmian);
end;
/
select imie, NVL(przydzial_myszy,0) "Myszki po podwyzce" from Kocury order by PRZYDZIAL_MYSZY desc ;

rollback;


--zad37
declare
    sa_wiersze BOOLEAN:=FALSE;
    licznik  number default 1;
    brak_kotow EXCEPTION;
    cursor kursor is 
    select 'Nr', pseudo pseudonim, przydzial_myszy + NVL(myszy_extra, 0) zjada
    from Kocury
    order by zjada desc;
  
begin
    DBMS_output.put_line('Nr  Psedonim   Zjada');
    for wiersz in kursor
    loop
        sa_wiersze:=TRUE;
        DBMS_output.put_line(licznik||'   ' || RPAD(wiersz.pseudonim, 11, ' ')|| LPAD(wiersz.zjada, 4, ' '));
        
        licznik := licznik + 1;
        exit when licznik = 6;
    end loop;
    if not sa_wiersze 
        then raise brak_kotow;
    end if;    
exception    
    WHEN brak_kotow THEN DBMS_OUTPUT.PUT_LINE('Brak kotów');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;
/

--zad38
--Zad. 19. Dla kotów pe³ni¹cych funkcjê KOT i MILUSIA wyœwietliæ w kolejnoœci hierarchii 
--imiona wszystkich ich szefów. Zadanie rozwi¹zaæ na trzy sposoby:
--a.	z wykorzystaniem tylko z³¹czeñ,
--b.	z wykorzystaniem drzewa, operatora CONNECT_BY_ROOT i tabel przestawnych

declare
    cursor kursor is 
    SELECT imie
    FROM Kocury
    where funkcja IN ('KOT', 'MILUSIA')
    group by imie;
    
    licznik number default 1;
    liczba_szefow number;
    koniec number;
    imiek Kocury.imie%TYPE;
begin 
    koniec := &ile;
    DBMS_OUTPUT.PUT_line('Przyk³adowy wynik dla liczby prze³o¿onych = ' || koniec);
    select * into liczba_szefow from 
                        (SELECT max(count(CONNECT_BY_ROOT imie)) 
                        FROM Kocury k --to s³u¿y do sprawdzenia jak¹ tabele stworzyc
                        CONNECT BY PRIOR szef = pseudo
                        START WITH funkcja IN ('KOT', 'MILUSIA')
                        GROUP BY CONNECT_BY_ROOT imie);
                        
    if koniec >= liczba_szefow-1 --zale¿y co jest mniejsze
        then koniec := liczba_szefow-1;
    end if;    
    
    DBMS_OUTPUT.PUT('Imie  '); 
    loop        
        DBMS_OUTPUT.PUT(lpad('Szef '|| licznik, 10, ' ') );  
        licznik := licznik +1;
        exit when (koniec + 1) = licznik;
    end loop;
    
    licznik := 0;
    for wiersz in kursor   
    loop
        licznik := 0;
        DBMS_OUTPUT.new_line;
        imiek := wiersz.imie;
        
        for korzen in (SELECT CONNECT_BY_ROOT imie , imie szef, LEVEL lev
                        FROM Kocury k
                        where CONNECT_BY_ROOT imie = wiersz.imie
                        CONNECT BY PRIOR szef = pseudo
                        START WITH funkcja IN ('KOT', 'MILUSIA')
                        ) 
        loop
            exit when (licznik-1) = koniec;
            DBMS_OUTPUT.PUT(rpad(korzen.szef, 10, ' '));           
            licznik := licznik + 1;
        end loop;    
        --exit when kursor%notfound; 
    end loop;
    --close kursor;
exception    
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;
/

--zad39

DECLARE
    numerb Number := &number;
    nazwab Bandy.nazwa%TYPE := upper('&nazwa_bandy');
    terenb Bandy.teren%TYPE := upper('&teren');
    found BOOLEAN default false;
    found1 BOOLEAN default false;
    found2 BOOLEAN default false;
    found3 BOOLEAN default false;
    zlynumer exception;
    zlabanda exception;
    komunikat varchar2(256) := '';
BEGIN
    if numerb <= 0 then raise zlynumer;
    end if;
    
    for i in (select nr_bandy from bandy)
    loop
        if numerb = i.nr_bandy then --czemu tu nie moze byæ samo i???????????
        found := true;
        found1 := true;
        end if;
    end loop;  
    
    if found1 then 
        komunikat := komunikat || numerb || ': ju¿ istnieje, ';
    else
        komunikat := komunikat || numerb || ', ';
    end if;
        
    for i in (select nazwa from bandy)
    loop
        if nazwab = i.nazwa then 
        found := true;
        found2 := true;
        end if;
    end loop;
    
    if found2 then 
        komunikat := komunikat || nazwab || ': ju¿ istnieje, ';
    else
        komunikat := komunikat || nazwab || ', ';
    end if;
        
    for i in (select teren from bandy)
    loop
        if terenb = i.teren then --czemu tu nie moze byæ samo i???????????
        found := true;
        found3 := true;
        end if;
    end loop;
    
    if found3 then 
        komunikat := komunikat || terenb || ': ju¿ istnieje ';
    else
        komunikat := komunikat || terenb;
    end if;
    
    dbms_output.put_line(komunikat);
    if found then raise zlabanda; end if;
    
    INSERT INTO Bandy (nr_bandy, nazwa, teren) values (numerb, nazwab, terenb) ;
exception
    when zlynumer then dbms_output.put_line('Numer musi byæ > 0');
    when zlabanda then dbms_output.put_line('Taka banda ju¿ istnieje');
    when others then dbms_output.put_line(sqlerrm);
END;
/

select * from Bandy;
rollback;

--zad40

CREATE OR REPLACE Procedure banda(numerb Number, nazwab Bandy.nazwa%TYPE,terenb Bandy.teren%TYPE)   
    is
    found BOOLEAN default false;
    found1 BOOLEAN default false;
    found2 BOOLEAN default false;
    found3 BOOLEAN default false;
    zlynumer exception;
    zlabanda exception;
    komunikat varchar2(256) := '';
BEGIN
    if numerb <= 0 then raise zlynumer;
    end if;
    
    for i in (select nr_bandy from bandy)
    loop
        if numerb = i.nr_bandy then 
        found := true;
        found1 := true;
        end if;
    end loop;  
    
    if found1 then 
        komunikat := komunikat || numerb || ': ju¿ istnieje, ';
    else
        komunikat := komunikat || numerb || ', ';
    end if;
        
    for i in (select nazwa from bandy)
    loop
        if nazwab = i.nazwa then 
        found := true;
        found2 := true;
        end if;
    end loop;
    
    if found2 then 
        komunikat := komunikat || nazwab || ': ju¿ istnieje, ';
    else
        komunikat := komunikat || nazwab || ', ';
    end if;
        
    for i in (select teren from bandy)
    loop
        if terenb = i.teren then 
        found := true;
        found3 := true;
        end if;
    end loop;
    
    if found3 then 
        komunikat := komunikat || terenb || ': ju¿ istnieje ';
    else
        komunikat := komunikat || terenb;
    end if;
    
    dbms_output.put_line(komunikat);
    if found then raise zlabanda; end if;
    
    INSERT INTO Bandy (nr_bandy, nazwa, teren) values (numerb, nazwab, terenb) ;
exception
    when zlynumer then dbms_output.put_line('Numer musi byæ > 0');
    when zlabanda then dbms_output.put_line('Taka banda ju¿ istnieje');
    when others then dbms_output.put_line(sqlerrm);
END;
/

rollback;
begin
    banda(2, 'SZEFOSTWO', 'SAD');
--    banda(6, 'hmm', 'hmm');
end;
/
Select * from bandy;
SELECT * from USER_OBJECTS;
DROP procedure banda;

--zad41

CREATE OR REPLACE TRIGGER numer_trig
    BEFORE 
    INSERT
    ON Bandy
    FOR EACH ROW    
DECLARE
   maxnumer number default 0;
BEGIN
    Select count(nazwa) into maxnumer from bandy;
    :NEW.NR_BANDY:=maxnumer+1; --dostêp do nowej wartoœci atrybutu
END;
/

begin 
    banda(11, 'nazwa', 'teren'); 
end;
/

select * from bandy;
rollback;
drop trigger numer_trig;
drop procedure banda;

--ZAD42-------------------------------------------------------------------------------------------

create or replace package pamiec as
  przydzial_tygr number default 0; 
  nagroda number default 0;
  strata number default 0;  --ile razy tygrys ma straciæ
  pom number default 0;
  end;
/

create or replace trigger przydzial_tygrysa
    before update on KOCURY
begin
    SELECT PRZYDZIAL_MYSZY into pamiec.przydzial_tygr from KOCURY where PSEUDO = 'TYGRYS';
end;
/

create or replace trigger zmiany
    before update on KOCURY
    for each row
    declare
      roznica number default 0;
    begin
      if :new.FUNKCJA = 'MILUSIA' then                          --tylko dla milusi 
          IF :new.PRZYDZIAL_MYSZY <= :old.PRZYDZIAL_MYSZY then  --nie mo¿na wykonac przydzialu w dol
              dbms_output.put_line('Nie mozna zmieniæ przydzia³u '|| :old.PSEUDO||' z '|| :old.PRZYDZIAL_MYSZY||' na '|| :new.PRZYDZIAL_MYSZY);
              :new.PRZYDZIAL_MYSZY := :old.PRZYDZIAL_MYSZY;     --zostaje ten sam przydzial
          else
              roznica := :new.PRZYDZIAL_MYSZY - :old.PRZYDZIAL_MYSZY;
              IF roznica < 0.1*pamiec.przydzial_tygr  then            --mniej niz 10proc tygrysa
                  dbms_output.put_line('Kara za zmiane '|| :old.PSEUDO||' z '|| :old.PRZYDZIAL_MYSZY||' na '|| :new.PRZYDZIAL_MYSZY);
                  pamiec.strata := pamiec.strata+1;                   --+ kara dla tygrysa
                  dbms_output.put_line(pamiec.strata);
                  :new.PRZYDZIAL_MYSZY := :new.PRZYDZIAL_MYSZY + 0.1*pamiec.przydzial_tygr; --+10proc tygrysa dla milus
                  :new.MYSZY_extra := :new.MYSZY_extra + 5;                               --+5myszy extra
              elsif roznica > 0.1*pamiec.przydzial_tygr then           --wiecej niz 10proc tygrysa
                  pamiec.nagroda := pamiec.nagroda+1;                  --+ nagroda dla tygrysa
                  dbms_output.put_line(pamiec.nagroda);
                  dbms_output.put_line('Nagroda za zmiane '|| :old.PSEUDO||' z '|| :old.PRZYDZIAL_MYSZY||' na '|| :new.PRZYDZIAL_MYSZY);
              end if;
          end if;
      end if;
    end;
/
create or replace trigger zmiany_tygrysa
after update on KOCURY
 -- pom zmienna pomocnicza ile pomo¿yæ
    begin
        IF pamiec.strata >0 then
            pamiec.pom:= pamiec.strata;
            pamiec.strata :=0;        --zeby sie ten trigger nie odpalal za kazdym razem jak wywolamy dolna linijke - zapetlenie
            
            dbms_output.put_line('elo ' || pamiec.przydzial_tygr*0.1*pamiec.pom);
            update KOCURY set PRZYDZIAL_MYSZY = przydzial_myszy - FLOOR(pamiec.przydzial_tygr*0.1*pamiec.pom) where PSEUDO='TYGRYS';  --odejmujemy 10proc tyle razy ile kar
            dbms_output.put_line('Zabrano '|| FLOOR(pamiec.przydzial_tygr*0.1*pamiec.pom)||' przydzialu myszy tygrysowi.');
        end if;
        IF pamiec.nagroda >0 then
            pamiec.pom := pamiec.nagroda;
            pamiec.nagroda:=0;
            update KOCURY set MYSZY_extra  = MYSZY_extra+(5*pamiec.pom) where PSEUDO='TYGRYS';
            dbms_output.put_line('Dodano '|| 5*pamiec.pom ||' myszy extra tygrysowi');
        end if;
    end;
/
select * from KOCURY;
select * from KOCURY where funkcja = 'MILUSIA' or pseudo ='TYGRYS';
update KOCURY set PRZYDZIAL_MYSZY = (PRZYDZIAL_MYSZY +1) where FUNKCJA='MILUSIA';
update KOCURY set PRZYDZIAL_MYSZY = (PRZYDZIAL_MYSZY +20) where FUNKCJA='MILUSIA';
rollback ;

drop trigger przydzial_tygrysa;
drop trigger zmiany;
drop trigger zmiany_tygrysa;
drop package pamiec;
-- update KOCURY set PRZYDZIAL_MYSZY = 103 where PSEUDO='TYGRYS';

--zad42b-------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER kontrola
FOR UPDATE of przydzial_myszy
on Kocury
COMPOUND TRIGGER
    
    przydzial_tygr number default 0; 
    nagroda number default 0;
    strata number default 0;
    pom number default 0;
    
    before statement is

    begin
        SELECT PRZYDZIAL_MYSZY into przydzial_tygr from KOCURY where PSEUDO = 'TYGRYS';
    end before statement;

    before each row is 
        begin      
          if :new.FUNKCJA = 'MILUSIA' then                          --tylko dla milusi 
              IF :new.PRZYDZIAL_MYSZY <= :old.PRZYDZIAL_MYSZY then  --nie mo¿na wykonac przydzialu w dol
                  dbms_output.put_line('Nie mozna zmieniæ przydzia³u '|| :old.PSEUDO||' z '|| :old.PRZYDZIAL_MYSZY||' na '|| :new.PRZYDZIAL_MYSZY);
                  :new.PRZYDZIAL_MYSZY := :old.PRZYDZIAL_MYSZY;     --zostaje ten sam przydzial
              else
                  IF (:new.PRZYDZIAL_MYSZY - :old.PRZYDZIAL_MYSZY) < 0.1*przydzial_tygr  then            --mniej niz 10proc tygrysa
    --                 dbms_output.put_line(roznica || '  prz tygr: '|| przydzial_tygr);
                    dbms_output.put_line('Kara za zmiane '|| :old.PSEUDO||' z '|| :old.PRZYDZIAL_MYSZY||' na '|| :new.PRZYDZIAL_MYSZY);
                      strata := strata+1;                   --+ kara dla tygrysa
                      :new.PRZYDZIAL_MYSZY := :new.PRZYDZIAL_MYSZY + 0.1*przydzial_tygr; --+10proc tygrysa dla milus
                      :new.MYSZY_extra := :new.MYSZY_extra + 5;                               --+5myszy extra
                      dbms_output.put_line('halo ' || :new.MYSZY_extra);
                  elsif (:new.PRZYDZIAL_MYSZY - :old.PRZYDZIAL_MYSZY) > 0.1*przydzial_tygr then           --wiecej niz 10proc tygrysa
                      nagroda := nagroda+1;                  --+ nagroda dla tygrysa
                      dbms_output.put_line('Nagroda za zmiane '|| :old.PSEUDO||' z '|| :old.PRZYDZIAL_MYSZY||' na '|| :new.PRZYDZIAL_MYSZY);
                  end if;
              end if;
          end if;
    end before each row;
    
    AFTER EACH ROW IS
      BEGIN
        NULL;
    END AFTER EACH ROW;
    
    after statement is
         begin
           pom := 0;    --zmienna pomocnicza ile pomo¿yæ
       
            IF strata >0 then
                pom:= strata;
                strata :=0;        --zeby sie ten trigger nie odpalal za kazdym razem jak wywolamy dolna linijke - zapetlenie
                update KOCURY set PRZYDZIAL_MYSZY = FLOOR(PRZYDZIAL_MYSZY - PRZYDZIAL_MYSZY*0.1*pom) where PSEUDO='TYGRYS';  --odejmujemy 10proc tyle razy ile kar
                dbms_output.put_line('Zabrano '|| FLOOR(przydzial_tygr*0.1*pom)||' przydzialu myszy tygrysowi.');
            end if;
            IF nagroda >0 then
                pom := nagroda;
                nagroda:=0;
                update KOCURY set MYSZY_extra = MYSZY_extra+(5*pom) where PSEUDO='TYGRYS';
                dbms_output.put_line('Dodano '|| 5*pom ||' myszy extra tygrysowi');
            end if;
    end after statement;
END kontrola;
/

select * from KOCURY where funkcja = 'MILUSIA' or pseudo ='TYGRYS';
update KOCURY set PRZYDZIAL_MYSZY = (PRZYDZIAL_MYSZY + 1) where FUNKCJA='MILUSIA';
update KOCURY set PRZYDZIAL_MYSZY = (PRZYDZIAL_MYSZY + 13) where FUNKCJA='MILUSIA';
rollback;

drop trigger kontrola;
SELECT * FROM USER_TRIGGERS;






--CREATE OR REPLACE TRIGGER kontrola
--FOR UPDATE of przydzial_myszy
--on Kocury
--COMPOUND TRIGGER
--    
--    przydzial_tygr number default 0; 
--    nagroda number default 0;
--    strata number default 0;
--    nowy number default 0;
--    
--    roznica number default 0;
--    pom number default 0;
--    
--    before statement is
--    begin
--        SELECT PRZYDZIAL_MYSZY into przydzial_tygr from KOCURY where PSEUDO = 'TYGRYS';
--    end before statement;
--
--    before each row is 
--        begin
--          roznica := 0;
--        
--          if :new.FUNKCJA = 'MILUSIA' then                          --tylko dla milusi 
--              nowy := :new.PRZYDZIAL_MYSZY;
--              IF :new.PRZYDZIAL_MYSZY <= :old.PRZYDZIAL_MYSZY then  --nie mo¿na wykonac przydzialu w dol
--                  dbms_output.put_line('Nie mozna zmieniæ przydzia³u '|| :old.PSEUDO||' z '|| :old.PRZYDZIAL_MYSZY||' na '|| :new.PRZYDZIAL_MYSZY);
--                  :new.PRZYDZIAL_MYSZY := :old.PRZYDZIAL_MYSZY;     --zostaje ten sam przydzial
--              else
--                  roznica := :new.PRZYDZIAL_MYSZY - :old.PRZYDZIAL_MYSZY;
--                  IF roznica < 0.1*przydzial_tygr  then            --mniej niz 10proc tygrysa
--    --                 dbms_output.put_line(roznica || '  prz tygr: '|| przydzial_tygr);
--                    dbms_output.put_line('Kara za zmiane '|| :old.PSEUDO||' z '|| :old.PRZYDZIAL_MYSZY||' na '|| :new.PRZYDZIAL_MYSZY);
--                      strata := strata+1;                   --+ kara dla tygrysa
--                      :new.PRZYDZIAL_MYSZY := :new.PRZYDZIAL_MYSZY + 0.1*przydzial_tygr; --+10proc tygrysa dla milus
--                      :new.MYSZY_extra := :new.MYSZY_extra + 5;                               --+5myszy extra
--                      dbms_output.put_line('halo ' || :new.MYSZY_extra);
--                  elsif roznica > 0.1*przydzial_tygr then           --wiecej niz 10proc tygrysa
--                      :new.PRZYDZIAL_MYSZY := nowy;
--                      nagroda := nagroda+1;                  --+ nagroda dla tygrysa
--                      dbms_output.put_line('Nagroda za zmiane '|| :old.PSEUDO||' z '|| :old.PRZYDZIAL_MYSZY||' na '|| :new.PRZYDZIAL_MYSZY);
--                  end if;
--              end if;
--          end if;
--    end before each row;
--    
--    AFTER EACH ROW IS
--      BEGIN
--        NULL;
--    END AFTER EACH ROW;
--    
--    after statement is
--         begin
--           pom := 0;    --zmienna pomocnicza ile pomo¿yæ
--       
--            IF strata >0 then
--                pom:= strata;
--                strata :=0;        --zeby sie ten trigger nie odpalal za kazdym razem jak wywolamy dolna linijke - zapetlenie
--                update KOCURY set PRZYDZIAL_MYSZY = FLOOR(PRZYDZIAL_MYSZY - PRZYDZIAL_MYSZY*0.1*pom) where PSEUDO='TYGRYS';  --odejmujemy 10proc tyle razy ile kar
--                dbms_output.put_line('Zabrano '|| FLOOR(przydzial_tygr*0.1*pom)||' przydzialu myszy tygrysowi.');
--            end if;
--            IF nagroda >0 then
--                pom := nagroda;
--                nagroda:=0;
--                update KOCURY set MYSZY_extra = MYSZY_extra+(5*pom) where PSEUDO='TYGRYS';
--                dbms_output.put_line('Dodano '|| 5*pom ||' myszy extra tygrysowi');
--            end if;
--    end after statement;
--END kontrola;
--/
--
--select * from KOCURY where funkcja = 'MILUSIA' or pseudo ='TYGRYS';
--update KOCURY set PRZYDZIAL_MYSZY = (PRZYDZIAL_MYSZY + 1) where FUNKCJA='MILUSIA';
--update KOCURY set PRZYDZIAL_MYSZY = (PRZYDZIAL_MYSZY + 13) where FUNKCJA='MILUSIA';
--rollback;
--
--drop trigger kontrola;
--SELECT * FROM USER_TRIGGERS;

--zad43 

DECLARE
    cursor funkcje is SELECT funkcja from FUNKCJE order by funkcja;
    cursor bandyc is SELECT nazwa, NR_BANDY from BANDY order by nazwa;
    cursor plcie is SELECT PLEC from KOCURY group by PLEC order by plec;
    cursor przydzialy is 
        SELECT sum(NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0)) suma, b.nazwa, funkcja, plec 
        from KOCURY k join Bandy b on b.nr_bandy = k.nr_bandy
        group by b.nazwa, plec, funkcja
        order by b.nazwa, plec, funkcja;    
    cursor ileWBandzie is
        select count(*) ile
        from Kocury k join bandy b on k.nr_bandy = b.nr_bandy
        group by b.nazwa, plec
        order by b.nazwa, plec;
    cursor przydzialyPlci is
        SELECT SUM(PRZYDZIAL_MYSZY + NVL(MYSZY_extra,0)) ile 
        FROM KOCURY K, bandy b where K.nr_bandy = b.nr_bandy
        group by b.nazwa, plec
        order by b.nazwa, plec; 
    cursor przydzialyFunkcji is
         SELECT funkcja, SUM(NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_extra,0)) suma
         from Kocury K 
         group by funkcja
         order by funkcja;
         
    kotp przydzialy%ROWTYPE;
    il ileWBandzie%ROWTYPE;
    ilp przydzialyPlci%ROWTYPE;
    sumka przydzialyFunkcji%ROWTYPE;
    ilosc number;
    
BEGIN

   -- naglowek
    dbms_output.put('NAZWA BANDY       PLEC    ILE ');
    for fun in funkcje loop
      dbms_output.put(RPAD(fun.funkcja,10));
    end loop;

    dbms_output.put_line('    SUMA');
    dbms_output.put('----------------- ------ ----');

    for fun in funkcje loop
          dbms_output.put(' ---------');
    end loop;
    dbms_output.put_line(' --------');
    
    open przydzialy;
    open ileWBandzie;
    open przydzialyPlci;

    fetch przydzialy into kotp;
    
    for banda in bandyc loop
        for ple in plcie loop
            --¿eby tylko raz wyœwietla³o nazwe bandy
            dbms_output.put(case when ple.plec = 'M' then RPAD(banda.nazwa,18) else  RPAD(' ',18) end);
            dbms_output.put(case when ple.plec = 'M' then 'Kocor' else 'Kotka' end);
            
            --iloœæ kotów z dana banda i plcia
            fetch ileWBandzie into il;
            dbms_output.put(LPAD(il.ile,4));
            
            --ile zjada kto --musi byæ posortowane!
            for fun in funkcje loop                             
               if kotp.plec=ple.plec AND kotp.funkcja=fun.FUNKCJA AND kotp.nazwa = banda.nazwa
                then dbms_output.put(LPAD(NVL(kotp.suma,0),10));
                     fetch przydzialy into kotp; 
                else
                dbms_output.put(LPAD(0,10));
                end if;                
            end loop;
       
            fetch przydzialyPlci into ilp;
            dbms_output.put(LPAD(ilp.ile,10));
            dbms_output.new_line();
        end loop;
    end loop;
    
    close przydzialy;
    close ileWBandzie;
    close przydzialyPlci;
  
    dbms_output.put('----------------- ------ ----');
    for fun in funkcje loop dbms_output.put(' ---------'); end loop;
    dbms_output.put_line(' --------');

   --open przydzialyFunkcji;
    dbms_output.put('Zjada razem                ');
    
    for fun in funkcje loop
        for p in przydzialyFunkcji loop
            if p.funkcja = fun.funkcja and p.funkcja != 'HONOROWA'
            then dbms_output.put(LPAD(NVL(p.suma,0),10));
            end if;
        end loop;    
        if fun.funkcja = 'HONOROWA'
        then dbms_output.put(LPAD('0',10));
        end if;
    
    end loop;

--    for fun in funkcje loop
--        SELECT SUM(NVL(PRZYDZIAL_MYSZY,0)+NVL(MYSZY_EXTRA,0)) into ilosc from Kocury K 
--        where K.FUNKCJA=fun.FUNKCJA;
--        dbms_output.put(LPAD(NVL(ilosc,0),10));
--    end loop;
    
    --close przydzialyFunkcji;
    SELECT sum(nvl(PRZYDZIAL_MYSZY,0)+nvl(MYSZY_extra,0)) into ilosc FROM Kocury;
    dbms_output.put(LPAD(ilosc,10));
    dbms_output.new_line();
end;
/

--zad44---------------------------------------------------------------------------------------------------------------------
   
create or replace package podatek_package as
    function podatek(pseudonim Kocury.pseudo%TYPE) return number;
    procedure banda(numerb Number, nazwab Bandy.nazwa%TYPE,terenb Bandy.teren%TYPE);
end podatek_package;
/

create or replace package body podatek_package as
    function podatek (pseudonim Kocury.pseudo%TYPE) return number is
    podatek number default 0;
    ile number default 0;
    przydz number default 0 ;
    begin
      select ceil(0.05*(nvl(PRZYDZIAL_MYSZY,0)+nvl(MYSZY_EXTRA,0))) 
      into podatek from KOCURY where pseudonim=KOCURY.PSEUDO; --5%

      SELECT count(pseudo) into ile from KOCURY where SZEF = pseudonim;            
      if ile <= 0 then podatek:=podatek+2; end if ;

      SELECT count(pseudo) into ile from WROGOWIE_KOCUROW where pseudo=pseudonim; 
      if ile <= 0 then podatek:=podatek+1; end if;

      -- je¿eli ma przydzia³ > 30 to -2 myszki
      SELECT przydzial_myszy into przydz from KOCURY WHERE pseudonim=pseudo;
      if przydz > 30 then podatek:=podatek+2; end if; 

      return podatek;
    end;

    Procedure banda(numerb Number, nazwab Bandy.nazwa%TYPE,terenb Bandy.teren%TYPE)   
    is
        found BOOLEAN default false;
        found1 BOOLEAN default false;
        found2 BOOLEAN default false;
        found3 BOOLEAN default false;
        zlynumer exception;
        zlabanda exception;
        komunikat varchar2(256) := '';
    BEGIN
        if numerb <= 0 then raise zlynumer;
        end if;
        
        for i in (select nr_bandy from bandy)
        loop
            if numerb = i.nr_bandy then 
            found := true;
            found1 := true;
            end if;
        end loop;  
        
        if found1 then 
            komunikat := komunikat || numerb || ': ju¿ istnieje, ';
        else
            komunikat := komunikat || numerb || ', ';
        end if;
            
        for i in (select nazwa from bandy)
        loop
            if nazwab = i.nazwa then 
            found := true;
            found2 := true;
            end if;
        end loop;
        
        if found2 then 
            komunikat := komunikat || nazwab || ': ju¿ istnieje, ';
        else
            komunikat := komunikat || nazwab || ', ';
        end if;
            
        for i in (select teren from bandy)
        loop
            if terenb = i.teren then 
            found := true;
            found3 := true;
            end if;
        end loop;
        
        if found3 then 
            komunikat := komunikat || terenb || ': ju¿ istnieje ';
        else
            komunikat := komunikat || terenb;
        end if;
        
        dbms_output.put_line(komunikat);
        if found then raise zlabanda; end if;
        
        INSERT INTO Bandy (nr_bandy, nazwa, teren) values (numerb, nazwab, terenb) ;
    exception
        when zlynumer then dbms_output.put_line('Numer musi byæ > 0');
        when zlabanda then dbms_output.put_line('Taka banda ju¿ istnieje');
        when others then dbms_output.put_line(sqlerrm);
    END;
end;
/

begin
  dbms_output.put(RPAD('PSEUDONIM',10));
  dbms_output.put(LPAD('PODATEK',10));
  dbms_output.new_line();
  for kocur in (SELECT PSEUDO from Kocury) loop
    dbms_output.put_line(RPAD(kocur.pseudo,10) || LPAD(podatek_package.podatek(kocur.pseudo),10));
  end loop;
end;
/

drop package podatek_package;

--zad45

drop table DODATKI_EXTRA;
create table DODATKI_EXTRA (    --autmatycznie generuje id wiêksze
    ID_DODATKU number(2) generated by default on null as identity constraint dod_pk_id primary key,
    PSEUDO varchar2(15) constraint dod_fg_pseudo references KOCURY(PSEUDO),
    DODATEK_EXTRA number(3) not null
);


create or replace trigger mechanizm
for UPDATE of przydzial_myszy, myszy_extra
on Kocury 
compound trigger
    strata number default 0; 
    pse Kocury.pseudo%TYPE;
    
before each row is
begin
    if :new.funkcja = 'MILUSIA' and (:new.przydzial_myszy > :old.przydzial_myszy 
            or :new.myszy_extra > :old.myszy_extra) then
            if login_user != 'TYGRYS' then
                :new.PRZYDZIAL_MYSZY := :old.PRZYDZIAL_MYSZY;
                strata := 1;
                pse := :new.pseudo;
            end if;                 
    end if;  
end before each row;

after statement is
    begin
        IF strata > 0 then
             --insert into DODATKI_EXTRA(PSEUDO,DODATEK_EXTRA) values (pse, -10);
            for i in (select pseudo from Kocury where funkcja = 'MILUSIA') loop
                insert into DODATKI_EXTRA(PSEUDO,DODATEK_EXTRA) values (i.PSEUDO, -10);
            end loop;
        end if;
end after statement;    
end;
/
        
select * from dodatki_extra;

update Kocury set przydzial_myszy = 200
where pseudo = 'PUSZYSTA';

drop trigger mechanizm;
drop trigger monitor_wykroczen;
rollback;
drop table dodatki_extra;

--('SONIA','D','PUSZYSTA','MILUSIA','ZOMBI','2010-11-18',20,35,3


-- Zadanie 46 --
CREATE TABLE proby_wykroczenia 
(
    kto VARCHAR2(15) NOT NULL, 
    kiedy DATE NOT NULL,
    komu VARCHAR2(15) NOT NULL,
    operacja VARCHAR2(15) NOT NULL
);

DROP TABLE proby_wykroczenia;

CREATE OR REPLACE TRIGGER monitor_wykroczen
    BEFORE INSERT OR UPDATE OF PRZYDZIAL_MYSZY
    ON KOCURY
    FOR EACH ROW
DECLARE
    min_mysz FUNKCJE.MIN_MYSZY%TYPE;
    max_mysz FUNKCJE.MAX_MYSZY%TYPE;
    curr_data DATE DEFAULT SYSDATE;
    zdarzenie VARCHAR2(20);
    poza_zakresem EXCEPTION;
--  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    SELECT MIN_MYSZY, MAX_MYSZY INTO min_mysz, max_mysz FROM FUNKCJE WHERE FUNKCJA = :NEW.FUNKCJA;
    IF max_mysz < :NEW.PRZYDZIAL_MYSZY OR min_mysz > :NEW.PRZYDZIAL_MYSZY THEN
        IF INSERTING THEN 
            zdarzenie := 'INSERT';
        ELSIF UPDATING THEN
            zdarzenie := 'UPDATE';
        END IF;
        INSERT INTO Proby_wykroczenia(kto, kiedy, komu, operacja) 
        VALUES (ORA_LOGIN_USER, curr_data, :NEW.PSEUDO, zdarzenie);
        --COMMIT;
        :NEW.PRZYDZIAL_MYSZY := :OLD.PRZYDZIAL_MYSZY;
    end if;
END;
/
UPDATE KOCURY
SET PRZYDZIAL_MYSZY = 200
WHERE IMIE = 'JACEK';

INSERT INTO Kocury VALUES ('ELWIRA','D','DAMECZKA','KOT','TYGRYS','2022-12-01',70,NULL,4);

SELECT * FROM Kocury where imie = 'JACEK';
SELECT * FROM Proby_wykroczenia;


ROLLBACK;

DROP TABLE Proby_wykroczenia;
drop trigger monitor_wykroczen;


   --     COMMIT;
--        RAISE poza_zakresem;
--    END IF;
--EXCEPTION
--    WHEN poza_zakresem THEN
--        DBMS_OUTPUT.PUT_LINE('poza zakresem');


--LISTA 4


-- 47---------------------------------------------------------------------------------------------------------

DROP TYPE KocuryO Force;

CREATE OR REPLACE TYPE KocuryO FORCE AS OBJECT
(
 imie VARCHAR2(15),
 plec VARCHAR2(1),
 pseudo VARCHAR2(10),
 funkcja VARCHAR2(10),
 szef REF KocuryO,
 w_stadku_od DATE,
 przydzial_myszy NUMBER(3),
 myszy_extra NUMBER(3),
 nr_bandy NUMBER(2),
 MEMBER FUNCTION przedstaw_sie RETURN VARCHAR2,
 MEMBER FUNCTION zarobki RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY KocuryO AS
  MEMBER FUNCTION przedstaw_sie RETURN VARCHAR2 IS
    BEGIN
      RETURN imie||', mój pseudonim '||pseudo||', od: '||TO_CHAR(w_stadku_od, 'yyyy-mm-dd');
    END; 
  MEMBER FUNCTION zarobki RETURN NUMBER IS
    BEGIN
      RETURN przydzial_myszy + NVL(myszy_extra, 0);
    END;
END;
/
--Klucz g³ówny relacji z obiektem wierszowym nie mo¿e byæ oparty 
--na polu o typie odniesienia (REF). 
CREATE OR REPLACE TYPE PlebsO AS OBJECT
(
  idn INTEGER,
  kot REF KocuryO,
  MEMBER FUNCTION dane_o_kocie RETURN VARCHAR2
);
/

CREATE OR REPLACE TYPE BODY PlebsO AS
  MEMBER FUNCTION dane_o_kocie RETURN VARCHAR2 IS
      text VARCHAR2(500);
    BEGIN
      SELECT 'IMIE: ' || DEREF(kot).imie || ' PSEUDO ' || DEREF(kot).pseudo 
      INTO text FROM dual;
      RETURN text;
    END;
END;
/

CREATE OR REPLACE TYPE ElitaO AS OBJECT
(
  idn INTEGER,
  kot REF KocuryO,
  sluga REF PlebsO,
  MEMBER FUNCTION pobierz_sluge RETURN REF PlebsO
);
/

CREATE OR REPLACE TYPE BODY ElitaO AS
  MEMBER FUNCTION pobierz_sluge RETURN REF PlebsO IS
    BEGIN
      RETURN sluga;
    END;
END;
/

CREATE OR REPLACE TYPE WpisO AS OBJECT
(
  idn INTEGER,
  dataWprowadzenia DATE,
  dataUsuniecia DATE,
  kot REF ElitaO,
  MEMBER PROCEDURE wyprowadz_mysz(dat DATE)
);
/

CREATE OR REPLACE TYPE BODY WpisO AS
  MEMBER PROCEDURE wyprowadz_mysz(dat DATE) IS
    BEGIN
      datausuniecia := dat;
    END;
END;
/

DROP TABLE KocuryT;
DROP TABLE PlebsT;
DROP TABLE ElitaT;
DROP TABLE WpisT;

DROP TYPE KocuryO force;
DROP TYPE PlebsO force;
DROP TYPE ElitaO force;
DROP TYPE WpisO force;


CREATE TABLE KocuryT OF KocuryO
(CONSTRAINT KocuryT_key PRIMARY KEY (pseudo));

CREATE TABLE PlebsT OF PlebsO
(CONSTRAINT PlebsT_key PRIMARY KEY (idn));

CREATE TABLE ElitaT OF ElitaO
(CONSTRAINT ElitaT_key PRIMARY KEY (idn));

CREATE TABLE WpisT OF WpisO
(CONSTRAINT WpisT_key PRIMARY KEY (idn));

INSERT INTO KocuryT VALUES (KocuryO('MRUCZEK','M','TYGRYS','SZEFUNIO',NULL,'2002-01-01',103,33,1));

INSERT INTO KocuryT VALUES (KocuryO('CHYTRY','M','BOLEK','DZIELCZY',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'TYGRYS'),'2002-05-05',50,NULL,1));
INSERT INTO KocuryT VALUES (KocuryO('KOREK','M','ZOMBI','BANDZIOR',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'TYGRYS'),'2004-03-16',75,13,3));
INSERT INTO KocuryT VALUES (KocuryO('BOLEK','M','LYSY','BANDZIOR',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'TYGRYS'),'2006-08-15',72,21,2));
INSERT INTO KocuryT VALUES (KocuryO('MICKA','D','LOLA','MILUSIA',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'TYGRYS'),'2009-10-14',25,47,1));
INSERT INTO KocuryT VALUES (KocuryO('RUDA','D','MALA','MILUSIA',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'TYGRYS'),'2006-09-17',22,42,1));
INSERT INTO KocuryT VALUES (KocuryO('PUCEK','M','RAFA','LOWCZY',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'TYGRYS'),'2006-10-15',65,NULL,4));

INSERT INTO KocuryT VALUES (KocuryO('JACEK','M','PLACEK','LOWCZY',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'LYSY'),'2008-12-01',67,NULL,2));
INSERT INTO KocuryT VALUES (KocuryO('BARI','M','RURA','LAPACZ',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'LYSY'),'2009-09-01',56,NULL,2));
INSERT INTO KocuryT VALUES (KocuryO('ZUZIA','D','SZYBKA','LOWCZY',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'LYSY'),'2006-07-21',65,NULL,2));
INSERT INTO KocuryT VALUES (KocuryO('BELA','D','LASKA','MILUSIA',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'LYSY'),'2008-02-01',24,28,2));

INSERT INTO KocuryT VALUES (KocuryO('LATKA','D','UCHO','KOT',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'RAFA'),'2011-01-01',40,NULL,4));
INSERT INTO KocuryT VALUES (KocuryO('DUDEK','M','MALY','KOT',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'RAFA'),'2011-05-15',40,NULL,4));
INSERT INTO KocuryT VALUES (KocuryO('KSAWERY','M','MAN','LAPACZ',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'RAFA'),'2008-07-12',51,NULL,4));
INSERT INTO KocuryT VALUES (KocuryO('MELA','D','DAMA','LAPACZ',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'RAFA'),'2008-11-01',51,NULL,4));

INSERT INTO KocuryT VALUES (KocuryO('PUNIA','D','KURKA','LOWCZY',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'ZOMBI'),'2008-01-01',61,NULL,3));
INSERT INTO KocuryT VALUES (KocuryO('SONIA','D','PUSZYSTA','MILUSIA',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'ZOMBI'),'2010-11-18',20,35,3));

INSERT INTO KocuryT VALUES (KocuryO('LUCEK','M','ZERO','KOT',(SELECT ref(k) FROM kocuryT k WHERE pseudo = 'KURKA'),'2010-03-01',43,NULL,3));

COMMIT;

SELECT * FROM kocuryT;

CREATE OR REPLACE TRIGGER trig_plebs_elita
BEFORE INSERT ON PlebsT
FOR EACH ROW
DECLARE
    num INTEGER;
BEGIN
    SELECT COUNT(*) INTO num
    FROM ElitaT e 
    WHERE e.kot = :new.kot;
    
    if num > 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'Kot nie moze zostac dodany, jest z ELITY');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trig_elita_plebs
BEFORE INSERT ON ElitaT
FOR EACH ROW
DECLARE
    num INTEGER;
BEGIN
    SELECT COUNT(*) INTO num
    FROM PlebsT p 
    WHERE p.kot = :new.kot;
    
    if num > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Kot nie moze zostac dodany, jest z PLEBSU');
    END IF;
END;
/

--Wartoœæ identyfikatora OID mo¿na uzyskaæ poprzez wykorzystanie funkcji/operatora REF 
--w zapytaniu SELECT, której argumentem jest alias do relacji z obiektem wierszowym. 
INSERT INTO PlebsT
    SELECT PlebsO(ROWNUM, REF(K))
    FROM KocuryT K
    WHERE K.funkcja = 'KOT'
COMMIT;

select ref(p), idn, value(p).kot.pseudo from plebst p;

--select ref(p).dane_o_kocie() from plebst p;
select * from plebst;

INSERT INTO ElitaT
  SELECT ElitaO(ROWNUM, REF(K), NULL)
  FROM KocuryT K
  WHERE K.szef IS NULL OR K.szef = (SELECT ref(k) FROM kocuryT k WHERE pseudo = 'TYGRYS');
--  WHERE K.szef = 'TYGRYS'
--        OR K.pseudo = 'TYGRYS';
COMMIT; 

select deref(kot).pseudo from elitat;
--wstawiamy s³uge z plebsu o id 1 do kota z elity (RAFA)
UPDATE ElitaT
SET sluga = (SELECT REF(T) FROM plebst T WHERE idn = 1)
WHERE DEREF(kot).pseudo = 'RAFA';
COMMIT;

----------------------------------------Niedzia³aj¹ce inserty (triggery)

INSERT INTO ElitaT
  SELECT ElitaO(ROWNUM, REF(K), NULL)
  FROM KocuryT K
  WHERE K.pseudo = 'UCHO';
COMMIT;

INSERT INTO PlebsT
  SELECT PlebsO(ROWNUM, REF(K))
  FROM KocuryT K
  WHERE K.pseudo = 'TYGRYS';
COMMIT;

--ROWNUM tworzy siê dla tego selecta
--wpiso nam tworzy nowy obiekt
INSERT INTO WpisT
  SELECT WpisO(ROWNUM, ADD_MONTHS(CURRENT_DATE, -TRUNC(DBMS_RANDOM.VALUE(0, 12))), NULL, REF(K))
  FROM ElitaT K;
COMMIT;

select * from wpist;

--U¯YCIE VALUE
select ref(e) oid , e.idn, value(e).kot.pseudo pseudo_kota from elitat e;
select ref(e) oid , e.idn, value(e).kot.zarobki() zarobki_kota from elitat e;

select e.idn, value(e).kot.przedstaw_sie() przedstawienie from elitat e;
select e.idn, e.kot.przedstaw_sie() przedstawienie from elitat e;   --tylko w sql
select e.idn, deref(e.kot).przedstaw_sie() przedstawienie from elitat e;    --tak w pl/sql

select e.idn, value(e).kot przedstawienie from elitat e;
select e.idn, deref(e.kot) przedstawienie from elitat e; 

-- JOIN z REF
select * from elitat e
join kocuryt k on ref(k) = e.kot;

--PODZAPYTANIE wpisy i kocury z przydzialem + uzycie metody
select ("ko").przedstaw_sie(), ("ko").przydzial_myszy from wpist w
join 
(select ref(k) "ko" from kocuryt k where k.przydzial_myszy > 30)
on ("ko") = w.kot.kot;


-- grupowanie i metoda
SELECT k.funkcja, ROUND(AVG(k.zarobki()),2) FROM kocuryt k
GROUP BY k.funkcja;


--zad18

select k1.imie, to_char(K1.w_stadku_od, 'yyyy-mm-dd') "POLUJE OD"
from Kocuryt k1, Kocuryt k2
where k2.imie = 'JACEK' AND k1.w_stadku_od<k2.w_stadku_od
ORDER BY k1.w_stadku_od DESC
;

--zad19a

SELECT k1.imie, k1.funkcja, (k1.szef).pseudo "Szef 1", 
NVL(((k1.szef).szef).pseudo,' ') "Szef 2", 
NVL((((k1.szef).szef).szef).pseudo,' ') "Szef 3"
FROM Kocuryt k1 
WHERE k1.funkcja = 'KOT' OR k1.funkcja = 'MILUSIA'                
;

--zad26

select funkcja, round(avg(przydzial_myszy + NVL(myszy_extra, 0)))
"Srednio najw. i najm. myszy"
from kocuryt
group by funkcja
having (avg(przydzial_myszy + NVL(myszy_extra, 0))) in
(
    (select max(A) from 
        (select avg(przydzial_myszy + NVL(myszy_extra, 0)) as A
        from kocuryt
        where funkcja != 'SZEFUNIO'
        group by funkcja)
    ),
    (
    select min(AV) from 
        (select avg(przydzial_myszy + NVL(myszy_extra, 0)) as AV
        from kocuryt
        group by funkcja)
    )
)
;

--zad34
DECLARE
    liczba NUMBER;
    fun Kocuryt.funkcja%TYPE ;
BEGIN
    SELECT count(pseudo), min(funkcja) into liczba, fun
    From Kocuryt
    Where funkcja = '&nazwa_funkcji';
    if liczba > 0 then dbms_output.put_line('Znaleziono kota pelniacego funkcje ' || fun);
    else DBMS_OUTPUT.PUT_LINE('Nie znaleziono');
    end if;
end;
/

--zad35

DECLARE
    imie Kocuryt.imie%TYPE;
    przydzial Number;
    miesiac number;
    found BOOLEAN default false;
BEGIN
    Select  imie, (nvl(przydzial_myszy,0)+nvl(myszy_extra,0))*12, extract(month from w_stadku_od)
    INTO imie, przydzial, miesiac
    From Kocuryt
    Where pseudo = upper('&pseudo');

    If przydzial > 700 then dbms_output.put_line(imie || ' calkowity przydzial myszy > 700');
                            found := true;
    END IF;
    if miesiac = 5 then dbms_output.put_line(imie || ' maj jest miesiacem przystapienia do stada');
                        found := true;
    END IF;
    if imie LIKE '%A%' THEN DBMS_OUTPUT.PUT_LINE(imie || ' imie zawiera litere A');
                            found := true;
    END IF;
    IF not found then dbms_output.put_line(imie || ' nie odpowiada kryteriom');
    END IF;
    Exception
    when no_data_found then dbms_output.put_line('Nie znaleziono takiego kota');
    when others then dbms_output.put_line(sqlerrm);
END;
/




-- zadanie 49 -----------------------------------------------------------------------------
CREATE TABLE Myszy (
    nr_myszy        NUMBER(10)           CONSTRAINT mys_nr_pk PRIMARY KEY,
    lowca           VARCHAR2(15)        CONSTRAINT koc_low_fk REFERENCES Kocury(pseudo),
    zjadacz         VARCHAR2(15)        CONSTRAINT koc_zja_fk REFERENCES Kocury(pseudo),
    waga_myszy      NUMBER(3)           CONSTRAINT waga_myszy_ogr CHECK (waga_myszy BETWEEN 10 AND 120),
    data_zlowienia  DATE                CONSTRAINT dat_nn NOT NULL,
    data_wydania    DATE,
    CONSTRAINT daty_popr CHECK (data_zlowienia <= data_wydania)
);
DROP TABLE Myszy;

CREATE SEQUENCE  numery_myszy;  --numeracja wszystkich myszy
ALTER SESSION SET NLS_DATE_FORMAT ='YYYY-MM-DD';   
DROP SEQUENCE numery_myszy;

DECLARE
    pierwszy_dzien DATE := TO_DATE('2004-1-1');
    ostatnia_sroda DATE := NEXT_DAY(LAST_DAY(pierwszy_dzien) - 7, 'ŒRODA');
    ostatni_dzien DATE := TO_DATE('2023-1-22');
    myszy_mies NUMBER(4);
    TYPE tp IS TABLE OF Kocury.pseudo%TYPE;
    tab_pseudo tp := tp();
    TYPE tm IS TABLE OF NUMBER(3);
    tab_myszy tm := tm();
    TYPE myszy_rek IS TABLE OF Myszy%ROWTYPE INDEX BY BINARY_INTEGER;
    myszki myszy_rek;
    nr_myszy BINARY_INTEGER := 0;
    indeks_zjadacza NUMBER(5);
    nadwyzka NUMBER(3);
    srednia NUMBER(3);
    lw NUMBER;
BEGIN
    LOOP
        EXIT WHEN pierwszy_dzien >= ostatni_dzien;       
        IF pierwszy_dzien < NEXT_DAY(LAST_DAY(pierwszy_dzien), 'ŒRODA') - 7 THEN
                ostatnia_sroda := NEXT_DAY(LAST_DAY(pierwszy_dzien), 'ŒRODA') - 7;
        ELSE    --je¿eli po ost œrodzie to kolejny miesi¹c
            ostatnia_sroda := NEXT_DAY(LAST_DAY(ADD_MONTHS(pierwszy_dzien, 1)), 'ŒRODA') - 7;
        END IF;
        IF ostatnia_sroda > ostatni_dzien THEN
            ostatnia_sroda := ostatni_dzien;
        END IF;     
        SELECT SUM(NVL(przydzial_myszy,0) + NVL(myszy_extra,0))
        INTO myszy_mies FROM KOCURY WHERE W_STADKU_OD < ostatnia_sroda;       
        --je¿eli ju¿ by³ w stadku, zapisujemy ile myszy dany pseudo
        SELECT pseudo, NVL(przydzial_myszy,0) + NVL(myszy_extra,0) BULK COLLECT INTO tab_pseudo, tab_myszy
        FROM KOCURY WHERE W_STADKU_OD < ostatnia_sroda;       
        indeks_zjadacza :=1;
        srednia := CEIL(0.86*myszy_mies/tab_pseudo.COUNT);   --tyle myszy na jednego
        nadwyzka := srednia * tab_pseudo.COUNT - myszy_mies;
        
--Liczba wpisanych myszy, upolowanych w  konkretnym miesi¹cu, ma byæ zgodna z 
--liczb¹ myszy, które koty otrzyma³y w ramach „wyp³aty” w tym miesi¹cu 
        FOR i IN 1..(srednia*tab_pseudo.COUNT)
        LOOP
            nr_myszy := nr_myszy+1;
            myszki(nr_myszy).NR_MYSZY := nr_myszy;
            myszki(nr_myszy).lowca := tab_pseudo(MOD(i,tab_pseudo.COUNT)+1);
--je¿eli ustawi siê ostatni dzieñ przed ostatni¹ œrod¹ miesiaca to ¿eby doda³y siê
--myszy ale nie przypisa³ ¿aden zjadacz, bo inaczej zostan¹ od razu wydane
            IF ostatnia_sroda != ostatni_dzien THEN --wczeœniej jest przypisanie
                myszki(nr_myszy).DATA_WYDANIA := ostatnia_sroda;              
                --wybieranie zjadacza myszki
                IF(tab_myszy(indeks_zjadacza) = 0 ) THEN
                    indeks_zjadacza := indeks_zjadacza + 1;
                ELSE
                    tab_myszy(indeks_zjadacza) := tab_myszy(indeks_zjadacza)-1; --pobieramy kolejn¹ myszkê do zapisu
                END IF;
                --nadwy¿ka, przesliœmy wszystkie myszy
                IF indeks_zjadacza > tab_myszy.COUNT THEN
                    indeks_zjadacza := DBMS_RANDOM.VALUE(1,tab_myszy.COUNT);
                END IF;              
                myszki(nr_myszy).zjadacz := tab_pseudo(indeks_zjadacza);
            END IF;           
            myszki(nr_myszy).WAGA_MYSZY := DBMS_RANDOM.VALUE(10,120);
            myszki(nr_myszy).DATA_ZLOWIENIA := pierwszy_dzien + MOD(nr_myszy,TRUNC(ostatnia_sroda) - TRUNC(pierwszy_dzien));
        END LOOP;       
        pierwszy_dzien := ostatnia_sroda +1;      
    END LOOP;

    FORALL i IN 1..myszki.COUNT
        INSERT INTO Myszy(nr_myszy, lowca, zjadacz, waga_myszy,data_zlowienia, data_wydania)
            VALUES(numery_myszy.NEXTVAL, myszki(i).lowca, myszki(i).zjadacz, myszki(i).waga_myszy, myszki(i).data_zlowienia, myszki(i).data_wydania);
END;
/

SELECT * FROM Myszy order by nr_myszy desc;
DELETE FROM Myszy;
CREATE SEQUENCE  numery_myszy;  --numeracja wszystkich myszy
DROP SEQUENCE numery_myszy;

SELECT COUNT(*) FROM Myszy;

Select * from myszy where data_wydania is not null;


-- tabele myszy dla kazdego kota

BEGIN
    FOR kot IN (SELECT pseudo FROM Kocury)
    LOOP
        EXECUTE IMMEDIATE 'CREATE TABLE Myszy_' || kot.pseudo || '(
            nr_myszy NUMBER(7) CONSTRAINT myszy_pk_'|| kot.pseudo || ' PRIMARY KEY,
            waga_myszy NUMBER(3) CONSTRAINT waga_myszy_' || kot.pseudo ||' CHECK (waga_myszy BETWEEN 10 AND 120),
            data_zlowienia DATE CONSTRAINT data_zlowienia_nn_' || kot.pseudo ||' NOT NULL)';
    END LOOP;
END;
/

select * from Myszy_TYGRYS;

BEGIN
    FOR kot IN (SELECT pseudo FROM Kocury)
    LOOP
        EXECUTE IMMEDIATE 'DROP TABLE Myszy_' || kot.pseudo;
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE przyjmij_myszy(userPseudo Kocury.pseudo%TYPE, data DATE)
AS
    TYPE tw IS TABLE OF NUMBER(3);
        tab_wagi tw:=tw();
    TYPE tn IS TABLE OF NUMBER(10);
        tab_nr tn := tn();
    myCount NUMBER(2);
    kot_exc EXCEPTION;
    data_exc EXCEPTION;
BEGIN
    IF data>sysdate THEN    --przysz³oœæ
        RAISE data_exc;
    end if;
    
    SELECT count(K.pseudo) INTO myCount FROM KOCURY K WHERE K.PSEUDO = userPseudo;
    IF myCount = 0 THEN --nie ma takiego kota
        RAISE kot_exc;
    end if;
    
    EXECUTE IMMEDIATE 'SELECT nr_myszy, waga_myszy FROM Myszy_'||userPseudo || ' WHERE data_zlowienia= ''' || data || ''''
    BULK COLLECT INTO tab_nr, tab_wagi;
    
    FORALL i in 1..tab_wagi.COUNT
        INSERT INTO Myszy VALUES (tab_nr(i), userPseudo, NULL, tab_wagi(i),data, NULL);

    EXECUTE IMMEDIATE 'DELETE FROM Myszy_'|| userPseudo || ' WHERE data_zlowienia= ''' || data || '''';
    
    EXCEPTION
    WHEN kot_exc THEN DBMS_OUTPUT.PUT_LINE('Brak kota o podanym pseudonimie');
    WHEN data_exc THEN DBMS_OUTPUT.PUT_LINE('B³êdna data');
end;
/


SELECT * FROM MYSZY_TYGRYS;


INSERT INTO MYSZY_TYGRYS VALUES(NUMERY_MYSZY.nextval, 70, '2023-01-22');
INSERT INTO MYSZY_TYGRYS VALUES(NUMERY_MYSZY.nextval, 50, '2023-01-22');


BEGIN
    przyjmij_myszy('TYGRYS','2023-01-22'); 
END;
/

select * from myszy order by data_zlowienia DESC;
SELECT * FROM MYSZY_TYGRYS;

rollback;
DELETE FROM MYSZY_TYGRYS;
--------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE WYPLAC AS
    TYPE tp IS TABLE OF Kocury.pseudo%TYPE;
    tab_pseudo tp := tp();
    TYPE tm is TABLE OF NUMBER(4);
    tab_myszy tm := tm();
    TYPE tn IS TABLE OF NUMBER(7);
    tab_nr tn:=tn();
    dzien_wyplaty DATE:=(NEXT_DAY(LAST_DAY(SYSDATE)-7, 'ŒRODA'));
    TYPE tps IS TABLE OF Kocury.pseudo%TYPE INDEX BY BINARY_INTEGER;
    tab_zjadaczy tps;
    liczba_najedzonych NUMBER(2):=0;
    ind_zjadacza NUMBER(2):=1;
    czy_wyplata_byla NUMBER(4);
BEGIN
--    IF (SYSDATE != dzien_wyplaty) THEN
--        RAISE_APPLICATION_ERROR(-20002, 'Dzis nie jest ostatnia sroda miesiaca, nie mozesz robic wyplaty');
--    END IF;

--czy w tym miesi¹cu ju¿ by³a wyp³ata?    
    SELECT COUNT(*) INTO czy_wyplata_byla FROM MYSZY WHERE TO_CHAR(data_wydania) = TO_CHAR(dzien_wyplaty);
    IF (czy_wyplata_byla > 0) THEN
        DBMS_OUTPUT.PUT_LINE(czy_wyplata_byla);
        RAISE_APPLICATION_ERROR(-20003, 'Wyplata na ten miesiac juz byla dokonana');
    END IF;

    SELECT pseudo, NVL(przydzial_myszy,0)+NVL(myszy_extra, 0)
        BULK COLLECT INTO tab_pseudo, tab_myszy
        FROM KOCURY CONNECT BY PRIOR pseudo = SZEF
        START WITH szef IS NULL
        ORDER BY level;
    
    --niewydane myszy
    SELECT nr_myszy
        BULK COLLECT INTO tab_nr
        FROM MYSZY WHERE DATA_WYDANIA IS NULL;

    FOR i IN 1..tab_nr.COUNT
    LOOP    --karmimy, o ile jeszcze nie wszyscy sie najedli
        WHILE tab_myszy(ind_zjadacza)=0 AND liczba_najedzonych<tab_pseudo.COUNT
        LOOP
            liczba_najedzonych := liczba_najedzonych+1;
            ind_zjadacza := MOD(ind_zjadacza+1, tab_pseudo.COUNT)+1; 
        end loop;
        
        --nadwy¿ki dla tygrysa
        IF liczba_najedzonych = tab_pseudo.COUNT THEN
            tab_zjadaczy(i) := 'TYGRYS';
        ELSE
            ind_zjadacza := MOD(ind_zjadacza+1, tab_pseudo.COUNT)+1;
            tab_zjadaczy(i) := tab_pseudo(ind_zjadacza);            --uk³adamy ich w hierarchii w giga tablicy
            tab_myszy(ind_zjadacza) := tab_myszy(ind_zjadacza)-1;   --zmniejszamy ile jeszcze mo¿e zjeœæ
        end if;
    end loop;
--kto i kiedy zjad³ myszki
    FORALL i IN 1..tab_nr.COUNT
        EXECUTE IMMEDIATE
        'UPDATE Myszy SET data_wydania=''' || dzien_wyplaty|| ''', zjadacz=:ps
        WHERE nr_myszy=:nr'
        USING tab_zjadaczy(i), tab_nr(i);
end;
/

SELECT * FROM Myszy where data_wydania is null order by nr_myszy desc;
SELECT * FROM Myszy order by nr_myszy desc;

BEGIN 
    WYPLAC;
END;
/
ROLLBACK;


