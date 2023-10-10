       IDENTIFICATION DIVISION.
       PROGRAM-ID. FactorialProg.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 NUM                 PIC 9(3)   VALUE ZEROS.
       01 FACT                PIC 9(10)  VALUE 1.
       01 COUNTER             PIC 9(3)   VALUE ZEROS.

       PROCEDURE DIVISION.
       START-PROCEDURE.
           DISPLAY "Enter a number to find the factorial: " NO ADVANCING
           ACCEPT NUM
           PERFORM VARYING COUNTER FROM 1 BY 1 UNTIL COUNTER > NUM
               COMPUTE FACT = FACT * COUNTER
           END-PERFORM
           DISPLAY "Factorial of " NUM " is: " FACT
           STOP RUN.
