IDENTIFICATION DIVISION. *> Compile and run with cobc -std=cobol2014 --free -x day1.cbl && ./day1
PROGRAM-ID. DAY1.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT DAY1DATA ASSIGN TO INPUT
    ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD DAY1DATA.
    01 CALIBRATION PIC X(99).

WORKING-STORAGE SECTION.
01 WS-CALIBRATION PIC X(99).
01 WS-NUM.
    05 WS-FIRST PIC X(1).
    05 WS-LAST PIC X(1).
77 WS-CALIBRATION-VALUE PIC 9(2).
77 WS-EOF PIC A(1).
77 WS-LINE-POS PIC 9(3).
77 WS-CHAR PIC X(1).
77 WS-TOTAL PIC 9(8).

PROCEDURE DIVISION.
MAIN-PARA.
    MOVE 0 TO WS-TOTAL.

    OPEN INPUT DAY1DATA.
        PERFORM UNTIL WS-EOF='Y'
            READ DAY1DATA INTO WS-CALIBRATION
                AT END MOVE 'Y' TO WS-EOF
                NOT AT END
                PERFORM READ-CALIBRATION-PARA
                ADD WS-CALIBRATION-VALUE TO WS-TOTAL
            END-READ
        END-PERFORM.
    CLOSE DAY1DATA.

    DISPLAY 'TOTAL: ' WS-TOTAL
    STOP RUN.

READ-CALIBRATION-PARA.
    MOVE 1 TO WS-LINE-POS
    MOVE 'XX' TO WS-NUM

    PERFORM UNTIL WS-LINE-POS > LENGTH OF WS-CALIBRATION
        IF WS-CALIBRATION(WS-LINE-POS:3) = 'one'
            MOVE 1 TO WS-CHAR
        ELSE
            IF WS-CALIBRATION(WS-LINE-POS:3) = 'two'
                MOVE 2 TO WS-CHAR
            ELSE
                IF WS-CALIBRATION(WS-LINE-POS:5) = 'three'
                    MOVE 3 TO WS-CHAR
                ELSE
                    IF WS-CALIBRATION(WS-LINE-POS:4) = 'four'
                        MOVE 4 TO WS-CHAR
                    ELSE
                        IF WS-CALIBRATION(WS-LINE-POS:4) = 'five'
                            MOVE 5 TO WS-CHAR
                        ELSE
                            IF WS-CALIBRATION(WS-LINE-POS:3) = 'six'
                                MOVE 6 TO WS-CHAR
                            ELSE
                                IF WS-CALIBRATION(WS-LINE-POS:5) = 'seven'
                                    MOVE 7 TO WS-CHAR
                                ELSE
                                    IF WS-CALIBRATION(WS-LINE-POS:5) = 'eight'
                                        MOVE 8 TO WS-CHAR
                                    ELSE
                                        IF WS-CALIBRATION(WS-LINE-POS:4) = 'nine'
                                            MOVE 9 TO WS-CHAR
                                        ELSE
                                            MOVE WS-CALIBRATION(WS-LINE-POS:1) TO WS-CHAR
                                        END-IF
                                    END-IF
                                END-IF
                            END-IF
                        END-IF
                    END-IF
                END-IF
            END-IF
        END-IF

        IF WS-CHAR IS NUMERIC
            IF WS-FIRST = 'X'
                MOVE WS-CHAR TO WS-FIRST
            END-IF

            MOVE WS-CHAR TO WS-LAST
        END-IF

        ADD 1 to WS-LINE-POS
    MOVE WS-NUM TO WS-CALIBRATION-VALUE
    END-PERFORM.
