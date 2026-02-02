--ZAD. 1
CREATE TABLE movies as select * from ztpd.movies;

--ZAD. 2
describe movies;
SELECT * FROM MOVIES;

--ZAD.3
SELECT * from movies
where cover is null;

--ZAD. 4
SELECT title, id, DBMS_LOB.GETLENGTH(cover) as filesize from movies
where cover is not null;

--ZAD. 5
SELECT id, title, DBMS_LOB.GETLENGTH(cover) as filesize from movies
where cover is null;

--ZAD. 6
SELECT * from ALL_DIRECTORIES;

--ZAD. 7
UPDATE movies
set cover = empty_blob(), mime_type = 'image/jpeg'
where id = 66;

--ZAD 8
select id, title, DBMS_LOB.GETLENGTH(cover) as filesize from movies
where id in (65,66);


--ZAD 9
DECLARE
    v_blob   BLOB;
    v_bfile  BFILE;
    v_len    INTEGER;
BEGIN
    v_bfile := BFILENAME('TPD_DIR', 'escape.jpg');

    SELECT cover
    INTO v_blob
    FROM movies
    WHERE id = 66
    FOR UPDATE;

    DBMS_LOB.FILEOPEN(v_bfile, DBMS_LOB.FILE_READONLY);

    v_len := DBMS_LOB.GETLENGTH(v_bfile);

    DBMS_LOB.LOADFROMFILE(v_blob, v_bfile, v_len);

    DBMS_LOB.FILECLOSE(v_bfile);

    COMMIT;
END;


--ZAD 11
DECLARE
    fils BFILE := BFILENAME('TPD_DIR','eagles.jpg');
BEGIN
    INSERT INTO TEMP_COVERS(MOVIE_ID, IMAGE, MIME_TYPE)
    VALUES (65, fils, 'image/jpeg');
    COMMIT;
END;

--ZAD 12
SELECT movie_id, DBMS_LOB.GETLENGTH(image) from temp_covers where movie_id=65;

--ZAD 13
DECLARE
    v_blob      BLOB;
    v_bfile     BFILE;
    v_mime      VARCHAR2(50);
    v_size      INTEGER;
BEGIN
    SELECT image, mime_type
    INTO v_bfile, v_mime
    FROM temp_covers
    WHERE movie_id = 65;

    DBMS_LOB.CREATETEMPORARY(v_blob, TRUE);

    DBMS_LOB.FILEOPEN(v_bfile, DBMS_LOB.FILE_READONLY);

    v_size := DBMS_LOB.GETLENGTH(v_bfile);

    DBMS_LOB.LOADFROMFILE(v_blob, v_bfile, v_size);

    DBMS_LOB.FILECLOSE(v_bfile);

    UPDATE movies
    SET cover = v_blob,
        mime_type = v_mime
    WHERE id = 65;

    DBMS_LOB.FREETEMPORARY(v_blob);

    COMMIT;
END;


--ZAD. 14
SELECT id, DBMS_LOB.GETLENGTH(cover) from movies where id in (65,66);


--ZAD 15
DROP TABLE movies;