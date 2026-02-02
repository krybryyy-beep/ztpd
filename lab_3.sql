--ZAD, 1
create table DOKUMENTY (
    ID NUMBER(12) PRIMARY KEY,
    DOKUMENT CLOB
);


--ZAD. 2
DECLARE

    tekst VARCHAR(15) := 'Oto tekst. ';
    licznik number :=10000;
    tekst_clob CLOB;
BEGIN

    for i in 1..licznik
    loop
        tekst_clob := concat(tekst_clob,tekst);
    end loop;
    insert into DOKUMENTY VALUES
    (1, tekst_clob);

END;

--ZAD. 3
SELECT * FROM dokumenty;

SELECT ID,UPPER(DOKUMENT) FROM DOKUMENTY;
SELECT ID,LENGTH(DOKUMENT) FROM DOKUMENTY;
SELECT ID,DBMS_LOB.GETLENGTH(DOKUMENT) FROM DOKUMENTY;
select id, substr(dokument, 5,1000) from dokumenty;
select id, DBMS_LOB.SUBSTR(dokument,1000,5) from dokumenty;

--ZAD 4
INSERT INTO dokumenty values(2, empty_clob());


--ZAD 5
INSERT INTO dokumenty values(3,null);


--ZAD 6
SELECT * FROM dokumenty;
1 Oto tekst....
2
3 (null)

SELECT ID,UPPER(DOKUMENT) FROM DOKUMENTY;
1 OTO TEKST....
2
3 (null)


--ZAD 7
DECLARE
    v_file     BFILE := BFILENAME('TPD_DIR', 'dokument.txt');
    v_clob     CLOB;
    dst_off    INTEGER := 1;
    src_off    INTEGER := 1;
    csid       INTEGER := 0;
    ctx        INTEGER := 0;
    warning    INTEGER;
BEGIN
    SELECT dokument INTO v_clob
    FROM dokumenty WHERE id = 2 FOR UPDATE;
    DBMS_LOB.FILEOPEN(v_file, DBMS_LOB.FILE_READONLY);
    DBMS_LOB.LOADCLOBFROMFILE(
        v_clob,
        v_file,
        DBMS_LOB.LOBMAXSIZE,
        dst_off,
        src_off,
        csid,
        ctx,
        warning
    );
    DBMS_LOB.FILECLOSE(v_file);
    COMMIT; DBMS_OUTPUT.PUT_LINE('Status kopiowania: ' || warning); END;

--ZAD 8
UPDATE dokumenty
set dokument=to_clob(bfilename('TPD_DIR','dokument.txt'))
where id=3;

--ZAD 9
SELECT * FROM DOKUMENTY;

--ZAD 10
SELECT ID,DBMS_LOB.GETLENGTH(DOKUMENT) FROM DOKUMENTY;

--ZAD 11
DROP TABLE dokumenty;

--ZAD 12
CREATE OR REPLACE PROCEDURE clob_censor( p_clob IN OUT CLOB, p_text IN VARCHAR2) IS
    v_mask     VARCHAR2(32767) := '';
    v_len      INTEGER := LENGTH(p_text);
    v_pos      INTEGER;
BEGIN
    FOR i IN 1 .. v_len LOOP v_mask := v_mask || '.';
    END LOOP; v_pos := DBMS_LOB.INSTR(p_clob, p_text, 1);
    WHILE v_pos > 0 LOOP
        DBMS_LOB.WRITE(p_clob, v_len, v_pos, v_mask);
        v_pos := DBMS_LOB.INSTR(p_clob, p_text, v_pos + v_len);
    END LOOP;
END clob_censor;


--ZAD 14
DROP TABLE BIOGRAPHIES;

