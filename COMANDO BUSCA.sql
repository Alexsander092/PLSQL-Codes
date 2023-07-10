CLEAR SCREEN
SET VERIFY OFF
ACCEPT val CHAR PROMPT 'Qual valor deseja buscar: '
ACCEPT COLUMN_USER PROMPT 'Em qual coluna procurar: '
CLEAR SCREEN;

DECLARE
    contador                             INTEGER;
    string_busca                         VARCHAR2(4000) := '&val'; /* this was <<val>> */
    
                     
BEGIN
    FOR t IN (SELECT 
                     table_name,
                     column_name
                FROM USER_tab_columns
               WHERE COLUMN_NAME = :column_user 
               AND data_type IN ('NUMBER'))
    LOOP
        BEGIN
            EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM ' || t.table_name || ' WHERE ' || t.column_name || ' = :1' INTO contador USING string_busca;

            IF contador > 0
            THEN
                DBMS_OUTPUT.put_line(t.table_name || '     ' || t.column_name || ' ' || contador);
            END IF;
        EXCEPTION
            WHEN OTHERS
            THEN
                DBMS_OUTPUT.put_line('Erro encontrado tentando ler ' || t.column_name || ' da tabela' || t.table_name);
        END;
    END LOOP; 
END;
/     