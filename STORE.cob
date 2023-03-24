IDENTIFICATION DIVISION.
PROGRAM-ID. RETAIL-POS.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT SALES-FILE ASSIGN TO 'SALES.DAT'
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS SALES-KEY
        ALTERNATE RECORD KEY IS SALESDATE-KEY
        FILE STATUS IS SALES-STATUS.
    SELECT INVENTORY-FILE ASSIGN TO 'INVENTORY.DAT'
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS INV-STATUS.
    SELECT CUSTOMER-FILE ASSIGN TO 'CUSTOMER.DAT'
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS CUSTOMER-KEY
        FILE STATUS IS CUST-STATUS.

DATA DIVISION.
FILE SECTION.
FD SALES-FILE.
01 SALES-RECORD.
   05 SALES-KEY PIC X(10).
   05 SALESDATE-KEY PIC X(8).
   05 SALES-AMOUNT PIC 9(5)V99.

FD INVENTORY-FILE.
01 INV-RECORD.
   05 INV-KEY PIC X(10).
   05 INV-DESC PIC X(30).
   05 INV-QTY PIC 9(5).

FD CUSTOMER-FILE.
01 CUST-RECORD.
   05 CUSTOMER-KEY PIC X(10).
   05 CUSTOMER-NAME PIC X(30).
   05 CUSTOMER-ADDRESS PIC X(50).
   05 CUSTOMER-PHONE PIC X(10).

WORKING-STORAGE SECTION.
01 WS-DATE.
   05 WS-YEAR PIC 9(4).
   05 WS-MONTH PIC 9(2).
   05 WS-DAY PIC 9(2).
01 WS-NEW-SALE.
   05 WS-INV-KEY PIC X(10).
   05 WS-QTY PIC 9(5).
01 WS-SALES-TOTAL PIC 9(6)V99.
01 WS-MENU-CHOICE PIC X.
01 WS-CUST-KEY PIC X(10).
01 WS-CUST-RECORD.
   05 WS-CUST-NAME PIC X(30).
   05 WS-CUST-ADDRESS PIC X(50).
   05 WS-CUST-PHONE PIC X(10).
01 WS-INVENTORY-FOUND PIC X(3) VALUE 'NO '.

PROCEDURE DIVISION.
MAIN-PROCESS.
    PERFORM DISPLAY-MENU
    UNTIL WS-MENU-CHOICE = '5'
    STOP RUN.

DISPLAY-MENU.
    DISPLAY 'RETAIL POINT-OF-SALE SYSTEM MENU'
    DISPLAY '1. NEW SALE'
    DISPLAY '2. DISPLAY SALES REPORT'
    DISPLAY '3. DISPLAY INVENTORY REPORT'
    DISPLAY '4. DISPLAY CUSTOMER REPORT'
    DISPLAY '5. EXIT'
    ACCEPT WS-MENU-CHOICE
    PERFORM PROCESS-MENU-CHOICE.

PROCESS-MENU-CHOICE.
    EVALUATE WS-MENU-CHOICE
        WHEN '1'
            PERFORM NEW-SALE
        WHEN '2'
            PERFORM DISPLAY-SALES-REPORT
        WHEN '3'
            PERFORM DISPLAY-INVENTORY-REPORT
        WHEN '4'
            PERFORM DISPLAY-CUSTOMER-REPORT
        WHEN '5'
            CONTINUE
        WHEN OTHER
            DISPLAY 'INVALID MENU CHOICE'
    END-EVALUATE.

NEW-SALE.
    DISPLAY 'NEW SALE'