CHIP             SN8F2288             ;
//{{SONIX_CODE_OPTION                 ;
    .Code_Option LVD "LVD_M"          ;
    .Code_Option Rst_Length "No"      ;
    .Code_Option Reset_Pin "P07"      ;
    .Code_Option Watch_Dog "Enable"   ;
    .Code_Option Fslow "Flosc/2"      ;
    .Code_Option High_CLK "12M_X'tal" ;
    .Code_Option Fcpu "Fosc/4"        ;
    .Code_Option Security "Enable"    ;
//}}SONIX_CODE_OPTION                 ;
.DATA                                 ;
.CODE                                 ;
ORG              0x0000               ;
_reset:                               ;
    JMP          _reset_2880          ;
ORG              0x0008               ;
_interrupt:                           ;
    JMP          _interrupt_0009      ;
ORG              0x0010               ;
_reset_0010:                          ;
    JMP          _reset_0052          ;
_interrupt_0009:                      ;
    PUSH                              ;
    B0MOV        A,     UDP0          ;
    B0MOV        0x5c,  A             ;
    B0MOV        A,     RBANK         ;
    B0MOV        0x5d,  A             ;
    B0MOV        A,     Y             ;
    B0MOV        0x5e,  A             ;
    B0MOV        A,     Z             ;
    B0MOV        0x5f,  A             ;
    B0MOV        A,     R             ;
    B0MOV        0x60,  A             ;
    B0BTS1       FUSBIRQ              ;
    JMP          _interrupt_002a      ;
    B0BCLR       FUSBIRQ              ;
    B0BCLR       FUSBIRQ              ;
    B0BCLR       FUSBIRQ              ;
    B0BCLR       FUSBIRQ              ;
    MOV          A,     #0x00         ;
    B0MOV        RBANK, A             ;
    B0BTS0       FSUSPEND             ;
    B0BSET       0x59.4               ;
    B0BTS0       FBUS_RST             ;
    JMP          _interrupt_09d5      ;
    B0BTS0       FEP0IN               ;
    JMP          _interrupt_0acd      ;
    B0BTS0       FEP0OUT              ;
    JMP          _interrupt_0b0b      ;
    B0BTS0       FEP1_ACK             ;
    JMP          _interrupt_0a9b      ;
    B0BTS0       FEP2_ACK             ;
    JMP          _interrupt_0aa6      ;
    B0BTS0       FEP0SETUP            ;
    JMP          _interrupt_0aa8      ;
_interrupt_002a:                      ;
    B0BTS1       FTC1IEN              ;
    JMP          _interrupt_003e      ;
    B0BTS1       FTC1IRQ              ;
    JMP          _interrupt_003e      ;
    B0BCLR       FTC1IRQ              ;
    B0BSET       0x59.7               ;
    B0BTS1       0x64.0               ;
    JMP          _interrupt_003e      ;
    INCMS        0x65                 ;
    NOP                               ;
    B0MOV        A,     0x65          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_003e      ;
    INCMS        0x66                 ;
    NOP                               ;
    B0MOV        A,     0x66          ;
    CMPRS        A,     #0x40         ;
    JMP          _interrupt_003e      ;
    B0BCLR       0x64.2               ;
    B0BSET       P0.1                 ;
_interrupt_003e:                      ;
    B0MOV        A,     0x5f          ;
    B0MOV        Z,     A             ;
    B0MOV        A,     0x5e          ;
    B0MOV        Y,     A             ;
    B0MOV        A,     0x60          ;
    B0MOV        R,     A             ;
    B0MOV        A,     0x5c          ;
    B0MOV        UDP0,  A             ;
    B0MOV        A,     0x5d          ;
    B0MOV        RBANK, A             ;
    POP                               ;
    RETI                              ;
_reset_0052:                          ;
    MOV          A,     #0x7f         ;
    B0MOV        STKP,  A             ;
    B0MOV        RBANK, #0x00         ;
    B0MOV        Y,     #0x00         ;
    B0MOV        Z,     #0x7f         ;
_reset_0057:                          ;
    CLR          @YZ                  ;
    DECMS        Z                    ;
    JMP          _reset_0057          ;
    CLR          @YZ                  ;
    B0BSET       Y.0                  ;
    B0MOV        Z,     #0xfe         ;
_reset_005d:                          ;
    CLR          @YZ                  ;
    DECMS        Z                    ;
    JMP          _reset_005d          ;
    CLR          @YZ                  ;
    B0BCLR       0x64.7               ;
    MOV          A,     PFLAG         ;
    AND          A,     #0xc0         ;
    CMPRS        A,     #0x80         ;
    JMP          _label_006e          ;
    B0BCLR       0x64.3               ;
    CLR          0x64                 ;
    CLR          0x65                 ;
    CLR          0x66                 ;
    B0MOV        A,     PFLAG         ;
    AND          A,     #0xc0         ;
    CMPRS        A,     #0x00         ;
    JMP          _reset_007f          ;
_label_006e:                          ;
    B0BSET       0x64.2               ;
    B0BCLR       P0.1                 ;
    CLR          UDA                  ;
    B0BCLR       FGIE                 ;
    B0BCLR       FUSBIRQ              ;
    B0BCLR       FDP_PU_EN            ;
    MOV          A,     #0x04         ;
    MOV          UPID,  A             ;
    NOP                               ;
    NOP                               ;
    MOV          A,     #0x64         ;
    CALL         func_0146            ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    MOV          A,     #0x64         ;
    CALL         func_0146            ;
    JMP          $+1                  ;
_reset_007f:                          ;
    CLR          UDA                  ;
    CLR          USTATUS              ;
    CLR          EP_ACK               ;
    CLR          UE0R                 ;
    CLR          UE1R                 ;
    CLR          UE2R                 ;
    CLR          UDP0                 ;
    CLR          UDR0_R               ;
    CLR          UDR0_W               ;
    CLR          EP0OUT_CNT           ;
    CLR          UE1R_C               ;
    CLR          UE2R_C               ;
    MOV          A,     #0x18         ;
    B0MOV        EP2FIFO_ADDR,A       ;
    MOV          A,     #0x02         ;
    B0MOV        UPID,  A             ;
    CLR          0x67                 ;
    CLR          0x68                 ;
    CLR          0x69                 ;
    CLR          0x6a                 ;
    CLR          0x77                 ;
    CLR          0x61                 ;
    CLR          0x76                 ;
    CLR          0x56                 ;
    CLR          0x57                 ;
    CLR          0x58                 ;
    CLR          0x6b                 ;
    CLR          0x6c                 ;
    MOV          A,     #0x7d         ;
    B0MOV        0x6d,  A             ;
    CLR          0x6e                 ;
    CLR          0x6f                 ;
    CLR          0x70                 ;
    CLR          0x71                 ;
    CLR          0x72                 ;
    CLR          0x73                 ;
    MOV          A,     #0x01         ;
    B0MOV        0x74,  A             ;
    B0MOV        0x75,  A             ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    B0BCLR       0x64.3               ;
    CLR          0x64                 ;
    CLR          0x65                 ;
    CLR          0x66                 ;
    B0BSET       FGIE                 ;
    B0BCLR       FUSBIRQ              ;
    B0BSET       FUSBIEN              ;
    B0BSET       FUDE                 ;
    B0BSET       FDP_PU_EN            ; Enable D+ pull-up
    B0BCLR       0x77.3               ;
    BCLR         0x12.2               ;
    BSET         0x12.3               ;
    MOV          A,     #0x00         ;
    B0MOV        0x59,  A             ;
    CLR          0x5a                 ;
    MOV          A,     #0x00         ;
    B0MOV        P0M,   A             ; Set all P0 ports to be input mode
    XOR          A,     #0xff         ;
    B0MOV        P0UR,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        P1M,   A             ; Set all P1 ports to be input mode
    XOR          A,     #0xff         ;
    B0MOV        P1UR,  A             ;
    B0MOV        P1W,   A             ;
    MOV          A,     #0x80         ;
    B0MOV        P2M,   A             ; Set P2 ports to be out-in-in-in-in-in-in-in (10000000)
    XOR          A,     #0x8f         ;
    B0MOV        P2UR,  A             ;
    MOV          A,     #0x70         ;
    B0MOV        P2,    A             ;
    MOV          A,     #0x00         ;
    B0MOV        0xc3,  A             ;
    MOV          A,     #0xff         ;
    B0MOV        0xd3,  A             ;
    B0MOV        0xe3,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        P4M,   A             ; Set all P4 ports to be input mode
    XOR          A,     #0xff         ;
    B0MOV        P4UR,  A             ;
    MOV          A,     #0x3f         ;
    B0MOV        P5M,   A             ; Set P5 ports to be in-in-out-out-out-out-out-out (00111111)
    XOR          A,     #0xff         ;
    B0MOV        P5UR,  A             ;
    MOV          A,     #0x0f         ;
    B0MOV        P5,    A             ;
    B0BCLR       P0.5                 ;
    B0BSET       P0M.5                ; Set P0.5 port to be out
    MOV          A,     #0x64         ;
    CALL         func_0146            ;
    B0MOV        A,     P1            ;
    XOR          A,     #0xff         ;
    CMPRS        A,     #0x20         ;
    JMP          _reset_00de          ;
    JMP          _reset_2890          ;
_reset_00de:                          ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    CALL         func_0152            ;
    CALL         func_0173            ;
    B0BCLR       0x00.1               ; Clear FnLock signal
    BCLR         0x14.5               ; Auto-scroll flag
    CLR          0x47                 ;
    B0BSET       0x14.4               ;
    MOV          A,     #0x05         ;
    B0MOV        0x35,  A             ;
_reset_00e8:                          ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    B0BTS0       FSUSPEND             ;
    CALL         func_0a02            ;
    B0BTS1       0x59.7               ;
    JMP          _reset_00e8          ;
    B0BCLR       0x59.7               ;
    INCMS        0x02                 ;
    NOP                               ;
    CALL         func_09ae            ;
    B0BTS0       0x14.4               ;
    JMP          _reset_00f8          ;
    BTS0         0x12.4               ;
    JMP          _reset_00f8          ;
    B0BTS1       P2.6                 ;
    CALL         func_06ba            ; POINT A (maybe)
_reset_00f8:                          ;
    CALL         key_scan             ; Key-scanning
    CALL         func_015e            ;
    BTS0         0x00.2               ;
    JMP          _reset_0113          ;
    DECMS        0x44                 ;
    JMP          _reset_00ff          ;
    JMP          _reset_0100          ;
_reset_00ff:                          ;
    JMP          _reset_0113          ;
_reset_0100:                          ;
    MOV          A,     #0x0a         ;
    MOV          0x44,  A             ;
    CALL         func_0129            ;
    B0BTS1       FC                   ;
    JMP          _reset_0107          ;
    BSET         0x13.0               ;
    JMP          _reset_0113          ;
_reset_0107:                          ;
    CALL         func_0133            ;
    B0BTS1       FC                   ;
    JMP          _reset_010c          ;
    BSET         0x13.0               ;
    JMP          _reset_0113          ;
_reset_010c:                          ;
    BTS1         0x00.5               ;
    JMP          _reset_0113          ;
    BCLR         0x00.5               ;
    CLR          0x10                 ;
    CLR          0x15                 ;
    CALL         func_011f            ;
    BSET         0x13.0               ;
_reset_0113:                          ;
    MOV          A,     0x61          ;
    CMPRS        A,     #0x01         ;
    JMP          _reset_00e8          ;
    B0BTS1       0x59.4               ;
    JMP          _reset_011a          ;
    B0BCLR       0x59.4               ;
    CALL         func_0a02            ;
_reset_011a:                          ;
    B0BTS1       FUE1M0               ;
    CALL         func_1098            ;
    B0BTS1       FUE2M0               ;
    CALL         func_12a4            ;
    JMP          _reset_00e8          ;

func_011f:                            ;
    B0MOV        Y,     #0x00         ;
    B0MOV        Z,     #0x17         ;
func_011f_0002:                       ;
    CLR          @YZ                  ;
    INCMS        Z                    ;
    NOP                               ;
    MOV          A,     #0x20         ;
    SUB          A,     Z             ;
    B0BTS0       FC                   ;
    JMP          func_011f_0002       ;
    RET                               ;

func_0129:                            ;
    MOV          A,     0x10          ;
    B0BTS0       FZ                   ;
    JMP          func_0129_0008       ;
    CLR          0x10                 ;
    CLR          0x15                 ;
    CALL         func_011f            ;
    B0BSET       FC                   ;
    RET                               ;

func_0129_0008:                       ;
    B0BCLR       FC                   ;
    RET                               ;

func_0133:                            ;
    MOV          A,     0x15          ;
    B0BTS1       FZ                   ;
    JMP          func_0133_0006       ;
    MOV          A,     0x17          ;
    B0BTS0       FZ                   ;
    JMP          func_0133_000b       ;
func_0133_0006:                       ;
    CLR          0x10                 ;
    CLR          0x15                 ;
    CALL         func_011f            ;
    B0BSET       FC                   ;
    RET                               ;

func_0133_000b:                       ;
    B0BCLR       FC                   ;
    RET                               ;

func_0140:                            ;
    MOV          0x03,  A             ;
func_0140_0001:                       ; <-----------------+
    NOP                               ; may be timing     |
    NOP                               ; may be timing     |
    DECMS        0x03                 ; 0x03 counter      |
    JMP          func_0140_0001       ; ------------------+
    RET                               ;

func_0146:                            ;
    MOV          0x04,  A             ;
func_0146_0001:                       ;
    MOV          A,     #0x7c         ;
    CALL         func_0140            ;
    MOV          A,     #0x7c         ;
    CALL         func_0140            ;
    MOV          A,     #0x7c         ;
    CALL         func_0140            ;
    MOV          A,     #0x7c         ;
    CALL         func_0140            ;
    DECMS        0x04                 ;
    JMP          func_0146_0001       ;
    RET                               ;

func_0152:                            ;
    B0BCLR       FTC1IRQ              ;
    B0BCLR       FTC1IEN              ;
    B0BCLR       FTC1ENB              ;
    MOV          A,     #0x24         ;
    B0MOV        TC1M,  A             ;
    MOV          A,     #0x44         ;
    B0MOV        TC1C,  A             ;
    B0MOV        TC1R,  A             ;
    B0BCLR       FTC1IRQ              ;
    B0BSET       FTC1IEN              ;
    B0BSET       FTC1ENB              ;
    RET                               ;

func_015e:                            ;
    BTS1         0x12.7               ;
    RET                               ;
    BCLR         0x12.7               ;
func_0161:                            ;
    B0BCLR       FGIE                 ;
    MOV          A,     #0x00         ;
    B0MOV        PEROML,A             ;
    MOV          A,     #0x28         ;
    B0MOV        PEROMH,A             ;
    MOV          A,     #0xc3         ;
    B0MOV        PECMD, A             ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        PERAML,A             ;
    MOV          A,     #0x00         ;
    B0MOV        PERAMCNT,A           ;
    MOV          A,     #0x5a         ;
    B0MOV        PECMD, A             ;
    NOP                               ;
    B0BSET       FGIE                 ;
    RET                               ;

func_0173:                            ;
    B0MOV        Y,     #0x28         ;
    B0MOV        Z,     #0x00         ;
    MOVC                              ;
    CMPRS        A,     #0xff         ;
    JMP          func_0173_0006       ;
    JMP          func_0173_000e       ;

func_0173_0006:                       ;
    AND          A,     #0x02         ;
    MOV          0x00,  A             ;
    B0MOV        A,     R             ;
    CMPRS        A,     #0xff         ;
    JMP          func_0173_000c       ;
    JMP          func_0173_000e       ;

func_0173_000c:                       ;
    MOV          0x01,  A             ;
    RET                               ;

func_0173_000e:                       ;
    MOV          A,     #0x05         ;
    MOV          0x01,  A             ;
    CLR          0x00                 ;
    CALL         func_0161            ;
    RET                               ;

    DW           0x00bf     ; <- Key matrix mask 01 for P2.2 - |
    DW           0x00bf     ; <- Key matrix mask 02 for P2.0 - |
    DW           0x00be     ; <- Key matrix mask 03 for P4.0 - |
    DW           0x0022     ; <- Key matrix mask 04 for P4.5 - |
    DW           0x00ff     ; <- Key matrix mask 05 for P4.1 - |
    DW           0x00ff     ; <- Key matrix mask 06 for P2.1 - |
    DW           0x00bf     ; <- Key matrix mask 07 for P4.4 - |
    DW           0x00be     ; <- Key matrix mask 08 for P4.2 - |
    DW           0x00df     ; <- Key matrix mask 09 for P4.3 - |
    DW           0x00a0     ; <- Key matrix mask 10 for P2.3 - |
    DW           0x00fb     ; <- Key matrix mask 11 for P0.5 - |
    DW           0x004a     ; <- Key matrix mask 12 for P0.4 - |
    DW           0x0041     ; <- Key matrix mask 13 for P4.6 - |
    DW           0x00c8     ; <- Key matrix mask 14 for P4.7 - |
    DW           0x0059     ; <- Key matrix mask 15 for P0.3 - |
    DW           0x007a     ; <- Key matrix mask 16 for P0.6 - |

read_row:
    MOVC                              ;; Load 8-bit mask
    MOV          0x07,  A             ;; Save 8-bit mask to 0x07
    MOV          A,     #0x0e         ;; Set waiting time (14 times)
    CALL         func_0140            ;; Delay function
    B0MOV        A,     P1            ;; Read column buffer values (P0.0-0.7)
    XOR          A,     #0xff         ;; Convert active-low to be active-high
    AND          A,     0x07          ;; Mask the read column buffer values
    MOV          0x08,  A             ;; Save the masked raw bits to 0x08
    MOV          A,     #0x7a         ;; 
    ADD          Z,     A             ;; Get Z val of RAM address where the row bits to be saved
    MOV          A,     0x08          ;; A: masked raw bits
    B0MOV        @YZ,   A             ;; Store at RAM. RAM[0x0100 + 0] = columns
    MOV          A,     #0x87         ;; 
    ADD          Z,     A             ;; Increment Z val
    RET                               ;;

key_scan:                             ; Key-scanning
    B0MOV        Y,     #0x01         ; Y = #0x01
    B0MOV        Z,     #0x86         ; Z = #0x86 (for ROM, not RAM)
    B0BSET       P2M.2                ; ---------- [row 7] Set port 2.2 to be output mode.
    B0BCLR       P2.2                 ; Set port 2.2 buffer low
    CALL         read_row             ;; Read row and store in Y = #0x01, Z = #0x00
    B0BSET       P2.2                 ; Set port 2.2 buffer high
    B0BCLR       P2M.2                ; Set port 2.2 to be input mode.
    B0BSET       P2M.0                ; ---------- [row 5] Set port 2.0 to be output mode.
    B0BCLR       P2.0                 ; Set port 2.0 buffer low
    CALL         read_row             ;; Read row and store in Y = #0x01, Z = #0x01
    B0BSET       P2.0                 ; Set port 2.0 buffer high
    B0BCLR       P2M.0                ; Set port 2.0 to be input mode.
    B0BSET       P4M.0                ; ---------- [row 9] P4.0 
    B0BCLR       P4.0                 ; Set port 4.0 buffer low
    CALL         read_row             ;;
    B0BSET       P4.0                 ;
    B0BCLR       P4M.0                ; P4.0
    B0BSET       P4M.5                ; ---------- [row 14] P4.5
    B0BCLR       P4.5                 ;
    CALL         read_row             ;;
    B0BSET       P4.5                 ;
    B0BCLR       P4M.5                ; P4.5
    B0BSET       P4M.1                ; ---------- [row 10] P4.1
    B0BCLR       P4.1                 ;
    CALL         read_row             ;;
    B0BSET       P4.1                 ;
    B0BCLR       P4M.1                ; P4.1
    B0BSET       P2M.1                ; ---------- [row 06] P2.1
    B0BCLR       P2.1                 ;
    CALL         read_row             ;;
    B0BSET       P2.1                 ;
    B0BCLR       P2M.1                ; P2.1
    B0BSET       P4M.4                ; ---------- [row 13] P4.4
    B0BCLR       P4.4                 ;
    CALL         read_row             ;;
    B0BSET       P4.4                 ;
    B0BCLR       P4M.4                ; P4.4
    B0BSET       P4M.2                ; ---------- [row 11] P4.2
    B0BCLR       P4.2                 ;
    CALL         read_row             ;;
    B0BSET       P4.2                 ;
    B0BCLR       P4M.2                ; P4.2
    B0BSET       P4M.3                ; ---------- [row 12] P4.3
    B0BCLR       P4.3                 ;
    CALL         read_row             ;;
    B0BSET       P4.3                 ;
    B0BCLR       P4M.3                ; P4.3
    B0BSET       P2M.3                ; ---------- [row 08] P2.3
    B0BCLR       P2.3                 ;
    CALL         read_row             ;;
    B0BSET       P2.3                 ;
    B0BCLR       P2M.3                ; P2.3
    B0BSET       P0M.5                ; ---------- [row 03] P0.5
    B0BCLR       P0.5                 ;
    CALL         read_row             ;;
    B0BSET       P0.5                 ;
    B0BCLR       P0M.5                ; P0.5
    B0BSET       P0M.4                ; ---------- [row 02] P0.4
    B0BCLR       P0.4                 ;
    CALL         read_row             ;;
    B0BSET       P0.4                 ;
    B0BCLR       P0M.4                ; P0.4
    B0BSET       P4M.6                ; ---------- [row 15] P4.6
    B0BCLR       P4.6                 ;
    CALL         read_row             ;;
    B0BSET       P4.6                 ;
    B0BCLR       P4M.6                ; P4.6
    B0BSET       P4M.7                ; ---------- [row 16] P4.7
    B0BCLR       P4.7                 ;
    CALL         read_row             ;;
    B0BSET       P4.7                 ;
    B0BCLR       P4M.7                ; P4.7
    B0BSET       P0M.3                ; ---------- [row 01] P0.3
    B0BCLR       P0.3                 ;
    CALL         read_row             ;;
    B0BSET       P0.3                 ;
    B0BCLR       P0M.3                ; P0.3
    B0BSET       P0M.6                ; ---------- [row 04] P0.6
    B0BCLR       P0.6                 ;
    CALL         read_row             ;;
    B0BSET       P0.6                 ;
    B0BCLR       P0M.6                ; P0.6
    CLR          0x07                 ;
    CLR          0x08                 ;
func_0186_00b4:                       ; === Ghosting / abnormal multi-key detection phase (entry) ===
    CALL         func_04eb            ; Set Y=0x01, Z=0x00 -> point to current scan buffer RAM[0x0100..]
    MOV          A,     0x07          ; A = row index (row_i)
    ADD          Z,     A             ; Z = 0x00 + row_i -> RAM[0x0100 + row_i]
    B0MOV        A,     @YZ           ; A = column bit pattern of row_i (8-bit)
    MOV          0x09,  A             ; Save current row pattern into 0x09
    MOV          R,     A             ; save x to R
    SUB          A,     #0x01         ; A = x - 1
    AND          A,     R             ; A = x & (x - 1)
    B0BTS0       FZ                   ; if Z==1 => <=1 set bits
    JMP          func_0186_00cf       ; If popcount <= 1 (single or no key), skip comparison and go to next row
    INCMS        0x08                 ; popcount >= 2 -> initialize secondary row index (row_j++)
    NOP                               ;
func_0186_00c0:                       ; === Compare row_i with other rows (row_j loop) ===
    CALL         func_04eb            ; Reset Y=0x01, Z=0x00 -> current scan buffer
    MOV          A,     0x08          ; A = secondary row index (row_j)
    ADD          Z,     A             ; Z = 0x00 + row_j
    B0MOV        A,     @YZ           ; A = column bit pattern of row_j
    AND          A,     0x09          ; A = pattern(row_i)
    MOV          R,     A             ; save x to R
    SUB          A,     #0x01         ; A = x - 1
    AND          A,     R             ; A = x & (x - 1)
    B0BTS0       FZ                   ; if Z==1 => <=1 set bits
    JMP          func_0186_00c7       ; If one or zero, continue scanning other rows
    JMP          func_0186_010a       ; JMP func_0186_00df ; If two or more, suspicious pattern detected

func_0186_00c7:                       ; === Advance to next row_j ===
    INCMS        0x08                 ; row_j++
    NOP                               ;
    MOV          A,     #0x0f         ; A = 15 (maximum row index)
    SUB          A,     0x08          ; A = 15 - row_j
    B0BTS0       FC                   ; Check if row_j <= 15
    JMP          func_0186_00c0       ; If still within range, continue comparison
    MOV          A,     0x07          ; Reset row_j to row_i
    MOV          0x08,  A             ;
func_0186_00cf:                       ; === Advance to next row_i ===
    INCMS        0x07                 ; row_i++
    NOP                               ;
    INCMS        0x08                 ; row_j++
    NOP                               ;
    MOV          A,     #0x0e         ; A = 14 (last row index to check)
    SUB          A,     0x07          ; A = 14 - row_i
    B0BTS0       FC                   ; Check if row_i <= 14
    JMP          func_0186_00b4       ; Continue scanning remaining rows
    CALL         func_02a1            ; Clear working registers 0x09, 0x0a, 0x0b, 0x0c
    BCLR         0x00.4               ; Clear abnormal-processing flag
    CLR          0x07                 ; Reset row_i index
    CLR          0x08                 ; Reset row_j index
    CLR          0x0e                 ; Clear row offset pointer
    MOV          A,     #0x01         ;
    MOV          0x0d,  A             ; Reset bit-processing counter
    JMP          func_0186_0120       ; Resume normal key change processing

    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE

func_0186_010a:                       ; === Unrecoverable ghosting -> full reset ===
    BTS0         0x00.4               ; Check if reset already performed
    JMP          func_02a1            ; If yes, silently return
    BSET         0x00.4               ; Mark reset performed
    BSET         0x13.0               ; Request report update
    BSET         0x00.2               ; Set special-state flag
    B0MOV        Y,     #0x01         ;
    B0MOV        Z,     #0x20         ;
func_0186_0111:                       ;
    CLR          @YZ                  ; Clear RAM[0x0120..] (key state buffer)
    INCMS        Z                    ;
    NOP                               ;
    MOV          A,     #0x29         ;
    SUB          A,     Z             ;
    B0BTS0       FC                   ;
    JMP          func_0186_0111       ;
    CLR          0x15                 ; Clear modifier state
    CALL         func_011f            ; Send all-keys-released report
    BSET         0x00.5               ; Request resynchronization
func_02a1:                            ; === Clear working variables ===
    CLR          0x09                 ;
    CLR          0x0a                 ;
    CLR          0x0b                 ;
    CLR          0x0c                 ;
    RET                               ;

func_0186_0120:                       ; === Normal key change detection ===
    BCLR         0x00.2               ; Clear special-state flag
    CALL         func_04eb            ; Point to current scan buffer
    MOV          A,     0x07          ; 
    ADD          Z,     A             ;
    B0MOV        A,     @YZ           ;
    B0BTS0       FZ                   ; Check if row data is zero
    JMP          func_0186_012d       ;
    MOV          0x09,  A             ; Save current row data
    MOV          0x0c,  A             ;
    BSET         0x00.2               ; Mark valid row detected
    MOV          A,     #0x0a         ;
    MOV          0x44,  A             ;
    JMP          func_0186_012f       ;

func_0186_012d:                       ;
    MOV          0x09,  A             ; Store current row data
    MOV          0x0c,  A             ;
func_0186_012f:                       ;
    CALL         func_04ee            ; Point to previous scan buffer
    MOV          A,     0x07          ;
    ADD          Z,     A             ;
    B0MOV        A,     @YZ           ;
    MOV          0x0a,  A             ; Load previous row data
    MOV          A,     0x09          ;
    CMPRS        A,     0x0a          ; Compare current vs previous
    JMP          func_0186_0138       ;
    JMP          func_0186_013b       ;

func_0186_0138:                       ; === No change ===
    MOV          A,     0x09          ;
    B0MOV        @YZ,   A             ; Update previous buffer
    JMP          func_0186_02d1       ;

func_0186_013b:                       ; === Change detected (generate diff) ===
    CALL         func_04f1            ; Prepare diff buffer
    MOV          A,     0x07          ;
    ADD          Z,     A             ;
    B0MOV        A,     @YZ           ;
    MOV          0x0a,  A             ;
    CLR          0x0b                 ;
    MOV          A,     0x09          ;
    XOR          A,     0x0a          ; diff = current XOR previous
    B0BTS0       FZ                   ;
    JMP          func_0186_02d1       ;
    MOV          0x0b,  A             ; Store changed bits mask
func_0186_0146:                       ;
    BTS1         0x0b.0               ; Check 0x0b.0
    JMP          func_0186_02c3       ; If 0x0b.0 == 0, ===> JMP func_0186_02c3
    BCLR         0x00.3               ; If 0x0b.0 == 1, set 0x00.3 = 0
    BTS1         0x09.0               ; Check 0x09.0
    BSET         0x00.3               ; If 0x09.0 == 0, set 0x00.3 = 1
    MOV          A,     0x0e          ;
    ADD          A,     0x0d          ; A = 0x0e + 0x0d
    MOV          0x08,  A             ; 0x08 = 0x0e + 0x0d
    B0MOV        Y,     #0x05         ; Y = #0x05
    B0MOV        Z,     #0xa0         ; Z = #0xa0 (+0) (Real #0x04B0, Offset = 0x05A0)
    MOV          A,     0x08          ;
    ADD          Z,     A             ; Z = 0x08 + Z
    B0BTS0       FC                   ;
    INCMS        Y                    ; If Carry flag == 1, Y = Y + 1. If Y == 0, skip next. 
    MOVC                              ; IF Carry flag == 0, Copy from ROM [Y, Z] to A. memoOVC Y const 05, Z c-v a0 + var
    MOV          0x0f,  A             ; 0x0f = A (LOWER byte)
    BTS0         0x00.7               ;; Check Mod key flag
    JMP          get_L2_key           ;; Jump to 2nd layer function
process_a:                            ;;
    BTS1         0x00.3               ;; Check 0x00.3 (What flag ?)
    JMP          func_0186_015c       ;; If 0x00.3 == 0, JMP 015c
    CALL         func_054f            ;; If 0x00.3 == 1, CALL func_054f (Clear 0x42, and do many things before return.)
    B0BTS0       FC                   ;; Check the carry flag
    JMP          func_0186_02c3       ;; If FC == 1, JMP 02c3 (Common fucntion) ===> JMP func_0186_02c3
    JMP          func_0186_015f       ;; If FC == 0, JMP 015f (Fx and Fn + X key process) ---> Route B

get_L2_key:                           ;;
    MOV          A,     R             ;; 
    MOV          0x0f,  A             ;; 0x0f = R (HIGHER byte)
    JMP          process_a            ;; 

func_0186_015c:                       ;
    CALL         func_04fd            ; Clear 0x41, and do many things before return.
    B0BTS0       FC                   ; Carry flag of 'ADD Z, A' in the func_0186_0146.
    JMP          func_0186_02c3       ; If FC == 1, JMP 02c3 (Common fucntion) ===> JMP func_0186_02c3
func_0186_015f:                       ; If FC == 0, JMP 015f (Fx and Fn + X key process) ---> Route B
    MOV          A,     0x0f          ;
    CMPRS        A, #0xaf ;; Compare with Fn key. default: #0xaf
    JMP          func_0186_016e       ; If 0x0f is not "Fn", Go to func_0186_016e
    B0MOV        A,     0x74          ; If 0x0f is "Fn", get value of 0x74
    B0BTS0       FZ                   ; Check FZ flag (if 0x74 == 0)
    RET                               ; if 0x74 == 0, RETURN
    BCLR         0x00.0               ; 0x00.0 = 0
    BTS1         0x00.3               ; Check 0x00.3 (What flag ?)
    BSET         0x00.0               ; If 0x00.3 == 0, 0x00.0 = 1 ( Fn key pressed flag ? ).
    BSET         0x13.0               ; 0x13.0 = 1  13.0 Modifier key pressed flag
    BSET         0x13.4               ; 0x13.4 = 1	13.4 ? will be activated when ESC, Fx, ...
    BSET         0x13.6               ; 0x13.6 = 1	13.6 ? will be activated when ESC, Fx, ....
    BSET         0x13.7               ; 0x13.7 = 1	13.7 ? 
    JMP          key_categorization   ;;

func_0186_016e:                       ; [ Fn + B --> Break (Ctrl + P) ]
    BTS1         0x00.0               ; Check 0x00.0
    JMP          func_0186_0198       ; If 0x00.0 == 0, JMP to 0198 (Normal key process)
    CMPRS        A,     #0x05         ;; Compare with #0x05 (B key)
    JMP          func_0186_0180       ;; if not, Go to [ Fn + S --> Alt + PrtScn or SysReq ]
    BSET         0x12.5               ;; Something to emit Break
    BSET         0x13.0               ;; Something to emit Break
    CLR          0x3f                 ;; Clear 0x3f flag
    JMP          func_0186_02c3       ;; JMP to func_0186_02c3

func_0186_0180:                       ; [ Fn + S --> Alt + PrtScn or SysReq ]
    CMPRS        A,     #0x16         ; Compare with #0x16 (S key)
    JMP          func_0186_0186       ; If not, Go to [ Fn + Esc --> Toggle FnLk ]
    B0BSET       0x14.3               ; Something to emit SysReq
    B0BSET       0x13.0               ; Something to emit SysReq
    CLR          0x3f                 ; Clear 0x3f flag
    JMP          func_0186_02c3       ; JMP to func_0186_02c3

func_0186_0186:                       ; [ Fn + Esc --> Toggle FnLk ]
    CMPRS        A,     #0x29         ; Compare with #0x29 (ESC key)
    JMP          func_0186_0198       ; If not, JMP to 0198
    BTS1         0x00.3               ; Check 0x00.3
    JMP          func_0186_018e       ; If 0x00.3 == 0, JMP
    BSET         0x13.6               ; If 0x00.3 == 1, set 0x13.6 = 1
    CLR          0x28                 ; , and 0x28 = 00
    CLR          0x29                 ; , and 0x29 = 00
    JMP          func_0186_02c3       ; JMP to func_0186_02c3

func_0186_018e:                       ; [ If 0x00.3 == 0]
    BSET         0x13.6               ; Set 0x13.6 = 1
    MOV          A,     #0x02         ; 
    MOV          0x29,  A             ; Set 0x29 = 02
    CLR          0x28                 ; Set 0x28 = 00
    BSET         0x13.5               ; Set 0x13.5 = 1
    BSET         0x13.0               ; Set 0x13.0 = 1
    BSET         0x13.4               ; Set 0x13.4 = 1
    CLR          0x21                 ; Set 0x21 = 00
    CLR          0x22                 ; Set 0x22 = 00
    JMP          func_0186_02c3       ; JMP to func_0186_02c3

func_0186_0198:                       ;
    B0MOV        A,     0x74          ; Get value of 0x74
    B0BTS0       FZ                   ; Check Flag Zero
    JMP          key_categorization   ;;
    MOV          A,     0x00          ; If FZ == 1, Get lower two-digit of 0x00 value 
    AND          A,     #0x03         ; (0x00.0: Fn pressed signal, 0x00.1: Fnlock signal from PC).
    B0ADD        PCL,   A             ;
    JMP          key_categorization   ;; if A == 0 (00), Key-type categorization
    JMP          f1_mute              ;  if A == 1 (01), Media key process
    JMP          f1_mute              ;  if A == 2 (10), Media key process
    JMP          key_categorization   ;; if A == 3 (11), Key-type categorization

