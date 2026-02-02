--ZADANIE 1
CREATE TABLE CYTATY AS SELECT * FROM ZTPD.CYTATY;

--ZADANIE 2
select autor, tekst
from cytaty
where lower(tekst) like '%optymista%' and lower(tekst) like '%pesymista%';


--ZADANIE 3
CREATE INDEX cytaty_ctx on cytaty(tekst) indextype is ctxsys.context;

--ZADANIE 4
SELECT * from cytaty where contains(tekst,'optymista AND pesymista')>0;

--ZADANIE 5
SELECT autor, tekst
from cytaty
where contains(tekst, 'optymista AND pesymista', 1) > 0;

--ZADANIE 6
SELECT * FROM cytaty
WHERE CONTAINS(tekst, 'NEAR((optymist, pesymist), 3)') > 0;

--ZADANIE 7
select autor, tekst
from cytaty where contains(tekst, 'near((optymista, pesymista), 10)', 1) > 0;

--ZADANIE 8
SELECT * from cytaty
where contains(tekst, 'życi%')>0;

--ZADANIE9
SELECT score(1) from cytaty
where contains(tekst, 'życi%',1)>0;

--ZADANIE 10
SELECT autor, tekst, score(1) as dopasowanie
from cytaty
where contains(tekst, 'życi%', 1) > 0
order by score(1) desc
    fetch first 1 row only;


--ZADANIE11

select * from cytaty
where contains(tekst, 'fuzzy(probelm)')>0;

--ZZADANIE 12
INSERT INTO CYTATY(id,autor,tekst) values
(39,'Bertrand Russell','To smutne, że głupcy są tacy pewni siebie, a ludzie rozsądni tacy pełni wątpliwości.');



--ZADANIE 13
select * from cytaty
where contains(tekst, 'głupcy')>0;

--ZADANIE 4
SELECT token_text FROM DR$CYTATY_TEKST_IDX$I;
SELECT token_text FROM DR$CYTATY_TEKST_IDX$I
WHERE token_text = 'głupcy';

--ZADANIE 15
drop index cytaty_ctx;
create index cytaty_ctx on cytaty(tekst)
indextype is ctxsys.context;

--ZADANIE 16
select * from cytaty
where contains(tekst, 'głupcy')>0;

--ZADANIE 17
DROP INDEX CYTATY_TEKST_IDX;
DROP TABLE CYTATY;

-- ZADANIE 18
drop index cytaty_ctx;
drop table cytaty;


-- ZADANIE 1
create table quotes as
select * from ztpd.quotes;

--ZADANIE 2
create index QUOTES_TEXT_IDX on QUOTES(TEXT)
indextype is CTXSYS.CONTEXT;

--ZADANIE 3
select * from quotes
where contains(text, 'work')>0;

select * from quotes
where contains(text, '$work')>0;
select * from quotes
where contains(text, 'working')>0;
select * from quotes
where contains(text, '$working')>0;

--ZADANIE 4
select * from quotes
where contains(text, 'it')>0;

-- ZADANIE 5
select * from CTX_STOPLISTS;

-- ZADANIE 6
select * from ctx_stopwords;

--ZADANIE 7
DROP INDEX QUOTES_TEXT_IDX;

CREATE INDEX QUOTES_TEXT_IDX
ON QUOTES(TEXT)
INDEXTYPE IS CTXSYS.CONTEXT
PARAMETERS('STOPLIST CTXSYS.EMPTY_STOPLIST');

--ZADANIE 8
select * from quotes
where contains(text, 'it')>0;


--ZADANIE 9
select * from quotes

where contains(text, 'fool AND humans')>0;

-- ZADANIE 10
select * from quotes
where contains(text, 'fool AND computer')>0;


--ZADANIE 13
BEGIN
    ctx_ddl.create_section_group('nullgroup', 'NULL_SECTION_GROUP');
    ctx_ddl.add_special_section('nullgroup', 'SENTENCE');
    ctx_ddl.add_special_section('nullgroup', 'PARAGRAPH');
END;

--ZADANIE 14
create index quotes_ctx on quotes(text)
    indextype is ctxsys.context
parameters ('stoplist CTXSYS.EMPTY_STOPLIST section group quotes_sg');

--ZADANIE 15
select author, text
from quotes
where contains(text, '(fool AND humans) within sentence', 1) > 0;
select author, text
from quotes
where contains(text, '(fool AND computer) within sentence', 1) > 0;

--ZADANIE 16

select * from quotes
where contains(text, 'humans')>0;
--zwrócił

--ZAD. 17
drop index quotes_ctx;
begin
  ctx_ddl.create_preference('quotes_lex', 'BASIC_LEXER');
  ctx_ddl.set_attribute('quotes_lex', 'printjoins', '-');
  ctx_ddl.set_attribute('quotes_lex', 'index_text', 'yes');
end;
/
create index quotes_ctx on quotes(text)
    indextype is ctxsys.context
parameters ('stoplist CTXSYS.EMPTY_STOPLIST section group quotes_sg lexer quotes_lex');