f1_mute:                              ; [F1 Mute]
    MOV          A,     0x0f          ;
    B0MOV        Y,     #0x04         ;;
    CMPRS        A,     #0x3a         ; Check 0x0f value is F1
    JMP          f2_vol_down          ; if not, Go to [F2 vol --]
    B0MOV        Z,     #0x55         ;;
    JMP          consumer_key         ;;

f2_vol_down:                          ; [F2 vol --]
    CMPRS        A,     #0x3b         ; Check 0x0f value is F2
    JMP          f3_vol_up            ; if not, Go to [F3 vol ++]
    B0MOV        Z,     #0x56         ;;
    JMP          consumer_key         ;;

f3_vol_up:                            ; [F3 vol ++]
    CMPRS        A,     #0x3c         ; Check 0x0f value is F3
    JMP          f4_mic_mute_pre      ; if not, Go to [F4 Mic Mute]
    B0MOV        Z,     #0x57         ;;
    JMP          consumer_key         ;;

f4_mic_mute_pre:
    CMPRS        A,     #0x3d         ; Check 0x0f value is F4
    JMP          f5_brightness_dn_pre ; if not, Go to F5
    JMP          f4_mic_mute          ;

f4_mic_mute:                          ; [F4 Mic Mute]
    B0MOV        Z,     #0x58         ;;
    JMP          special_key          ;;

f5_brightness_dn_pre:                 ;
    CMPRS        A,     #0x3e         ; Check 0x0f value is F5
    JMP          f6_brightness_up_pre ; if not, Go to F6
    JMP          f5_brightness_down   ; if not, Go to F6

f5_brightness_down:                   ; [F5 brightness down]
    BTS1         0x12.2               ; Check 0x12.2
    JMP          f5_brightness_down_b ; If 0x12.2 == 0, JMP to branch
    B0MOV        Z,     #0x59         ;;
    JMP          special_key          ;;

f5_brightness_down_b:                 ; [F5 brightness down]
    BTS1         0x12.3               ; Check 0x12.3
    JMP          func_0186_02c3       ; If 0x12.2 == 0, Go to 02c3
    B0MOV        Z,     #0x5a         ;;
    JMP          consumer_key         ;; 

f6_brightness_up_pre:
    CMPRS        A,     #0x3f         ; Check 0x0f value is F6
    JMP          f7_process_pre       ; if not, Go to F7
    JMP          f6_brightness_up     ;

f6_brightness_up:                     ; [F6 brightness up]
    BTS1         0x12.2               ; Check 0x12.2
    JMP          f6_brightness_up_b   ; If 0x12.2 == 0, JMP to branch
    B0MOV        Z,     #0x5b         ;;
    JMP          special_key          ;;

f6_brightness_up_b:                   ; [F6 brightness up]
    BTS1         0x12.3               ; Check 0x12.3
    JMP          func_0186_02c3       ; If 0x12.2 == 0, Go to 02c3
    B0MOV        Z,     #0x5c         ;;
    JMP          consumer_key         ;;

f7_process_pre:
    CMPRS        A,     #0x40         ;
    JMP          f8_process_pre       ;
    JMP          f7_process           ;  

f7_process:                           ; [F7]
    B0BTS0       0x14.7               ;
    JMP          func_0186_020d       ;
    B0BTS1       0x12.0               ;
    JMP          func_0186_0217       ;
func_0186_020d:                       ;
    B0MOV        Z,     #0x5d         ;;
    JMP          special_key          ;;
    
func_0186_0217:                       ; [F7]
    B0BTS0       0x12.2               ;
    JMP          func_0186_021b       ;
    B0BTS1       0x12.3               ;
    JMP          func_0186_02c3       ;
func_0186_021b:                       ;
    BSET         0x40.4               ;
    BSET         0x13.0               ;
    CLR          0x3f                 ;
    JMP          func_0186_02c3       ;

f8_process_pre:
    CMPRS        A,     #0x41         ;
    JMP          f9_process_pre       ;
    JMP          f8_process           ;

f8_process:                           ; [F8]
    BTS1         0x12.3               ;
    JMP          func_0186_022e       ;
    B0MOV        Z,     #0x5e         ;;
    JMP          consumer_key         ;;

func_0186_022e:                       ; [F8]
    B0MOV        Z,     #0x5f         ;;
    JMP          special_key          ;;

f9_process_pre:
    CMPRS        A,     #0x42         ;
    JMP          f10_process_pre      ;
    JMP          f9_process           ;

f9_process:                           ; [F9]
    BTS1         0x12.3               ;
    JMP          func_0186_023f       ;
    BSET         0x40.6               ;
    BSET         0x13.0               ;
    CLR          0x3f                 ;
func_0186_023f:                       ;
    B0MOV        Z,     #0x60         ;;
    JMP          special_key          ;;

f10_process_pre:
    CMPRS        A,     #0x43         ;
    JMP          f11_process_pre      ;
    JMP          f10_process          ;

f10_process:                          ; [F10]
    B0MOV        Z,     #0x61         ;;
    JMP          consumer_key         ;;

f11_process_pre:                      ; 
    CMPRS        A,     #0x44         ;
    JMP          f12_process_pre      ;
    JMP          f11_process          ;

f11_process:                          ; [F11]
    BTS0         0x12.0               ;
    JMP          func_0186_025d       ;
    BSET         0x40.7               ;
    BSET         0x13.0               ;
    CLR          0x3f                 ;
func_0186_025d:                       ;
    B0MOV        Z,     #0x62         ;;
    JMP          special_key          ;;

f12_process_pre:
    CMPRS        A,     #0x45         ; Check 0x0f value is F12
    JMP          key_categorization   ;; If not F12, go to key categorization
    JMP          f12_process          ;

f12_process:                          ; [F12]
    BTS1         0x12.3               ; If F12, 0x12.3 flag check
    JMP          func_0186_0273       ; If 0x12.3 == 0, JMP to func_0186_0273
    BSET         0x13.4               ; If 0x12.3 == 1, 
    BTS0         0x00.3               ; 0x00.3 flag check
    JMP          func_0186_027b       ; If 0x00.3 == 1, JMP to func_0186_027b
    MOV          A,     #0xf2         ; 
    MOV          0x21,  A             ; 0x21 = #0xf2
    MOV          A,     #0x03         ;
    MOV          0x22,  A             ; 0x22 = #0x03
    JMP          func_0186_02c3       ; ===> JMP func_0186_02c3

func_0186_0273:                       ; [F12]
    BSET         0x13.6               ; 0x13.6 = 1
    BTS0         0x00.3               ; Check 0x00.3
    JMP          func_0186_027b       ; If 0x00.3 == 1, JMP to func_0186_027b
    MOV          A,     #0x94         ; If 0x00.3 == 0,
    MOV          0x28,  A             ; 0x28 = #0x94
    MOV          A,     #0x01         ; 
    MOV          0x29,  A             ; 0x29 = #0x01
    JMP          func_0186_02c3       ; ===> JMP func_0186_02c3

func_0186_027b:                       ;
    CLR          0x28                 ; 0x28 = #0x00
    CLR          0x29                 ; 0x29 = #0x00
    CLR          0x21                 ; 0x21 = #0x00
    CLR          0x22                 ; 0x22 = #0x00
    JMP          func_0186_02c3       ; ===> JMP func_0186_02c3

consumer_key:
    BSET         0x13.4               ;; Set 0x13.4 = 1
    BTS0         0x00.3               ;; Check 0x00.3
    B0MOV        Z,     #0x65         ;; ROM address for 0x0000
    MOVC                              ;;
    MOV          0x21,  A             ;; 0x21 = LOWER byte
    MOV          A,     R             ;; 
    MOV          0x22,  A             ;; 0x22 = R (HIGHER byte)
    JMP          func_0186_02c3       ;;
              
special_key:
    BSET         0x13.6               ;; Set 0x13.6 = 1
    BTS0         0x00.3               ;; Check 0x00.3
    B0MOV        Z,     #0x65         ;; ROM address for 0x0000
    MOVC                              ;;
    MOV          0x28,  A             ;; 0x28 = LOWER byte
    MOV          A,     R             ;; 
    MOV          0x29,  A             ;; 0x29 = R (HIGHER byte)
    JMP          func_0186_02c3       ;;

key_categorization:                   ;
    B0MOV        Y,     #0x04         ;;
    MOV          A,     0x0f          ;;
    SUB          A,     #0xcd         ;;
    B0BTS1       FC                   ;;
    JMP          func_0186_02be       ;;
    SUB          A,     #0x08         ;;
    B0BTS1       FC                   ;;
    JMP          function_key         ;;
    SUB          A,     #0x0b         ;;
    B0BTS1       FC                   ;;
    JMP          application_key      ;;
    SUB          A,     #0x08         ;;
    B0BTS1       FC                   ;;
    JMP          modifier_key         ;;
    BSET         0x13.0               ;;
    B0MOV        Z,     #0x25         ;; Macro key ROM address
    ADD          Z,     A             ;; 
    MOVC                              ;;
    MOV          0x0f,  A             ;;
    MOV          A,     R             ;; [hgfedcba] a: LeftControl, b: LeftShift, c: LeftAlt, d: LeftGUI, e: RightControl, f: RightShift, g: RightAlt, h: RightGUI
    BTS0         0x00.3               ;;
    JMP          macro_key_released   ;;
    JMP          macro_key_pressed    ;;

application_key:
    ADD          A,     #0x0b         ;;    
    BSET         0x13.4               ;; ------- Custom counsumer key --------
    B0MOV        Z,     #0x45         ;; -------------------------------------
    ADD          Z,     A             ;;
    BTS0         0x00.3               ;; -------------------------------------
    B0MOV        Z,     #0x65         ;; ROM address for 0x0000
    MOVC                              ;; -------------------------------------
    MOV          0x21,  A             ;; -------------------------------------
    MOV          A,     R             ;; -------------------------------------
    MOV          0x22,  A             ;; -------------------------------------
    JMP          func_0186_02c3       ;; -------------------------------------

function_key:
    ADD          A,     #0x08         ;; 
    B0ADD        PCL,   A             ;;
    JMP          f4_mic_mute          ;;
    JMP          f5_brightness_down   ;;
    JMP          f6_brightness_up     ;;
    JMP          f7_process           ;;
    JMP          f8_process           ;;
    JMP          f9_process           ;;
    JMP          f11_process          ;;
    JMP          f12_process          ;;

macro_key_released:
    XOR          A,     #0xff         ;;
    AND          0x15,  A             ;;
    JMP          func_0186_02be       ;;

macro_key_pressed:
    OR           0x15,  A             ;;
    JMP          func_0186_02be       ;;

modifier_key:
    BSET         0x13.0               ; Set 0x13.0 = 1  (0x13.0 is modifier key flag?)
    ADD          A,     #0x08         ;;
    CMPRS        A,     #0x07         ;; If A == #0x07, Do 2nd layer key process
    JMP          non_l2_mod_keys      ;;
    BSET         0x00.7               ;; SET 0x00.7 flag (2nd layer key pressed) = 1
    BTS0         0x00.3               ;; Check 0x00.3 
    BCLR         0x00.7               ;; If 0x00.3 == 1, 0x00.7 = 0 
    JMP          func_0186_02c3       ;; JMP to func_0186_02c3
    
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE

non_l2_mod_keys:
    B0MOV        Y,     #0x04         ;; Address of bit musk ROM
    B0MOV        Z,     #0xf5         ;;
    ADD          Z,     A             ;; add 0, 1, 2, 3, 4, 5, 6, (7)
    MOVC                              ;; Load bit musk
    BTS0         0x00.3               ;; 
    JMP          mod_released         ;; 
    JMP          mod_pressed          ;; 

mod_released:                         ;;
    XOR          A,     #0xff         ;;
    AND          0x15,  A             ;;
    JMP          func_0186_02c3       ;;

mod_pressed:                          ;;
    OR           0x15,  A             ;;
    JMP          func_0186_02c3       ;;

func_0186_02be:                       ; [ Non-modifier key process ]
    BTS1         0x00.3               ; Check 0x00.3
    JMP          func_0186_02c2       ; If 0x00.3 == 0, Clear 0x10, Y = #0x00, Z = #0x17 (in func_0489), and Go to 02c3.
    CALL         func_04ab            ; If 0x00.3 == 1, Clear 0x08 only and go to 02c3.
    JMP          func_0186_02c3       ;

func_0186_02c2:                       ;
    CALL         func_0489            ;

func_0186_02c3:                       ; [Some general and important process]
    B0BCLR       FC                   ; Set the carry flag 0
    RRCM         0x09                 ; Right rotation 0x09
    RRCM         0x0b                 ; Right rotation 0x0b
    INCMS        0x0d                 ; 0x0d += 1 (0x0d may be counter.) ---------------------------------------+ Increment 
    NOP                               ;                                                                         |
    MOV          A,     #0x08         ;                                                                         | 8-time repeat
    SUB          A,     0x0d          ; A = #0x08 - 0x0d (upper than 8 or not)                                  |
    B0BTS0       FC                   ; Check the carry flag                                                    |
    JMP          func_0186_0146       ; If #0x08 >= 0x0d, JMP func_0186_0146 (memoOVC) -------------------------+ Check
    CALL         func_04f1            ; If #0x08 < 0x0d, CALL func_04f (Y=#0x01, Z=#0x20, and Define something)	|
    MOV          A,     0x07          ;                                                                         |
    ADD          Z,     A             ;	Z = Z + 0x07 val                                                        |
    MOV          A,     0x0c          ;                                                                         |
    B0MOV        @YZ,   A             ; Load 0x0c value to RAM YZ (Y = #0x00, Z = Given Z (e.g. #0x17) + 0x07)  |
func_0186_02d1:                       ;                                                                         |
    MOV          A,     #0x08         ;                                                                         |
    ADD          0x0e,  A             ; 0x0e = 0x0e + #0x08                                                     |
    MOV          A,     #0x01         ;                                                                         |
    MOV          0x0d,  A             ; 0x0d = #0x01 (0x0d counter reset to 1) ---------------------------------+ Reset
    CLR          0x08                 ; 0x08 = 0x00 (0x08 reset)
    INCMS        0x07                 ; 0x07 += 1
    NOP                               ;
    MOV          A,     #0x0f         ;
    SUB          A,     0x07          ; A = #0x0f - 0x07 (upper than 16 or not)
    B0BTS0       FC                   ;
    JMP          func_0186_0120       ; If 0x07 >= #0x0f, 
    CLR          0x07                 ; If 0x07 < #0x0f, 0x07 and 0x08 reset
    CLR          0x08                 ;
    RET                               ;

    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    DW           0x0000 ; <- Macro - |
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE

    DW           0x0000 ; <- Custom Consumer key - |
    DW           0x0000 ; <- Custom Consumer key - |
    DW           0x0000 ; <- Custom Consumer key - |
    DW           0x0000 ; <- Custom Consumer key - |
    DW           0x0000 ; <- Custom Consumer key - |
    DW           0x0000 ; <- Custom Consumer key - |
    DW           0x0000 ; <- Custom Consumer key - |
    DW           0x0000 ; <- Custom Consumer key - |
    DW           0x0000 ; <- Custom Consumer key - |
    DW           0x0000 ; <- Custom Consumer key - |
    DW           0x0000 ; <- Custom Consumer key - |
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE

    DW           0x00e2               ; <- Media key - | 0455 | F1c  0x21 = E2, 0x22 = 00
    DW           0x00ea               ; <- Media key - | 0456 | F2c  0x21 = EA, 0x22 = 00
    DW           0x00e9               ; <- Media key - | 0457 | F3c  0x21 = E9, 0x22 = 00
    DW           0x0001               ; <- Media key - | 0458 | F4s  0x28 = 01, 0x29 = 00
    DW           0x0002               ; <- Media key - | 0459 | F5s  0x28 = 02, 0x29 = 00
    DW           0x0070               ; <- Media key - | 045a | F5c  0x21 = 70, 0x22 = 00
    DW           0x0004               ; <- Media key - | 045b | F6s  0x28 = 04, 0x29 = 00
    DW           0x006f               ; <- Media key - | 045c | F6c  0x21 = 6f, 0x22 = 00
    DW           0x0008               ; <- Media key - | 045d | F7s  0x28 = 08, 0x29 = 00
    DW           0x03f1               ; <- Media key - | 045e | F8c  0x21 = f1, 0x22 = 03
    DW           0x0010               ; <- Media key - | 045f | F8s  0x28 = 10, 0x29 = 00
    DW           0x0020               ; <- Media key - | 0460 | F9s  0x28 = 20, 0x29 = 00
    DW           0x0221               ; <- Media key - | 0461 | F10c 0x21 = 21, 0x22 = 02
    DW           0x0080               ; <- Media key - | 0462 | F11s 0x28 = 80, 0x29 = 00
    DW           0x03f2               ; <- Media key - | 0463 | F12c 0x21 = f2, 0x22 = 03
    DW           0x0194               ; <- Media key - | 0464 | F12s 0x28 = 94, 0x29 = 01

    DW           0x0000               ; <- FIXED (just for get 0x0000) - | 0465 |
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE
    NOP                               ;; <NOP> <- NOT USED ANYMORE

func_0489:                            ; [ Non-modifier special key process ]                 ; 0489
    CLR          0x10                 ; Set 0x10 = 0                                         ; 0489
    B0MOV        Y,     #0x00         ;
    B0MOV        Z,     #0x17         ; Set Y and Z and return to func_0186+0x2c2
func_0489_0003:                       ;
    B0MOV        A,     @YZ           ;
    B0BTS1       FZ                   ;
    JMP          func_0489_0011       ;
    MOV          A,     0x0f          ;
    B0MOV        @YZ,   A             ;
    INCMS        0x10                 ;
    NOP                               ;
    MOV          A,     #0x06         ;
    SUB          A,     0x10          ;
    B0BTS1       FC                   ;
    JMP          func_0489_001f       ;
    BCLR         0x00.4               ;
    BSET         0x13.0               ;
    RET                               ;

func_0489_0011:                       ; 049a 
    INCMS        0x10                 ; 049a 
    NOP                               ;
    B0MOV        A,     @YZ           ;
    CMPRS        A,     0x0f          ;
    JMP          func_0489_0019       ;
    BCLR         0x00.4               ;
    BSET         0x13.0               ;
    RET                               ;

func_0489_0019:                       ;
    INCMS        Z                    ;
    NOP                               ;
    MOV          A,     #0x20         ;
    SUB          A,     Z             ;
    B0BTS0       FC                   ;
    JMP          func_0489_0003       ;
func_0489_001f:                       ;
    BSET         0x00.4               ;
    BSET         0x13.0               ;
    RET                               ;

func_04ab:                            ;
    CLR          0x08                 ;
func_04ab_0001:                       ;
    B0MOV        Y,     #0x00         ; Y = #0x00
    B0MOV        Z,     #0x17         ; Z = #0x17
    MOV          A,     0x08          ; Z = #0x17 + 0x08 (If from func_04ab, it is 0x00.)
    ADD          Z,     A             ;
    B0MOV        A,     @YZ           ; Load YZ RAM
    CMPRS        A,     0x0f          ; Compare YZ value and 0x0f (pressed key)
    JMP          func_04ab_0036       ; If YZ != 0x0f, func_04ab_0036
    MOV          A,     0x08          ; If YZ == 0x0f, 
    B0ADD        PCL,   A             ; Control Program counter ()
    JMP          func_04ab_0014       ; (If from func_04ab, here.)
    JMP          func_04ab_0016       ;
    JMP          func_04ab_0018       ;
    JMP          func_04ab_001a       ;
    JMP          func_04ab_001c       ;
    JMP          func_04ab_001e       ;
    JMP          func_04ab_0020       ;
    JMP          func_04ab_0022       ;
    JMP          func_04ab_0024       ;
    JMP          func_04ab_0026       ;

func_04ab_0014:                       ;
    MOV          A,     0x18          ;
    MOV          0x17,  A             ; 0x17 = 0x18
func_04ab_0016:                       ;
    MOV          A,     0x19          ;
    MOV          0x18,  A             ; 0x18 = 0x19
func_04ab_0018:                       ;
    MOV          A,     0x1a          ;
    MOV          0x19,  A             ; 0x19 = 0x1a
func_04ab_001a:                       ;
    MOV          A,     0x1b          ;
    MOV          0x1a,  A             ; 0x1a = 0x1b
func_04ab_001c:                       ;
    MOV          A,     0x1c          ;
    MOV          0x1b,  A             ; 0x1b = 0x1c
func_04ab_001e:                       ;
    MOV          A,     0x1d          ;
    MOV          0x1c,  A             ; 0x1c = 0x1d
func_04ab_0020:                       ;
    MOV          A,     0x1e          ;
    MOV          0x1d,  A             ; 0x1d = 0x1e
func_04ab_0022:                       ;
    MOV          A,     0x1f          ;
    MOV          0x1e,  A             ; 0x1e = 0x1f
func_04ab_0024:                       ;
    MOV          A,     0x20          ;
    MOV          0x1f,  A             ; 0x1f = 0x20
func_04ab_0026:                       ;
    CLR          0x20                 ; 0x20 = 0
    DECMS        0x10                 ; 0x10 = 0x10 - 1
    NOP                               ;
    MOV          A,     0x10          ;
    CMPRS        A,     #0xff         ;
    JMP          func_04ab_002d       ; if 0x10 != #0xff,
    JMP          func_04ab_0033       ; if 0x10 == #0xff,

func_04ab_002d:                       ;
    MOV          A,     #0x06         ;
    SUB          A,     0x10          ;
    B0BTS0       FC                   ;
    JMP          func_04ab_0033       ;
    BSET         0x00.4               ;
    JMP          func_04ab_0034       ;

func_04ab_0033:                       ;
    BCLR         0x00.4               ;
func_04ab_0034:                       ;
    BSET         0x13.0               ;
    RET                               ;

func_04ab_0036:                       ;
    INCMS        0x08                 ;
    NOP                               ;
    MOV          A,     0x08          ;
    CMPRS        A,     #0x0a         ;
    NOP                               ;
    B0BTS1       FC                   ;
    JMP          func_04ab_0001       ;
    CLR          0x08                 ;
    BSET         0x13.0               ;
    RET                               ;

func_04eb:                            ;
    B0MOV        Y,     #0x01         ;
    B0MOV        Z,     #0x00         ;
    RET                               ;

func_04ee:                            ;
    B0MOV        Y,     #0x01         ;
    B0MOV        Z,     #0x10         ;
    RET                               ;

func_04f1:                            ;
    B0MOV        Y,     #0x01         ;
    B0MOV        Z,     #0x20         ;
    RET                               ;
    DW           0x0000               ; <- FIXED | 00000000 | <<< Mask-like data region. ROM address: from 0x04f4 to 0x04fc <<<<<<<
    DW           0x0001               ; <- FIXED | 00000001 | <<< may be reffered from func_04fd_003b and func_054f_003b <<<<<<<<<<
    DW           0x0002               ; <- FIXED | 00000010 | <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    DW           0x0004               ; <- FIXED | 00000100 | <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    DW           0x0008               ; <- FIXED | 00001000 | <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    DW           0x0010               ; <- FIXED | 00010000 | <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    DW           0x0020               ; <- FIXED | 00100000 | <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    DW           0x0040               ; <- FIXED | 01000000 | <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    DW           0x0080               ; <- FIXED | 10000000 | <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

func_04fd:                            ;
    CLR          0x41                 ;
func_04fd_0001:                       ;
    B0MOV        Y,     #0x01         ;
    B0MOV        Z,     #0x44         ;
    MOV          A,     0x41          ;
    ADD          Z,     A             ;
    B0BTS0       FC                   ;
    INCMS        Y                    ;
    NOP                               ;
    B0MOV        A,     @YZ           ;
    CMPRS        A,     0x0f          ;
    JMP          func_04fd_000c       ;
    JMP          func_04fd_0031       ;

func_04fd_000c:                       ;
    INCMS        0x41                 ;
    NOP                               ;
    MOV          A,     #0x09         ;
    SUB          A,     0x41          ;
    B0BTS0       FC                   ;
    JMP          func_04fd_0001       ;
    CLR          0x41                 ;
func_04fd_0013:                       ;
    B0MOV        Y,     #0x01         ;
    B0MOV        Z,     #0x44         ;
    MOV          A,     0x41          ;
    ADD          Z,     A             ;
    B0BTS0       FC                   ;
    INCMS        Y                    ;
    NOP                               ;
    B0MOV        A,     @YZ           ;
    B0BTS1       FZ                   ;
    JMP          func_04fd_002a       ;
    MOV          A,     0x0f          ;
    B0MOV        @YZ,   A             ;
    B0MOV        Y,     #0x01         ;
    B0MOV        Z,     #0x4e         ;
    MOV          A,     0x41          ;
    ADD          Z,     A             ;
    B0BTS0       FC                   ;
    INCMS        Y                    ;
    NOP                               ;
    MOV          A,     #0x05         ;
    B0MOV        @YZ,   A             ;
    B0BSET       P5.4                 ;
    JMP          func_04fd_003b       ;

func_04fd_002a:                       ;
    INCMS        0x41                 ;
    NOP                               ;
    MOV          A,     #0x09         ;
    SUB          A,     0x41          ;
    B0BTS0       FC                   ;
    JMP          func_04fd_0013       ;
    RET                               ;

func_04fd_0031:                       ;
    B0MOV        Y,     #0x01         ;
    B0MOV        Z,     #0x4e         ;
    MOV          A,     0x41          ;
    ADD          Z,     A             ;
    B0BTS0       FC                   ;
    INCMS        Y                    ;
    NOP                               ;
    DECMS        @YZ                  ;
    JMP          func_04fd_003b       ;
    JMP          func_04fd_0047       ;

func_04fd_003b:                       ;
    B0MOV        Y,     #0x04         ; Y = #0xf4
    B0MOV        Z,     #0xf4         ; Z = #0xf4 
    MOV          A,     0x0d          ; 
    ADD          Z,     A             ; Z = #0xf4 + 0x0d
    B0BTS0       FC                   ; Carry flag check
    INCMS        Y                    ; (may be omittable)
    NOP                               ; 
    MOVC                              ; memoOVC at Y = #0x04, Z = #0xf4 + 0x0d
    XOR          A,     #0xff         ; bit inversion
    AND          0x0c,  A             ; mask 0x0c
    B0BSET       FC                   ; Set Flag FC = 1
    RET                               ;

func_04fd_0047:                       ;
    B0MOV        Y,     #0x01         ;
    B0MOV        Z,     #0x44         ;
    MOV          A,     0x41          ;
    ADD          Z,     A             ;
    B0BTS0       FC                   ;
    INCMS        Y                    ;
    NOP                               ;
    CLR          @YZ                  ;
    B0BCLR       FC                   ; Clear Flag FC = 0
    B0BCLR       P5.4                 ;
    RET                               ;

func_054f:                            ; [ Some important CALL POINT ]             <-----------+
    CLR          0x42                 ; Clear 0x42                                            |
func_054f_0001:                       ;                                                       |
    B0MOV        Y,     #0x01         ; Y = #0x01                                             |
    B0MOV        Z,     #0x30         ; Z = #0x30                                             |
    MOV          A,     0x42          ;                                                       |
    ADD          Z,     A             ; Z = Z + 0x42 val                                      |
    B0BTS0       FC                   ; Check the carry flag                                  |
    INCMS        Y                    ; If carry occurs, Y += 1, if Y == 0, skip next.        |
    NOP                               ; No operation                                          |
    B0MOV        A,     0x0f          ; A <-- 0x0f                                            |
    CMPRS        A,     @YZ           ; Compare A and value of YZ                             |
    JMP          func_054f_000c       ; If 0x0f val != YZ val                                 |
    JMP          func_054f_0031       ; If 0x0f val == YZ val                                 |

func_054f_000c:                       ;                                                       |
    INCMS        0x42                 ; 0x42 += 1                                             |
    NOP                               ; No operation                                          |
    MOV          A,     #0x09         ; A <-- #0x09                                           |
    SUB          A,     0x42          ; A <-- A - 0x42 val                                    |
    B0BTS0       FC                   ; Check carry                                           |
    JMP          func_054f_0001       ; If carry not occurs, return to the func 0001 (loop?) -+
    CLR          0x42                 ; If carry occurs, clear 0x42
func_054f_0013:                       ;
    B0MOV        Y,     #0x01         ; Y = #0x01
    B0MOV        Z,     #0x30         ; Z = #0x30
    MOV          A,     0x42          ;
    ADD          Z,     A             ; Z = #0x30 + 0x42 val
    B0BTS0       FC                   ; Check the carry flag
    INCMS        Y                    ; If carry occurs, Y += 1
    NOP                               ; No operation
    B0MOV        A,     @YZ           ; A <-- YZ val
    B0BTS1       FZ                   ; Check the Zero flag
    JMP          func_054f_002a       ; If zero flag == 0, JMP
    MOV          A,     0x0f          ; If zero flag == 1,
    B0MOV        @YZ,   A             ; YZ <-- 0x0f val
    B0MOV        Y,     #0x01         ; Y = #0x01
    B0MOV        Z,     #0x3a         ; Z = #0x3a
    MOV          A,     0x42          ;
    ADD          Z,     A             ; Z = #0x3a + 0x42 val
    B0BTS0       FC                   ; Check the carry flag
    INCMS        Y                    ; If carry occurs, Y += 1
    NOP                               ; No operation
    MOV          A,     #0x02         ; A <-- #0x02
    B0MOV        @YZ,   A             ; YZ <-- A
    B0BSET       P5.5                 ; P5.5 = 1
    JMP          func_054f_003b       ;

func_054f_002a:                       ;
    INCMS        0x42                 ; 0x42 val += 1
    NOP                               ; No operation
    MOV          A,     #0x09         ; 
    SUB          A,     0x42          ; A = #0x09 - 0x42
    B0BTS0       FC                   ; Check the carry flag
    JMP          func_054f_0013       ; If carry occurs, JMP (loop?)
    RET                               ; ---> Return to func_0186+0x158

func_054f_0031:                       ;
    B0MOV        Y,     #0x01         ; Y = #0x01
    B0MOV        Z,     #0x3a         ; Z = #0x3a
    MOV          A,     0x42          ; 
    ADD          Z,     A             ; Z = #0x3a + 0x42
    B0BTS0       FC                   ; Check the carry flag
    INCMS        Y                    ; If carry occurs, Y = Y + 1
    NOP                               ; No operation
    DECMS        @YZ                  ; YZ = YZ - 1
    JMP          func_054f_003b       ; if YZ != 0
    JMP          func_054f_0046       ; if YZ == 0

func_054f_003b:                       ;
    B0MOV        Y,     #0x04         ; Y = #0x04
    B0MOV        Z,     #0xf4         ; Z = #0xf4 (+0)
    MOV          A,     0x0d          ;
    ADD          Z,     A             ; Z = #0xf4 + 0x0d
    B0BTS0       FC                   ; Check the carry flag
    INCMS        Y                    ; If carry occurs, Y = Y + 1
    NOP                               ; No operation
    MOVC                              ; A <-- ROM [Y,Z]. memoOVC Y = 04, Z = f4 + g.
    OR           0x0c,  A             ; 0x0c val = 0x0c val ORed with loaded YZ val
    B0BSET       FC                   ; Set the carry flag = 1
    RET                               ; ---> Return to func_0186+0x158

func_054f_0046:                       ; [ KEYMAP SET ]
    B0MOV        Y,     #0x01         ; Y = #0x01
    B0MOV        Z,     #0x30         ; Z = #0x30
    MOV          A,     0x42          ;
    ADD          Z,     A             ; Z = Z + 0x42 val
    B0BTS0       FC                   ; Carry flag check
    INCMS        Y                    ; If Carry occur,  Y += 1 if Y == 0, skip next.
    NOP                               ;
    CLR          @YZ                  ; Clear YZ
    B0BCLR       FC                   ; Set Carry flag = 0
    B0BCLR       P5.5                 ; Clear P5.5
    RET                               ; ---> Return to func_0186+0x158
    DW           0x0000               ; DW | 0x0000 | .. | <<<<<<<<<<<<<<<<<<<< Key ID mapping region <<<<<<<<<<<<<<<<
    DW           0x2929       ; DW | 0x0029 | Escape |
    DW           0x3535       ; DW | 0x0035 | Grave Accent and Tilde |
    DW           0x1414       ; DW | 0x0014 | q and Q |
    DW           0x1e1e       ; DW | 0x001e | 1 and ! |
    DW           0x0404       ; DW | 0x0004 | a and A |
    DW           0x1d1d       ; DW | 0x001d | z and Z |
    DW           0x8b8b       ; DW | 0x008b | International5 |
    DW           0x2b2b       ; DW | 0x002b | Tab |
    DW           0x3d3d       ; DW | 0x003d | F4 |
    DW           0x3b3b       ; DW | 0x003b | F2 |
    DW           0x0808       ; DW | 0x0008 | e and E |
    DW           0x2020       ; DW | 0x0020 | 3 and # |
    DW           0x0707       ; DW | 0x0007 | d and D |
    DW           0x0606       ; DW | 0x0006 | c and C |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x3c3c       ; DW | 0x003c | F3 |
    DW           0x6464       ; DW | 0x0064 | Nonã¼US Slash Bar |
    DW           0x3a3a       ; DW | 0x003a | F1 |
    DW           0x1a1a       ; DW | 0x001a | w and W |
    DW           0x1f1f       ; DW | 0x001f | 2 and @ |
    DW           0x1616       ; DW | 0x0016 | s and S |
    DW           0x1b1b       ; DW | 0x001b | x and X |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x3939       ; DW | 0x0039 | Caps Lock |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0xe0e0       ; DW | 0x00e0 | LeftControl |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0xe4e4       ; DW | 0x00e4 | RightControl |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x0a0a       ; DW | 0x000a | g and G |
    DW           0x2222       ; DW | 0x0022 | 5 and % |
    DW           0x1515       ; DW | 0x0015 | r and R |
    DW           0x2121       ; DW | 0x0021 | 4 and $ |
    DW           0x0909       ; DW | 0x0009 | f and F |
    DW           0x1919       ; DW | 0x0019 | v and V |
    DW           0x0505       ; DW | 0x0005 | b and B |
    DW           0x1717       ; DW | 0x0017 | t and T |
    DW           0x0b0b       ; DW | 0x000b | h and H |
    DW           0x2323       ; DW | 0x0023 | 6 and ^ |
    DW           0x1818       ; DW | 0x0018 | u and U |
    DW           0x2424       ; DW | 0x0024 | 7 and & |
    DW           0x0d0d       ; DW | 0x000d | j and J |
    DW           0x1010       ; DW | DW | 0x0010 | m and M |
    DW           0x1111       ; DW | 0x0011 | n and N |
    DW           0x1c1c       ; DW | 0x001c | y and Y |
    DW           0x3f3f       ; DW | 0x003f | F6 |
    DW           0x2e2e       ; DW | 0x002e | = and + |
    DW           0x0c0c       ; DW | 0x000c | i and I |
    DW           0x2525       ; DW | 0x0025 | 8 and * |
    DW           0x0e0e       ; DW | 0x000e | k and K |
    DW           0x3636       ; DW | 0x0036 | Comma and < |
    DW           0x8787       ; DW | 0x0087 | International1 |
    DW           0x3030       ; DW | 0x0030 | ] and } |
    DW           0x8a8a       ; DW | 0x008a | International4 |
    DW           0x4141       ; DW | 0x0041 | F8 |
    DW           0x1212       ; DW | 0x0012 | o and O |
    DW           0x2626       ; DW | 0x0026 | 9 and ( |
    DW           0x0f0f       ; DW | 0x000f | l and L |
    DW           0x3737       ; DW | 0x0037 | . and > |
    DW           0x8888       ; DW | 0x0088 | International2 |
    DW           0x4040       ; DW | 0x0040 | F7 |
    DW           0x3434       ; DW | 0x0034 | ' and " |
    DW           0x2d2d       ; DW | 0x002d | ã¼ and Underscore |
    DW           0x1313       ; DW | 0x0013 | p and P |
    DW           0x2727       ; DW | 0x0027 | 0 and ) |
    DW           0x3333       ; DW | 0x0033 | ; and : |
    DW           0x3232       ; DW | 0x0032 | Nonã¼US # and ~ |
    DW           0x3838       ; DW | 0x0038 | / and ? |
    DW           0x2f2f       ; DW | 0x002f | [ and { |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0xe5e5       ; DW | 0x00e5 | RightShift |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0xe1e1       ; DW | 0x00e1 | LeftShift |
    DW           0x3e3e       ; DW | 0x003e | F5 |
    DW           0x4242       ; DW | 0x0042 | F9 |
    DW           0x8989       ; DW | 0x0089 | International3 |
    DW           0x4343       ; DW | 0x0043 | F10 |
    DW           0x3131       ; DW | 0x0031 | \ and | |
    DW           0x2828       ; DW | 0x0028 | Return (ENTER) |
    DW           0x2c2c       ; DW | 0x002c | Spacebar |
    DW           0x2a2a       ; DW | 0x002a | DELETE (Backspace) |
    DW           0xe7e7       ; DW | 0x0000 | .. |
    DW           0x4a4a       ; DW | 0x004a | Home |
    DW           0xd7d7       ; DW | 0x0000 | .. |
    DW           0x4444       ; DW | 0x0044 | F11 |
    DW           0xd5d5       ; DW | 0x0000 | .. |
    DW           0xcdcd       ; DW | 0x0000 | .. |
    DW           0x5151       ; DW | 0x0051 | DownArrow |
    DW           0xd6d6       ; DW | 0x0000 | .. |
    DW           0xe2e2       ; DW | 0x00e2 | LeftAlt |
    DW           0xd4d4       ; DW | 0x00d4 | Keypad Memory Subtract |
    DW           0x4747       ; DW | 0x0000 | .. |
    DW           0xa5a5       ; DW | 0x0000 | .. |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0xe6e6       ; DW | 0x00e6 | RightAlt |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0xa6a6       ; DW | 0x0000 | .. |
    DW           0xd2d2       ; DW | 0x00d2 | Keypad Memory Clear |
    DW           0x4545       ; DW | 0x0045 | F12 |
    DW           0x6666       ; DW | 0x0000 | .. |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x4f4f       ; DW | 0x004f | RightArrow |
    DW           0xe3e3       ; DW | 0x00e3 | Left GUI |
    DW           0x5252       ; DW | 0x0052 | UpArrow |
    DW           0xa7a7       ; DW | 0x0000 | .. |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x4d4d       ; DW | 0x004d | End |
    DW           0xafaf       ; DW | 0x00af | Fn | af
    DW           0x4848       ; DW | 0x0048 | Pause |
    DW           0x5050       ; DW | 0x0050 | LeftArrow |
    DW           0xd0d0       ; DW | 0x00d0 | Keypad Memory Store |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x4c4c       ; DW | 0x004c | Delete Forward |
    DW           0x0000       ; DW | 0x0000 | .. |
    DW           0x4949       ; DW | 0x0049 | Insert |
    DW           0x4646       ; DW | 0x0046 | PrintScreen |
    DW           0x4b4b       ; DW | 0x004b | PageUp |
    DW           0x4e4e       ; DW | 0x004e | PageDown |
    DW           0x0000       ; DW | 0x0000 | .. |

func_0621:                            ; [ Trackpoint I2C ]
    B0BSET       P2.5                 ; tpSDA  = 1
    B0BSET       P2M.5                ; tpSDAM = 1(I2C SDA mode)
    JMP          $+1                  ;
    B0BSET       P2.4                 ; tpSCL  = 1
    B0BSET       P2M.4                ; tpSCLM = 1 (I2C SCL mode)
    JMP          $+1                  ;
    B0BCLR       P2.5                 ; tpSDA  = 0
    JMP          $+1                  ;
    JMP          $+1                  ;
    B0BCLR       P2.4                 ; tpSCL  = 0
    JMP          $+1                  ;
    JMP          $+1                  ;
    RET                               ;

func_062e:                            ; [ Trackpoint I2C ]
    B0BCLR       P2M.5                ; tpSDAM = 0
    JMP          $+1                  ;
    B0BCLR       P2M.4                ; tpSCLM = 0
func_062e_0003:                       ;
    B0BTS1       P2.4                 ;
    JMP          func_062e_0003       ;
    B0BCLR       P2.4                 ; tpSCL  = 0
    B0BSET       P2M.4                ; tpSCLM = 1
    B0BSET       P2.4                 ; tpSCL  = 1 
    MOV          A,     #0x06         ;
    CALL         func_0140            ;
    B0BCLR       P2.4                 ; tpSCL  = 0
    B0BCLR       P2.5                 ; tpSDA  = 0
    B0BSET       P2M.5                ; tpSDAM = 1
    B0BCLR       P2M.4                ; tpSCLM = 0
    MOV          A,     #0x03         ;
    CALL         func_0140            ;
    B0BCLR       P2M.5                ; tpSDAM = 0
    RET                               ;

func_0640:                            ; [ Trackpoint I2C ]
    BTS1         0x4d.1               ;
    JMP          func_0640_0004       ;
    B0BSET       P2.5                 ; tpSDA  = 1
    JMP          func_0640_0005       ;

func_0640_0004:                       ; [ Trackpoint I2C Read? ]
    B0BCLR       P2.5                 ; tpSDA  = 0
func_0640_0005:                       ;
    B0BSET       P2M.5                ; tpSDAM = 1
    JMP          $+1                  ;
    B0BSET       P2M.4                ; tpSCLM = 1
    B0BSET       P2.4                 ; tpSCL  = 1
    MOV          A,     #0x04         ;
    CALL         func_0140            ; Wait for #0x04 * n clocks.
    B0BCLR       P2.4                 ; tpSCL  = 0
    MOV          A,     #0x01         ;
    CALL         func_0140            ; Wait for #0x01 * n clocks.
    RET                               ;

func_064f:                            ;
    B0BCLR       P2M.5                ; tpSDAM = 0
    JMP          $+1                  ;
    BSET         0x4d.0               ; 0x4d.0 = 1
    B0BCLR       P2.4                 ; tpSCL  = 0
    MOV          A,     #0x04         ; A = #0x04 (100)
    CALL         func_0140            ; Call sleep function (wait for #0x04 * const clocks)
    B0BSET       P2.4                 ; tpSCL  = 1
    B0BTS1       P2.5                 ; Check tpSDA 1
    BCLR         0x4d.0               ; 0x4d.0 = 0
    MOV          A,     #0x02         ; A = #0x02
    CALL         func_0140            ; Call sleep function (wait for #0x02 * const clocks)
    RET                               ;

func_065b:                            ;
    BCLR         0x4d.3               ;
    BCLR         0x4d.2               ;
    CALL         func_064f            ;
    BTS1         0x4d.0               ;
    BSET         0x4d.2               ;
    B0BCLR       P2.4                 ;
    JMP          $+1                  ;
    RET                               ;

func_0663:                            ;
    MOV          0x48,  A             ;
    MOV          A,     #0x08         ;
    MOV          0x4c,  A             ;
    B0BCLR       FC                   ;
func_0663_0004:                       ;
    BSET         0x4d.1               ;
    BTS1         0x48.7               ;
    BCLR         0x4d.1               ;
    CALL         func_0640            ; Some SDA and SCL operations.
    RLCM         0x48                 ;
    DECMS        0x4c                 ;
    JMP          func_0663_0004       ;
    RET                               ;

func_066f:                            ;
    MOV          A,     0x49          ;
    MOV          0x48,  A             ;
    B0BCLR       P2M.4                ;
    JMP          $+1                  ;
    B0BCLR       FC                   ;
    RLCM         0x48                 ;
    B0BTS1       FC                   ;
    JMP          func_066f_000a       ;
    B0BSET       P2.5                 ;
    JMP          func_066f_000b       ;

func_066f_000a:                       ;
    B0BCLR       P2.5                 ;
func_066f_000b:                       ;
    B0BTS1       P2.4                 ;
    JMP          func_066f_000b       ;
    B0BCLR       P2.4                 ;
    B0BSET       P2M.4                ;
    MOV          A,     #0x07         ;
    MOV          0x4c,  A             ;
    B0BCLR       FC                   ;
func_066f_0012:                       ;
    BSET         0x4d.1               ;
    BTS1         0x48.7               ;
    BCLR         0x4d.1               ;
    CALL         func_0640            ; Some SDA and SCL operations.
    RLCM         0x48                 ;
    DECMS        0x4c                 ;
    JMP          func_066f_0012       ;
    RET                               ;

func_0689:                            ;
    B0BCLR       P2M.5                ; Trackpoint I2C SDA mode 0
    B0BCLR       P2M.4                ; Trackpoint I2C SCL mode 1
func_0689_0002:                       ;                        <--+
    B0BTS1       P2.4                 ; Trackpoint I2C SCL check  | (Clock check. Wait for turning 1.)
    JMP          func_0689_0002       ; if 0, --------------------+
    CLR          0x48                 ; 0x48 = 0
    B0BSET       P2.4                 ; Trackpoint I2C SCL Set 1
    B0BSET       P2M.4                ; Trackpoint I2C SCL mode 1
    BSET         0x4d.0               ; 0x4d.0 = 1
    B0BTS1       P2.5                 ; Trackpoint I2C SDA check
    BCLR         0x4d.0               ; if SDA == 0, 0x4d.0 = 1
    BCLR         0x48.0               ; 0x48.0 = 0
    BTS0         0x4d.0               ; Check 0x4d.0
    BSET         0x48.0               ; if 1 (SDA == 0), 0x48.0 = 1
    MOV          A,     #0x07         ;
    MOV          0x4c,  A             ; 0x4c = #0x07
    B0BCLR       FC                   ; Set Flag FC = 0
func_0689_0010:                       ; <-----------------------------------------------------------+
    RLCM         0x48                 ; 0x48 <-- Roteate 0x48. Maybe, change bit to be written.     |
    CALL         func_064f            ;                                                             |
    BCLR         0x48.0               ; 0x48.0 = 0 (Written 0)                                      |
    BTS0         0x4d.0               ; Check 0x4d.0                                                |
    BSET         0x48.0               ; if 0x4d.0 == 1, 0x48.0 = 1	 (Written 1)                    |
    DECMS        0x4c                 ; decrement 0x4c (maybe counter?)                             |
    JMP          func_0689_0010       ; if 0x4c != 0, return to top --------------------------------+
    B0BCLR       P2.4                 ; if 0x4c == 0, Trackpoint I2C SCL Set 0
    JMP          $+1                  ;
    MOV          A,     0x48          ; A = 0x48
    RET                               ; Return to lines in func_06ba

func_06a4:                            ;
    BCLR         0x4d.1               ; 0x4d.1 = 0
    CALL         func_0640            ; Some SDA and SCL operations
    RET                               ;

func_06a7:                            ;
    BSET         0x4d.1               ; 0x4d.1 = 1
    CALL         func_0640            ; Some SDA and SCL operations
    RET                               ;

func_06aa:                            ;
    MOV          0x49,  A             ;
    CALL         func_0621            ; _i2c_start ?
    MOV          A,     #0x54         ; #'T'?
    CALL         func_0663            ;
    CALL         func_065b            ;
    B0BTS1       0x4d.2               ;
    JMP          func_06aa_000d       ;
    CALL         func_066f            ;
    CALL         func_065b            ;
    B0BTS1       0x4d.2               ;
    JMP          func_06aa_000d       ;
    BCLR         0x4d.3               ;
    JMP          func_06aa_000e       ;

func_06aa_000d:                       ;
    BSET         0x4d.3               ;
func_06aa_000e:                       ;
    CALL         func_062e            ;
    RET                               ;

func_06ba:                            ;
    CALL         func_0621            ;
    MOV          A,     #0x55         ; I2C Address 0x2a
    CALL         func_0663            ;
    CALL         func_065b            ;
    B0BTS1       0x4d.2               ;
    JMP          func_06ba_001a       ;
    CALL         func_0689            ; Read SDA? (_i2c_rxbyte)
    CMPRS        A,     #0x80         ; Check read byte == #0x80
    JMP          func_06ba_0018       ; if read byte == #0x80, JMP
    CALL         func_06a4            ;
    CALL         func_0689            ; Read SDA? (_i2c_rxbyte)
    MOV          0x45,  A             ; 0x45 = read byte         tpDatan?
    CALL         func_06a4            ;
    CALL         func_0787            ; POINT B (maybe)
    CALL         func_0689            ; Read SDA? (_i2c_rxbyte)
    MOV          0x32,  A             ; 0x32 = read byte         tpDatan?
    CALL         func_06a4            ;
    CALL         func_0689            ; Read SDA? (_i2c_rxbyte)
    XOR          A,     #0xff         ; Invert all read bits
    ADD          A,     #0x01         ; read bits + 1
    MOV          0x33,  A             ; 0x33 = calcd read bits   tpDatan? 33 points mut
    CALL         func_06a4            ;
    CALL         func_0689            ; Read SDA? (_i2c_rxbyte)
    CALL         func_06a7            ;

func_06ba_0018:                       ;
    BCLR         0x4d.3               ;
    JMP          func_06ba_001b       ;

func_06ba_001a:                       ;
    BSET         0x4d.3               ; what flag?
func_06ba_001b:                       ;
    CALL         func_062e            ;
    BTS0         0x12.6               ; If 0x12.6 == 0, skip
    JMP          func_06ba_0021       ; [Middle-button 1] Write No operation to disable the auto-scrolling
    CALL         func_080e            ;
    CALL         func_0831            ;
    CALL         func_07b7            ; [RETURN POINT FROM TRACKPOINT PROCESS]
    NOP    ;; [ tp speed++ ] x2
    NOP    ;; [ tp speed++ ] x3
    NOP    ;; [ tp speed++ ] x4
    NOP    ;; [ tp speed++ ] x5

func_06ba_0021:                       ; Related to the auto-scrolling
    BTS1         0x12.6               ; [Middle-button 2] Write No operation to disable the auto-scrolling
    RET                               ; RETURN to POINT A
    MOV          A,     0x32          ; 32points
    MOV          0x34,  A             ; 0x34 <= 0x32
    MOV          A,     0x33          ; 33points
    MOV          0x35,  A             ; 0x35 <= 0x33
    BTS1         0x34.7               ;
    JMP          func_06ba_002d       ;
    MOV          A,     0x34          ;
    XOR          A,     #0xff         ; Invert all bits
    ADD          A,     #0x01         ; +1
    MOV          0x34,  A             ; 0x34 = 0x34 inverted + 00000001
func_06ba_002d:                       ;
    B0BCLR       FC                   ;
    RRCM         0x34                 ;
    BTS1         0x35.7               ;
    JMP          func_06ba_0035       ;
    MOV          A,     0x35          ;
    XOR          A,     #0xff         ; Invert all bits
    ADD          A,     #0x01         ; +1
    MOV          0x35,  A             ; 0x35 = 0x35 inverted + 00000001
func_06ba_0035:                       ;
    MOV          A,     0x34          ;
    SUB          A,     0x35          ; A = 0x34 - 0x35
    B0BTS0       FC                   ;
    JMP          func_06ba_0057       ;
    MOV          A,     0x32          ; 32points
    MOV          0x34,  A             ; 0x34 = 0x32
    MOV          A,     0x33          ; 33points
    MOV          0x35,  A             ; 0x35 = 0x33
    BTS1         0x34.7               ;
    JMP          func_06ba_0043       ;
    MOV          A,     0x34          ;
    XOR          A,     #0xff         ; Invert all bits
    ADD          A,     #0x01         ; +1
    MOV          0x34,  A             ; 0x34 = 0x34 inverted + 00000001
func_06ba_0043:                       ;
    BTS1         0x35.7               ;
    JMP          func_06ba_0049       ;
    MOV          A,     0x35          ;
    XOR          A,     #0xff         ; Invert all bits
    ADD          A,     #0x01         ; +1
    MOV          0x35,  A             ; 0x35 = 0x35 inverted + 00000001
func_06ba_0049:                       ;
    B0BCLR       FC                   ;
    RRCM         0x35                 ;
    MOV          A,     0x35          ;
    SUB          A,     0x34          ;
    B0BTS0       FC                   ;
    JMP          func_06ba_0093       ;
    CLR          0x2e                 ; 2epoints
    CLR          0x2f                 ; 2fpoints
    CLR          0x30                 ;
    CLR          0x31                 ;
    CLR          0x36                 ;
    CLR          0x37                 ;
    BCLR         0x13.2               ;
    RET                               ; RETURN to POINT A

func_06ba_0057:                       ;
    CLR          0x36                 ;
    CLR          0x30                 ;
    BTS0         0x14.5               ; Auto-scroll flag
    JMP          func_06ba_0061       ;
    BCLR         0x14.6               ;
    MOV          A,     0x32          ; 32points
    B0BTS1       FZ                   ;
    JMP          func_06ba_0061       ;
    BSET         0x14.6               ; Set 0x14.6
    RET                               ;

func_06ba_0061:                       ;
    BTS1         0x32.7               ; 32points
    JMP          func_06ba_007a       ;
    MOV          A,     0x32          ; 32points
    B0BTS1       0x37.7               ;
    JMP          func_06ba_0068       ;
    ADD          0x37,  A             ;
    JMP          func_06ba_0069       ;

func_06ba_0068:                       ;
    MOV          0x37,  A             ;
func_06ba_0069:                       ;
    MOV          A,     0x37          ;
    ADD          A,     #0x0d         ;
    B0BTS1       FC                   ;
    JMP          func_06ba_0074       ;
    BTS1         0x13.3               ;
    JMP          func_06ba_0073       ;
    MOV          A,     #0xff         ;
    XOR          A,     0x31          ;
    ADD          A,     #0x01         ;
    MOV          0x31,  A             ;
func_06ba_0073:                       ;
    RET                               ;

func_06ba_0074:                       ;
    MOV          0x37,  A             ;
    MOV          A,     #0x01         ;
    ADD          0x31,  A             ;
    BSET         0x13.3               ;
    JMP          func_06ba_0069       ;
    DW           0x0e00               ; DW | 0x0e00 | .. |

func_06ba_007a:                       ;
    MOV          A,     0x32          ; 32points
    B0BTS0       0x37.7               ;
    JMP          func_06ba_007f       ;
    ADD          0x37,  A             ;
    JMP          func_06ba_0080       ;

func_06ba_007f:                       ;
    MOV          0x37,  A             ;
func_06ba_0080:                       ;
    MOV          A,     0x32          ; 32points
    ADD          0x37,  A             ;
func_06ba_0082:                       ;
    MOV          A,     0x37          ;
    SUB          A,     #0x0d         ;
    B0BTS0       FC                   ;
    JMP          func_06ba_008d       ;
    BTS1         0x13.3               ;
    JMP          func_06ba_008c       ;
    MOV          A,     #0xff         ;
    XOR          A,     0x31          ;
    ADD          A,     #0x01         ;
    MOV          0x31,  A             ;
func_06ba_008c:                       ;
    RET                               ;

func_06ba_008d:                       ;
    MOV          0x37,  A             ;
    MOV          A,     #0xff         ;
    ADD          0x31,  A             ;
    BSET         0x13.3               ;
    JMP          func_06ba_0082       ;
    DW           0x0e00               ; DW | 0x0e00 | .. |

func_06ba_0093:                       ;
    CLR          0x31                 ;
    CLR          0x37                 ;
    BTS0         0x14.5               ; Auto-scroll flag
    JMP          func_06ba_009d       ;
    BCLR         0x14.6               ;
    MOV          A,     0x33          ; 33points
    B0BTS1       FZ                   ;
    JMP          func_06ba_009d       ;
    BSET         0x14.6               ;
    RET                               ;

func_06ba_009d:                       ;
    BTS1         0x33.7               ; 33points
    JMP          func_06ba_00b5       ;
    MOV          A,     0x33          ; 33points
    BTS1         0x36.7               ;
    JMP          func_06ba_00a4       ;
    ADD          0x36,  A             ;
    JMP          func_06ba_00a5       ;

func_06ba_00a4:                       ;
    MOV          0x36,  A             ;
func_06ba_00a5:                       ;
    MOV          A,     0x36          ;
    ADD          A,     #0x12         ;
    B0BTS0       FC                   ;
    RET                               ;
    MOV          0x36,  A             ;
    MOV          A,     #0x01         ;
    ADD          0x30,  A             ;
    BTS0         0x14.5               ; Auto-scroll flag
    JMP          func_06ba_00b1       ;
    BSET         0x13.2               ;
    BCLR         0x13.3               ;
    JMP          func_06ba_00b3       ;

func_06ba_00b1:                       ;
    BCLR         0x13.2               ;
    BSET         0x13.3               ;
func_06ba_00b3:                       ;
    JMP          func_06ba_00a5       ;
    DW           0x0e00               ; DW | 0x0e00 | .. |

func_06ba_00b5:                       ;
    MOV          A,     0x33          ; 33points
    B0BTS0       0x36.7               ;
    JMP          func_06ba_00ba       ;
    ADD          0x36,  A             ;
    JMP          func_06ba_00bb       ;

func_06ba_00ba:                       ;
    MOV          0x36,  A             ;
func_06ba_00bb:                       ;
    MOV          A,     0x33          ; 33points
    ADD          0x36,  A             ;
func_06ba_00bd:                       ;
    MOV          A,     0x36          ;
    SUB          A,     #0x12         ;
    B0BTS1       FC                   ;
    RET                               ;
    MOV          0x36,  A             ;
    MOV          A,     #0xff         ;
    ADD          0x30,  A             ;
    BTS0         0x14.5               ; Auto-scroll flag
    JMP          func_06ba_00c9       ;
    BSET         0x13.2               ;
    BCLR         0x13.3               ;
    JMP          func_06ba_00cb       ;

func_06ba_00c9:                       ;
    BCLR         0x13.2               ;
    BSET         0x13.3               ;
func_06ba_00cb:                       ;
    JMP          func_06ba_00bd       ;
    DW           0x0e00               ; DW | 0x0e00 | .. |

func_0787:                            ;
    BCLR         0x2c.0               ;
    BTS0         0x45.0               ;
    BSET         0x2c.0               ;
    BCLR         0x2c.1               ;
    BTS0         0x45.1               ;
    BSET         0x2c.1               ;
    BTS0         0x14.5               ; Auto-scroll flag
    JMP          func_0787_000b       ; [Middle-button 3] Write No operation to disable the auto-scrolling
    BCLR         0x2c.2               ;
    BTS0         0x45.2               ;
    BSET         0x2c.2               ;
func_0787_000b:                       ; Related to the auto-scrolling
    MOV          A,     0x2c          ;
    CMPRS        A,     0x2d          ; if 0x2d != 0x2c
    JMP          func_0787_0010       ; 
    BCLR         0x13.2               ; 
    JMP          func_0787_0013       ;

func_0787_0010:                       ;
    MOV          A,     0x2c          ;
    MOV          0x2d,  A             ; 0x2d = 0x2c
    BSET         0x13.2               ; Set 0x13.2 what flag?
func_0787_0013:                       ;
    BTS0         0x14.5               ; Auto-scroll flag
    JMP          func_0787_0019       ; 
    BCLR         0x12.6               ; Clear 0x12.6
    BTS0         0x2c.2               ; 
    BSET         0x12.6               ; If 0x2c.2 == 1, set 0x12.6 (May be middle button pressed trigger?)
    JMP          func_0787_002f       ;

func_0787_0019:                       ;
    BCLR         0x2c.2               ; 0x2c.2 = 0
    MOV          A,     0x45          ; 
    AND          A,     #0x04         ; Set 1 to the 3rd bit of the value of 0x45 (#0x04 = 0000100)
    CMPRS        A,     0x78          ; 
    JMP          func_0787_0020       ; 
    BCLR         0x13.6               ; 0x13.6 = 0
    JMP          func_0787_002f       ;

func_0787_0020:                       ;
    MOV          A,     0x45          ; 
    AND          A,     #0x04         ; Set 1 to the 3rd bit of the value of 0x45 (#0x04 = 0000100)
    MOV          0x78,  A             ; 
    BSET         0x13.6               ; Set 0x13.6 (Some general flag)
    BTS1         0x78.2               ; Check 0x78.2 What is this ?
    JMP          func_0787_002c       ;
    MOV          A,     #0x00         ; Set the special key trigger pair
    MOV          0x28,  A             ; 0x28 = #0x00
    MOV          A,  #0x04            ; 
    MOV          0x29,  A             ; 0x29 = #0x04
    BSET         0x12.6               ; Set 0x12.6
    JMP          func_0787_002f       ;

func_0787_002c:                       ; Clear the special key trigger pair (0x28, 0x29)
    CLR          0x28                 ; 0x28 = 0
    CLR          0x29                 ; 0x29 = 0
    BCLR         0x12.6               ; 0x12.6 = 0
func_0787_002f:                       ;
    RET                               ; RETURN TO POINT B

func_07b7:                            ; [Trackpoint X-axis processing region]
    MOV          A,     0x32          ; A = 0x32
    B0BTS0       FZ                   ; Check FZ
    JMP          func_07b7_0017       ; if FZ == 1 (0x32 == 0), go to Y-axis process
    BSET         0x13.2               ; if FZ == 0, 0x13.2 = 1.
    BTS0         0x2e.7               ; Test 0x2e.7
    JMP          func_07b7_000f       ; if 0x2e.7 == 1, go to func_07b7_000f --+
    ADD          0x2e,  A             ; 0x2e = 0x2e + 0x32 --------------------+ <Omit> MOV A, 0x32
    BTS0         0x32.7               ; Test 0x32.7
    JMP          func_07b7_0017       ; if 0x32.7 == 1, go to Y-axis process
    BTS1         0x2e.7               ; if 0x32.7 == 0, Test 0x2e.7 (updated) 
    JMP          func_07b7_0017       ; if 0x2e.7 == 0, go to Y-axis process
    MOV          A,     #0x7f         ; if 0x2e.7 == 1, 
    MOV          0x2e,  A             ; 0x2e = 01111111
    JMP          func_07b7_0017       ; go to Y-axis

func_07b7_000f:                       ; [Trackpoint Y-axis processing region] --+
    ADD          0x2e,  A             ; 0x2e = 0x2e + 0x32 ---------------------+ <Omit> MOV A, 0x32
    BTS1         0x32.7               ; Test 0x32.7
    JMP          func_07b7_0017       ; if 0x32.7 == 0, go to Y-axis process
    BTS0         0x2e.7               ; if 0x32.7 == 1, Test 0x2e.7
    JMP          func_07b7_0017       ; if 0x2e.7 == 1, go to Y-axis process
    MOV          A,     #0x81         ; if 0x2e.7 == 0, 
    MOV          0x2e,  A             ; 0x2e = 10000001
func_07b7_0017:                       ; [Trackpoint Y-axis processing region]
    MOV          A,     0x33          ; 33points
    B0BTS0       FZ                   ;
    JMP          func_07b7_002e       ; if FZ == 1 (0x33 == 0), RETURN 
    BSET         0x13.2               ; 0x13.2 = 1
    BTS0         0x2f.7               ; 2fpoints
    JMP          func_07b7_0026       ; if 0x2f.7 == 1 ---------------------------+ <Omit> MOV A, 0x33
    ADD          0x2f,  A             ; 2fpoints (mut)	| 0x2f = 0x2f + 0x33 -----+
    BTS0         0x33.7               ; 33points                                  |
    JMP          func_07b7_002e       ; if 0x33.7 == 1, RETURN                    |
    BTS1         0x2f.7               ; 2fpoints                                  |
    JMP          func_07b7_002e       ;                                           |
    MOV          A,     #0x7f         ; if 0x2f.7 == 0, RETURN                    |
    MOV          0x2f,  A             ; 2fpoints (mut)	| 0x2f = #0x7f (01111111) |
    JMP          func_07b7_002e       ; RETURN                                    |

func_07b7_0026:                       ; <-----------------------------------------+ <Omit> MOV A, 0x33
    ADD          0x2f,  A             ; 2fpoints (mut)	| 0x2f = 0x2f + 0x33 -----+
    BTS1         0x33.7               ; 33points
    JMP          func_07b7_002e       ; if 0x33.7 == 0, RETURN
    BTS0         0x2f.7               ; 2fpoints
    JMP          func_07b7_002e       ; if 0x2f.7 == 1, RETURN
    MOV          A,     #0x81         ;
    MOV          0x2f,  A             ; 2fpoints (mut)	| 0x2f = #0x81 (10000001), and RETURN
func_07b7_002e:                       ;
    RET                               ;

func_07e6:                            ;
    MOV          A,     0x01          ;
    AND          A,     #0x0f         ;
    B0ADD        PCL,   A             ;
    JMP          func_07e6_0026       ;
    JMP          func_07e6_000d       ;
    JMP          func_07e6_0010       ;
    JMP          func_07e6_0013       ;
    JMP          func_07e6_0016       ;
    JMP          func_07e6_0026       ;
    JMP          func_07e6_0019       ;
    JMP          func_07e6_001c       ;
    JMP          func_07e6_001f       ;
    JMP          func_07e6_0022       ;

func_07e6_000d:                       ;
    B0MOV        Y,     #0x08         ; Y = #0x08
    B0MOV        Z,     #0x54         ; Z = #0x54
    JMP          func_07e6_0024       ;

func_07e6_0010:                       ;
    B0MOV        Y,     #0x08         ; Y = #0x08
    B0MOV        Z,     #0x80         ; Z = #0x80
    JMP          func_07e6_0024       ;

func_07e6_0013:                       ;
    B0MOV        Y,     #0x08         ; Y = #0x08
    B0MOV        Z,     #0xab         ; Z = #0xab
    JMP          func_07e6_0024       ;

func_07e6_0016:                       ;
    B0MOV        Y,     #0x08         ; Y = #0x08
    B0MOV        Z,     #0xd6         ; Z = #0xd6
    JMP          func_07e6_0024       ;

func_07e6_0019:                       ;
    B0MOV        Y,     #0x09         ;
    B0MOV        Z,     #0x01         ;
    JMP          func_07e6_0024       ;

func_07e6_001c:                       ;
    B0MOV        Y,     #0x09         ;
    B0MOV        Z,     #0x2c         ;
    JMP          func_07e6_0024       ;

func_07e6_001f:                       ;
    B0MOV        Y,     #0x09         ;
    B0MOV        Z,     #0x57         ;
    JMP          func_07e6_0024       ;

func_07e6_0022:                       ;
    B0MOV        Y,     #0x09         ;
    B0MOV        Z,     #0x83         ;
func_07e6_0024:                       ;
    B0BCLR       FC                   ;
    RET                               ;

func_07e6_0026:                       ;
    B0BSET       FC                   ;
    RET                               ;

func_080e:                            ;
    CALL         func_07e6            ;
    B0BTS0       FC                   ;
    JMP          func_080e_0022       ;
    MOV          A,     0x32          ; 32points
    BTS1         0x32.7               ; 32points
    JMP          func_080e_0008       ;
    XOR          A,     #0xff         ;
    ADD          A,     #0x01         ;
func_080e_0008:                       ;
    MOV          0x34,  A             ;
    MOV          A,     #0x29         ;
    SUB          A,     0x34          ;
    B0BTS0       FC                   ;
    JMP          func_080e_000f       ;
    MOV          A,     #0x29         ;
    JMP          func_080e_0010       ;

func_080e_000f:                       ;
    MOV          A,     0x34          ;
func_080e_0010:                       ;
    ADD          Z,     A             ;
    B0BTS0       FC                   ;
    INCMS        Y                    ;
    NOP                               ;
    MOVC                              ;
    B0MOV        0x34,  A             ;
    BTS0         0x32.7               ; 32points
    JMP          func_080e_001b       ;
    MOV          A,     0x34          ;
    ADD          0x32,  A             ; 32points
    JMP          func_080e_0022       ;

func_080e_001b:                       ;
    B0MOV        A,     0x32          ; 32points
    XOR          A,     #0xff         ;
    ADD          A,     #0x01         ;
    ADD          A,     0x34          ;
    XOR          A,     #0xff         ;
    ADD          A,     #0x01         ;
    B0MOV        0x32,  A             ; 32points
func_080e_0022:                       ;
    RET                               ;

func_0831:                            ;
    CALL         func_07e6            ;
    B0BTS0       FC                   ;
    JMP          func_0831_0022       ;
    MOV          A,     0x33          ; 33points
    BTS1         0x33.7               ; 33points
    JMP          func_0831_0008       ;
    XOR          A,     #0xff         ;DW
    ADD          A,     #0x01         ;
func_0831_0008:                       ;
    MOV          0x35,  A             ;
    MOV          A,     #0x29         ;
    SUB          A,     0x35          ;
    B0BTS0       FC                   ;
    JMP          func_0831_000f       ;
    MOV          A,     #0x29         ;
    JMP          func_0831_0010       ;

func_0831_000f:                       ;
    MOV          A,     0x35          ;
func_0831_0010:                       ;
    ADD          Z,     A             ;
    B0BTS0       FC                   ;
    INCMS        Y                    ;
    NOP                               ;
    MOVC                              ; memoOVC Y = #0x08 or #0x09?, Z = v-c z + 29
    MOV          0x35,  A             ;
    BTS0         0x33.7               ; 33points
    JMP          func_0831_001b       ;
    MOV          A,     0x35          ;
    ADD          0x33,  A             ; 33points (mut) | 0x33 = 0x33 + 0x35
    JMP          func_0831_0022       ;

func_0831_001b:                       ;
    B0MOV        A,     0x33          ; B033points
    XOR          A,     #0xff         ; invert
    ADD          A,     #0x01         ;
    ADD          A,     0x35          ;
    XOR          A,     #0xff         ;
    ADD          A,     #0x01         ;
    B0MOV        0x33,  A             ; B033points | B00x33 = invert(invert(B00x33) + 1 + 0x35) + 1
func_0831_0022:                       ;
    RET                               ;
    DW           0x0000               ; DW | 0x0000 | .. | address: 0x0854. designated from func_07e6_000d
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0xfff9               ; DW | 0xfff9 | .. |
    DW           0xfff9               ; DW | 0xfff9 | .. |
    DW           0xfff8               ; DW | 0xfff8 | .. |
    DW           0xfff8               ; DW | 0xfff8 | .. |
    DW           0xfff7               ; DW | 0xfff7 | .. |
    DW           0xfff7               ; DW | 0xfff7 | .. |
    DW           0xfff6               ; DW | 0xfff6 | .. |
    DW           0xfff6               ; DW | 0xfff6 | .. |
    DW           0xfff5               ; DW | 0xfff5 | .. |
    DW           0xfff4               ; DW | 0xfff4 | .. |
    DW           0xfff4               ; DW | 0xfff4 | .. |
    DW           0xfff3               ; DW | 0xfff3 | .. |
    DW           0xfff3               ; DW | 0xfff3 | .. |
    DW           0xfff2               ; DW | 0xfff2 | .. |
    DW           0xfff2               ; DW | 0xfff2 | .. |
    DW           0xfff1               ; DW | 0xfff1 | .. |
    DW           0xfff1               ; DW | 0xfff1 | .. |
    DW           0xfff0               ; DW | 0xfff0 | .. |
    DW           0xffef               ; DW | 0xffef | .. |
    DW           0xffef               ; DW | 0xffef | .. |
    DW           0xffee               ; DW | 0xffee | .. |
    DW           0xffee               ; DW | 0xffee | .. |
    DW           0xffed               ; DW | 0xffed | .. |
    DW           0xffed               ; DW | 0xffed | .. |
    DW           0xffec               ; DW | 0xffec | .. |
    DW           0xffec               ; DW | 0xffec | .. |
    DW           0xffeb               ; DW | 0xffeb | .. |
    DW           0xffeb               ; DW | 0xffeb | .. |
    DW           0xffea               ; DW | 0xffea | .. |
    DW           0xffe9               ; DW | 0xffe9 | .. |
    DW           0xffe9               ; DW | 0xffe9 | .. |
    DW           0x0000               ; DW | 0x0000 | .. | address: 0x0880. designated from func_07e6_0010
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0xfff9               ; DW | 0xfff9 | .. |
    DW           0xfff9               ; DW | 0xfff9 | .. |
    DW           0xfff8               ; DW | 0xfff8 | .. |
    DW           0xfff8               ; DW | 0xfff8 | .. |
    DW           0xfff7               ; DW | 0xfff7 | .. |
    DW           0xfff7               ; DW | 0xfff7 | .. |
    DW           0xfff7               ; DW | 0xfff7 | .. |
    DW           0xfff6               ; DW | 0xfff6 | .. |
    DW           0xfff6               ; DW | 0xfff6 | .. |
    DW           0xfff5               ; DW | 0xfff5 | .. |
    DW           0xfff5               ; DW | 0xfff5 | .. |
    DW           0xfff4               ; DW | 0xfff4 | .. |
    DW           0xfff4               ; DW | 0xfff4 | .. |
    DW           0xfff3               ; DW | 0xfff3 | .. |
    DW           0xfff3               ; DW | 0xfff3 | .. |
    DW           0xfff2               ; DW | 0xfff2 | .. |
    DW           0xfff2               ; DW | 0xfff2 | .. |
    DW           0xfff2               ; DW | 0xfff2 | .. |
    DW           0xfff1               ; DW | 0xfff1 | .. |
    DW           0xfff1               ; DW | 0xfff1 | .. |
    DW           0xfff0               ; DW | 0xfff0 | .. |
    DW           0xfff0               ; DW | 0xfff0 | .. |
    DW           0xffef               ; DW | 0xffef | .. |
    DW           0xffef               ; DW | 0xffef | .. |
    DW           0xffee               ; DW | 0xffee | .. |
    DW           0xffee               ; DW | 0xffee | .. |
    DW           0xffee               ; DW | 0xffee | .. |
    DW           0xffed               ; DW | 0xffed | .. |
    DW           0x0000               ; DW | 0x0000 | .. | address: 0x08ab. designated from func_07e6_0013
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0xfff9               ; DW | 0xfff9 | .. |
    DW           0xfff9               ; DW | 0xfff9 | .. |
    DW           0xfff9               ; DW | 0xfff9 | .. |
    DW           0xfff9               ; DW | 0xfff9 | .. |
    DW           0xfff8               ; DW | 0xfff8 | .. |
    DW           0xfff8               ; DW | 0xfff8 | .. |
    DW           0xfff8               ; DW | 0xfff8 | .. |
    DW           0xfff8               ; DW | 0xfff8 | .. |
    DW           0xfff7               ; DW | 0xfff7 | .. |
    DW           0xfff7               ; DW | 0xfff7 | .. |
    DW           0xfff7               ; DW | 0xfff7 | .. |
    DW           0xfff7               ; DW | 0xfff7 | .. |
    DW           0xfff6               ; DW | 0xfff6 | .. |
    DW           0xfff6               ; DW | 0xfff6 | .. |
    DW           0xfff6               ; DW | 0xfff6 | .. |
    DW           0xfff6               ; DW | 0xfff6 | .. |
    DW           0xfff6               ; DW | 0xfff6 | .. |
    DW           0x0000               ; DW | 0x0000 | .. | address: 0x08d6. designated from func_07e6_0016
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffe               ; DW | 0xfffe | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffd               ; DW | 0xfffd | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffc               ; DW | 0xfffc | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffb               ; DW | 0xfffb | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0xfffa               ; DW | 0xfffa | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0004               ; DW | 0x0004 | .. |
    DW           0x0004               ; DW | 0x0004 | .. |
    DW           0x0004               ; DW | 0x0004 | .. |
    DW           0x0004               ; DW | 0x0004 | .. |
    DW           0x0005               ; DW | 0x0005 | .. |
    DW           0x0005               ; DW | 0x0005 | .. |
    DW           0x0005               ; DW | 0x0005 | .. |
    DW           0x0005               ; DW | 0x0005 | .. |
    DW           0x0006               ; DW | 0x0006 | .. |
    DW           0x0006               ; DW | 0x0006 | .. |
    DW           0x0006               ; DW | 0x0006 | .. |
    DW           0x0006               ; DW | 0x0006 | .. |
    DW           0x0007               ; DW | 0x0007 | .. |
    DW           0x0007               ; DW | 0x0007 | .. |
    DW           0x0007               ; DW | 0x0007 | .. |
    DW           0x0007               ; DW | 0x0007 | .. |
    DW           0x0008               ; DW | 0x0008 | .. |
    DW           0x0008               ; DW | 0x0008 | .. |
    DW           0x0008               ; DW | 0x0008 | .. |
    DW           0x0008               ; DW | 0x0008 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x000a               ; DW | 0x000a | .. |
    DW           0x000a               ; DW | 0x000a | .. |
    DW           0x000a               ; DW | 0x000a | .. |
    DW           0x000a               ; DW | 0x000a | .. |
    DW           0x000b               ; DW | 0x000b | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0004               ; DW | 0x0004 | .. |
    DW           0x0004               ; DW | 0x0004 | .. |
    DW           0x0005               ; DW | 0x0005 | .. |
    DW           0x0006               ; DW | 0x0006 | .. |
    DW           0x0006               ; DW | 0x0006 | .. |
    DW           0x0007               ; DW | 0x0007 | .. |
    DW           0x0007               ; DW | 0x0007 | .. |
    DW           0x0008               ; DW | 0x0008 | .. |
    DW           0x0008               ; DW | 0x0008 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x000a               ; DW | 0x000a | .. |
    DW           0x000a               ; DW | 0x000a | .. |
    DW           0x000b               ; DW | 0x000b | .. |
    DW           0x000c               ; DW | 0x000c | .. |
    DW           0x000c               ; DW | 0x000c | .. |
    DW           0x000d               ; DW | 0x000d | .. |
    DW           0x000d               ; DW | 0x000d | .. |
    DW           0x000e               ; DW | 0x000e | .. |
    DW           0x000e               ; DW | 0x000e | .. |
    DW           0x000f               ; DW | 0x000f | .. |
    DW           0x000f               ; DW | 0x000f | .. |
    DW           0x0010               ; DW | 0x0010 | .. |
    DW           0x0011               ; DW | 0x0011 | .. |
    DW           0x0011               ; DW | 0x0011 | .. |
    DW           0x0012               ; DW | 0x0012 | .. |
    DW           0x0012               ; DW | 0x0012 | .. |
    DW           0x0013               ; DW | 0x0013 | .. |
    DW           0x0013               ; DW | 0x0013 | .. |
    DW           0x0014               ; DW | 0x0014 | .. |
    DW           0x0014               ; DW | 0x0014 | .. |
    DW           0x0015               ; DW | 0x0015 | .. |
    DW           0x0015               ; DW | 0x0015 | .. |
    DW           0x0016               ; DW | 0x0016 | .. |
    DW           0x0017               ; DW | 0x0017 | .. |
    DW           0x0017               ; DW | 0x0017 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0004               ; DW | 0x0004 | .. |
    DW           0x0005               ; DW | 0x0005 | .. |
    DW           0x0006               ; DW | 0x0006 | .. |
    DW           0x0007               ; DW | 0x0007 | .. |
    DW           0x0008               ; DW | 0x0008 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x000a               ; DW | 0x000a | .. |
    DW           0x000b               ; DW | 0x000b | .. |
    DW           0x000c               ; DW | 0x000c | .. |
    DW           0x000d               ; DW | 0x000d | .. |
    DW           0x000e               ; DW | 0x000e | .. |
    DW           0x000e               ; DW | 0x000e | .. |
    DW           0x000f               ; DW | 0x000f | .. |
    DW           0x0010               ; DW | 0x0010 | .. |
    DW           0x0011               ; DW | 0x0011 | .. |
    DW           0x0012               ; DW | 0x0012 | .. |
    DW           0x0013               ; DW | 0x0013 | .. |
    DW           0x0014               ; DW | 0x0014 | .. |
    DW           0x0014               ; DW | 0x0014 | .. |
    DW           0x0015               ; DW | 0x0015 | .. |
    DW           0x0016               ; DW | 0x0016 | .. |
    DW           0x0017               ; DW | 0x0017 | .. |
    DW           0x0018               ; DW | 0x0018 | .. |
    DW           0x0019               ; DW | 0x0019 | .. |
    DW           0x001a               ; DW | 0x001a | .. |
    DW           0x001a               ; DW | 0x001a | .. |
    DW           0x001b               ; DW | 0x001b | .. |
    DW           0x001c               ; DW | 0x001c | .. |
    DW           0x001d               ; DW | 0x001d | .. |
    DW           0x001e               ; DW | 0x001e | .. |
    DW           0x001f               ; DW | 0x001f | .. |
    DW           0x001f               ; DW | 0x001f | .. |
    DW           0x0020               ; DW | 0x0020 | .  |
    DW           0x0021               ; DW | 0x0021 | .! |
    DW           0x0022               ; DW | 0x0022 | ." |
    DW           0x0023               ; DW | 0x0023 | .# |
    DW           0x0024               ; DW | 0x0024 | .$ |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0004               ; DW | 0x0004 | .. |
    DW           0x0005               ; DW | 0x0005 | .. |
    DW           0x0006               ; DW | 0x0006 | .. |
    DW           0x0007               ; DW | 0x0007 | .. |
    DW           0x0008               ; DW | 0x0008 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x000b               ; DW | 0x000b | .. |
    DW           0x000c               ; DW | 0x000c | .. |
    DW           0x000d               ; DW | 0x000d | .. |
    DW           0x000e               ; DW | 0x000e | .. |
    DW           0x000f               ; DW | 0x000f | .. |
    DW           0x0010               ; DW | 0x0010 | .. |
    DW           0x0011               ; DW | 0x0011 | .. |
    DW           0x0012               ; DW | 0x0012 | .. |
    DW           0x0013               ; DW | 0x0013 | .. |
    DW           0x0014               ; DW | 0x0014 | .. |
    DW           0x0015               ; DW | 0x0015 | .. |
    DW           0x0016               ; DW | 0x0016 | .. |
    DW           0x0017               ; DW | 0x0017 | .. |
    DW           0x0018               ; DW | 0x0018 | .. |
    DW           0x0019               ; DW | 0x0019 | .. |
    DW           0x001a               ; DW | 0x001a | .. |
    DW           0x001b               ; DW | 0x001b | .. |
    DW           0x001c               ; DW | 0x001c | .. |
    DW           0x001d               ; DW | 0x001d | .. |
    DW           0x001e               ; DW | 0x001e | .. |
    DW           0x0020               ; DW | 0x0020 | .  |
    DW           0x0021               ; DW | 0x0021 | .! |
    DW           0x0022               ; DW | 0x0022 | ." |
    DW           0x0023               ; DW | 0x0023 | .# |
    DW           0x0024               ; DW | 0x0024 | .$ |
    DW           0x0025               ; DW | 0x0025 | .% |
    DW           0x0026               ; DW | 0x0026 | .& |
    DW           0x0027               ; DW | 0x0027 | .' |
    DW           0x0028               ; DW | 0x0028 | .( |
    DW           0x0029               ; DW | 0x0029 | .) |
    DW           0x002a               ; DW | 0x002a | .* |
    DW           0x002b               ; DW | 0x002b | .+ |
    DW           0x002c               ; DW | 0x002c | ., |

func_09ae:                            ;
    B0BTS1       0x14.4               ;
    RET                               ;
    MOV          A,     0x47          ;
    B0ADD        PCL,   A             ;
    JMP          func_09ae_0008       ;
    JMP          func_09ae_000f       ;
    JMP          func_09ae_0014       ;
    JMP          func_09ae_002a       ;

func_09ae_0008:                       ;
    MOV          A,     #0xfc         ;
    CALL         func_06aa            ;
    MOV          A,     #0x4b         ;
    B0MOV        0x34,  A             ;
    INCMS        0x47                 ;
    NOP                               ;
    JMP          func_09ae_002e       ;

func_09ae_000f:                       ;
    DECMS        0x34                 ;
    JMP          func_09ae_002e       ;
    INCMS        0x47                 ;
    NOP                               ;
    JMP          func_09ae_002e       ;

func_09ae_0014:                       ;
    CALL         func_06ba            ;
    MOV          A,     0x2c          ;
    B0BTS1       FZ                   ;
    JMP          func_09ae_0023       ;
    MOV          A,     0x32          ;
    B0BTS1       FZ                   ;
    JMP          func_09ae_0023       ;
    MOV          A,     0x33          ;
    B0BTS1       FZ                   ;
    JMP          func_09ae_0023       ;
    BCLR         0x12.4               ;
    BCLR         0x13.2               ;
    INCMS        0x47                 ;
    NOP                               ;
    JMP          func_09ae_002e       ;

func_09ae_0023:                       ;
    DECMS        0x35                 ;
    JMP          func_09ae_0028       ;
    B0BSET       0x12.4               ;
    B0BCLR       0x13.2               ;
    B0BCLR       0x14.4               ;
func_09ae_0028:                       ;
    CLR          0x47                 ;
    JMP          func_09ae_002e       ;

func_09ae_002a:                       ;
    MOV          A,     #0xc4         ;
    CALL         func_06aa            ;
    BCLR         0x14.4               ;
    CLR          0x47                 ;
func_09ae_002e:                       ;
    RET                               ;
_interrupt_09d5:                      ;
    B0BCLR       FSTPHX               ;
    B0MOV        Z,     #0x07         ;
_interrupt_09d7:                      ;
    DECMS        Z                    ;
    JMP          _interrupt_09d7      ;
    B0BCLR       FCLKMD               ;
    MOV          A,     #0x80         ;
    B0MOV        UDA,   A             ;
    CLR          UDP0                 ;
    CLR          UDR0_R               ;
    CLR          UDR0_W               ;
    B0BCLR       0x59.1               ;
    B0BCLR       0x59.2               ;
    B0BCLR       0x59.4               ;
    CLR          0x61                 ;
    CLR          USTATUS              ;
    CLR          EP0OUT_CNT           ;
    B0BCLR       0x64.0               ;
    B0BCLR       0x64.1               ;
    B0BCLR       0x64.3               ;
    CLR          0x65                 ;
    CLR          0x66                 ;
    MOV          A,     #0x01         ;
    B0MOV        0x74,  A             ;
    B0MOV        0x75,  A             ;
    MOV          A,     #0xe0         ;
    AND          A,     0x77          ;
    CLR          UE0R                 ;
    CLR          UE1R                 ;
    CLR          UE2R                 ;
    B0BSET       P5.3                 ;
    MOV          A,     #0xfc         ;
    AND          0x00,  A             ;
    CLR          0x47                 ;
    B0BSET       0x14.4               ;
    MOV          A,     #0x05         ;
    B0MOV        0x35,  A             ;
    JMP          _interrupt_003e      ;

func_0a02:                            ;
    B0BTS1       0x64.2               ;
    JMP          func_0a02_0008       ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    B0BTS0       FSUSPEND             ;
    JMP          func_0a02_1d1e       ;
func_0a02_0008:                       ;
    B0BTS0       0x64.3               ;
    JMP          func_0a02_001b       ;
    B0BTS0       0x59.6               ;
    JMP          func_0a02_000e       ;
    CLR          0x5a                 ;
    JMP          func_0a02_001b       ;

func_0a02_000e:                       ;
    INCMS        0x5a                 ;
    NOP                               ;
    MOV          A,     0x5a          ;
    CMPRS        A,     #0x05         ;
    JMP          func_0a02_001b       ;
    CLR          0x5a                 ;
    B0BCLR       0x59.6               ;
    B0BSET       0x64.7               ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    RET                               ;

func_0a02_001b:                       ;
    B0BCLR       0x64.3               ;
    B0BSET       0x59.6               ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    B0BTS1       FSUSPEND             ;
    RET                               ;
    B0BCLR       0x59.4               ;
    B0BTS0       0x64.7               ;
    JMP          func_0a02_1d1e       ;
    MOV          A,     #0xff         ;
    B0MOV        P1UR,  A             ;
    MOV          A,     #0x32         ;
    CALL         func_0140            ;
    B0BCLR       0x59.4               ;
    B0BSET       P5.3                 ;
    B0BSET       P2M.2                ;
    B0BSET       P2M.0                ;
    B0BSET       P4M.0                ;
    B0BSET       P4M.5                ;
    B0BSET       P4M.1                ;
    B0BSET       P2M.1                ;
    B0BSET       P4M.4                ;
    B0BSET       P4M.2                ;
    B0BSET       P4M.3                ;
    B0BSET       P2M.3                ;
    B0BSET       P0M.5                ;
    B0BSET       P0M.4                ;
    B0BSET       P4M.6                ;
    B0BSET       P4M.7                ;
    B0BSET       P0M.3                ;
    B0BSET       P0M.6                ;
    B0BCLR       P2.2                 ;
    B0BCLR       P2.0                 ;
    B0BCLR       P4.0                 ;
    B0BCLR       P4.5                 ;
    B0BCLR       P4.1                 ;
    B0BCLR       P2.1                 ;
    B0BCLR       P4.4                 ;
    B0BCLR       P4.2                 ;
    B0BCLR       P4.3                 ;
    B0BCLR       P2.3                 ;
    B0BCLR       P0.5                 ;
    B0BCLR       P0.4                 ;
    B0BCLR       P4.6                 ;
    B0BCLR       P4.7                 ;
    B0BCLR       P0.3                 ;
    B0BCLR       P0.6                 ;
    B0BSET       FCLKMD               ;
    NOP                               ;
    NOP                               ;
    B0BSET       FSTPHX               ;
func_0a02_0050:                       ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    B0BTS1       FSUSPEND             ;
    JMP          func_0a02_005f       ;
    B0BTS1       0x59.3               ;
    JMP          func_0a02_0050       ;
    B0MOV        A,     P1            ;
    CMPRS        A,     #0xff         ;
    JMP          func_0a02_005a       ;
    JMP          func_0a02_005c       ;

func_0a02_005a:                       ;
    B0BSET       0x00.6               ;
    JMP          func_0a02_0066       ;

func_0a02_005c:                       ;
    B0BTS1       P2.6                 ;
    JMP          func_0a02_0066       ;
    JMP          func_0a02_0050       ;

func_0a02_005f:                       ;
    B0BCLR       FSTPHX               ;
    MOV          A,     #0x07         ;
    B0MOV        Z,     A             ;
func_0a02_0062:                       ;
    DECMS        Z                    ;
    JMP          func_0a02_0062       ;
    B0BCLR       FCLKMD               ;
    RET                               ;

func_0a02_0066:                       ;
    B0BCLR       FSTPHX               ;
    MOV          A,     #0x07         ;
    B0MOV        Z,     A             ;
func_0a02_0069:                       ;
    DECMS        Z                    ;
    JMP          func_0a02_0069       ;
    B0BCLR       FCLKMD               ;
    B0BCLR       0x59.6               ;
    CLR          0x5a                 ;
    B0BCLR       FGIE                 ;
    MOV          A,     #0xc6         ;
    B0MOV        UPID,  A             ;
    CALL         func_0a90            ;
    MOV          A,     #0xc5         ;
    B0MOV        UPID,  A             ;
    CALL         func_0a99            ;
    MOV          A,     #0xc2         ;
    B0MOV        UPID,  A             ;
    B0BCLR       FP00IRQ              ;
    B0BCLR       FUSBIRQ              ;
    B0BSET       FGIE                 ;
    B0BTS0       0x61.0               ;
    RET                               ;
    MOV          A,     #0x64         ;
    CALL         func_0146            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    CALL         func_2700            ;
    B0BTS0       FSUSPEND             ;
    JMP          func_0a02_1d1e       ;
    B0BCLR       0x59.4               ;
    RET                               ;

func_0a90:                            ;
    MOV          A,     #0xff         ;
    B0MOV        Z,     A             ;
    MOV          A,     #0x01         ;
    B0MOV        R,     A             ;
func_0a90_0004:                       ;
    DECMS        Z                    ;
    JMP          func_0a90_0004       ;
    DECMS        R                    ;
    JMP          func_0a90_0004       ;
    RET                               ;

func_0a99:                            ;
    MOV          A,     #0xff         ;
    B0MOV        Z,     A             ;
    MOV          A,     #0x1e         ;
    B0MOV        R,     A             ;
func_0a99_0004:                       ;
    NOP                               ;
    DECMS        Z                    ;
    JMP          func_0a99_0004       ;
    DECMS        R                    ;
    JMP          func_0a99_0004       ;
    RET                               ;
_interrupt_0a9b:                      ;
    B0BCLR       FEP1_ACK             ;
    B0BTS1       0x64.2               ;
    JMP          _interrupt_0aa5      ;
    B0BTS1       0x64.1               ;
    JMP          _interrupt_0aa5      ;
    B0BTS0       0x64.0               ;
    JMP          _interrupt_0aa5      ;
    B0BSET       0x64.0               ;
    CLR          0x65                 ;
    CLR          0x66                 ;
_interrupt_0aa5:                      ;
    JMP          _interrupt_003e      ;
_interrupt_0aa6:                      ;
    B0BCLR       FEP2_ACK             ;
    JMP          _interrupt_003e      ;
_interrupt_0aa8:                      ;
    B0BCLR       FEP0SETUP            ;
    B0BCLR       FUE0M0               ;
    B0BCLR       0x59.6               ;
    CLR          0x5a                 ;
    MOV          A,     #0x00         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    B0MOV        0x4e,  A             ;
    MOV          A,     #0x01         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    B0MOV        0x4f,  A             ;
    MOV          A,     #0x02         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    B0MOV        0x51,  A             ;
    MOV          A,     #0x03         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    B0MOV        0x50,  A             ;
    MOV          A,     #0x04         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    B0MOV        0x53,  A             ;
    MOV          A,     #0x05         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    B0MOV        0x52,  A             ;
    MOV          A,     #0x06         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    B0MOV        0x55,  A             ;
    MOV          A,     #0x07         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    B0MOV        0x54,  A             ;
    JMP          _interrupt_0c26      ;
_interrupt_0acd:                      ;
    B0BCLR       FEP0IN               ;
    B0BTS1       0x59.2               ;
    JMP          _interrupt_0ad4      ;
    B0BCLR       0x59.2               ;
    B0MOV        A,     0x63          ;
    OR           A,     #0x80         ;
    B0MOV        UDA,   A             ;
_interrupt_0ad4:                      ;
    B0BTS0       0x77.2               ;
    JMP          _interrupt_0adf      ;
    B0MOV        A,     0x54          ;
    OR           A,     0x55          ;
    B0BTS0       FZ                   ;
    JMP          _interrupt_003e      ;
    B0BTS0       0x4e.7               ;
    JMP          _interrupt_0add      ;
    JMP          _interrupt_003e      ;
_interrupt_0add:                      ;
    CALL         func_0bd6            ;
    JMP          _interrupt_0b0a      ;
_interrupt_0adf:                      ;
    B0BCLR       0x77.2               ;
    B0BSET       0x77.3               ;
    B0MOV        A,     0x78          ;
    CMPRS        A,     #0xaa         ;
    JMP          _interrupt_0b0a      ;
    B0MOV        A,     0x79          ;
    CMPRS        A,     #0x55         ;
    JMP          _interrupt_0b0a      ;
    B0MOV        A,     0x7a          ;
    CMPRS        A,     #0xa5         ;
    JMP          _interrupt_0b0a      ;
    B0MOV        A,     0x7b          ;
    CMPRS        A,     #0x5a         ;
    JMP          _interrupt_0b0a      ;
    B0MOV        A,     0x7c          ;
    CMPRS        A,     #0xff         ;
    JMP          _interrupt_0b0a      ;
    B0MOV        A,     0x7d          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0b0a      ;
    B0MOV        A,     0x7e          ;
    CMPRS        A,     #0x33         ;
    JMP          _interrupt_0b0a      ;
    B0MOV        A,     0x7f          ;
    CMPRS        A,     #0xcc         ;
    JMP          _interrupt_0b0a      ;
    CLR          USTATUS              ;
    B0MOV        A,     STKP          ;
    AND          A,     #0x07         ;
    ADD          A,     #0x01         ;
    B0MOV        Z,     A             ;
    B0ADD        Z,     A             ;
    MOV          A,     #0xf0         ;
    ADD          A,     Z             ;
    B0MOV        Z,     A             ;
    B0MOV        Y,     #0x00         ;
    MOV          A,     #0x90         ;
    B0MOV        @YZ,   A             ;
    INCMS        Z                    ;
    NOP                               ;
    MOV          A,     #0x28         ;
    B0MOV        @YZ,   A             ;
    RET                               ;
_interrupt_0b0a:                      ;
    JMP          _interrupt_003e      ;
_interrupt_0b0b:                      ;
    B0BCLR       FEP0OUT              ;
    B0BTS0       0x77.1               ;
    JMP          _interrupt_0b20      ;
    B0BTS1       0x77.0               ;
    JMP          _interrupt_0bb0      ;
    B0BCLR       0x77.0               ;
    B0BTS1       0x64.2               ;
    JMP          _interrupt_0b1a      ;
    B0BTS1       0x64.1               ;
    JMP          _interrupt_0b1a      ;
    B0BTS0       0x64.0               ;
    JMP          _interrupt_0b1a      ;
    B0BSET       0x64.0               ;
    CLR          0x65                 ;
    CLR          0x66                 ;
_interrupt_0b1a:                      ;
    MOV          A,     #0x00         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    MOV          0x76,  A             ;
    B0BCLR       P5.3                 ;
    JMP          _interrupt_0bb0      ;
_interrupt_0b20:                      ;
    MOV          A,     #0x00         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    MOV          0x78,  A             ;
    MOV          A,     0x78          ;
    CMPRS        A,     #0x13         ;
    JMP          _interrupt_0b28      ;
    JMP          _interrupt_0b47      ;
_interrupt_0b28:                      ;
    MOV          A,     #0x01         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    MOV          0x79,  A             ;
    MOV          A,     #0x02         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    MOV          0x7a,  A             ;
    MOV          A,     #0x03         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    MOV          0x7b,  A             ;
    MOV          A,     #0x04         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    MOV          0x7c,  A             ;
    MOV          A,     #0x05         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    MOV          0x7d,  A             ;
    MOV          A,     #0x06         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    MOV          0x7e,  A             ;
    MOV          A,     #0x07         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    MOV          0x7f,  A             ;
    B0BCLR       0x77.1               ;
    B0BSET       0x77.2               ;
    JMP          _interrupt_0bb0      ;
_interrupt_0b47:                      ;
    B0BCLR       0x77.1               ;
    MOV          A,     #0x01         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    MOV          0x79,  A             ;
    MOV          A,     #0x02         ;
    CALL         func_0c22            ;
    CALL         func_0c26            ;
    MOV          0x7a,  A             ;
    MOV          A,     0x79          ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0b6e      ;
    MOV          A,     0x7a          ;
    CMPRS        A,     #0x03         ;
    JMP          _interrupt_0b5b      ;
    B0BSET       0x12.0               ;
    B0BCLR       0x14.7               ;
    B0BSET       0x12.2               ;
    B0BCLR       0x12.3               ;
    JMP          _interrupt_0bb0      ;
_interrupt_0b5b:                      ;
    CMPRS        A,     #0x05         ;
    JMP          _interrupt_0b62      ;
    B0BCLR       0x12.0               ;
    B0BSET       0x14.7               ;
    B0BSET       0x12.2               ;
    B0BCLR       0x12.3               ;
    JMP          _interrupt_0bb0      ;
_interrupt_0b62:                      ;
    CMPRS        A,     #0x08         ;
    JMP          _interrupt_0b69      ;
    B0BCLR       0x12.0               ;
    B0BCLR       0x14.7               ;
    B0BCLR       0x12.2               ;
    B0BSET       0x12.3               ;
    JMP          _interrupt_0bb0      ;
_interrupt_0b69:                      ;
    B0BCLR       0x12.0               ;
    B0BCLR       0x14.7               ;
    B0BSET       0x12.2               ;
    B0BCLR       0x12.3               ;
    JMP          _interrupt_0bb0      ;
_interrupt_0b6e:                      ;
    CMPRS        A,     #0x02         ;
    JMP          _interrupt_0b74      ;
    MOV          A,     0x7a          ;
    MOV          0x01,  A             ;
    BSET         0x12.7               ;
    JMP          _interrupt_0bb0      ;
_interrupt_0b74:                      ;
    CMPRS        A,     #0x03         ;
    JMP          _interrupt_0b7a      ;
    BSET         0x11.0               ;
    BCLR         0x11.1               ;
    BCLR         0x11.2               ;
    JMP          _interrupt_0bb0      ;
_interrupt_0b7a:                      ;
    CMPRS        A,     #0x04         ;
    JMP          _interrupt_0b80      ;
    BCLR         0x11.0               ;
    BSET         0x11.1               ;
    BCLR         0x11.2               ;
    JMP          _interrupt_0bb0      ;
_interrupt_0b80:                      ;
    CMPRS        A,     #0x05         ;
    JMP          _interrupt_0b8c      ;
    BSET         0x12.7               ;
    MOV          A,     0x7a          ;
    B0BTS1       FZ                   ;
    JMP          _interrupt_0b88      ;
    B0BSET       0x00.1               ; Set FnLock signal ON?
    JMP          _interrupt_0bb0      ;
_interrupt_0b88:                      ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0bb0      ;
    B0BCLR       0x00.1               ; Clear FnLock signal?
    JMP          _interrupt_0bb0      ;
_interrupt_0b8c:                      ;
    CMPRS        A,     #0x06         ;
    JMP          _interrupt_0b91      ;
    BCLR         0x11.0               ;
    BCLR         0x11.1               ;
    BSET         0x11.2               ;
_interrupt_0b91:                      ;
    CMPRS        A,     #0x07         ;
    JMP          _interrupt_0b9f      ;
    MOV          A,     0x7a          ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0bb0      ;
    BSET         0x13.7               ;
    MOV          A,     #0xc6         ;
    BTS0         0x12.1               ;
    MOV          A,     #0x00         ;
    MOV          0x2a,  A             ;
    CLR          0x2b                 ;
    MOV          A,     #0x02         ;
    XOR          0x12,  A             ;
    JMP          _interrupt_0bb0      ;
_interrupt_0b9f:                      ;
    CMPRS        A,     #0x08         ;
    JMP          _interrupt_0ba9      ;
    MOV          A,     0x7a          ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0bb0      ;
    B0BSET       0x13.6               ;
    CLR          0x28                 ;
    MOV          A,     #0x08         ;
    B0MOV        0x29,  A             ;
    JMP          _interrupt_0bb0      ;
_interrupt_0ba9:                      ;
    CMPRS        A,     #0x09         ;
    JMP          _interrupt_0bb0      ;
    B0BCLR       0x14.5               ; Auto-scroll flag
    MOV          A,     0x7a          ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0bb0      ;
    B0BSET 0x14.5 ;; Auto-scroll flag (Originally B0BSET)
_interrupt_0bb0:                      ;
    B0BSET       FUE0M0               ;
    JMP          _interrupt_003e      ;

func_0bba:                            ;
    MOV          A,     0x69          ;
    SUB          A,     #0x01         ;
    MOV          0x69,  A             ;
    B0BTS0       FC                   ;
    JMP          func_0bba_0008       ;
    MOV          A,     0x6a          ;
    SUB          A,     #0x01         ;
    MOV          0x6a,  A             ;
func_0bba_0008:                       ;
    B0BTS1       FC                   ;
    CLR          0x6a                 ;
    RET                               ;

func_0bc5:                            ;
    MOV          A,     0x54          ;
    SUB          A,     0x6a          ;
    B0BTS0       FC                   ;
    JMP          func_0bc5_0005       ;
    JMP          func_0bc5_000c       ;

func_0bc5_0005:                       ;
    MOV          A,     0x54          ;
    CMPRS        A,     0x6a          ;
    JMP          func_0bc5_0010       ;
    MOV          A,     0x55          ;
    SUB          A,     0x69          ;
    B0BTS0       FC                   ;
    JMP          func_0bc5_0010       ;
func_0bc5_000c:                       ;
    MOV          A,     0x54          ;
    MOV          0x6a,  A             ;
    MOV          A,     0x55          ;
    MOV          0x69,  A             ;
func_0bc5_0010:                       ;
    RET                               ;

func_0bd6:                            ;
    MOV          A,     0x68          ;
    MOV          Y,     A             ;
    MOV          A,     0x67          ;
    MOV          Z,     A             ;
    CALL         func_0bc5            ;
    MOV          A,     #0x08         ;
    MOV          0x62,  A             ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    MOV          A,     0x6a          ;
    CMPRS        A,     #0x00         ;
    JMP          func_0bd6_002f       ;
    MOV          A,     0x69          ;
    B0BTS1       FZ                   ;
    JMP          func_0bd6_0012       ;
    MOV          A,     #0xf0         ;
    AND          UE0R,  A             ;
    JMP          func_0bd6_004a       ;

func_0bd6_0012:                       ;
    MOV          A,     0x69          ;
    SUB          A,     #0x08         ;
    B0BTS0       FC                   ;
    JMP          func_0bd6_002f       ;
    MOV          A,     #0xf0         ;
    AND          UE0R,  A             ;
    MOV          A,     0x69          ;
    OR           UE0R,  A             ;
func_0bd6_001a:                       ;
    MOVC                              ; memoOVC, Y = ?, Z = v-c z + 01
    CALL         func_0c2c            ; write UDR0 ? at UDP0 ?
    MOV          A,     #0x01         ;
    CALL         func_0c2a            ; UDP0 += 1
    B0BTS1       0x59.5               ;
    JMP          func_0bd6_0027       ;
    MOV          A,     R             ;
    CALL         func_0c2c            ; write UDR0 ? at UDP0 ?
    MOV          A,     #0x01         ;
    CALL         func_0c2a            ; UDP0 += 1
    DECMS        0x69                 ;
    JMP          func_0bd6_0027       ;
    JMP          func_0bd6_004a       ;

func_0bd6_0027:                       ;
    MOV          A,     #0x01         ;
    ADD          Z,     A             ;
    B0BTS0       FC                   ;
    ADD          Y,     A             ;
    B0BCLR       FC                   ;
    DECMS        0x69                 ;
    JMP          func_0bd6_001a       ;
    JMP          func_0bd6_004a       ;

func_0bd6_002f:                       ;
    MOVC                              ; memoOVC, Y = ?, Z = ? (may be v-c)
    CALL         func_0c2c            ; write UDR0 ? at UDP0 ?
    MOV          A,     #0x01         ;
    CALL         func_0c2a            ; UDP0 += 1
    B0BTS1       0x59.5               ;
    JMP          func_0bd6_003b       ;
    MOV          A,     R             ;
    CALL         func_0c2c            ; write UDR0 ? at UDP0 ?
    MOV          A,     #0x01         ;
    CALL         func_0c2a            ;
    CALL         func_0bba            ;
    DECMS        0x62                 ;
func_0bd6_003b:                       ;
    MOV          A,     #0x01         ;
    ADD          Z,     A             ;
    B0BTS0       FC                   ;
    ADD          Y,     A             ;
    B0BCLR       FC                   ;
    INCMS        0x67                 ;
    JMP          func_0bd6_0043       ;
    INCMS        0x68                 ;
func_0bd6_0043:                       ;
    CALL         func_0bba            ;
    DECMS        0x62                 ;
    JMP          func_0bd6_002f       ;
    MOV          A,     #0xf0         ;
    AND          UE0R,  A             ;
    MOV          A,     #0x08         ;
    OR           UE0R,  A             ;
func_0bd6_004a:                       ;
    B0BSET       FUE0M0               ;
    RET                               ;

func_0c22:                            ;
    B0MOV        UDP0,  A             ; set UDP0 = A
    RET                               ;
    DW           0x13a3               ; DW | 0x13a3 | .. |
    DW           0x0e00               ; DW | 0x0e00 | .. |

func_0c26:                            ;
    B0MOV        A,     UDR0_R        ;
    RET                               ;

func_0c28:                            ;
    B0MOV        UDP0,  A             ;
    RET                               ;

func_0c2a:                            ;
    ADD          UDP0,  A             ;
    RET                               ;

func_0c2c:                            ;
    B0MOV        UDR0_W,A             ; Write UDR0-W
    RET                               ;
_interrupt_0c26:                      ;
    B0MOV        A,     0x4e          ;
    AND          A,     #0x60         ;
    CMPRS        A,     #0x20         ;
    JMP          _interrupt_0c2b      ;
    JMP          _interrupt_0e0f      ;
_interrupt_0c2b:                      ;
    AND          A,     #0x60         ;
    B0BTS1       FZ                   ;
    JMP          _interrupt_0f59      ;
    B0MOV        A,     0x4f          ;
    AND          A,     #0x0f         ;
    ADD          PCL,   A             ;
    JMP          _interrupt_0c42      ;
    JMP          _interrupt_0c80      ;
    JMP          _interrupt_0f59      ;
    JMP          _interrupt_0ce4      ;
    JMP          _interrupt_0f59      ;
    JMP          _interrupt_0d0f      ;
    JMP          _interrupt_0d18      ;
    JMP          _interrupt_0dd1      ;
    JMP          _interrupt_0dd2      ;
    JMP          _interrupt_0dd9      ;
    JMP          _interrupt_0df1      ;
    JMP          _interrupt_0dff      ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    JMP          _interrupt_0f59      ;
_interrupt_0c41:                      ;
    JMP          _interrupt_003e      ;
_interrupt_0c42:                      ;
    B0MOV        A,     0x4e          ;
    AND          A,     #0x1f         ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0c47      ;
    JMP          _interrupt_0c4e      ;
_interrupt_0c47:                      ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0c4a      ;
    JMP          _interrupt_0c59      ;
_interrupt_0c4a:                      ;
    CMPRS        A,     #0x02         ;
    JMP          _interrupt_0c4d      ;
    JMP          _interrupt_0c66      ;
_interrupt_0c4d:                      ;
    JMP          _interrupt_0f59      ;
_interrupt_0c4e:                      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    MOV          A,     #0x02         ;
    B0BTS1       0x59.3               ;
    AND          A,     #0xfd         ;
    CALL         func_0c2c            ; write_UDR0 ? at UDP0 0
    MOV          A,     #0x01         ;
    CALL         func_0c2a            ;
    MOV          A,     #0x00         ;
    CALL         func_0c2c            ; write_UDR0 0 at UDP0 1
    JMP          _interrupt_0c7d      ;
_interrupt_0c59:                      ;
    B0BTS1       0x59.1               ;
    JMP          _interrupt_0f59      ;
    MOV          A,     #0x00         ;
    CMPRS        A,     0x53          ;
    JMP          _interrupt_0f59      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ; set UDP = 0
    CALL         func_0c2c            ; write UDR0 0 at UDP 0
    MOV          A,     #0x01         ;
    CALL         func_0c2a            ; UDP += 1
    MOV          A,     #0x00         ;
    CALL         func_0c2c            ; write UDR0 0 at UDP 1
    JMP          _interrupt_0c7d      ;
_interrupt_0c66:                      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    B0MOV        A,     0x53          ;
    AND          A,     #0x03         ;
    ADD          PCL,   A             ;
    JMP          _interrupt_0c6f      ;
    JMP          _interrupt_0c71      ;
    JMP          _interrupt_0c75      ;
    JMP          _interrupt_0f59      ;
_interrupt_0c6f:                      ;
    B0MOV        A,     0x56          ;
    JMP          _interrupt_0c78      ;
_interrupt_0c71:                      ;
    B0BTS1       0x59.1               ;
    JMP          _interrupt_0f59      ;
    B0MOV        A,     0x57          ;
    JMP          _interrupt_0c78      ;
_interrupt_0c75:                      ;
    B0BTS1       0x59.1               ;
    JMP          _interrupt_0f59      ;
    B0MOV        A,     0x58          ;
_interrupt_0c78:                      ;
    CALL         func_0c2c            ; write_UDR0 A at UDP 0
    MOV          A,     #0x01         ;
    CALL         func_0c2a            ; UDP += 1
    MOV          A,     #0x00         ;
    CALL         func_0c2c            ; write_UDR0 0 at UDP 0
_interrupt_0c7d:                      ;
    MOV          A,     #0x22         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0c80:                      ;
    B0MOV        A,     0x4e          ;
    AND          A,     #0x1f         ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0c85      ;
    JMP          _interrupt_0c89      ;
_interrupt_0c85:                      ;
    CMPRS        A,     #0x02         ;
    JMP          _interrupt_0c88      ;
    JMP          _interrupt_0c94      ;
_interrupt_0c88:                      ;
    JMP          _interrupt_0f59      ;
_interrupt_0c89:                      ;
    B0BTS1       0x59.1               ;
    JMP          _interrupt_0f59      ;
    B0MOV        A,     0x51          ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0f59      ;
    B0BSET       0x64.3               ;
    B0BCLR       0x59.3               ;
    MOV          A,     #0x00         ;
    CALL         func_0c22            ; set UDP0 = 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 0t
    JMP          _interrupt_0ce1      ;
_interrupt_0c94:                      ;
    B0MOV        A,     0x51          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0f59      ;
    B0MOV        A,     0x53          ;
    AND          A,     #0x03         ;
    ADD          PCL,   A             ;
    JMP          _interrupt_0c9e      ;
    JMP          _interrupt_0ca0      ;
    JMP          _interrupt_0cca      ;
    JMP          _interrupt_0f59      ;
_interrupt_0c9e:                      ;
    CLR          0x56                 ;
    JMP          _interrupt_0ce1      ;
_interrupt_0ca0:                      ;
    B0BTS1       0x59.1               ;
    JMP          _interrupt_0f59      ;
    CLR          0x57                 ;
    B0BTS1       0x61.0               ;
    JMP          _interrupt_0ce1      ;
    MOV          A,     #0x08         ;
    CALL         func_0c28            ; set UDP0 #0x08
    MOV          A,     0x15          ; 0x15 POINT
    CALL         func_0c2c            ; write UDR0 0x15 at UDP0 #0x08
    MOV          A,     #0x09         ;
    CALL         func_0c28            ; set UDP0 #0x09
    MOV          A,     #0x00         ;
    CALL         func_0c2c            ; write UDR0 0x15 at UDP0 #0x09
    MOV          A,     #0x0a         ;
    CALL         func_0c28            ;
    MOV          A,     0x17          ;
    CALL         func_0c2c            ; write UDR0 0x17 at UDP0 #0x0a
    MOV          A,     #0x0b         ;
    CALL         func_0c28            ;
    MOV          A,     0x18          ;
    CALL         func_0c2c            ; write UDR0 0x18 at UDP0 #0x0b
    MOV          A,     #0x0c         ;
    CALL         func_0c28            ;
    MOV          A,     0x19          ;
    CALL         func_0c2c            ; write UDR0 0x19 at UDP0 #0x0c
    MOV          A,     #0x0d         ;
    CALL         func_0c28            ;
    MOV          A,     0x1a          ;
    CALL         func_0c2c            ; write UDR0 0x1a at UDP0 #0x0d
    MOV          A,     #0x0e         ;
    CALL         func_0c28            ;
    MOV          A,     0x1b          ;
    CALL         func_0c2c            ; write UDR0 0x1b at UDP0 #0x0e
    MOV          A,     #0x0f         ;
    CALL         func_0c28            ;
    MOV          A,     0x1c          ;
    CALL         func_0c2c            ; write UDR0 0x1c at UDP0 #0x0f
    MOV          A,     #0x08         ;
    B0MOV        UE1R_C,A             ;
    MOV          A,     #0xa0         ;
    B0MOV        UE1R,  A             ;
    JMP          _interrupt_0ce1      ;
_interrupt_0cca:                      ;
    B0BTS1       0x59.1               ;
    JMP          _interrupt_0f59      ;
    CLR          0x58                 ;
    B0BTS1       0x61.0               ;
    JMP          _interrupt_0ce1      ;
    MOV          A,     #0x18         ; 					|
    CALL         func_0c28            ; B0MOV	UDP0, A		| UDP0 = #0x18
    MOV          A,     0x2c          ; 					|
    CALL         func_0c2c            ; B0MOV	UDR0_W, A	| UDR0_W = 0x2c
    MOV          A,     #0x19         ; 					|
    CALL         func_0c28            ; B0MOV	UDP0, A		| UDP0 = #0x19
    MOV          A,     0x2e          ; 2epoints		    |
    CALL         func_0c2c            ; B0MOV	UDR0_W, A	| UDR0_W = 0x2e
    MOV          A,     #0x1a         ; 					|
    CALL         func_0c28            ; B0MOV	UDP0, A		| UDP0 = #0x1a
    MOV          A,     0x2f          ; 2fpoints			| 
    CALL         func_0c2c            ; B0MOV	UDR0_W, A	| UPR0_W = 0x2f
    CLR          0x2e                 ; 2epoints
    CLR          0x2f                 ; 2fpoints
    MOV          A,     #0x03         ; 					|
    B0MOV        UE2R_C,A             ; 					| UE2R_C = #0x03
    MOV          A,     #0xa0         ; 					|
    B0MOV        UE2R,  A             ; 					| UE2R = #0xa0
_interrupt_0ce1:                      ;
    MOV          A,     #0x20         ; 0x20 = 32 (dec)
    MOV          UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0ce4:                      ;
    B0MOV        A,     0x4e          ;
    AND          A,     #0x1f         ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0ce9      ;
    JMP          _interrupt_0ced      ;
_interrupt_0ce9:                      ;
    CMPRS        A,     #0x02         ;
    JMP          _interrupt_0cec      ;
    JMP          _interrupt_0cf6      ;
_interrupt_0cec:                      ;
    JMP          _interrupt_0f59      ;
_interrupt_0ced:                      ;
    B0MOV        A,     0x51          ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0f59      ;
    B0BSET       0x64.3               ;
    B0BSET       0x59.3               ;
    MOV          A,     #0x00         ;
    CALL         func_0c22            ; set UDP0 = #0x00
    CALL         func_0c2c            ; write_UDR0 0 at UDP0 0
    JMP          _interrupt_0d0c      ;
_interrupt_0cf6:                      ;
    B0MOV        A,     0x51          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0f59      ;
    B0MOV        A,     0x53          ;
    AND          A,     #0x03         ;
    ADD          PCL,   A             ;
    JMP          _interrupt_0d00      ;
    JMP          _interrupt_0d03      ;
    JMP          _interrupt_0d08      ;
    JMP          _interrupt_0f59      ;
_interrupt_0d00:                      ;
    MOV          A,     #0x01         ;
    B0MOV        0x56,  A             ;
    JMP          _interrupt_0d0c      ;
_interrupt_0d03:                      ;
    B0BTS1       0x59.1               ;
    JMP          _interrupt_0f59      ;
    MOV          A,     #0x01         ;
    B0MOV        0x57,  A             ;
    JMP          _interrupt_0d0c      ;
_interrupt_0d08:                      ;
    B0BTS1       0x59.1               ;
    JMP          _interrupt_0f59      ;
    MOV          A,     #0x01         ;
    B0MOV        0x58,  A             ;
_interrupt_0d0c:                      ;
    MOV          A,     #0x20         ;
    MOV          UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0d0f:                      ;
    B0BCLR       0x59.1               ;
    B0BSET       0x59.2               ;
    B0MOV        A,     0x51          ;
    CMPRS        A,     #0x00         ;
    B0BSET       0x59.1               ;
    B0MOV        0x63,  A             ;
    MOV          A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0d18:                      ;
    B0BCLR       0x59.6               ;
    B0BTS1       0x64.2               ;
    JMP          _interrupt_0d1e      ;
    B0BTS0       0x64.0               ;
    JMP          _interrupt_0d1e      ;
    B0BSET       0x64.1               ;
_interrupt_0d1e:                      ;
    B0BCLR       0x59.5               ;
    B0MOV        A,     0x50          ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0d2b      ;
    MOV          A,     #0x12         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0x64         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x0f         ;
    B0MOV        0x68,  A             ;
    JMP          _interrupt_0dcf      ;
_interrupt_0d2b:                      ;
    B0BCLR       0x59.5               ;
    CMPRS        A,     #0x02         ;
    JMP          _interrupt_0d37      ;
    MOV          A,     #0x3b         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0x76         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x0f         ;
    B0MOV        0x68,  A             ;
    JMP          _interrupt_0dcf      ;
_interrupt_0d37:                      ;
    B0BSET       0x59.5               ;
    CMPRS        A,     #0x03         ;
    JMP          _interrupt_0d75      ;
    NOP                               ;
    MOV          A,     #0x07         ;
    AND          A,     0x51          ;
    B0ADD        PCL,   A             ;
    JMP          _interrupt_0d47      ;
    JMP          _interrupt_0d50      ;
    JMP          _interrupt_0d59      ;
    JMP          _interrupt_0d62      ;
    JMP          _interrupt_0d6b      ;
    JMP          _interrupt_0d74      ;
    JMP          _interrupt_0f59      ;
    JMP          _interrupt_0f59      ;
    JMP          _interrupt_0f59      ;
_interrupt_0d47:                      ;
    MOV          A,     #0x04         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0x44         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x10         ;
    B0MOV        0x68,  A             ;
    JMP          _interrupt_0dcf      ;
_interrupt_0d50:                      ;
    MOV          A,     #0x0e         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0x46         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x10         ;
    B0MOV        0x68,  A             ;
    JMP          _interrupt_0dcf      ;
_interrupt_0d59:                      ;
    MOV          A,     #0x5c         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0x4d         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x10         ;
    B0MOV        0x68,  A             ;
    JMP          _interrupt_0dcf      ;
_interrupt_0d62:                      ;
    MOV          A,     #0x12         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0x7b         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x10         ;
    B0MOV        0x68,  A             ;
    JMP          _interrupt_0dcf      ;
_interrupt_0d6b:                      ;
    MOV          A,     #0x28         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0x84         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x10         ;
    B0MOV        0x68,  A             ;
    JMP          _interrupt_0dcf      ;
_interrupt_0d74:                      ;
    JMP          _interrupt_0dd0      ;
_interrupt_0d75:                      ;
    B0BCLR       0x59.5               ;
    CMPRS        A,     #0x04         ;
    JMP          _interrupt_0d82      ;
    NOP                               ;
    MOV          A,     #0x09         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0x7f         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x0f         ;
    B0MOV        0x68,  A             ;
    JMP          _interrupt_0dcf      ;
_interrupt_0d82:                      ;
    B0BCLR       0x59.5               ;
    CMPRS        A,     #0x05         ;
    JMP          _interrupt_0d9e      ;
    MOV          A,     #0x03         ;
    AND          A,     0x51          ;
    B0ADD        PCL,   A             ;
    JMP          _interrupt_0f59      ;
    JMP          _interrupt_0d8c      ;
    JMP          _interrupt_0d95      ;
    JMP          _interrupt_0f59      ;
_interrupt_0d8c:                      ;
    MOV          A,     #0x07         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0x91         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x0f         ;
    B0MOV        0x68,  A             ;
    JMP          _interrupt_0dcf      ;
_interrupt_0d95:                      ;
    MOV          A,     #0x07         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0xaa         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x0f         ;
    B0MOV        0x68,  A             ;
    JMP          _interrupt_0dcf      ;
_interrupt_0d9e:                      ;
    B0BCLR       0x59.5               ;
    CMPRS        A,     #0x21         ;
    JMP          _interrupt_0db6      ;
    B0MOV        A,     0x53          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0dad      ;
    MOV          A,     #0x09         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0x88         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x0f         ;
    B0MOV        0x68,  A             ;
    JMP          _interrupt_0dcf      ;
_interrupt_0dad:                      ;
    MOV          A,     #0x09         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0xa1         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x0f         ;
    B0MOV        0x68,  A             ;
    JMP          _interrupt_0dcf      ;
_interrupt_0db6:                      ;
    B0BSET       0x59.5               ;
    CMPRS        A,     #0x22         ;
    JMP          _interrupt_0f59      ;
    B0BSET       0x77.4               ;
    B0MOV        A,     0x53          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0dc7      ;
    B0BSET       0x77.7               ;
    MOV          A,     #0x51         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0xb1         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x0f         ;
    B0MOV        0x68,  A             ;
    JMP          _interrupt_0dcf      ;
_interrupt_0dc7:                      ;
    MOV          A,     #0xd3         ;
    B0MOV        0x69,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x6a,  A             ;
    MOV          A,     #0xda         ;
    B0MOV        0x67,  A             ;
    MOV          A,     #0x0f         ;
    B0MOV        0x68,  A             ;
_interrupt_0dcf:                      ;
    CALL         func_0bd6            ;
_interrupt_0dd0:                      ;
    JMP          _interrupt_0c41      ;
_interrupt_0dd1:                      ;
    JMP          _interrupt_0f59      ;
_interrupt_0dd2:                      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ; set UDP0 = #0x00
    B0MOV        A,     0x61          ;
    CALL         func_0c2c            ; write UDR0 0x61 at UDP0 0
    MOV          A,     #0x21         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0dd9:                      ;
    B0BTS1       0x59.1               ;
    JMP          _interrupt_0f59      ;
    B0MOV        A,     0x51          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0de5      ;
    B0MOV        0x61,  A             ;
    MOV          A,     #0x01         ;
    B0MOV        0x57,  A             ;
    B0MOV        0x58,  A             ;
    CLR          UE1R                 ;
    CLR          UE2R                 ;
    JMP          _interrupt_0dee      ;
_interrupt_0de5:                      ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0f59      ;
    B0MOV        0x61,  A             ;
    CLR          0x56                 ;
    CLR          0x57                 ;
    CLR          0x58                 ;
    MOV          A,     #0x80         ;
    B0MOV        UE1R,  A             ;
    B0MOV        UE2R,  A             ;
_interrupt_0dee:                      ;
    MOV          A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0df1:                      ;
    B0BTS1       0x59.1               ;
    JMP          _interrupt_0f59      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ; set UDP0 0
    B0MOV        A,     0x53          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0dfa      ;
    MOV          A,     0x6b          ;
    JMP          _interrupt_0dfb      ;
_interrupt_0dfa:                      ;
    MOV          A,     0x6c          ;
_interrupt_0dfb:                      ;
    CALL         func_0c2c            ; write UDR0 0x6b or 0x6c at UDP0 0
    MOV          A,     #0x21         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0dff:                      ;
    B0BTS1       0x59.1               ;
    JMP          _interrupt_0f59      ;
    CLR          0x56                 ;
    CLR          0x57                 ;
    CLR          0x58                 ;
    B0MOV        A,     0x53          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0e0a      ;
    B0MOV        A,     0x51          ;
    B0MOV        0x6b,  A             ;
    JMP          _interrupt_0e0c      ;
_interrupt_0e0a:                      ;
    B0MOV        A,     0x51          ;
    B0MOV        0x6c,  A             ;
_interrupt_0e0c:                      ;
    MOV          A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0e0f:                      ;
    B0MOV        A,     0x4f          ;
    AND          A,     #0x0f         ;
    ADD          PCL,   A             ;
    JMP          _interrupt_0f59      ;
    JMP          _interrupt_0e22      ;
    JMP          _interrupt_0e9f      ;
    JMP          _interrupt_0f23      ;
    JMP          _interrupt_0f59      ;
    JMP          _interrupt_0f59      ;
    JMP          _interrupt_0f59      ;
    JMP          _interrupt_0f59      ;
    JMP          _interrupt_0f59      ;
    JMP          _interrupt_0e88      ;
    JMP          _interrupt_0ee0      ;
    JMP          _interrupt_0f3a      ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    JMP          _interrupt_0f59      ;
_interrupt_0e22:                      ;
    B0MOV        A,     0x4e          ;
    CMPRS        A,     #0xa1         ;
    JMP          _interrupt_0f59      ;
    B0MOV        A,     0x53          ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0e29      ;
    JMP          _interrupt_0e2b      ;
_interrupt_0e29:                      ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0f59      ;
_interrupt_0e2b:                      ;
    B0MOV        A,     0x50          ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0e2f      ;
    JMP          _interrupt_0e33      ;
_interrupt_0e2f:                      ;
    CMPRS        A,     #0x03         ;
    JMP          _interrupt_0e32      ;
    JMP          _interrupt_0e38      ;
_interrupt_0e32:                      ;
    JMP          _interrupt_0f59      ;
_interrupt_0e33:                      ;
    B0MOV        A,     0x55          ;
    AND          A,     #0x0f         ;
    OR           A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0e38:                      ;
    B0MOV        A,     0x54          ;
    AND          A,     #0x0f         ;
    CMPRS        A,     #0x03         ;
    JMP          _interrupt_0e4f      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    MOV          A,     #0x13         ;
    CALL         func_0c2c            ; write UDR0 #0x13 at UDP0 0
    MOV          A,     #0x01         ;
    CALL         func_0c28            ;
    MOV          A,     #0x03         ;
    CALL         func_0c2c            ; write UDR0 #0x03 at UDP0 1
    MOV          A,     #0x02         ;
    CALL         func_0c28            ;
    MOV          A,     0x01          ;
    CALL         func_0c2c            ; write UDR0 0x01 at UDP0 2
    BTS0         0x11.0               ;
    BCLR         0x11.0               ;
    B0MOV        A,     0x55          ;
    AND          A,     #0x0f         ;
    OR           A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0e87      ;
_interrupt_0e4f:                      ;
    B0MOV        A,     0x54          ;
    AND          A,     #0x0f         ;
    CMPRS        A,     #0x04         ;
    JMP          _interrupt_0e6a      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    MOV          A,     #0x13         ;
    CALL         func_0c2c            ; write UDR0 #0x13 at UDP0 0
    MOV          A,     #0x01         ;
    CALL         func_0c28            ;
    MOV          A,     #0x04         ;
    CALL         func_0c2c            ; write UDR0 #0x04 at UDP0 1
    MOV          A,     #0x02         ;
    CALL         func_0c28            ;
    MOV          A,     #0x03         ;
    CALL         func_0c2c            ; write UDR0 #0x03 at UDP0 2
    MOV          A,     #0x03         ;
    CALL         func_0c28            ;
    MOV          A,     #0x30         ;
    CALL         func_0c2c            ; write UDR0 #0x30 at UDP0 3
    BTS0         0x11.1               ;
    BCLR         0x11.1               ;
    B0MOV        A,     0x55          ;
    AND          A,     #0x0f         ;
    OR           A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0e87      ;
_interrupt_0e6a:                      ;
    B0MOV        A,     0x54          ;
    AND          A,     #0x0f         ;
    CMPRS        A,     #0x06         ;
    JMP          _interrupt_0e85      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    MOV          A,     #0x13         ;
    CALL         func_0c2c            ; write UDR0 #0x13 at UDP0 0
    MOV          A,     #0x01         ;
    CALL         func_0c28            ;
    MOV          A,     #0x06         ;
    CALL         func_0c2c            ; write UDR0 #0x06 at UDP0 1
    MOV          A,     #0x00         ;
    B0BTS0       0x00.1               ; Check FnLock signal
    MOV          A,     #0x01         ;
    MOV          0x43,  A             ;
    MOV          A,     #0x02         ;
    CALL         func_0c28            ;
    MOV          A,     0x43          ;
    CALL         func_0c2c            ; write UDR0 0x43 at UDP0 2
    BTS0         0x11.2               ;
    BCLR         0x11.2               ;
    B0MOV        A,     0x55          ;
    AND          A,     #0x0f         ;
    OR           A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0e87      ;
_interrupt_0e85:                      ;
    MOV          A,     #0x20         ;
    B0MOV        UE0R,  A             ;
_interrupt_0e87:                      ;
    JMP          _interrupt_0c41      ;
_interrupt_0e88:                      ;
    B0MOV        A,     0x4e          ;
    CMPRS        A,     #0x21         ;
    JMP          _interrupt_0f59      ;
    B0MOV        A,     0x53          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0e95      ;
    B0MOV        A,     0x50          ;
    CMPRS        A,     #0x02         ;
    JMP          _interrupt_0e92      ;
    JMP          _interrupt_0e99      ;
_interrupt_0e92:                      ;
    CMPRS        A,     #0x03         ;
    JMP          _interrupt_0f59      ;
    JMP          _interrupt_0e9b      ;
_interrupt_0e95:                      ;
    B0MOV        A,     0x50          ;
    CMPRS        A,     #0x03         ;
    JMP          _interrupt_0f59      ;
    JMP          _interrupt_0e9b      ;
_interrupt_0e99:                      ;
    B0BSET       0x77.0               ;
    JMP          _interrupt_0e9c      ;
_interrupt_0e9b:                      ;
    B0BSET       0x77.1               ;
_interrupt_0e9c:                      ;
    MOV          A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0e9f:                      ;
    B0MOV        A,     0x4e          ;
    CMPRS        A,     #0xa1         ;
    JMP          _interrupt_0f59      ;
    B0BSET       0x77.5               ;
    B0MOV        A,     0x53          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0eab      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    MOV          A,     0x6d          ;
    CALL         func_0c2c            ; write UDR0 0x6d at UDP0 0
    JMP          _interrupt_0edd      ;
_interrupt_0eab:                      ;
    MOV          A,     #0x1f         ;
    AND          A,     0x51          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0eb4      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    B0MOV        A,     0x6e          ;
    CALL         func_0c2c            ; write UDR0 0x6e at UDP0  0
    JMP          _interrupt_0edd      ;
_interrupt_0eb4:                      ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0ebb      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    B0MOV        A,     0x6e          ;
    CALL         func_0c2c            ; write UDR0 0x6e at UDP0  0
    JMP          _interrupt_0edd      ;
_interrupt_0ebb:                      ;
    CMPRS        A,     #0x16         ;
    JMP          _interrupt_0ec2      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    B0MOV        A,     0x6f          ;
    CALL         func_0c2c            ; write UDR0 0x6f at UDP0 0
    JMP          _interrupt_0edd      ;
_interrupt_0ec2:                      ;
    CMPRS        A,     #0x10         ;
    JMP          _interrupt_0ec9      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    B0MOV        A,     0x70          ;
    CALL         func_0c2c            ; write UDR0 0x70 at UDP0 0
    JMP          _interrupt_0edd      ;
_interrupt_0ec9:                      ;
    CMPRS        A,     #0x11         ;
    JMP          _interrupt_0ed0      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    B0MOV        A,     0x71          ;
    CALL         func_0c2c            ; write UDR0 0x71 at UDP0 0
    JMP          _interrupt_0edd      ;
_interrupt_0ed0:                      ;
    CMPRS        A,     #0x13         ;
    JMP          _interrupt_0ed7      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    B0MOV        A,     0x72          ;
    CALL         func_0c2c            ; write UDR0 0x72 at UDP0 0
    JMP          _interrupt_0edd      ;
_interrupt_0ed7:                      ;
    CMPRS        A,     #0x15         ;
    JMP          _interrupt_0edd      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    B0MOV        A,     0x73          ;
    CALL         func_0c2c            ; write UDR0 0x73 at UDP0 0
_interrupt_0edd:                      ;
    MOV          A,     #0x21         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0ee0:                      ;
    B0MOV        A,     0x4e          ;
    CMPRS        A,     #0x21         ;
    JMP          _interrupt_0f59      ;
    B0BSET       0x77.5               ;
    B0MOV        A,     0x53          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0eeb      ;
    B0MOV        A,     0x50          ;
    MOV          0x6d,  A             ;
    MOV          0x38,  A             ;
    JMP          _interrupt_0f20      ;
_interrupt_0eeb:                      ;
    MOV          A,     #0x1f         ;
    AND          A,     0x51          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0efd      ;
    B0MOV        A,     0x50          ;
    B0MOV        0x6e,  A             ;
    B0MOV        0x39,  A             ;
    B0MOV        0x6f,  A             ;
    B0MOV        0x3a,  A             ;
    B0MOV        0x70,  A             ;
    B0MOV        0x3b,  A             ;
    B0MOV        0x71,  A             ;
    B0MOV        0x3c,  A             ;
    B0MOV        0x72,  A             ;
    B0MOV        0x3d,  A             ;
    B0MOV        0x73,  A             ;
    B0MOV        0x3e,  A             ;
    JMP          _interrupt_0f20      ;
_interrupt_0efd:                      ;
    CMPRS        A,     #0x01         ;
    JMP          _interrupt_0f03      ;
    B0MOV        A,     0x50          ;
    B0MOV        0x6e,  A             ;
    B0MOV        0x39,  A             ;
    JMP          _interrupt_0f20      ;
_interrupt_0f03:                      ;
    CMPRS        A,     #0x16         ;
    JMP          _interrupt_0f09      ;
    B0MOV        A,     0x50          ;
    B0MOV        0x6f,  A             ;
    B0MOV        0x3a,  A             ;
    JMP          _interrupt_0f20      ;
_interrupt_0f09:                      ;
    CMPRS        A,     #0x10         ;
    JMP          _interrupt_0f0f      ;
    B0MOV        A,     0x50          ;
    B0MOV        0x70,  A             ;
    B0MOV        0x3b,  A             ;
    JMP          _interrupt_0f20      ;
_interrupt_0f0f:                      ;
    CMPRS        A,     #0x11         ;
    JMP          _interrupt_0f15      ;
    B0MOV        A,     0x50          ;
    B0MOV        0x71,  A             ;
    B0MOV        0x3c,  A             ;
    JMP          _interrupt_0f20      ;
_interrupt_0f15:                      ;
    CMPRS        A,     #0x13         ;
    JMP          _interrupt_0f1b      ;
    B0MOV        A,     0x50          ;
    B0MOV        0x72,  A             ;
    B0MOV        0x3d,  A             ;
    JMP          _interrupt_0f20      ;
_interrupt_0f1b:                      ;
    CMPRS        A,     #0x15         ;
    JMP          _interrupt_0f20      ;
    B0MOV        A,     0x50          ;
    B0MOV        0x73,  A             ;
    B0MOV        0x3e,  A             ;
_interrupt_0f20:                      ;
    MOV          A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0f23:                      ;
    B0MOV        A,     0x4e          ;
    CMPRS        A,     #0xa1         ;
    JMP          _interrupt_0f59      ;
    B0BTS0       0x77.6               ;
    JMP          _interrupt_0f2b      ;
    MOV          A,     #0x01         ;
    MOV          0x74,  A             ;
    MOV          0x75,  A             ;
_interrupt_0f2b:                      ;
    B0MOV        A,     0x53          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0f33      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    MOV          A,     0x74          ;
    CALL         func_0c2c            ; write UDR0 0x74 at UDP0 0
    JMP          _interrupt_0f37      ;
_interrupt_0f33:                      ;
    MOV          A,     #0x00         ;
    CALL         func_0c28            ;
    MOV          A,     0x75          ;
    CALL         func_0c2c            ; write UDR0 0x75 at UDP0 0
_interrupt_0f37:                      ;
    MOV          A,     #0x21         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0f3a:                      ;
    B0MOV        A,     0x4e          ;
    CMPRS        A,     #0x21         ;
    JMP          _interrupt_0f59      ;
    B0BSET       0x77.6               ;
    B0BCLR       P5.3                 ;
    B0MOV        A,     0x53          ;
    CMPRS        A,     #0x00         ;
    JMP          _interrupt_0f54      ;
    B0MOV        A,     0x51          ;
    B0BTS1       FZ                   ;
    JMP          _interrupt_0f4e      ;
    B0BCLR       0x77.7               ;
    B0MOV        A,     0x6d          ;
    B0MOV        0x06,  A             ;
    MOV          A,     #0x7f         ;
    B0MOV        0x6d,  A             ;
    B0MOV        0x38,  A             ;
    B0MOV        A,     0x51          ;
    B0MOV        0x74,  A             ;
    JMP          _interrupt_0f56      ;
_interrupt_0f4e:                      ;
    B0MOV        A,     0x51          ;
    B0MOV        0x74,  A             ;
    B0MOV        A,     0x06          ;
    B0MOV        0x6d,  A             ;
    B0BSET       0x77.7               ;
    JMP          _interrupt_0f56      ;
_interrupt_0f54:                      ;
    B0MOV        A,     0x51          ;
    MOV          0x75,  A             ;
_interrupt_0f56:                      ;
    MOV          A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          _interrupt_0c41      ;
_interrupt_0f59:                      ;
    MOV          A,     #0x40         ;
    B0MOV        UE0R,  A             ; _i2c_rxbyte? : UE0R = i2cBitCnt?
    JMP          _interrupt_003e      ;
    DW           0x0012               ; DW | 0x0012 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0008               ; DW | 0x0008 | .. |
    DW           0x00ef               ; DW | 0x00ef | .. |
    DW           0x0017               ; DW | 0x0017 | .. |
    DW           0x0047               ; DW | 0x0047 | .G |
    DW           0x0060               ; DW | 0x0060 | .` |
    DW           0x0030               ; DW | 0x0030 | .0 |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x003b               ; DW | 0x003b | .; |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x00a0               ; DW | 0x00a0 | .. |
    DW           0x0032               ; DW | 0x0032 | .2 |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x0004               ; DW | 0x0004 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x0021               ; DW | 0x0021 | .! |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0022               ; DW | 0x0022 | ." |
    DW           0x0051               ; DW | 0x0051 | .Q |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0007               ; DW | 0x0007 | .. |
    DW           0x0005               ; DW | 0x0005 | .. |
    DW           0x0081               ; DW | 0x0081 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x003f               ; DW | 0x003f | .? |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x000a               ; DW | 0x000a | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x0004               ; DW | 0x0004 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x0021               ; DW | 0x0021 | .! |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0022               ; DW | 0x0022 | ." |
    DW           0x00d3               ; DW | 0x00d3 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0007               ; DW | 0x0007 | .. |
    DW           0x0005               ; DW | 0x0005 | .. |
    DW           0x0082               ; DW | 0x0082 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x003f               ; DW | 0x003f | .? |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x000a               ; DW | 0x000a | .. |
    DW           0x0105               ; DW | 05 01    Global: Usage Page      = Generic Desktop (0x01)
    DW           0x0609               ; DW | 09 06    Local:  Usage           = Generic Desktop: Keyboard
    DW           0x01a1               ; DW | A1 01    Main:   Collection      = Application (0x01)
    DW           0x0705               ; DW | 05 07    Global: Usage Page      = Keyboard / Keypad (0x07)
    DW           0xe019               ; DW | 19 E0    Local:  Usage Minimum   = Keyboard / Keypad: Keyboard 0xE0
    DW           0xe729               ; DW | 29 E7    Local:  Usage Maximum   = Keyboard / Keypad: Keyboard 0xE7
    DW           0x0015               ; DW | 15 00    Global: Logical Minimum = 0 (0x00)
    DW           0x0125               ; DW | 25 01    Global: Logical Maximum = 1 (0x01)
    DW           0x0175               ; DW | 75 01    Global: Report Size     = 1 (0x01)
    DW           0x0895               ; DW | 95 08    Global: Report Count    = 8 (0x08)
    DW           0x0281               ; DW | 81 02    Main:   Input           = 0x02 (Data, Variable, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x0195               ; DW | 95 01    Global: Report Count    = 1 (0x01)
    DW           0x0875               ; DW | 75 08    Global: Report Size     = 8 (0x08)
    DW           0x0181               ; DW | 81 01    Main:   Input           = 0x01 (Constant, Array, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x0595               ; DW | 95 05    Global: Report Count    = 5 (0x05)
    DW           0x0175               ; DW | 75 01    Global: Report Size     = 1 (0x01)
    DW           0x0805               ; DW | 05 08    Global: Usage Page      = LEDs (0x08)
    DW           0x0119               ; DW | 19 01    Local:  Usage Minimum   = LEDs: 0x01
    DW           0x0529               ; DW | 29 05    Local:  Usage Maximum   = LEDs: 0x05
    DW           0x0291               ; DW | 91 02    Main:   Output          = 0x02 (Data, Variable, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x0195               ; DW | 95 01    Global: Report Count    = 1 (0x01)
    DW           0x0375               ; DW | 75 03    Global: Report Size     = 3 (0x03)
    DW           0x0191               ; DW | 91 01    Main:   Output          = 0x01 (Constant, Array, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x0695               ; DW | 95 06    Global: Report Count    = 6 (0x06)
    DW           0x0875               ; DW | 75 08    Global: Report Size     = 8 (0x08)
    DW           0x0016               ; DW | 16 00 00 Global: Logical Minimum = 0 (0x0000)
    DW           0x2600               ; DW | 26 AF 00 Global: Logical Maximum = 175 (0x00AF)
    DW           0x00af               ; DW | || || ||
    DW           0x0705               ; DW | 05 07    Global: Usage Page      = Keyboard / Keypad (0x07)
    DW           0x001a               ; DW | 1A 00 00 Local:  Usage Minimum   = Keyboard / Keypad: Keyboard 0x00
    DW           0x2a00               ; DW | 2A AF 00 Local:  Usage Maximum   = Keyboard / Keypad: Keyboard 0xAF
    DW           0x00af               ; DW | || || ||
    DW           0x0081               ; DW | 81 00    Main:   Input           = 0x00 (Data, Array, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x0c05               ; DW | 05 0C    Global: Usage Page      = Consumer (0x0C)
    DW           0x0009               ; DW | 09 00    Local:  Usage           = Consumer: 0x00
    DW           0x8015               ; DW | 15 80    Global: Logical Minimum = -128 (0x80)
    DW           0x7f25               ; DW | 25 7F    Global: Logical Maximum = 127  (0x7F)
    DW           0x0875               ; DW | 75 08    Global: Report Size     = 8 (0x08)
    DW           0x0895               ; DW | 95 08    Global: Report Count    = 8 (0x08)
    DW           0x02b1               ; DW | B1 02    Main:   Feature         = 0x02 (Data, Variable, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x00c0               ; DW | C0       Main:   End Collection
    DW           0x0105               ; DW | 05 01    Global: Usage Page      = Generic Desktop (0x01)
    DW           0x0209               ; DW | 09 02    Local:  Usage           = Generic Desktop: Mouse
    DW           0x01a1               ; DW | A1 01    Main:   Collection      = Application (0x01)
    DW           0x0185               ; DW | 85 01    Global: Report ID       = 1 (0x01)
    DW           0x0905               ; DW | 05 09    Global: Usage Page      = Button (0x09)
    DW           0x0119               ; DW | 19 01    Local:  Usage Minimum   = Button: 0x01
    DW           0x0529               ; DW | 29 05    Local:  Usage Maximum   = Button: 0x05
    DW           0x0015               ; DW | 15 00    Global: Logical Minimum = 0 (0x00)
    DW           0x0125               ; DW | 25 01    Global: Logical Maximum = 1 (0x01)
    DW           0x0175               ; DW | 75 01    Global: Report Size     = 1 (0x01)
    DW           0x0595               ; DW | 95 05    Global: Report Count    = 5 (0x05)
    DW           0x0281               ; DW | 81 02    Main:   Input           = 0x02 (Data, Variable, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x0375               ; DW | 75 03    Global: Report Size     = 3 (0x03)
    DW           0x0195               ; DW | 95 01    Global: Report Count    = 1 (0x01)
    DW           0x0181               ; DW | 81 01    Main:   Input           = 0x01 (Constant, Array, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x0105               ; DW | 05 01    Global: Usage Page      = Generic Desktop (0x01)
    DW           0x0109               ; DW | 09 01    Local:  Usage           = Generic Desktop: Pointer
    DW           0x00a1               ; DW | A1 00    Main:   Collection      = Physical (0x00)
    DW           0x3009               ; DW | 09 30    Local:  Usage           = Generic Desktop: X
    DW           0x3109               ; DW | 09 31    Local:  Usage           = Generic Desktop: Y
    DW           0x8115               ; DW | 15 81    Global: Logical Minimum = -127 (0x81)
    DW           0x7f25               ; DW | 25 7F    Global: Logical Maximum = 127 (0x7F)
    DW           0x0875               ; DW | 75 08    Global: Report Size     = 8 (0x08)
    DW           0x0295               ; DW | 95 02    Global: Report Count    = 2 (0x02)
    DW           0x0681               ; DW | 81 06    Main:   Input           = 0x06 (Data, Variable, Relative, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x09c0               ; DW | C0       Main:   End Collection
    DW           0x9538               ; DW | 09 38    Local:  Usage           = Generic Desktop: Wheel
    DW           0x8101               ; DW | 95 01    Global: Report Count    = 1 (0x01)
    DW           0x0506               ; DW | 81 06    Main:   Input           = 0x06 (Data, Variable, Relative, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x0a0c               ; DW | 05 0C    Global: Usage Page      = Consumer (0x0C)
    DW           0x0238               ; DW | 0A 38 02 Local:  Usage           = Consumer: 0x238
    DW           0x0681               ; DW | 81 06    Main:   Input           = 0x06 (Data, Variable, Relative, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x05c0               ; DW | C0       Main:   End Collection
    DW           0x090c               ; DW | 05 0C    Global: Usage Page      = Consumer (0x0C)
    DW           0xa101               ; DW | 09 01    Local:  Usage           = Consumer: 0x01
    DW           0x8501               ; DW | A1 01    Main:   Collection      = Application (0x01)
    DW           0x1510               ; DW | 85 10    Global: Report ID       = 16 (0x10)
    DW           0x2600               ; DW | 15 00    Global: Logical Minimum = 0 (0x00)
    DW           0x023c               ; DW | 26 3C 02 Global: Logical Maximum = 572 (0x023C)
    DW           0x0019               ; DW | 19 00    Local:  Usage Minimum   = Consumer: 0x00
    DW           0x3c2a               ; DW | 2A 3C 02 Local:  Usage Maximum   = Consumer: 0x23C
    DW           0x7502               ; DW | 75 10    Global: Report Size     = 16 (0x10)
    DW           0x9510               ; DW | 95 01    Global: Report Count    = 1 (0x01)
    DW           0x8101               ; DW | 81 00    Main:   Input           = 0x00 (Data, Array, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0xc000               ; DW | C0       Main:   End Collection
    DW           0xa306               ; DW | || || ||
    DW           0x09ff               ; DW | 06 A3 FF Global: Usage Page      = 0xFFA3 (0xFFA3)
    DW           0xa101               ; DW | 09 01    Local:  Usage           = 0xFFA3: 0x01
    DW           0x8501               ; DW | A1 01    Main:   Collection      = Application (0x01)
    DW           0x1911               ; DW | 85 11    Global: Report ID       = 17 (0x11)
    DW           0x2a00               ; DW | 19 00    Local:  Usage Minimum   = 0xFFA3: 0x00
    DW           0x00ff               ; DW | 2A FF 00 Local:  Usage Maximum   = 0xFFA3: 0xFF
    DW           0x0015               ; DW | 15 00    Global: Logical Minimum = 0 (0x00)
    DW           0xff26               ; DW | 26 FF 00 Global: Logical Maximum = 255 (0x00FF)
    DW           0x7500               ; DW | 75 08    Global: Report Size     = 8 (0x08)
    DW           0x9508               ; DW | 95 02    Global: Report Count    = 2 (0x02)
    DW           0x8102               ; DW | 81 02    Main:   Input           = 0x02 (Data, Variable, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0xc002               ; DW | C0       Main:   End Collection
    DW           0xa006               ; DW | 06 A0 FF Global: Usage Page      = 0xFFA0 (0xFFA0)
    DW           0x09ff               ; DW | 09 01    Local:  Usage           = 0xFFA0: 0x01
    DW           0xa101               ; DW | A1 01    Main:   Collection      = Application (0x01)
    DW           0x8501               ; DW | 85 15    Global: Report ID       = 21 (0x15)
    DW           0x1a15               ; DW | 1A F1 00 Local:  Usage Minimum   = 0xFFA0: 0xF1
    DW           0x00f1               ; DW | || || ||
    DW           0xfc2a               ; DW | 2A FC 00 Local:  Usage Maximum   = 0xFFA0: 0xFC
    DW           0x1500               ; DW | 15 00    Global: Logical Minimum = 0 (0x00)
    DW           0x2500               ; DW | 25 01    Global: Logical Maximum = 1 (0x01)
    DW           0x7501               ; DW | 75 01    Global: Report Size     = 1 (0x01)
    DW           0x9501               ; DW | 95 0D    Global: Report Count    = 13 (0x0D)
    DW           0x810d               ; DW | 81 02    Main:   Input           = 0x02 (Data, Variable, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x9502               ; DW | 95 03    Global: Report Count    = 3 (0x03)
    DW           0x8103               ; DW | 81 01    Main:   Input           = 0x01 (Constant, Array, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0xc001               ; DW | C0       Main:   End Collection
    DW           0xa106               ; DW | 06 A1 FF Global: Usage Page      = 0xFFA1 (0xFFA1)
    DW           0x09ff               ; DW | 09 01    Local:  Usage           = 0xFFA1: 0x01
    DW           0xa101               ; DW | A1 01    Main:   Collection      = Application (0x01)
    DW           0x8501               ; DW | 85 16    Global: Report ID       = 22 (0x16)
    DW           0x1916               ; DW | 19 00    Local:  Usage Minimum   = 0xFFA1: 0x00
    DW           0x2a00               ; DW | 2A FF 00 Local:  Usage Maximum   = 0xFFA1: 0xFF
    DW           0x00ff               ; DW | || || ||
    DW           0x0015               ; DW | 15 00    Global: Logical Minimum = 0 (0x00)
    DW           0xff26               ; DW | 26 FF 00 Global: Logical Maximum = 255 (0x00FF)
    DW           0x7500               ; DW | 75 08    Global: Report Size     = 8 (0x08)
    DW           0x9508               ; DW | 95 02    Global: Report Count    = 2 (0x02)
    DW           0x8102               ; DW | 81 02    Main:   Input           = 0x02 (Data, Variable, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0xc002               ; DW | C0       Main:   End Collection
    DW           0x0006               ; DW | 06 00 FF Global: Usage Page      = 0xFF00 (0xFF00)
    DW           0x09ff               ; DW | 09 01    Local:  Usage           = 0xFF00: 0x01
    DW           0xa101               ; DW | A1 01    Main:   Collection      = Application (0x01)
    DW           0x8501               ; DW | 85 13    Global: Report ID       = 19 (0x13)
    DW           0x0913               ; DW | 09 01    Local:  Usage           = 0xFF00: 0x01
    DW           0x1501               ; DW | 15 00    Global: Logical Minimum = 0 (0x00)
    DW           0x2600               ; DW | 26 FF 00 Global: Logical Maximum = 255 (0x00FF)
    DW           0x00ff               ; DW | || || ||
    DW           0x0875               ; DW | 75 08    Global: Report Size     = 8 (0x08)
    DW           0x0895               ; DW | 95 08    Global: Report Count    = 8 (0x08)
    DW           0x0281               ; DW | 81 02    Main:   Input           = 0x02 (Data, Variable, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x0209               ; DW | 09 02    Local:  Usage           = 0xFF00: 0x02
    DW           0x0875               ; DW | 75 08    Global: Report Size     = 8 (0x08)
    DW           0x0895               ; DW | 95 08    Global: Report Count    = 8 (0x08)
    DW           0x0291               ; DW | 91 02    Main:   Output          = 0x02 (Data, Variable, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x0309               ; DW | 09 03    Local:  Usage           = 0xFF00: 0x03
    DW           0x0875               ; DW | 75 08    Global: Report Size     = 8 (0x08)
    DW           0x0895               ; DW | 95 08    Global: Report Count    = 8 (0x08)
    DW           0x02b1               ; DW | B1 02    Main:   Feature         = 0x02 (Data, Variable, Absolute, NoWrap, Linear, PreferredState, NoNullPosition, NonVolatile)
    DW           0x00c0               ; DW | C0       Main:   End Collection
    DW           0x0304               ; DW | 0x0304 | .. |
    DW           0x0409               ; DW | 0x0409 | .. |
    DW           0x030e               ; DW | 0x030e | .. |
    DW           0x004c               ; DW | 0x004c | .L | Lenovo\
    DW           0x0065               ; DW | 0x0065 | .e |
    DW           0x006e               ; DW | 0x006e | .n |
    DW           0x006f               ; DW | 0x006f | .o |
    DW           0x0076               ; DW | 0x0076 | .v |
    DW           0x006f               ; DW | 0x006f | .o |
    DW           0x035c               ; DW | 0x035c | .\ |
    DW           0x0054               ; DW | 0x0054 | .T | Thinkpad 
    DW           0x0068               ; DW | 0x0068 | .h |
    DW           0x0069               ; DW | 0x0069 | .i |
    DW           0x006e               ; DW | 0x006e | .n |
    DW           0x006b               ; DW | 0x006b | .k |
    DW           0x0050               ; DW | 0x0050 | .P |
    DW           0x0061               ; DW | 0x0061 | .a |
    DW           0x0064               ; DW | 0x0064 | .d |
    DW           0x0020               ; DW | 0x0020 | .  |
    DW           0x0043               ; DW | 0x0043 | .C | Compact 
    DW           0x006f               ; DW | 0x006f | .o |
    DW           0x006d               ; DW | 0x006d | .m |
    DW           0x0070               ; DW | 0x0070 | .p |
    DW           0x0061               ; DW | 0x0061 | .a |
    DW           0x0063               ; DW | 0x0063 | .c |
    DW           0x0074               ; DW | 0x0074 | .t |
    DW           0x0020               ; DW | 0x0020 | .  |
    DW           0x0055               ; DW | 0x0055 | .U | USB 
    DW           0x0053               ; DW | 0x0053 | .S |
    DW           0x0042               ; DW | 0x0042 | .B |
    DW           0x0020               ; DW | 0x0020 | .  |
    DW           0x004b               ; DW | 0x004b | .K | Keyboard 
    DW           0x0065               ; DW | 0x0065 | .e |
    DW           0x0079               ; DW | 0x0079 | .y |
    DW           0x0062               ; DW | 0x0062 | .b |
    DW           0x006f               ; DW | 0x006f | .o |
    DW           0x0061               ; DW | 0x0061 | .a |
    DW           0x0072               ; DW | 0x0072 | .r |
    DW           0x0064               ; DW | 0x0064 | .d |
    DW           0x0020               ; DW | 0x0020 | .  |
    DW           0x0077               ; DW | 0x0077 | .w | with 
    DW           0x0069               ; DW | 0x0069 | .i |
    DW           0x0074               ; DW | 0x0074 | .t |
    DW           0x0068               ; DW | 0x0068 | .h |
    DW           0x0020               ; DW | 0x0020 | .  |
    DW           0x0054               ; DW | 0x0054 | .T | TrackPoint 
    DW           0x0072               ; DW | 0x0072 | .r |
    DW           0x0061               ; DW | 0x0061 | .a |
    DW           0x0063               ; DW | 0x0063 | .c |
    DW           0x006b               ; DW | 0x006b | .k |
    DW           0x0050               ; DW | 0x0050 | .P |
    DW           0x006f               ; DW | 0x006f | .o |
    DW           0x0069               ; DW | 0x0069 | .i |
    DW           0x006e               ; DW | 0x006e | .n |
    DW           0x0074               ; DW | 0x0074 | .t |
    DW           0x0312               ; DW | 0x0312 | .. |
    DW           0x0030               ; DW | 0x0030 | .0 | 00000000
    DW           0x0030               ; DW | 0x0030 | .0 |
    DW           0x0030               ; DW | 0x0030 | .0 |
    DW           0x0030               ; DW | 0x0030 | .0 |
    DW           0x0030               ; DW | 0x0030 | .0 |
    DW           0x0030               ; DW | 0x0030 | .0 |
    DW           0x0030               ; DW | 0x0030 | .0 |
    DW           0x0030               ; DW | 0x0030 | .0 |
    DW           0x0328               ; DW | 0x0328 | .( | (
    DW           0x0048               ; DW | 0x0048 | .H | HID-CompliantDevice
    DW           0x0049               ; DW | 0x0049 | .I |
    DW           0x0044               ; DW | 0x0044 | .D |
    DW           0x002d               ; DW | 0x002d | .- |
    DW           0x0043               ; DW | 0x0043 | .C |
    DW           0x006f               ; DW | 0x006f | .o |
    DW           0x006d               ; DW | 0x006d | .m |
    DW           0x0070               ; DW | 0x0070 | .p |
    DW           0x006c               ; DW | 0x006c | .l |
    DW           0x0069               ; DW | 0x0069 | .i |
    DW           0x0061               ; DW | 0x0061 | .a |
    DW           0x006e               ; DW | 0x006e | .n |
    DW           0x0074               ; DW | 0x0074 | .t |
    DW           0x2044               ; DW | 0x2044 |  D |
    DW           0x0065               ; DW | 0x0065 | .e |
    DW           0x0076               ; DW | 0x0076 | .v |
    DW           0x0069               ; DW | 0x0069 | .i |
    DW           0x0063               ; DW | 0x0063 | .c |
    DW           0x0065               ; DW | 0x0065 | .e |

func_1098:                            ;
    MOV          A,     #0x00         ;
    CMPRS        A,     0x57          ;
    JMP          func_1098_0004       ;
    JMP          func_1098_0007       ;

func_1098_0004:                       ;
    MOV          A,     #0xc0         ;
    B0MOV        UE1R,  A             ;
    RET                               ;

func_1098_0007:                       ;
    BTS0         0x13.0               ;
    JMP          func_1098_000e       ;
    MOV          A,     0x38          ;
    B0BTS0       FZ                   ;
    JMP          func_1098_000d       ;
    DECMS        0x38                 ;
func_1098_000d:                       ;
    RET                               ;

func_1098_000e:                       ;
    MOV          A,     0x6d          ;
    MOV          0x38,  A             ;
    CALL         func_1169            ;
    B0BTS1       FC                   ;
    JMP          func_1098_00a6       ;
    CALL         func_118b            ;
    B0BTS1       FC                   ;
    JMP          func_1098_00a6       ;
    CALL         func_11ad            ;
    B0BTS1       FC                   ;
    JMP          func_1098_00a6       ;
    CALL         func_11d6            ;
    B0BTS1       FC                   ;
    JMP          func_1098_00a6       ;
    CALL         func_1202            ;
    B0BTS1       FC                   ;
    JMP          func_1098_00a6       ;
    CALL         func_1254            ;
    B0BTS1       FC                   ;
    JMP          func_1098_00a6       ;
    CALL         func_1279            ;
    B0BTS1       FC                   ;
    JMP          func_1098_00a6       ;
    B0BTS1       0x00.6               ;
    JMP          func_1098_004a       ; If 0x00.6 == 0, 
    B0BCLR       0x00.6               ; If 0x00.6 == 1, 
    MOV          A,     #0x08         ; 8
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x08
    MOV          A,     #0x09         ; 9
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x09
    MOV          A,     #0x0a         ; a
    CALL         func_0c28            ;
    MOV          A,     #0x4f         ; 4f
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x0a
    MOV          A,     #0x0b         ; b
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x0b
    MOV          A,     #0x0c         ; c
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x0c
    MOV          A,     #0x0d         ; d
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x0d
    MOV          A,     #0x0e         ; e
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x0e
    MOV          A,     #0x0f         ; f
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x0f
    B0BCLR       0x13.0               ;
    JMP          func_1098_00c6       ;

func_1098_004a:                       ; [0c28 x 8 + 0c2c x 8]
    B0BTS1       0x00.4               ;
    JMP          func_1098_006e       ;
    MOV          A,     #0x08         ; 8
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x08
    MOV          A,     #0x09         ; 9
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x09
    MOV          A,     #0x0a         ; a
    CALL         func_0c28            ;
    MOV          A,     #0x01         ; 1
    CALL         func_0c2c            ; write UDR0 1 at UDP0 #0x0a
    MOV          A,     #0x0b         ; b
    CALL         func_0c28            ;
    MOV          A,     #0x01         ; 1
    CALL         func_0c2c            ; write UDR0 1 at UDP0 #0x0b
    MOV          A,     #0x0c         ; c
    CALL         func_0c28            ;
    MOV          A,     #0x01         ; 1
    CALL         func_0c2c            ; write UDR0 1 at UDP0 #0x0c
    MOV          A,     #0x0d         ; d
    CALL         func_0c28            ;
    MOV          A,     #0x01         ; 1
    CALL         func_0c2c            ; write UDR0 1 at UDP0 #0x0d
    MOV          A,     #0x0e         ; e
    CALL         func_0c28            ;
    MOV          A,     #0x01         ; 1
    CALL         func_0c2c            ; write UDR0 1 at UDP0 #0x0e
    MOV          A,     #0x0f         ; f
    CALL         func_0c28            ;
    MOV          A,     #0x01         ; 1
    CALL         func_0c2c            ; write UDR0 1 at UDP0 #0x0f
    B0BCLR       0x13.0               ;
    JMP          func_1098_00c6       ;

func_1098_006e:                       ;
    BTS1         0x13.1               ;
    JMP          func_1098_0080       ; If 0x13.1 == 0, JMP
    MOV          A,     0x15          ; If 0x13.1 == 1, A = 0x15 POINT 2 --- 1 line avail ?
    B0BTS1       FZ                   ;
    JMP          func_1098_0076       ; If FZ == 0, JMP
    MOV          A,     0x17          ; If FZ == 1, A = 0x17
    B0BTS0       FZ                   ;
    RET                               ; If FZ == 0,
func_1098_0076:                       ; If FZ == 1,
    MOV          A,     #0x00         ; ----------- 1 line avail 
    MOV          0x15,  A             ; 0x15 = 0
    MOV          0x17,  A             ; 0x17 = 0
    MOV          0x18,  A             ; 0x18 = 0
    MOV          0x19,  A             ; 0x19 = 0
    MOV          0x1a,  A             ; 0x1a = 0
    MOV          0x1b,  A             ; 0x1b = 0
    MOV          0x1c,  A             ; 0x1c = 0
    BCLR         0x13.0               ;
    JMP          func_1098_00a6       ;

func_1098_0080:                       ;
    BTS1         0x13.5               ;
    JMP          func_1098_00a5       ; If 0x13.5 (ESC-related flag) == 0, clear 0x13.0 and go to general(?) USB sending procedure.
    BCLR         0x13.5               ; 0x15 - 0x1c are scancode?
    MOV          A,     #0x08         ; 8
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x08
    MOV          A,     #0x09         ; 9
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x09
    MOV          A,     #0x0a         ; a
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x0a
    MOV          A,     #0x0b         ; b
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x0b
    MOV          A,     #0x0c         ; c
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x0c
    MOV          A,     #0x0d         ; d
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x0d
    MOV          A,     #0x0e         ; e
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x0e
    MOV          A,     #0x0f         ; f
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x0f
    BCLR         0x13.0               ;
    JMP          func_1098_00c6       ;

func_1098_00a5:                       ;
    BCLR         0x13.0               ;
func_1098_00a6:                       ;
    MOV          A,     #0x08         ; 8
    CALL         func_0c28            ;
    MOV          A,     0x15          ; 0x15
    CALL         func_0c2c            ; write UDR0 0x15 at UDP0 #0x08
    MOV          A,     #0x09         ; 9
    CALL         func_0c28            ;
    MOV          A,     #0x00         ; 0
    CALL         func_0c2c            ; write UDR0 0 at UDP0 #0x09
    MOV          A,     #0x0a         ; a
    CALL         func_0c28            ;
    MOV          A,     0x17          ; 0x17
    CALL         func_0c2c            ; write UDR0 0x17 at UDP0 #0x0a
    MOV          A,     #0x0b         ; b
    CALL         func_0c28            ;
    MOV          A,     0x18          ; 0x18
    CALL         func_0c2c            ; write UDR0 0x18 at UDP0 #0x0b
    MOV          A,     #0x0c         ; c
    CALL         func_0c28            ;
    MOV          A,     0x19          ; 0x19
    CALL         func_0c2c            ; write UDR0 0x19 at UDP0 #0x0c
    MOV          A,     #0x0d         ; d
    CALL         func_0c28            ;
    MOV          A,     0x1a          ; a
    CALL         func_0c2c            ; write UDR0 0x1a at UDP0 #0x0d
    MOV          A,     #0x0e         ; e
    CALL         func_0c28            ;
    MOV          A,     0x1b          ; 0x1b
    CALL         func_0c2c            ; write UDR0 0x1b at UDP0 #0x0e
    MOV          A,     #0x0f         ; f
    CALL         func_0c28            ;
    MOV          A,     0x1c          ; 0x1c
    CALL         func_0c2c            ; write UDR0 0x1c at UDP0 #0x0f

func_1098_00c6:                       ;
    MOV          A,     #0x08         ;
    B0MOV        UE1R_C,A             ;
    MOV          A,     #0xa0         ;
    B0MOV        UE1R,  A             ;
    RET                               ;
    DW           0x2d00               ; DW | 0x2d00 | -. |
    DW           0x2f99               ; DW | 0x2f99 | /. |
    DW           0x2d80               ; DW | 0x2d80 | -. |
    DW           0x2f98               ; DW | 0x2f98 | /. |
    DW           0x4013               ; DW | 0x4013 | @. |
    DW           0x0e00               ; DW | 0x0e00 | .. |

func_1169:                            ;
    BTS0         0x40.4               ;
    JMP          func_1169_0004       ;
    B0BSET       FC                   ;
    RET                               ;

func_1169_0004:                       ;
    BTS0         0x00.3               ;
    JMP          func_1169_0012       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_1169_000a       ;
    JMP          func_1169_000f       ;

func_1169_000a:                       ;
    CLR          0x15                 ;
    BSET         0x15.3               ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1169_0020       ;

func_1169_000f:                       ;
    MOV          A,     #0x13         ;
    MOV          0x17,  A             ;
    JMP          func_1169_001c       ;

func_1169_0012:                       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_1169_0016       ;
    JMP          func_1169_001b       ;

func_1169_0016:                       ;
    CLR          0x17                 ;
    CALL         func_129e            ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1169_0020       ;

func_1169_001b:                       ;
    BCLR         0x15.3               ;
func_1169_001c:                       ;
    BCLR         0x40.4               ;
    CLR          0x3f                 ;
    CALL         func_129e            ;
    BCLR         0x13.0               ;
func_1169_0020:                       ;
    B0BCLR       FC                   ;
    RET                               ;

func_118b:                            ;
    BTS0         0x40.6               ;
    JMP          func_118b_0004       ;
    B0BSET       FC                   ;
    RET                               ;

func_118b_0004:                       ;
    BTS0         0x00.3               ;
    JMP          func_118b_0012       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_118b_000a       ;
    JMP          func_118b_000f       ;

func_118b_000a:                       ;
    CLR          0x15                 ;
    BSET         0x15.3               ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_118b_0020       ;

func_118b_000f:                       ;
    MOV          A,     #0x70         ;
    B0MOV        0x17,  A             ;
    JMP          func_118b_001c       ;

func_118b_0012:                       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_118b_0016       ;
    JMP          func_118b_001b       ;

func_118b_0016:                       ;
    CLR          0x17                 ;
    CALL         func_129e            ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_118b_0020       ;

func_118b_001b:                       ;
    BCLR         0x15.3               ;
func_118b_001c:                       ;
    BCLR         0x40.6               ;
    CLR          0x3f                 ;
    CALL         func_129e            ;
    BCLR         0x13.0               ;
func_118b_0020:                       ;
    B0BCLR       FC                   ;
    RET                               ;

func_11ad:                            ;
    BTS0         0x40.1               ;
    JMP          func_11ad_0006       ;
    BTS0         0x40.0               ;
    JMP          func_11ad_0006       ;
    B0BSET       FC                   ;
    RET                               ;

func_11ad_0006:                       ;
    BTS0         0x00.3               ;
    JMP          func_11ad_0018       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_11ad_000c       ;
    JMP          func_11ad_0011       ;

func_11ad_000c:                       ;
    CLR          0x15                 ;
    BSET         0x15.3               ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_11ad_0027       ;

func_11ad_0011:                       ;
    BTS1         0x40.1               ;
    JMP          func_11ad_0015       ;
    MOV          A,     #0x14         ;
    JMP          func_11ad_0016       ;

func_11ad_0015:                       ;
    MOV          A,     #0x09         ;
func_11ad_0016:                       ;
    MOV          0x17,  A             ;
    JMP          func_11ad_0022       ;

func_11ad_0018:                       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_11ad_001c       ;
    JMP          func_11ad_0021       ;

func_11ad_001c:                       ;
    CLR          0x17                 ;
    CALL         func_129e            ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_11ad_0027       ;

func_11ad_0021:                       ;
    BCLR         0x15.3               ;
func_11ad_0022:                       ;
    BCLR         0x40.1               ;
    BCLR         0x40.0               ;
    CLR          0x3f                 ;
    CALL         func_129e            ;
    BCLR         0x13.0               ;
func_11ad_0027:                       ;
    B0BCLR       FC                   ;
    RET                               ;

func_11d6:                            ;
    BTS0         0x40.7               ;
    JMP          func_11d6_0004       ;
    B0BSET       FC                   ;
    RET                               ;

func_11d6_0004:                       ;
    BTS0         0x00.3               ;
    JMP          func_11d6_0017       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_11d6_000b       ;
    JMP          func_11d6_0010       ;
    JMP          func_11d6_0014       ;

func_11d6_000b:                       ;
    CLR          0x15                 ;
    BSET         0x15.0               ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_11d6_002a       ;

func_11d6_0010:                       ;
    BSET         0x15.2               ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_11d6_002a       ;

func_11d6_0014:                       ;
    MOV          A,     #0x2b         ;
    MOV          0x17,  A             ;
    JMP          func_11d6_0026       ;

func_11d6_0017:                       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_11d6_001c       ;
    JMP          func_11d6_0021       ;
    JMP          func_11d6_0025       ;

func_11d6_001c:                       ;
    CLR          0x17                 ;
    CALL         func_129e            ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_11d6_002a       ;

func_11d6_0021:                       ;
    BCLR         0x15.2               ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_11d6_002a       ;

func_11d6_0025:                       ;
    BCLR         0x15.0               ;
func_11d6_0026:                       ;
    BCLR         0x40.7               ;
    BCLR         0x13.0               ;
    CLR          0x3f                 ;
    CALL         func_129e            ;

func_11d6_002a:                       ;
    B0BCLR       FC                   ;
    RET                               ;

func_1202:                            ;
    BTS0         0x40.5               ;
    JMP          func_1202_0004       ;
    B0BSET       FC                   ;
    RET                               ;

func_1202_0004:                       ;
    BTS1         0x12.2               ;
    JMP          func_1202_0024       ;
    BTS0         0x00.3               ;
    JMP          func_1202_0014       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_1202_000c       ;
    JMP          func_1202_0011       ;

func_1202_000c:                       ;
    CLR          0x15                 ;
    BSET         0x15.3               ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1202_0022       ;

func_1202_0011:                       ;
    MOV          A,     #0x08         ;
    MOV          0x17,  A             ;
    JMP          func_1202_001e       ;

func_1202_0014:                       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_1202_0018       ;
    JMP          func_1202_001d       ;

func_1202_0018:                       ;
    CLR          0x17                 ;
    CALL         func_129e            ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1202_0022       ;

func_1202_001d:                       ;
    BCLR         0x15.3               ;
func_1202_001e:                       ;
    BCLR         0x40.5               ;
    BCLR         0x13.0               ;
    CLR          0x3f                 ;
    CALL         func_129e            ;

func_1202_0022:                       ;
    B0BCLR       FC                   ;
    RET                               ;

func_1202_0024:                       ;
    BTS0         0x12.3               ;
    JMP          func_1202_0028       ;
    B0BSET       FC                   ;
    RET                               ;

func_1202_0028:                       ;
    BTS1         0x00.3               ;
    JMP          func_1202_002c       ;
    B0BSET       FC                   ;
    JMP          func_1202_004a       ;

func_1202_002c:                       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_1202_0033       ;
    JMP          func_1202_0038       ;
    JMP          func_1202_003e       ;
    JMP          func_1202_0044       ;
    JMP          func_1202_004a       ;

func_1202_0033:                       ;
    CLR          0x15                 ;
    BSET         0x15.3               ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1202_0050       ;

func_1202_0038:                       ;
    MOV          A,     #0x14         ;
    MOV          0x17,  A             ;
    CALL         func_129e            ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1202_0050       ;

func_1202_003e:                       ;
    BCLR         0x15.3               ;
    CLR          0x17                 ;
    CALL         func_129e            ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1202_0050       ;

func_1202_0044:                       ;
    MOV          A,     #0x29         ;
    MOV          0x17,  A             ;
    CALL         func_129e            ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1202_0050       ;

func_1202_004a:                       ;
    CLR          0x17                 ;
    CALL         func_129e            ;
    BCLR         0x40.5               ;
    BCLR         0x13.0               ;
    CLR          0x3f                 ;
    CALL         func_129e            ;

func_1202_0050:                       ;
    B0BCLR       FC                   ;
    RET                               ;

func_1254:                            ;
    BTS0         0x12.5               ;
    JMP          func_1254_0004       ;
    B0BSET       FC                   ;
    RET                               ;

func_1254_0004:                       ;
    BTS0         0x00.3               ;
    JMP          func_1254_0015       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_1254_000a       ;
    JMP          func_1254_000f       ;

func_1254_000a:                       ;
    CLR          0x15                 ;
    BSET         0x15.0               ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1254_0023       ;

func_1254_000f:                       ;
    MOV          A,     #0x48         ;
    MOV          0x17,  A             ;
    CALL         func_129e            ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1254_001f       ;

func_1254_0015:                       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_1254_0019       ;
    JMP          func_1254_001e       ;

func_1254_0019:                       ;
    CLR          0x17                 ;
    CALL         func_129e            ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1254_0023       ;

func_1254_001e:                       ;
    BCLR         0x15.0               ;
func_1254_001f:                       ;
    BCLR         0x12.5               ;
    BCLR         0x13.0               ;
    CLR          0x3f                 ;
    CALL         func_129e            ;

func_1254_0023:                       ;
    B0BCLR       FC                   ;
    RET                               ;

func_1279:                            ;
    BTS0         0x14.3               ;
    JMP          func_1279_0004       ;
    B0BSET       FC                   ;
    RET                               ;

func_1279_0004:                       ;
    BTS0         0x00.3               ;
    JMP          func_1279_0015       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_1279_000a       ;
    JMP          func_1279_000f       ;

func_1279_000a:                       ;
    CLR          0x15                 ;
    BSET         0x15.2               ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1279_0023       ;

func_1279_000f:                       ;
    MOV          A,     #0x46         ;
    MOV          0x17,  A             ;
    CALL         func_129e            ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1279_001f       ;

func_1279_0015:                       ;
    MOV          A,     0x3f          ;
    B0ADD        PCL,   A             ;
    JMP          func_1279_0019       ;
    JMP          func_1279_001e       ;

func_1279_0019:                       ;
    CLR          0x17                 ;
    CALL         func_129e            ;
    INCMS        0x3f                 ;
    NOP                               ;
    JMP          func_1279_0023       ;

func_1279_001e:                       ;
    BCLR         0x15.2               ;
func_1279_001f:                       ;
    BCLR         0x14.3               ;
    BCLR         0x13.0               ;
    CLR          0x3f                 ;
    CALL         func_129e            ;

func_1279_0023:                       ;
    B0BCLR       FC                   ;
    RET                               ;

func_129e:                            ;
    CLR          0x18                 ;
    CLR          0x19                 ;
    CLR          0x1a                 ;
    CLR          0x1b                 ;
    CLR          0x1c                 ;
    RET                               ;

func_12a4:                            ;
    MOV          A,     #0x00         ;
    CMPRS        A,     0x58          ;
    JMP          func_12a4_0004       ;
    JMP          func_12a4_0007       ;

func_12a4_0004:                       ;
    MOV          A,     #0xc0         ;
    B0MOV        UE2R,  A             ;
    RET                               ;

func_12a4_0007:                       ;
    B0MOV        A,     0x75          ;
    CMPRS        A,     #0x01         ;
    JMP          func_12a4_000b       ;
    JMP          func_12a4_0022       ;

func_12a4_000b:                       ;
    BTS0         0x13.2               ;
    JMP          func_12a4_000e       ;
    RET                               ;

func_12a4_000e:                       ;
    BCLR         0x13.2               ; Clear 0x13.2
    MOV          A,     #0x18         ; 					| 
    CALL         func_0c28            ; B0MOV	UDP0, A		| UDP0 = #0x18
    MOV          A,     0x2c          ; 					| 
    CALL         func_0c2c            ; B0MOV	UDR0_W, A	| write UDR0 0x2c at UDP0 #0x18
    MOV          A,     #0x19         ; 					| 
    CALL         func_0c28            ; B0MOV	UDP0, A		| UDP0 = #0x19
    MOV          A,     0x2e          ; 2epoints			| - CONFIRMED - 0x2e: Track point X-axis value
    CALL         func_0c2c            ; B0MOV	UDR0_W, A	| write UDR0 0x2e at UDP0 #0x19
    MOV          A,     #0x1a         ; 					| 
    CALL         func_0c28            ; B0MOV	UDP0, A		| UDP0 = #0x1a
    MOV          A,     0x2f          ; 2fpoints			| - CONFIRMED - 0x2f: Track point Y-axis value
    CALL         func_0c2c            ; B0MOV	UDR0_W, A	| write UDR0 0x2f at UDP0 #0x1a
    CLR          0x2e                 ; 2epoints
    CLR          0x2f                 ; 2fpoints
    MOV          A,     #0x03         ; 					| 
    B0MOV        UE2R_C,A             ; 					| UE2R_C = #0x03
    MOV          A,     #0xa0         ; 					| 
    B0MOV        UE2R,  A             ; 					| UE2R = #0xa0
    RET                               ;

func_12a4_0022:                       ;
    BTS0         0x13.2               ;
    JMP          func_12a4_002c       ;
    MOV          A,     0x39          ;
    B0BTS0       FZ                   ;
    JMP          func_12a4_0028       ;
    DECMS        0x39                 ;
func_12a4_0028:                       ;
    JMP          func_12a4_005e       ;
    B0MOV        A,     0x6e          ;
    B0MOV        0x39,  A             ;
    JMP          func_12a4_002f       ;

func_12a4_002c:                       ;
    BCLR         0x13.2               ;
    B0MOV        A,     0x6e          ;
    B0MOV        0x39,  A             ;
func_12a4_002f:                       ;
    MOV          A,     #0x18         ;
    CALL         func_0c28            ;
    MOV          A,     #0x01         ;
    CALL         func_0c2c            ; write UDR0 1 at UDP0 #0x18
    MOV          A,     #0x19         ;
    CALL         func_0c28            ;
    BTS1         0x14.6               ; Check 0x14.6 (Seems to be finished flag of scroll amout calculation?)
    JMP          func_12a4_003a       ; If 0x14.6 == 0 go to 003a
    MOV          A,     0x2d          ;
    CALL         func_0c2c            ; write UDR0 0x2d at UDP0 #0x19
    JMP          func_12a4_003f       ;

func_12a4_003a:                       ;
    MOV          A,     0x2d          ; 
    AND          A,     #0xfb         ; [Middle-button 4] Write No operation to disable the auto-scrolling
    MOV          0x62,  A             ; 0x62 = 0x2d value AND #0xfb (11111011)
    MOV          A,     0x62          ;
    CALL         func_0c2c            ; write UDR0 0x62 at UDP0 #0x19

func_12a4_003f:                       ;
    MOV          A,     #0x1a         ;					    |
    CALL         func_0c28            ; B0MOV	UDP0, A		| UDP0 = #0x1a
    MOV          A,     0x2e          ; 2epoints			|
    CALL         func_0c2c            ; B0MOV	UDR0_W, A	| UDR0_W = 0x2e
    MOV          A,     #0x1b         ;					    |
    CALL         func_0c28            ; B0MOV	UDP0, A		| UDP0 = #0x1b
    MOV          A,     0x2f          ; 2fpoints			| 
    CALL         func_0c2c            ; B0MOV	UDR0_W, A	| UDR0_W = 0x2f
    MOV          A,     #0x1c         ;				        |
    CALL         func_0c28            ; B0MOV	UDP0, A		| UDP0 = #0x1c
    BTS0         0x14.5               ;			 		    | Auto-scroll flag
    JMP          func_12a4_004e       ;
    MOV          A,     0x30          ; 					|
    CALL         func_0c2c            ; B0MOV	UDR0_W, A	| UDR0_W = 0x30
    JMP          func_12a4_0050       ;

func_12a4_004e:                       ;
    MOV          A,     #0x00         ;				    	|
    CALL         func_0c2c            ; B0MOV	UDR0_W, A	| write UDR0 #0x00 at UDP0 #0x1c

func_12a4_0050:                       ;
    MOV          A,     #0x1d         ;
    CALL         func_0c28            ; B0MOV	UDP0, A
    MOV          A,     #0x00         ;
    CALL         func_0c2c            ; write UDR0 #0x00 at UDP0 #0x1d
    CLR          0x2e                 ; 2epoints
    CLR          0x2f                 ; 2fpoints
    BTS0         0x14.5               ; Auto-scroll flag
    JMP          func_12a4_0059       ;
    CLR          0x30                 ;
func_12a4_0059:                       ;
    MOV          A,     #0x06         ;
    B0MOV        UE2R_C,A             ;
    MOV          A,     #0xa0         ;
    B0MOV        UE2R,  A             ;
    RET                               ;

func_12a4_005e:                       ;
    BTS0         0x13.3               ;
    JMP          func_12a4_0068       ;
    MOV          A,     0x3a          ;
    B0BTS0       FZ                   ;
    JMP          func_12a4_0064       ;
    DECMS        0x3a                 ;
func_12a4_0064:                       ;
    JMP          func_12a4_0085       ;
    B0MOV        A,     0x6f          ;
    B0MOV        0x3a,  A             ;
    JMP          func_12a4_006b       ;

func_12a4_0068:                       ;
    BCLR         0x13.3               ;
    B0MOV        A,     0x6f          ;
    B0MOV        0x3a,  A             ;
func_12a4_006b:                       ;
    MOV          A,     #0x18         ;
    CALL         func_0c28            ;
    MOV          A,     #0x16         ;
    CALL         func_0c2c            ; write UDR0 #0x16 at UDP0 #0x18 
    MOV          A,     #0x19         ;
    CALL         func_0c28            ;
    MOV          A,     0x31          ;
    CALL         func_0c2c            ; write UDR0 0x31 at UDP0 #0x19 
    MOV          A,     #0x1a         ;
    CALL         func_0c28            ;
    BTS1         0x14.5               ; Auto-scroll flag
    JMP          func_12a4_007a       ;
    MOV          A,     0x30          ;
    CALL         func_0c2c            ; write UDR0 0x30 at UDP0 #0x1a
    JMP          func_12a4_007c       ;

func_12a4_007a:                       ;
    MOV          A,     #0x00         ;
    CALL         func_0c2c            ; write UDR0 #0x00 at UDP0 #0x1a

func_12a4_007c:                       ;
    BTS1         0x14.5               ; Auto-scroll flag
    JMP          func_12a4_007f       ;
    CLR          0x30                 ;
func_12a4_007f:                       ;
    CLR          0x31                 ;
    MOV          A,     #0x03         ;
    B0MOV        UE2R_C,A             ;
    MOV          A,     #0xa0         ;
    B0MOV        UE2R,  A             ;
    RET                               ;

func_12a4_0085:                       ;
    BTS0         0x13.4               ;
    JMP          func_12a4_008f       ;
    MOV          A,     0x3b          ;
    B0BTS0       FZ                   ;
    JMP          func_12a4_008b       ;
    DECMS        0x3b                 ;
func_12a4_008b:                       ;
    JMP          func_12a4_00b4       ;
    B0MOV        A,     0x70          ;
    B0MOV        0x3b,  A             ;
    JMP          func_12a4_009f       ;

func_12a4_008f:                       ;
    BCLR         0x13.4               ;
    B0MOV        A,     0x70          ;
    B0MOV        0x3b,  A             ;
    BTS1         0x13.1               ;
    JMP          func_12a4_009f       ;
    MOV          A,     0x23          ;
    B0BTS1       FZ                   ;
    JMP          func_12a4_009a       ;
    MOV          A,     0x24          ;
    B0BTS0       FZ                   ;
    RET                               ;
func_12a4_009a:                       ;
    CLR          0x23                 ;
    CLR          0x24                 ;
    CLR          0x21                 ;
    CLR          0x22                 ;
    JMP          func_12a4_00a3       ;

func_12a4_009f:                       ;
    MOV          A,     0x21          ;
    MOV          0x23,  A             ;
    MOV          A,     0x22          ;
    MOV          0x24,  A             ;
func_12a4_00a3:                       ;
    MOV          A,     #0x18         ;
    CALL         func_0c28            ;
    MOV          A,     #0x10         ;
    CALL         func_0c2c            ; write UDR0 #0x10 at UDP0 #0x18
    MOV          A,     #0x19         ;
    CALL         func_0c28            ;
    MOV          A,     0x23          ;
    CALL         func_0c2c            ; write UDR0 0x23 at UDP0 #0x19
    MOV          A,     #0x1a         ;
    CALL         func_0c28            ;
    MOV          A,     0x24          ;
    CALL         func_0c2c            ; write UDR0 0x24 at UDP0 #0x1a
    MOV          A,     #0x03         ;
    B0MOV        UE2R_C,A             ;
    MOV          A,     #0xa0         ;
    B0MOV        UE2R,  A             ;
    RET                               ;

func_12a4_00b4:                       ;
    BTS0         0x13.6               ;
    JMP          func_12a4_00be       ;
    MOV          A,     0x3e          ;
    B0BTS0       FZ                   ;
    JMP          func_12a4_00ba       ;
    DECMS        0x3e                 ;
func_12a4_00ba:                       ;
    JMP          func_12a4_00dd       ;
    B0MOV        A,     0x73          ;
    B0MOV        0x3e,  A             ;
    JMP          func_12a4_00cc       ;

func_12a4_00be:                       ;
    BCLR         0x13.6               ;
    B0MOV        A,     0x73          ;
    B0MOV        0x3e,  A             ;
    BTS1         0x13.1               ;
    JMP          func_12a4_00cc       ;
    MOV          A,     0x28          ;
    B0BTS1       FZ                   ;
    JMP          func_12a4_00c9       ;
    MOV          A,     0x29          ;
    B0BTS0       FZ                   ;
    RET                               ;
func_12a4_00c9:                       ;
    CLR          0x28                 ;
    CLR          0x29                 ;
    JMP          func_12a4_00cc       ;

func_12a4_00cc:                       ;
    MOV          A,     #0x18         ;
    CALL         func_0c28            ;
    MOV          A,     #0x15         ;
    CALL         func_0c2c            ; write UDR0 #0x15 at UDP0 #0x18 
    MOV          A,     #0x19         ;
    CALL         func_0c28            ;
    MOV          A,     0x28          ;
    CALL         func_0c2c            ; write UDR0 0x28 at UDP0 #0x19
    MOV          A,     #0x1a         ;
    CALL         func_0c28            ;
    MOV          A,     0x29          ;
    CALL         func_0c2c            ; write UDR0 0x29 at UDP0 #0x1a
    MOV          A,     #0x03         ;
    B0MOV        UE2R_C,A             ;
    MOV          A,     #0xa0         ;
    B0MOV        UE2R,  A             ;
    RET                               ;

func_12a4_00dd:                       ;
    BTS0         0x13.7               ;
    JMP          func_12a4_00e7       ;
    MOV          A,     0x3c          ;
    B0BTS0       FZ                   ;
    JMP          func_12a4_00e3       ;
    DECMS        0x3c                 ;
func_12a4_00e3:                       ;
    RET                               ;
    B0MOV        A,     0x71          ;
    B0MOV        0x3c,  A             ;
    JMP          func_12a4_00f6       ;

func_12a4_00e7:                       ;
    BCLR         0x13.7               ;
    B0MOV        A,     0x71          ;
    B0MOV        0x3c,  A             ;
    BTS1         0x13.1               ;
    JMP          func_12a4_00f6       ;
    BCLR         0x13.1               ;
    MOV          A,     0x2a          ;
    B0BTS1       FZ                   ;
    JMP          func_12a4_00f3       ;
    MOV          A,     0x2b          ;
    B0BTS0       FZ                   ;
    RET                               ;
func_12a4_00f3:                       ;
    CLR          0x2a                 ;
    CLR          0x2b                 ;
    JMP          func_12a4_00f6       ;

func_12a4_00f6:                       ;
    MOV          A,     #0x18         ;
    CALL         func_0c28            ;
    MOV          A,     #0x11         ;
    CALL         func_0c2c            ; write UDR0 #0x11 at UDP0 #0x18
    MOV          A,     #0x19         ;
    CALL         func_0c28            ;
    MOV          A,     0x2a          ;
    CALL         func_0c2c            ; write UDR0 0x2a at UDP0 #0x19
    MOV          A,     #0x1a         ;
    CALL         func_0c28            ;
    MOV          A,     0x2b          ;
    CALL         func_0c2c            ; write UDR0 0x2b at UDP0 #0x1a
    MOV          A,     #0x03         ;
    B0MOV        UE2R_C,A             ;
    MOV          A,     #0xa0         ;
    B0MOV        UE2R,  A             ;
    RET                               ;
    DW           0x2d00               ; DW | 0x2d00 | -. |
    DW           0x2f9b               ; DW | 0x2f9b | /. |
    DW           0x2d80               ; DW | 0x2d80 | -. |
    DW           0x2f9a               ; DW | 0x2f9a | /. |
    DW           0x0e00               ; DW | 0x0e00 | .. |
ORG              0x2700               ;
func_2700:                            ;
    B0BTS1       FSUSPEND             ;
    RET                               ;
    B0MOV        Y,     #0x00         ;
    B0MOV        Z,     #0x00         ;
    B0MOV        R,     #0x01         ;
func_2700_0005:                       ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    B0BTS1       FSUSPEND             ;
    RET                               ;
    B0BTS1       0x59.4               ;
    RET                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    DECMS        Z                    ;
    JMP          func_2700_0005       ;
    DECMS        Y                    ;
    JMP          func_2700_0005       ;
    DECMS        R                    ;
    JMP          func_2700_0005       ;
    RET                               ;

func_0a02_1d1e:                       ;
    B0BSET       0x64.2               ;
    B0BCLR       P0.1                 ;
    B0BCLR       FGIE                 ;
    B0BCLR       FDP_PU_EN            ;
    MOV          A,     #0x04         ;
    B0MOV        UPID,  A             ;
    MOV          A,     #0x64         ;
    CALL         func_0146            ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    MOV          A,     #0x64         ;
    CALL         func_0146            ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    MOV          A,     #0x64         ;
    CALL         func_0146            ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    MOV          A,     #0x64         ;
    CALL         func_0146            ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    MOV          A,     #0x64         ;
    CALL         func_0146            ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    MOV          A,     #0xfc         ;
    CALL         func_06aa            ;
    JMP          _label_006e          ;
ORG              0x27f0               ;
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xa720               ; DW | 0xa720 | .  |
    DW           0xaaaa               ; DW | 0xaaaa | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
    DW           0xffff               ; DW | 0xffff | .. |
_reset_2880:                          ;
    B0BCLR       FGIE                 ;
    NOP                               ;
    NOP                               ;
    B0MOV        Y,     #0x27         ;
    B0MOV        Z,     #0xff         ; Z = #0xff (Real: + 0x05a0 = 0x2d9f)
    MOVC                              ; memoOVC at Y const 27, Z const ff
    CMPRS        A,     #0xaa         ;
    JMP          _reset_289e          ;
    B0MOV        A,     R             ;
    CMPRS        A,     #0xaa         ;
    JMP          _reset_289e          ;
    JMP          _reset_0010          ;
    DW           0x0300               ; DW | 0x0300 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x3412               ; DW | 0x3412 | 4. |
    DW           0x7856               ; DW | 0x7856 | xV |
_reset_2890:                          ;
    B0BCLR       FGIE                 ;
    MOV          A,     #0x7f         ;
    B0MOV        STKP,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        RBANK, A             ;
    CLR          INTRQ                ;
    CLR          0x3a                 ;
    CLR          0x3c                 ;
    CLR          0x3b                 ;
    CLR          0x1a                 ;
    B0BSET       0x0d.0               ;
    B0MOV        A,     UDA           ; 
    AND          A,     #0x7f         ; 0x0e = UDA value AND 01111111
    B0MOV        0x0e,  A             ; 0x0e point
_reset_289e:                          ;
    MOV          A,     #0x7f         ;
    B0MOV        STKP,  A             ;
    CLR          0x3a                 ;
    CLR          0x3c                 ;
    CLR          0x3b                 ;
    CLR          0x1a                 ;
    B0BTS1       FUDE                 ;
    JMP          _reset_28ba          ;
    B0BTS1       FDP_PU_EN            ;
    JMP          _reset_28ba          ;
    CLR          INTEN                ;
    CLR          INTRQ                ;
    CLR          INTEN1               ;
    CLR          INTRQ1               ;
    B0BCLR       FEP1NAK_INT_EN       ;
    B0BCLR       FEP2NAK_INT_EN       ;
    B0BCLR       FEP3NAK_INT_EN       ;
    B0BCLR       FEP4NAK_INT_EN       ;
    B0BCLR       FSOF_INT_EN          ;
    MOV          A,     #0x80         ;
    B0MOV        UE1R,  A             ;
    B0MOV        UE2R,  A             ;
    B0MOV        UE3R,  A             ;
    B0MOV        UE4R,  A             ;
    B0BCLR       FUSBIRQ              ;
    B0BSET       FUSBIEN              ;
    B0BCLR       0x1a.1               ;
    JMP          _reset_2904          ;
_reset_28ba:                          ;
    CLR          UDA                  ;
    CLR          USTATUS              ;
    CLR          EP_ACK               ;
    MOV          A,     #0x00         ;
    B0MOV        UE0R,  A             ; set UE0R 0
    B0MOV        UE1R,  A             ; set UE1R 0
    B0MOV        UE2R,  A             ; set UE2R 0
    B0MOV        UDP0,  A             ; set UDP0 0
    B0MOV        UDR0_R,A             ; set UDR0_R 0
    B0MOV        UDR0_W,A             ; set UDR0_W 0
    B0MOV        EP0OUT_CNT,A         ; set EP0OUT_CNT 0
    B0MOV        UE1R_C,A             ; set UE1R_C 0
    MOV          A,     #0x02         ;
    B0MOV        UPID,  A             ;
    B0BCLR       0x0b.2               ;
    CLR          0x11                 ;
    CLR          0x12                 ;
    CLR          0x13                 ;
    CLR          0x14                 ;
    CLR          0x1a                 ;
    CLR          0x0d                 ;
    CLR          0x19                 ;
    MOV          A,     #0x00         ;
    B0MOV        0x09,  A             ;
    B0MOV        0x0a,  A             ;
    B0MOV        0x16,  A             ;
    B0MOV        0x17,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x18,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x0b,  A             ;
    MOV          A,     #0x7f         ;
    B0MOV        STKP,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        P0M,   A             ;
    MOV          A,     #0xff         ;
    B0MOV        P0,    A             ;
    B0MOV        P0UR,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        P1M,   A             ;
    MOV          A,     #0xff         ;
    B0MOV        P1,    A             ;
    B0MOV        P1UR,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        P2M,   A             ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    MOV          A,     #0xff         ;
    B0MOV        P2,    A             ;
    B0MOV        P2UR,  A             ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    MOV          A,     #0x00         ;
    B0MOV        0xc3,  A             ;
    MOV          A,     #0xff         ;
    B0MOV        0xd3,  A             ;
    B0MOV        0xe3,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        P4M,   A             ;
    MOV          A,     #0xff         ;
    B0MOV        P4,    A             ;
    B0MOV        P4UR,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        P5M,   A             ;
    MOV          A,     #0xff         ;
    B0MOV        P5,    A             ;
    B0MOV        P5UR,  A             ;
    B0BCLR       FGIE                 ;
    B0BCLR       FUSBIRQ              ;
    B0BSET       FUSBIEN              ;
    B0BSET       FUDE                 ;
    B0BSET       FDP_PU_EN            ;
_reset_2904:                          ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    B0BTS0       0x0b.4               ;
    CALL         func_2934            ;
    B0BTS0       FUSBIRQ              ;
    CALL         func_290f            ;
    B0BTS0       0x3a.1               ;
    CALL         func_2b7a            ;
    B0BTS0       0x3b.7               ;
    JMP          _reset_2c9f          ;
    JMP          _reset_2904          ;

func_290f:                            ;
    B0BTS1       FUSBIRQ              ;
    JMP          func_290f_0015       ;
    B0BCLR       FUSBIRQ              ;
    B0BTS0       FSUSPEND             ;
    B0BSET       0x0b.4               ;
    B0BTS0       FBUS_RST             ;
    JMP          func_290f_0016       ;
    B0BTS0       FEP0SETUP            ;
    JMP          func_290f_002c       ;
    B0BTS0       FEP0IN               ;
    JMP          func_290f_0050       ;
    B0BTS0       FEP0OUT              ;
    JMP          func_290f_0068       ;
    B0BTS0       FEP1_ACK             ;
    JMP          func_290f_0027       ;
    B0BTS0       FEP2_ACK             ;
    JMP          func_290f_0027       ;
    B0BTS0       FEP3_ACK             ;
    JMP          func_290f_0027       ;
    B0BTS0       FEP4_ACK             ;
    JMP          func_290f_0027       ;
func_290f_0015:                       ;
    RET                               ;

func_290f_0016:                       ;
    MOV          A,     #0x80         ;
    B0MOV        UDA,   A             ;
    CLR          UDP0                 ;
    CLR          UDR0_R               ; Clear UDR0_R
    CLR          UDR0_W               ; Clear UDR0_W
    B0BCLR       0x0b.1               ;
    B0BCLR       0x0b.2               ;
    B0BCLR       0x0b.4               ;
    CLR          0x0d                 ;
    CLR          USTATUS              ;
    CLR          EP0OUT_CNT           ;
    MOV          A,     #0x00         ;
    B0MOV        UE0R,  A             ;
    B0MOV        UE1R,  A             ;
    JMP          func_290f_0015       ;

func_2934:                            ;
    B0BCLR       0x0b.4               ;
    RET                               ;

func_290f_0027:                       ;
    B0BCLR       FEP1_ACK             ;
    B0BCLR       FEP2_ACK             ;
    B0BCLR       FEP3_ACK             ;
    B0BCLR       FEP4_ACK             ;
    JMP          func_290f_0015       ;

func_290f_002c:                       ;
    B0BCLR       FEP0SETUP            ;
    B0BCLR       FUE0M0               ;
    MOV          A,     #0x00         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x01,  A             ;
    MOV          A,     #0x01         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x02,  A             ;
    MOV          A,     #0x02         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x04,  A             ;
    MOV          A,     #0x03         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x03,  A             ;
    MOV          A,     #0x04         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x06,  A             ;
    MOV          A,     #0x05         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x05,  A             ;
    MOV          A,     #0x06         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x08,  A             ;
    MOV          A,     #0x07         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x07,  A             ;
    CALL         func_2a21            ;
    JMP          func_290f_0015       ;

func_290f_0050:                       ;
    B0BCLR       FEP0IN               ;
    B0BTS0       0x3a.0               ;
    JMP          func_290f_0062       ;
    B0BTS0       0x0b.2               ;
    JMP          func_290f_005b       ;
    B0BTS1       0x0b.1               ;
    JMP          func_290f_005b       ;
    B0MOV        A,     0x0e          ;
    OR           A,     #0x80         ;
    B0MOV        UDA,   A             ;
    B0BSET       0x0b.2               ;
func_290f_005b:                       ;
    B0MOV        A,     0x07          ;
    OR           A,     0x08          ;
    B0BTS0       FZ                   ;
    JMP          func_290f_0067       ;
    B0BTS0       0x01.7               ;
    JMP          func_290f_0065       ;
    JMP          func_290f_0067       ;

func_290f_0062:                       ;
    B0BSET       0x3a.1               ;
    B0BCLR       0x3a.0               ;
    JMP          func_290f_0067       ;

func_290f_0065:                       ;
    CALL         func_29c9            ;
    JMP          func_290f_0067       ;

func_290f_0067:                       ;
    JMP          func_290f_0015       ;

func_290f_0068:                       ;
    B0BCLR       FEP0OUT              ;
    B0BTS0       0x1a.0               ;
    JMP          func_290f_0070       ;
    B0BTS0       0x1a.1               ;
    JMP          func_290f_0076       ;
    B0BTS0       0x1a.2               ;
    JMP          func_290f_0099       ;
    JMP          func_290f_009b       ;

func_290f_0070:                       ;
    B0BCLR       0x1a.0               ;
    MOV          A,     #0x00         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    MOV          0x19,  A             ;
    JMP          func_290f_009b       ;

func_290f_0076:                       ;
    MOV          A,     #0x00         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x1b,  A             ;
    MOV          A,     #0x01         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x1c,  A             ;
    MOV          A,     #0x02         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x1d,  A             ;
    MOV          A,     #0x03         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x1e,  A             ;
    MOV          A,     #0x04         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x1f,  A             ;
    MOV          A,     #0x05         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x20,  A             ;
    MOV          A,     #0x06         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x21,  A             ;
    MOV          A,     #0x07         ;
    CALL         func_2a15            ;
    CALL         func_2a19            ;
    B0MOV        0x22,  A             ;
    B0BCLR       0x1a.1               ;
    B0BSET       0x3a.0               ;
    JMP          func_290f_009b       ;

func_290f_0099:                       ;
    B0BCLR       0x1a.2               ;
    B0BSET       0x3a.2               ;
func_290f_009b:                       ;
    MOV          A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          func_290f_0015       ;

func_29ad:                            ;
    MOV          A,     0x13          ;
    SUB          A,     #0x01         ;
    MOV          0x13,  A             ;
    B0BTS0       FC                   ;
    JMP          func_29ad_0008       ;
    MOV          A,     0x14          ;
    SUB          A,     #0x01         ;
    MOV          0x14,  A             ;
func_29ad_0008:                       ;
    B0BTS1       FC                   ;
    CLR          0x14                 ;
    RET                               ;

func_29b8:                            ;
    MOV          A,     0x07          ;
    SUB          A,     0x14          ;
    B0BTS0       FC                   ;
    JMP          func_29b8_0005       ;
    JMP          func_29b8_000c       ;

func_29b8_0005:                       ;
    MOV          A,     0x07          ;
    CMPRS        A,     0x14          ;
    JMP          func_29b8_0010       ;
    MOV          A,     0x08          ;
    SUB          A,     0x13          ;
    B0BTS0       FC                   ;
    JMP          func_29b8_0010       ;
func_29b8_000c:                       ;
    MOV          A,     0x07          ;
    MOV          0x14,  A             ;
    MOV          A,     0x08          ;
    MOV          0x13,  A             ;
func_29b8_0010:                       ;
    RET                               ;

func_29c9:                            ;
    MOV          A,     0x12          ;
    MOV          Y,     A             ;
    MOV          A,     0x11          ;
    MOV          Z,     A             ;
    CALL         func_29b8            ;
    MOV          A,     #0x08         ;
    MOV          0x15,  A             ;
    MOV          A,     #0x00         ;
    CALL         func_2a1b            ;
    MOV          A,     0x14          ;
    CMPRS        A,     #0x00         ;
    JMP          func_29c9_002f       ;
    MOV          A,     0x13          ;
    B0BTS1       FZ                   ;
    JMP          func_29c9_0012       ;
    MOV          A,     #0xf0         ;
    AND          UE0R,  A             ;
    JMP          func_29c9_004a       ;

func_29c9_0012:                       ;
    MOV          A,     0x13          ;
    SUB          A,     #0x08         ;
    B0BTS0       FC                   ;
    JMP          func_29c9_002f       ;
    MOV          A,     #0xf0         ;
    AND          UE0R,  A             ;
    MOV          A,     0x13          ;
    OR           UE0R,  A             ;
func_29c9_001a:                       ;
    MOVC                              ; memoOVC at Y v-c, Z v-c,
    CALL         func_2a1f            ; write UDR0_W ? at UDP ?
    MOV          A,     #0x01         ;
    CALL         func_2a1d            ;
    B0BTS1       0x0b.5               ;
    JMP          func_29c9_0027       ;
    MOV          A,     R             ;
    CALL         func_2a1f            ; write UDR0_W ? at UDP ?
    MOV          A,     #0x01         ;
    CALL         func_2a1d            ;
    DECMS        0x13                 ;
    JMP          func_29c9_0027       ;
    JMP          func_29c9_004a       ;

func_29c9_0027:                       ;
    MOV          A,     #0x01         ;
    ADD          Z,     A             ;
    B0BTS0       FC                   ;
    ADD          Y,     A             ;
    B0BCLR       FC                   ;
    DECMS        0x13                 ;
    JMP          func_29c9_001a       ;
    JMP          func_29c9_004a       ;

func_29c9_002f:                       ;
    MOVC                              ; memoOVC, Y = ?, Z = ? 
    CALL         func_2a1f            ; write UDR0_W ? at UDP ?
    MOV          A,     #0x01         ;
    CALL         func_2a1d            ;
    B0BTS1       0x0b.5               ;
    JMP          func_29c9_003b       ;
    MOV          A,     R             ;
    CALL         func_2a1f            ; write UDR0_W ? at UDP ?
    MOV          A,     #0x01         ;
    CALL         func_2a1d            ;
    CALL         func_29ad            ;
    DECMS        0x15                 ; 0x15 POINT 3
func_29c9_003b:                       ;
    MOV          A,     #0x01         ;
    ADD          Z,     A             ;
    B0BTS0       FC                   ;
    ADD          Y,     A             ;
    B0BCLR       FC                   ;
    INCMS        0x11                 ;
    JMP          func_29c9_0043       ;
    INCMS        0x12                 ; 0x12 = 0x12 + 1
func_29c9_0043:                       ;
    CALL         func_29ad            ;
    DECMS        0x15                 ; 0x15 POINT 4
    JMP          func_29c9_002f       ;
    MOV          A,     #0xf0         ;
    AND          UE0R,  A             ;
    MOV          A,     #0x08         ;
    OR           UE0R,  A             ;
func_29c9_004a:                       ;
    B0BSET       FUE0M0               ;
    RET                               ;

func_2a15:                            ;
    B0MOV        UDP0,  A             ;
    RET                               ;
    DW           0x13a3               ; DW | 0x13a3 | .. |
    DW           0x0e00               ; DW | 0x0e00 | .. |

func_2a19:                            ;
    B0MOV        A,     UDR0_R        ;
    RET                               ;

func_2a1b:                            ;
    B0MOV        UDP0,  A             ;
    RET                               ;

func_2a1d:                            ;
    ADD          UDP0,  A             ;
    RET                               ;

func_2a1f:                            ;
    B0MOV        UDR0_W,A             ;
    RET                               ;

func_2a21:                            ;
    B0MOV        A,     0x01          ;
    AND          A,     #0x60         ;
    CMPRS        A,     #0x20         ;
    JMP          func_2a21_0005       ;
    JMP          func_2a21_00b6       ;

func_2a21_0005:                       ;
    AND          A,     #0x60         ;
    B0BTS1       FZ                   ;
    JMP          func_2a21_0110       ;
    B0MOV        A,     0x02          ;
    AND          A,     #0x0f         ;
    ADD          PCL,   A             ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_001c       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0044       ;
    JMP          func_2a21_004a       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_00a7       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    JMP          func_2a21_0110       ;

func_2a21_001b:                       ;
    RET                               ;

func_2a21_001c:                       ;
    B0MOV        A,     0x01          ;
    AND          A,     #0x1f         ;
    CMPRS        A,     #0x00         ;
    JMP          func_2a21_0021       ;
    JMP          func_2a21_0025       ;

func_2a21_0021:                       ;
    CMPRS        A,     #0x02         ;
    JMP          func_2a21_0024       ;
    JMP          func_2a21_002f       ;

func_2a21_0024:                       ;
    JMP          func_2a21_0110       ;

func_2a21_0025:                       ;
    B0MOV        A,     0x04          ;
    CMPRS        A,     #0x01         ;
    JMP          func_2a21_0110       ;
    B0BSET       0x0b.3               ;
    MOV          A,     #0x00         ;
    CALL         func_2a15            ;
    CALL         func_2a1f            ; write UDR0_W #0x00 at UDP #0x00
    MOV          A,     #0x20         ;
    MOV          UE0R,  A             ;
    JMP          func_2a21_001b       ;

func_2a21_002f:                       ;
    B0MOV        A,     0x04          ;
    CMPRS        A,     #0x00         ;
    JMP          func_2a21_0110       ;
    B0MOV        A,     0x06          ;
    AND          A,     #0x03         ;
    ADD          PCL,   A             ;
    JMP          func_2a21_0039       ;
    JMP          func_2a21_003c       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;

func_2a21_0039:                       ;
    MOV          A,     #0x01         ;
    B0MOV        0x09,  A             ;
    JMP          func_2a21_0041       ;

func_2a21_003c:                       ;
    B0BTS1       0x0b.1               ;
    JMP          func_2a21_0110       ;
    MOV          A,     #0x01         ;
    B0MOV        0x0a,  A             ;
    JMP          func_2a21_0041       ;

func_2a21_0041:                       ;
    MOV          A,     #0x20         ;
    MOV          UE0R,  A             ;
    JMP          func_2a21_001b       ;

func_2a21_0044:                       ;
    B0BSET       0x0b.1               ;
    B0MOV        A,     0x04          ;
    B0MOV        0x0e,  A             ; 0x0e = 0x04
    MOV          A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          func_2a21_001b       ;

func_2a21_004a:                       ;
    B0BCLR       0x0b.5               ;
    B0MOV        A,     0x03          ;
    CMPRS        A,     #0x01         ;
    JMP          func_2a21_0058       ;
    MOV          A,     #0x12         ;
    B0MOV        0x13,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x14,  A             ;
    MOV          A,     #0x34         ;
    B0MOV        0x11,  A             ;
    MOV          A,     #0x2b         ;
    B0MOV        0x12,  A             ; 0x12.0 = 1, 0x12.1 = 0, 0x12.2 = 1, 0x12.3 = 0, 0x12.4 = 1, 0x12.5 = 1, 0x12.6 = 0, 0x12.7 = 0 
    CALL         func_29c9            ;
    JMP          func_2a21_00a4       ;

func_2a21_0058:                       ;
    B0BCLR       0x0b.5               ;
    CMPRS        A,     #0x02         ;
    JMP          func_2a21_0065       ;
    MOV          A,     #0x22         ;
    B0MOV        0x13,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x14,  A             ;
    MOV          A,     #0x46         ;
    B0MOV        0x11,  A             ;
    MOV          A,     #0x2b         ;
    B0MOV        0x12,  A             ; 0x12.0 = 1, 0x12.1 = 0, 0x12.2 = 1, 0x12.3 = 0, 0x12.4 = 1, 0x12.5 = 1, 0x12.6 = 0, 0x12.7 = 0 
    CALL         func_29c9            ;
    JMP          func_2a21_00a4       ;

func_2a21_0065:                       ;
    B0BSET       0x0b.5               ;
    CMPRS        A,     #0x03         ;
    JMP          func_2a21_007f       ;
    NOP                               ;
    MOV          A,     #0x07         ;
    AND          A,     0x04          ;
    B0ADD        PCL,   A             ;
    JMP          func_2a21_0075       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;

func_2a21_0075:                       ;
    MOV          A,     #0x04         ;
    B0MOV        0x13,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x14,  A             ;
    MOV          A,     #0x78         ;
    B0MOV        0x11,  A             ;
    MOV          A,     #0x2b         ;
    B0MOV        0x12,  A             ; 0x12.0 = 1, 0x12.1 = 0, 0x12.2 = 1, 0x12.3 = 0, 0x12.4 = 1, 0x12.5 = 1, 0x12.6 = 0, 0x12.7 = 0
    CALL         func_29c9            ;
    JMP          func_2a21_00a4       ;

func_2a21_007f:                       ;
    B0BCLR       0x0b.5               ;
    CMPRS        A,     #0x21         ;
    JMP          func_2a21_0090       ;
    B0MOV        A,     0x06          ;
    CMPRS        A,     #0x00         ;
    JMP          func_2a21_0110       ;
    JMP          $+1                  ;
    MOV          A,     #0x09         ;
    B0MOV        0x13,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x14,  A             ;
    MOV          A,     #0x58         ;
    B0MOV        0x11,  A             ;
    MOV          A,     #0x2b         ;
    B0MOV        0x12,  A             ; 0x12.0 = 1, 0x12.1 = 0, 0x12.2 = 1, 0x12.3 = 0, 0x12.4 = 1, 0x12.5 = 1, 0x12.6 = 0, 0x12.7 = 0
    CALL         func_29c9            ;
    JMP          func_2a21_00a4       ;

func_2a21_0090:                       ;
    B0BSET       0x0b.5               ;
    CMPRS        A,     #0x22         ;
    JMP          func_2a21_00a3       ;
    MOV          A,     #0x01         ;
    B0MOV        0x18,  A             ;
    B0MOV        A,     0x06          ;
    CMPRS        A,     #0x00         ;
    JMP          func_2a21_0110       ;
    JMP          $+1                  ;
    MOV          A,     #0x1f         ;
    B0MOV        0x13,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x14,  A             ;
    MOV          A,     #0x68         ;
    B0MOV        0x11,  A             ;
    MOV          A,     #0x2b         ;
    B0MOV        0x12,  A             ; 0x12.0 = 1, 0x12.1 = 0, 0x12.2 = 1, 0x12.3 = 0, 0x12.4 = 1, 0x12.5 = 1, 0x12.6 = 0, 0x12.7 = 0
    CALL         func_29c9            ;
    JMP          func_2a21_00a4       ;

func_2a21_00a3:                       ;
    CALL         func_2a21_0110       ;

func_2a21_00a4:                       ;
    JMP          func_2a21_001b       ;
    DW           0xeb31               ; DW | 0xeb31 | .1 |
    DW           0xaa3c               ; DW | 0xaa3c | .< |

func_2a21_00a7:                       ;
    CLR          0x09                 ;
    CLR          0x0a                 ;
    B0BTS1       0x0b.1               ;
    JMP          func_2a21_00b2       ;
    B0MOV        A,     0x04          ;
    B0MOV        0x0d,  A             ;
    MOV          A,     #0x80         ;
    B0MOV        UE1R,  A             ;
func_2a21_00af:                       ;
    MOV          A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          func_2a21_001b       ;

func_2a21_00b2:                       ;
    B0MOV        A,     0x0d          ;
    CMPRS        A,     0x04          ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_00af       ;

func_2a21_00b6:                       ;
    B0MOV        A,     0x02          ;
    AND          A,     #0x0f         ;
    ADD          PCL,   A             ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_00c9       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_00fd       ;
    JMP          func_2a21_0110       ;
    JMP          func_2a21_0110       ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    JMP          func_2a21_0110       ;

func_2a21_00c9:                       ;
    B0MOV        A,     0x01          ;
    CMPRS        A,     #0xa1         ;
    JMP          func_2a21_0110       ;
    B0MOV        A,     0x03          ;
    CMPRS        A,     #0x01         ;
    JMP          func_2a21_00d0       ;
    JMP          func_2a21_00d4       ;

func_2a21_00d0:                       ;
    CMPRS        A,     #0x03         ;
    JMP          func_2a21_00d3       ;
    JMP          func_2a21_00d9       ;

func_2a21_00d3:                       ;
    JMP          func_2a21_0110       ;

func_2a21_00d4:                       ;
    B0MOV        A,     0x08          ;
    AND          A,     #0x0f         ;
    OR           A,     #0x20         ;
    B0MOV        UE0R,  A             ;
    JMP          func_2a21_001b       ;

func_2a21_00d9:                       ;
    MOV          A,     #0x00         ;
    B0MOV        UDP0,  A             ;
    MOV          A,     0x23          ;
    B0MOV        UDR0_W,A             ; Write UDR0 0x23 at UDP0 #0x00
    MOV          A,     #0x01         ;
    B0MOV        UDP0,  A             ;
    MOV          A,     0x24          ;
    B0MOV        UDR0_W,A             ; Write UDR0 0x24 at UDP0 #0x01
    MOV          A,     #0x02         ;
    B0MOV        UDP0,  A             ;
    MOV          A,     0x25          ;
    B0MOV        UDR0_W,A             ; Write UDR0 0x25 at UDP0 #0x02
    MOV          A,     #0x03         ;
    B0MOV        UDP0,  A             ;
    MOV          A,     0x26          ;
    B0MOV        UDR0_W,A             ; Write UDR0 0x26 at UDP0 #0x03
    MOV          A,     #0x04         ;
    B0MOV        UDP0,  A             ;
    MOV          A,     0x27          ;
    B0MOV        UDR0_W,A             ; Write UDR0 0x27 at UDP0 #0x04
    MOV          A,     #0x05         ;
    B0MOV        UDP0,  A             ;
    MOV          A,     0x28          ;
    B0MOV        UDR0_W,A             ; Write UDR0 0x28 at UDP0 #0x05
    MOV          A,     #0x06         ;
    B0MOV        UDP0,  A             ;
    MOV          A,     0x29          ;
    B0MOV        UDR0_W,A             ; Write UDR0 0x29 at UDP0 #0x06
    MOV          A,     #0x07         ;
    B0MOV        UDP0,  A             ;
    MOV          A,     0x2a          ;
    B0MOV        UDR0_W,A             ; Write UDR0 0x2a at UDP0 #0x07
    B0BSET       0x1a.2               ;
    MOV          A,     #0x28         ;
    B0MOV        UE0R,  A             ;
    JMP          func_2a21_001b       ;

func_2a21_00fd:                       ;
    B0MOV        A,     0x01          ;
    CMPRS        A,     #0x21         ;
    JMP          func_2a21_0110       ;
    B0MOV        A,     0x03          ;
    CMPRS        A,     #0x02         ;
    JMP          func_2a21_0104       ;
    JMP          func_2a21_0108       ;

func_2a21_0104:                       ;
    CMPRS        A,     #0x03         ;
    JMP          func_2a21_0107       ;
    JMP          func_2a21_010c       ;

func_2a21_0107:                       ;
    JMP          func_2a21_0110       ;

func_2a21_0108:                       ;
    B0BSET       0x1a.0               ;
    MOV          A,     #0x20         ;
    MOV          UE0R,  A             ;
    JMP          func_2a21_001b       ;

func_2a21_010c:                       ;
    B0BSET       0x1a.1               ;
    B0BCLR       0x3a.0               ;
    B0BSET       FUE0M0               ;
    JMP          func_2a21_001b       ;

func_2a21_0110:                       ;
    MOV          A,     #0x40         ;
    B0MOV        UE0R,  A             ;
    RET                               ;
    DW           0x0012               ; DW | 0x0012 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0008               ; DW | 0x0008 | .. |
    DW           0x0045               ; DW | 0x0045 | .E |
    DW           0x000c               ; DW | 0x000c | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0075               ; DW | 0x0075 | .u |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x0002               ; DW | 0x0002 | .. |
    DW           0x0022               ; DW | 0x0022 | ." |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0080               ; DW | 0x0080 | .. |
    DW           0x0032               ; DW | 0x0032 | .2 |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x0004               ; DW | 0x0004 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x0021               ; DW | 0x0021 | .! |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0001               ; DW | 0x0001 | .. |
    DW           0x0022               ; DW | 0x0022 | ." |
    DW           0x001f               ; DW | 0x001f | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x0007               ; DW | 0x0007 | .. |
    DW           0x0005               ; DW | 0x0005 | .. |
    DW           0x0081               ; DW | 0x0081 | .. |
    DW           0x0003               ; DW | 0x0003 | .. |
    DW           0x0010               ; DW | 0x0010 | .. |
    DW           0x0000               ; DW | 0x0000 | .. |
    DW           0x00ff               ; DW | 0x00ff | .. |
    DW           0x0c05               ; DW | 0x0c05 | .. |
    DW           0x0109               ; DW | 0x0109 | .. |
    DW           0x01a1               ; DW | 0x01a1 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x8015               ; DW | 0x8015 | .. |
    DW           0x7f25               ; DW | 0x7f25 | .% |
    DW           0x0875               ; DW | 0x0875 | .u |
    DW           0x1095               ; DW | 0x1095 | .. |
    DW           0x0281               ; DW | 0x0281 | .. |
    DW           0x0009               ; DW | 0x0009 | .. |
    DW           0x8015               ; DW | 0x8015 | .. |
    DW           0x7f25               ; DW | 0x7f25 | .% |
    DW           0x0875               ; DW | 0x0875 | .u |
    DW           0x0895               ; DW | 0x0895 | .. |
    DW           0x02b1               ; DW | 0x02b1 | .. |
    DW           0x00c0               ; DW | 0x00c0 | .. |
    DW           0x0304               ; DW | 0x0304 | .. |
    DW           0x0409               ; DW | 0x0409 | .. |

func_2b7a:                            ;
    B0BCLR       0x3a.1               ;
    B0BTS1       0x3b.6               ;
    JMP          func_2b7a_0005       ;
    JMP          func_2b7a_002b       ;

func_2b7a_0004:                       ;
    RET                               ;

func_2b7a_0005:                       ;
    MOV          A,     0x1b          ;
    CMPRS        A,     #0x00         ;
    JMP          func_2b7a_0009       ;
    JMP          func_2b7a_0027       ;

func_2b7a_0009:                       ;
    MOV          A,     0x1b          ;
    SUB          A,     #0x0a         ;
    B0BTS1       FC                   ;
    JMP          func_2b7a_000e       ;
    JMP          func_2b7a_0027       ;

func_2b7a_000e:                       ;
    B0BCLR       0x3b.2               ;
    B0MOV        A,     0x1c          ;
    CMPRS        A,     #0xaa         ;
    JMP          func_2b7a_0027       ;
    B0MOV        A,     0x1d          ;
    CMPRS        A,     #0x55         ;
    JMP          func_2b7a_0027       ;
    B0MOV        A,     0x1e          ;
    CMPRS        A,     #0x00         ;
    JMP          func_2b7a_0019       ;
    JMP          func_2b7a_001b       ;

func_2b7a_0019:                       ;
    CMPRS        A,     #0x01         ;
    JMP          func_2b7a_0027       ;
func_2b7a_001b:                       ;
    B0MOV        A,     0x1b          ;
    B0ADD        PCL,   A             ;
    JMP          func_2b7a_0027       ;
    JMP          func_2b7a_0045       ;
    JMP          func_2b7a_005c       ;
    JMP          func_2b7a_0081       ;
    JMP          func_2b7a_0091       ;
    JMP          func_2b7a_00e9       ;
    JMP          func_2b7a_00fd       ;
    JMP          func_2b7a_0123       ;
    JMP          func_2b7a_013f       ;
    JMP          func_2b7a_019f       ;

func_2b7a_0027:                       ;
    CALL         func_2d2e            ;
    MOV          A,     #0xff         ;
    CALL         func_2d37            ;

func_2b7a_002a:                       ;
    JMP          func_2b7a_0004       ;

func_2b7a_002b:                       ;
    MOV          A,     0x2d          ;
    OR           A,     0x2e          ; 2epoints ()
    B0BTS0       FZ                   ;
    JMP          func_2b7a_0044       ;
    CALL         func_2d58            ;
    MOV          A,     #0x04         ;
    ADD          0x2c,  A             ;
    MOV          A,     0x2c          ;
    B0BTS0       FZ                   ;
    INCMS        0x2b                 ;
    NOP                               ;
    DECMS        0x2d                 ;
    JMP          func_2b7a_003e       ;
    JMP          $+1                  ;
    MOV          A,     0x2e          ; 2epoints ()
    B0BTS1       FZ                   ;
    JMP          func_2b7a_003e       ;
    B0BCLR       0x3b.6               ;
    JMP          func_2b7a_0044       ;

func_2b7a_003e:                       ;
    MOV          A,     0x2d          ;
    CMPRS        A,     #0xff         ;
    JMP          func_2b7a_0044       ;
    DECMS        0x2e                 ; 2epoints 
    NOP                               ;
    NOP                               ;
func_2b7a_0044:                       ;
    JMP          func_2b7a_0004       ;

func_2b7a_0045:                       ;
    CALL         func_2d2e            ;
    B0MOV        Y,     #0x28         ;
    B0MOV        Z,     #0x8c         ; (Real: + 0x05a0 = 0x2E2C) 
    MOVC                              ; memoOVC, Y = const 28, Z = const 8c
    B0MOV        0x42,  A             ;
    B0MOV        A,     R             ;
    B0MOV        0x43,  A             ;
    INCMS        Z                    ;
    NOP                               ;
    MOVC                              ; memoOVC, Y = c-v 28 + g, Z = c-v 8c + g.
    B0MOV        0x44,  A             ;
    B0MOV        A,     R             ;
    B0MOV        0x45,  A             ;
    B0MOV        A,     0x42          ;
    B0MOV        0x27,  A             ;
    B0MOV        A,     0x43          ;
    B0MOV        0x28,  A             ;
    B0MOV        A,     0x44          ;
    B0MOV        0x29,  A             ;
    B0MOV        A,     0x45          ;
    B0MOV        0x2a,  A             ;
    B0BSET       0x3c.0               ;
    JMP          func_2b7a_002a       ;

func_2b7a_005c:                       ;
    CALL         func_2d2e            ;
    B0BTS1       0x3c.0               ;
    JMP          func_2b7a_007d       ;
    B0MOV        Y,     #0x28         ;
    B0MOV        Z,     #0x8e         ;
    MOVC                              ; memoOVC at Y = const 28, Z = const 8e
    B0MOV        0x46,  A             ;
    B0MOV        A,     R             ;
    B0MOV        0x47,  A             ;
    INCMS        Z                    ;
    NOP                               ;
    MOVC                              ; memoOVC at Y = c-v 28 + g, Z = c-v 8e + g
    B0MOV        0x48,  A             ; 48point
    B0MOV        A,     R             ;
    B0MOV        0x49,  A             ;
    MOV          A,     0x1f          ;
    CMPRS        A,     0x46          ;
    JMP          func_2b7a_007a       ;
    MOV          A,     0x20          ;
    CMPRS        A,     0x47          ;
    JMP          func_2b7a_007a       ;
    MOV          A,     0x21          ;
    CMPRS        A,     0x48          ; 48point
    JMP          func_2b7a_007a       ;
    MOV          A,     0x22          ;
    CMPRS        A,     0x49          ;
    JMP          func_2b7a_007a       ;
    MOV          A,     #0xfa         ;
    B0BSET       0x3c.1               ;
    JMP          func_2b7a_007f       ;

func_2b7a_007a:                       ;
    MOV          A,     #0xfe         ;
    B0BCLR       0x3c.1               ;
    JMP          func_2b7a_007f       ;

func_2b7a_007d:                       ;
    B0BCLR       0x3c.1               ;
    MOV          A,     #0xfd         ;
func_2b7a_007f:                       ;
    CALL         func_2d37            ;
    JMP          func_2b7a_002a       ;

func_2b7a_0081:                       ;
    CALL         func_2d2e            ;
    B0BTS1       0x3c.1               ;
    JMP          func_2b7a_008d       ;
    MOV          A,     0x22          ;
    CMPRS        A,     #0x00         ;
    JMP          func_2b7a_008a       ;
    MOV          A,     #0xfa         ;
    B0BSET       0x3c.2               ;
    JMP          func_2b7a_008f       ;

func_2b7a_008a:                       ;
    MOV          A,     #0xfe         ;
    B0BCLR       0x3c.2               ;
    JMP          func_2b7a_008f       ;

func_2b7a_008d:                       ;
    MOV          A,     #0xfd         ;
    B0BCLR       0x3c.2               ;
func_2b7a_008f:                       ;
    CALL         func_2d37            ;
    JMP          func_2b7a_002a       ;

func_2b7a_0091:                       ;
    CALL         func_2d2e            ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    CLR          0x38                 ;
    CLR          0x39                 ;
    MOV          A,     #0x27         ;
    B0MOV        PEROMH,A             ;
    MOV          A,     #0xff         ;
    B0MOV        PEROML,A             ;
    MOV          A,     #0x38         ;
    B0MOV        PERAML,A             ;
    MOV          A,     #0x00         ;
    AND          A,     #0x07         ;
    OR           A,     #0x00         ;
    B0MOV        PERAMCNT,A           ;
    MOV          A,     #0x5a         ;
    B0MOV        PECMD, A             ;
    NOP                               ;
    NOP                               ;
    MOV          A,     0x1f          ;
    MOV          0x34,  A             ;
    MOV          A,     0x20          ;
    MOV          0x33,  A             ; 33points (mut) 0x33 = 0x20
    MOV          A,     0x21          ;
    MOV          0x35,  A             ;
    MOV          A,     0x22          ;
    MOV          0x36,  A             ;
    MOV          A,     0x34          ;
    OR           A,     0x33          ; 33points
    B0BTS1       FZ                   ;
    JMP          func_2b7a_00db       ;
    MOV          A,     #0x00         ;
    MOV          0x37,  A             ;
    CLR          Y                    ;
    CLR          Z                    ;
    MOVC                              ; memoOVC at Y = const 00, Z = const 00.
    B0MOV        0x3d,  A             ;
    B0MOV        A,     R             ;
    B0MOV        0x3e,  A             ;
    MOV          A,     #0x00         ;
    MOV          0x33,  A             ; 33points (mut) 0x33 = 0
    MOV          A,     #0x00         ;
    MOV          0x34,  A             ;
    CALL         func_2d4d            ;
    DECMS        0x35                 ;
    NOP                               ;
    B0MOV        A,     0x3d          ;
    B0MOV        0x1b,  A             ;
    B0MOV        A,     0x3e          ;
    B0MOV        0x1c,  A             ;
    CLR          0x1d                 ;
    CLR          0x1e                 ;
    CLR          0x1f                 ;
    CLR          0x20                 ;
    CLR          0x21                 ;
    CLR          0x22                 ;
    MOV          A,     #0x00         ;
    B0MOV        0x2b,  A             ;
    MOV          A,     #0x00         ;
    B0MOV        0x2c,  A             ;
    CALL         func_2d58            ;
    CLR          0x1b                 ;
    CLR          0x1c                 ;
    MOV          A,     #0x04         ;
    B0MOV        0x2c,  A             ;
    CALL         func_2d58            ;
    MOV          A,     #0x80         ;
    MOV          0x34,  A             ;
    MOV          A,     #0x00         ;
    MOV          0x33,  A             ; 33points
    MOV          A,     #0x00         ;
    CMPRS        A,     0x35          ;
    JMP          func_2b7a_00db       ;
    JMP          func_2b7a_00e5       ;

func_2b7a_00db:                       ;
    CALL         func_2d4d            ;
    MOV          A,     #0x80         ;
    ADD          0x34,  A             ;
    MOV          A,     0x34          ;
    CMPRS        A,     #0x80         ;
    INCMS        0x33                 ;
    NOP                               ;
    DECMS        0x35                 ;
    JMP          func_2b7a_00db       ;
    JMP          func_2b7a_00e5       ;

func_2b7a_00e5:                       ;
    B0BSET       0x3c.3               ;
    MOV          A,     #0xfa         ;
    CALL         func_2d37            ;
    JMP          func_2b7a_002a       ;

func_2b7a_00e9:                       ;
    CALL         func_2d2e            ;
    B0BTS1       0x3c.1               ;
    JMP          func_2b7a_00f8       ;
    MOV          A,     0x1f          ;
    MOV          0x2c,  A             ;
    MOV          A,     0x20          ;
    MOV          0x2b,  A             ;
    MOV          A,     0x21          ;
    MOV          0x2d,  A             ;
    MOV          A,     0x22          ;
    MOV          0x2e,  A             ; 2epoints
    B0BSET       0x3b.6               ;
    B0BSET       0x3c.4               ;
    MOV          A,     #0xfa         ;
    JMP          func_2b7a_00fb       ;

func_2b7a_00f8:                       ;
    B0BCLR       0x3b.6               ;
    B0BCLR       0x3c.4               ;
    MOV          A,     #0xfd         ;
func_2b7a_00fb:                       ;
    CALL         func_2d37            ;
    JMP          func_2b7a_002a       ;

func_2b7a_00fd:                       ;
    CALL         func_2d2e            ;
    B0BTS1       0x3c.1               ;
    JMP          func_2b7a_011c       ;
    B0MOV        Y,     #0x00         ;
    B0MOV        Z,     #0x00         ;
    CLR          0x40                 ;
    CLR          0x41                 ;
func_2b7a_0104:                       ;
    MOVC                              ; memoOVC, LOOP, start from Y const 00, Z const 00.
    B0ADD        0x40,  A             ;
    B0BTS0       FC                   ;
    INCMS        0x41                 ;
    NOP                               ;
    B0MOV        A,     R             ;
    B0ADD        0x40,  A             ;
    B0BTS0       FC                   ;
    INCMS        0x41                 ;
    NOP                               ;
    INCMS        Z                    ;
    NOP                               ;
    B0MOV        A,     Z             ;
    B0BTS0       FZ                   ;
    INCMS        Y                    ;
    NOP                               ;
    B0MOV        A,     Y             ;
    CMPRS        A,     #0x28         ;
    JMP          func_2b7a_0104       ;
    B0MOV        A,     Z             ;
    CMPRS        A,     #0x00         ;
    JMP          func_2b7a_0104       ;
    MOV          A,     #0xfa         ;
    JMP          func_2b7a_011d       ;

func_2b7a_011c:                       ;
    MOV          A,     #0xfd         ;
func_2b7a_011d:                       ;
    CALL         func_2d37            ;
    B0MOV        A,     0x40          ;
    B0MOV        0x29,  A             ;
    B0MOV        A,     0x41          ;
    B0MOV        0x2a,  A             ;
    JMP          func_2b7a_002a       ;

func_2b7a_0123:                       ;
    B0BSET       0x3b.7               ;
    JMP          func_2b7a_002a       ;
_reset_2c9f:                          ;
    B0BCLR       0x3b.7               ;
    B0BCLR       FGIE                 ;
    CLR          UDA                  ;
    CLR          INTRQ                ;
    CLR          INTEN                ;
    CLR          USTATUS              ;
    CLR          EP0OUT_CNT           ;
    MOV          A,     #0x80         ;
    B0MOV        USB_INT_EN,A         ;
    B0MOV        Y,     #0x00         ;
    B0MOV        Z,     #0x00         ;
_reset_2caa:                          ;
    MOV          A,     #0x00         ;
    B0MOV        @YZ,   A             ;
    INCMS        Z                    ;
    NOP                               ;
    B0MOV        A,     Z             ;
    CMPRS        A,     #0x80         ;
    JMP          _reset_2caa          ;
    B0MOV        Y,     #0xff         ;
_reset_2cb2:                          ;
    B0MOV        Z,     #0xff         ;
_reset_2cb3:                          ;
    DECMS        Z                    ;
    JMP          _reset_2cb3          ;
    DECMS        Y                    ;
    JMP          _reset_2cb2          ;
    CALL         func_2d3c            ;
    JMP          _reset               ;

func_2b7a_013f:                       ;
    CALL         func_2d2e            ;
    B0MOV        A,     0x1e          ;
    CMPRS        A,     #0x01         ;
    JMP          func_2b7a_0144       ;
    JMP          func_2b7a_014d       ;

func_2b7a_0144:                       ;
    B0MOV        A,     0x1f          ;
    B0MOV        0x52,  A             ;
    B0MOV        A,     0x20          ;
    B0MOV        0x53,  A             ;
    B0MOV        A,     0x21          ;
    B0MOV        0x54,  A             ;
    B0MOV        A,     0x22          ;
    B0MOV        0x55,  A             ;
    JMP          func_2b7a_019c       ;

func_2b7a_014d:                       ;
    B0MOV        A,     0x1f          ;
    B0MOV        0x56,  A             ;
    B0MOV        A,     0x20          ;
    B0MOV        0x57,  A             ;
    B0MOV        A,     0x21          ;
    B0MOV        0x58,  A             ;
    B0MOV        A,     0x22          ;
    B0MOV        0x59,  A             ;
    MOV          A,     #0x2f         ; 0x2f = #0x2f
    B0MOV        0x2f,  A             ; 2fpoints (B0)
    MOV          A,     #0xf8         ;
    B0MOV        0x30,  A             ;
    MOV          A,     #0x4a         ;
    CLR          0x5a                 ; 0x5a = 0
func_2b7a_015b:                       ; <----------------------------------+
    B0MOV        A,     0x2f          ; 2fpoints (B0)                      |
    B0MOV        Y,     A             ; Y = 0x2f                           |
    B0MOV        A,     0x30          ;                                    |
    B0MOV        Z,     A             ; Z = 0x30                           |
    MOVC                              ; memoOVC, loop Y v, Z v             |
    B0MOV        0x38,  A             ;                                    |
    B0MOV        A,     R             ;                                    |
    B0MOV        0x39,  A             ; 0x38 = Low bit, 0x39 = High bit    |
    CLR          Y                    ; Y = 0                              |
    MOV          A,     #0x4a         ;                                    |
    ADD          A,     0x5a          ;                                    |
    B0MOV        Z,     A             ; Z = 0x5a + #0x4a                   |
    MOV          A,     0x38          ;                                    |
    B0MOV        @YZ,   A             ; @YZ = 0x38                         |
    MOV          A,     #0x01         ;                                    |
    B0ADD        Z,     A             ; Z += 1                             |
    B0ADD        0x30,  A             ; 0x30 += 1                          |
    B0ADD        0x5a,  A             ;                                    |
    B0ADD        0x5a,  A             ; 0x5a += 2                          |
    MOV          A,     0x39          ;                                    |
    B0MOV        @YZ,   A             ; @YZ = 0x39                         |
    B0MOV        A,     0x30          ;                                    |
    CMPRS        A,     #0xfc         ;                                    |
    JMP          func_2b7a_015b       ; if 0x30 != #0xfc ------------------+
    MOV          A,     #0x2f         ; if 0x30 == #0xfc
    MOV          0x33,  A             ; 0x33 = #0x2f         33points
    MOV          A,     #0x80         ;
    MOV          0x34,  A             ; 0x34 = #0x80
    CALL         func_2d4d            ;
    CLR          0x1b                 ;
    CLR          0x1c                 ;
    CLR          0x1d                 ;
    CLR          0x1e                 ;
    CLR          0x1f                 ;
    CLR          0x20                 ;
    CLR          0x21                 ;
    CLR          0x22                 ;
    B0MOV        Y,     #0x2f         ;
    B0MOV        Z,     #0x80         ;
func_2b7a_0182:                       ;
    B0MOV        A,     Y             ;
    B0MOV        0x2b,  A             ;
    B0MOV        A,     Z             ;
    B0MOV        0x2c,  A             ;
    CALL         func_2d58            ;
    MOV          A,     #0x04         ;
    B0ADD        Z,     A             ;
    B0MOV        A,     Z             ;
    CMPRS        A,     #0xf8         ;
    JMP          func_2b7a_0182       ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    MOV          A,     #0x2f         ;
    B0MOV        PEROMH,A             ;
    MOV          A,     #0xf8         ;
    B0MOV        PEROML,A             ;
    MOV          A,     #0x4a         ;
    B0MOV        PERAML,A             ;
    MOV          A,     #0x00         ;
    AND          A,     #0x07         ;
    OR           A,     #0x38         ;
    B0MOV        PERAMCNT,A           ;
    MOV          A,     #0x5a         ;
    B0MOV        PECMD, A             ;
    NOP                               ;
    NOP                               ;
func_2b7a_019c:                       ;
    MOV          A,     #0xfa         ;
    CALL         func_2d37            ;
    JMP          func_2b7a_002a       ;

func_2b7a_019f:                       ;
    CALL         func_2d2e            ;
    B0MOV        A,     0x1e          ;
    CMPRS        A,     #0x01         ;
    JMP          func_2b7a_01a4       ;
    JMP          func_2b7a_01a7       ;

func_2b7a_01a4:                       ;
    B0MOV        Y,     #0x2f         ;
    B0MOV        Z,     #0xfc         ;
    JMP          func_2b7a_01a9       ;

func_2b7a_01a7:                       ;
    B0MOV        Y,     #0x2f         ;
    B0MOV        Z,     #0xfe         ;
func_2b7a_01a9:                       ;
    MOVC                              ; memoOVC, Y = const 2f or 2f, Z = const fc or fe.
    B0MOV        0x27,  A             ;
    B0MOV        A,     R             ;
    B0MOV        0x28,  A             ;
    INCMS        Z                    ;
    NOP                               ;
    MOVC                              ; memoOVC, Y = const 2f or 2f. Z = const fc + 1 or fe + 1.
    B0MOV        0x29,  A             ;
    B0MOV        A,     R             ;
    B0MOV        0x2a,  A             ;
    JMP          func_2b7a_002a       ;

func_2d2e:                            ;
    B0MOV        A,     0x1b          ;
    B0MOV        0x23,  A             ; 0x23 = 0x1b
    B0MOV        A,     0x1c          ;
    B0MOV        0x24,  A             ; 0x24 = 0x1c
    B0MOV        A,     0x1d          ;
    B0MOV        0x25,  A             ; 0x25 = 0x1d
    B0MOV        A,     0x1e          ;
    B0MOV        0x26,  A             ; 0x26 = 0x1e
    RET                               ;

func_2d37:                            ;
    B0MOV        0x27,  A             ;
    B0MOV        0x28,  A             ;
    B0MOV        0x29,  A             ;
    B0MOV        0x2a,  A             ;
    RET                               ;

func_2d3c:                            ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    NOP                               ;
    MOV          A,     #0xff         ;
    B0MOV        Z,     A             ;
func_2d3c_000e:                       ;
    DECMS        Z                    ;
    JMP          func_2d3c_000e       ;
    RET                               ;

func_2d4d:                            ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    MOV          A,     0x33          ; 33points
    B0MOV        PEROMH,A             ;
    MOV          A,     0x34          ;
    B0MOV        PEROML,A             ;
    MOV          A,     #0xc3         ;
    B0MOV        PECMD, A             ;
    NOP                               ;
    NOP                               ;
    RET                               ;

func_2d58:                            ;
    MOV          A,     #0x5a         ;
    B0MOV        WDTR,  A             ;
    MOV          A,     0x2b          ;
    B0MOV        PEROMH,A             ;
    MOV          A,     0x2c          ;
    B0MOV        PEROML,A             ;
    MOV          A,     #0x1b         ;
    B0MOV        PERAML,A             ;
    MOV          A,     #0x00         ;
    AND          A,     #0x07         ;
    OR           A,     #0x18         ;
    B0MOV        PERAMCNT,A           ;
    MOV          A,     #0x5a         ;
    B0MOV        PECMD, A             ;
    NOP                               ;
    NOP                               ;
    RET                               ;
ENDP                                  ;
