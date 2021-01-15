000100990324     H DECEDIT('0,')  DATEDIT(*DMY.)
000101110531      * #Type   = BNDRPG
000102110531      * #Glb    = DBGLB
000103110531      * #Commit = *NONE
000104110531      * #Fixnbr = *ZONED
000200110531      //*************************************************************************
000300110531      //  ÚTSKRIFT Á KORTUM SEM RENNA ÚT Í MÁNUÐINUM                            *
000400110531      //*                                                                       *
000500110531      //* SKRIFAÐ UPP ÚR FORRITI EFTIR GHB                                      *
000600110531      //* HARALDUR VÍÐISSON NÓV 1991                                            *
000700110531      //*                                                                       *
000800110531      //* BREYTT 30.01.1993 - GUÐM.J.JÓNSSON                                    *
000900110531      //*                     FERLI HF.                                         *
001000110531      //* BREYTT 21.09.2000 - Snorri Þórðarson                                  *
001100110531      //*   Bætti við kennitölu í listana og lagaði dálka í listunum            *
001200110531      //                                                                        *
001300110531      //  Breytt - 04.04.2001 - Guðm.J.Jónsson                                  *
001400110531      //           Sett '**' í RCKODI vegna síhringi merkinga í DBKMA           *
001500110531      //           Allar færslur sem ekki eru auðar í RCKODI , uppfæra          *
001600110531      //           DBKMA með síhringikóda( í forriti KRKRN7R).                  *
001700110531      //
001800110531      //  Breytt - 08.10.2001 - Guðm.J.Jónsson                                  *
001900110531      //           Member "S24" (banki 1113) bættt við                          *
002000110531      //------------------------------------------------------------------------*
002100110531      //  Breytt - 10.07.2002 - Guðm.J.Jónsson                                  *
002200110531      //           Taka síhringi kóta út hjá þeim korthöfum sem                 *
002300110531      //           eru skludlausir og fjv > 2                                   *
002400110531      //------------------------------------------------------------------------*
002500110531      //  Breytt - 02.01.2003 - Guðm.J.Jónsson                                  *
002600110531      //           Ýmsar lagfæringar v/brot á banka                             *
002700110531      //------------------------------------------------------------------------*
002800110531      //  Breytt - 03.05.2003 - Guðm.J.Jónsson                                  *
002900110531      //           Bætt við 19 memberum v/ýmisa sparisjóða .                    *
003000110531      //------------------------------------------------------------------------*
003100110531      //  Breytt - 23.06.2003 - Guðm.J.Jónsson                                  *
003200110531      //           Skuldaviðmiðum fyrir MC+ Íslandsbanka verði -3000kr.         *
003300110531      //------------------------------------------------------------------------*
003400110531      //  Breytt - 06.08.2003 - Guðm.J.Jónsson                                  *
003500110531      //           Member "NETB" (banki 1155) bættt við og                      *
003600110531      //           gerður að sér stofnun.                                       *
003700110531      //------------------------------------------------------------------------*
003800110531      //  Breytt - 11.08.2003 - Guðm.J.Jónsson                                  *
003900110531      //           Ekki skoða vanskilaskrá/lokunarskrá RB fyrir +kort           *
004000110531      //------------------------------------------------------------------------*
004100110531      //  Breytt - 12.08.2003 - GuðmþJ.Jónsson                                  *
004200110531      //           Ekk endurnýja +kort sem ekki hafa verið notuð                *
004300110531      //           (þ.e. það hefur aldrei komið innborgun).                     *
004400110531      //------------------------------------------------------------------------*
004500110531      //  Breytt - 21.05.2004 - Guðm.J.Jónsson                                  *
004600110531      //           Sækja upplýsingra um hvort megi taka síhringikóda af í       *
004700110531      //           skránna DBUMDSPL1.                                           *
004800110531      //------------------------------------------------------------------------*
004900110531      //  Breytt - 28.04.2005 - Guðm.J.Jónsson                                  *
005000110531      //           Fjöldi "greitt of seint" (fjrj1) til að taka af síhringikoda *
005100110531      //           af fjölgað úr 2 í 4.                                         *
005200110531      //------------------------------------------------------------------------*
005300110531      //  Breytt - 04.01.2006 - Guðm.J.Jónsson                                  *
005400110531      //           Korthafi má núna skulda tvo síðustu gíróseðla til að fá      *
005500110531      //           endurnýjun , einnig var viðmiðun á höfnun vegna fjölda "V"   *
005600110531      //           breytt í 99 í skránni DBRKRRN.                               *
005700110531      //------------------------------------------------------------------------*
005800110531      //  Breytt - 10.09.2008 - Guðm.J.Jónsson                                  *
005900110531      //           Nýr member fyrir Borgun og annað sem því fylgir.             *
005901110531      //------------------------------------------------------------------------*
005902110531      //  Breytt - 6.06.2011 - Haraldur Víðisson                                *
005903110531      //           Maska kortnúmer, einfalda endurnýjunarlista                  *
006000110531      //*************************************************************************
006100020708     FKRKRN1W   uF   E           K DISK
006200930205     FDBKM      IF   E           K DISK
006300010219     FDBSKc1    IF   E           K DISK
006400010219     FDBSK1     IF   E           K DISK
006500930130     FDBNI      IF   E           K DISK
006600930130     FDBRK      IF   E           K DISK
006700930206     FDBST      IF   E           K DISK
006800930130     FDBT2      IF   E           K DISK
006900930203     FDBUTB     IF   E           K DISK
007000930204     FDBRKRN    IF   E           K DISK
007100030812     FDBih      IF   E           K DISK
007200040521     fdbumdspl1 if   e           k disk
007300930130     FDBRCRD    O  A E           K DISK
007400930130     FDBGENPVV  O  A F   17        DISK
007500930218     FKRKRN1P   O    E             PRINTER OFLIND(*IN91)
007600930218     FKRKRN2P   O    E             PRINTER OFLIND(*IN92)
007601110531      /copy qrpgsrc,dbxdef
007700110531      //-------------------------------------------------------------------------------------------
007800930130     D T2              S              1    DIM(99)                              LOKUNARKÓDAR
007900930130     D T2A             S              1    DIM(99)                              AÐGERÐ PR LOKKÓDA
008000930130     D FJT2            S              7  0 DIM(99)                              FJÖLDI PR KÓDA
008100930130     D T2T             S             30    DIM(99)                              LOKUNARTEXTI
008200930130     D UTS             S             11  2 DIM(12)                              UTTEKTIR INNL+ERL.
008300001006     D IDNR            S             10A                                        Kennitala
008400001110     D IDNRGEYM        S             10A                                        Ktal geyma v/lista
008500001020     DKENN12           S             12A                                        v/RB-fyrirspurnar
008600001006     DSVARKODI         S              5A                                        v/RB-fyrirspurnar
008700001006     DTEGUND           S              1A                                        v/RB-fyrirspurnar
008800001006     DFJOLDI           S              2A                                        v/RB-fyrirspurnar
008900001128     DFJOLDA           S              2A                                        v/RB-fyrirspurnar
009000001128     DFJOLDB           S              2A                                        v/RB-fyrirspurnar
009100001130     DFJALKSKRA        S              7  0                                      Fj. á lokunarskrá
009200001130     DFJAVSSKRA        S              7  0                                      Fj. á vanskilaskrá
009300030623     dvidmid           s              5p 0                                      Skuldaviðmiðun
009400110531      //
009500060103     D#DAGS1           S               D                                        JULUDA
009600990324     D#DAGS            S               D                                        JULUDA
009700990324     D#EIND            S               D                                        JULDT1
009800990324     D#INBD            S               D                                        JULDT2
009900990324     D#EIND1           S               D                                        JULDT3
009901110531     DKMMED            S               N
009902110531     Dwrkcrdno         S             16A
009903110531     Dprtcrd           S             16A
010000110531      //
010100911120     D                 DS
010200970123     D  AUGILD                 1      8  0
010300990324     D   AUGOYM                1      6  0
010400990324     D    AUGOO                1      2  0
010500990324     D    AUGAA                3      4  0
010600990324     D    AUGMM                5      6  0
010700990324     D   AUGDD                 7      8  0
010800930202     D                 DS
010900990324     D  PGILD                  1      8  0
011000930202     D  PGDD                   1      2  0
011100930202     D  PGMM                   3      4  0
011200990324     D  PGOO                   5      6  0
011300990324     D  PGAA                   7      8  0
011400930202     D                 DS
011500990324     D  PGILD2                 1      8  0
011600930202     D  PGDD2                  1      2  0
011700930202     D  PGMM2                  3      4  0
011800990324     D  PGOO2                  5      6  0
011900990324     D  PGAA2                  7      8  0
012000930202     D                 DS
012100970123     D  PDGLO                  1      8  0
012200930202     D  PDDD                   1      2  0
012300930202     D  PDMM                   3      4  0
012400970123     D  PDOO                   5      6  0
012500970123     D  PDAA                   7      8  0
012600930202     D                 DS
012700990324     D  PGILD3                 1      8  0
012800930202     D  PGDD3                  1      2  0
012900930202     D  PGMM3                  3      4  0
013000990324     D  PGOO3                  5      6  0
013100990324     D  PGAA3                  7      8  0
013200911122     D                 DS
013400911122     D  AUKORT                 1     13
013500911122     D  AUKRTN                14     16  0
013600911121     D                 DS
013700990324     D  RKLGIR                 1      8  0
013800990324     D  RKOO                   1      2  0
013900990324     D  RKYY                   3      4  0
014000990324     D  RKMM                   5      6  0
014100990324     D  RKDD                   7      8  0
014200911121     D                 DS
014300990324     D  SKGJLD                 1      8  0
014400991220     D   SKGJOYM               1      6  0
014500991220     D    SKGJOY               1      4  0
014600991220     D     SKGJOO              1      2  0
014700991220     D     SKGJYM              3      6  0
014800991220     D      SKGJYY             3      4  0
014900991220     D      SKGJMM             5      6  0
015000990324     D   SKGJDD                7      8  0
015100010219     D                 DS
015200010219     D  ScGJLD                 1      8  0
015300010219     D   ScGJOYM               1      6  0
015400010219     D    ScGJOY               1      4  0
015500010219     D     ScGJOO              1      2  0
015600010219     D     ScGJYM              3      6  0
015700010219     D      ScGJYY             3      4  0
015800010219     D      ScGJMM             5      6  0
015900010219     D   ScGJDD                7      8  0
016000911125     D                 DS
016100990324     D  SKEIND                 1      8  0
016200990324     D   SKEIOYM               1      6  0
016300990324     D    SKEIOO               1      2  0
016400990324     D    SKEIYY               3      4  0
016500990324     D    SKEIMM               5      6  0
016600990324     D   SKEIDD                7      8  0
016700911125     D                 DS
016800990324     D  SKDINB                 1      8  0
016900990324     D  SKDIOO                 1      2  0
017000990324     D  SKDIYY                 3      4  0
017100990324     D  SKDIMM                 5      6  0
017200990324     D  SKDIDD                 7      8  0
017300930202     D                 DS
017400970123     D  KMDGLO                 1      8  0
017500970123     D  KMDOO                  1      2  0
017600970123     D  KMDAA                  3      4  0
017700970123     D  KMDMM                  5      6  0
017800970123     D  KMDDD                  7      8  0
017900911121     D                 DS
018000911121     D  KMU                    1    132  2
018100911121     D                                     DIM(12)
018200911121     D  KMU01                  1     11  2
018300911121     D  KMU02                 12     22  2
018400911121     D  KMU03                 23     33  2
018500911121     D  KMU04                 34     44  2
018600911121     D  KMU05                 45     55  2
018700911121     D  KMU06                 56     66  2
018800911121     D  KMU07                 67     77  2
018900911121     D  KMU08                 78     88  2
019000911121     D  KMU09                 89     99  2
019100911121     D  KMU10                100    110  2
019200911121     D  KMU11                111    121  2
019300911121     D  KMU12                122    132  2
019400911121     D                 DS
019500911121     D  KME                    1    132  2
019600911121     D                                     DIM(12)
019700911121     D  KME01                  1     11  2
019800911121     D  KME02                 12     22  2
019900911121     D  KME03                 23     33  2
020000911121     D  KME04                 34     44  2
020100911121     D  KME05                 45     55  2
020200911121     D  KME06                 56     66  2
020300911121     D  KME07                 67     77  2
020400911121     D  KME08                 78     88  2
020500911121     D  KME09                 89     99  2
020600911121     D  KME10                100    110  2
020700911121     D  KME11                111    121  2
020800911121     D  KME12                122    132  2
020900911121     D                 DS
021000911121     D  KMD                    1    132  2
021100911121     D                                     DIM(12)
021200911121     D  KMD01                  1     11  2
021300911121     D  KMD02                 12     22  2
021400911121     D  KMD03                 23     33  2
021500911121     D  KMD04                 34     44  2
021600911121     D  KMD05                 45     55  2
021700911121     D  KMD06                 56     66  2
021800911121     D  KMD07                 67     77  2
021900911121     D  KMD08                 78     88  2
022000911121     D  KMD09                 89     99  2
022100911121     D  KMD10                100    110  2
022200911121     D  KMD11                111    121  2
022300911121     D  KMD12                122    132  2
022400911121     D                 DS
022500911121     D  KMI                    1    132  2
022600911121     D                                     DIM(12)
022700911121     D  KMI01                  1     11  2
022800911121     D  KMI02                 12     22  2
022900911121     D  KMI03                 23     33  2
023000911121     D  KMI04                 34     44  2
023100911121     D  KMI05                 45     55  2
023200911121     D  KMI06                 56     66  2
023300911121     D  KMI07                 67     77  2
023400911121     D  KMI08                 78     88  2
023500911121     D  KMI09                 89     99  2
023600911121     D  KMI10                100    110  2
023700911121     D  KMI11                111    121  2
023800911121     D  KMI12                122    132  2
023900030624     d                 ds
024000030624     d kmutge
024100030624     d  kmutge1                       2a   overlay(kmutge:1)
024200030812     d                 ds
024300030812     d ihkort
024400030812     d  ihkort1                      13a   overlay(ihkort:01)
024500030812     d  ihkort2                       3s 0 overlay(ihkort:14)
024600030812
024700030812     d ih_til          s              1a
024800110531      //
024900010130     DPARAM1           DS
025000990324     D  PAOAM                  1      6  0
025100990324     D   PAOA                  1      4  0
025200990324     D    PAOO                 1      2  0
025300990324     D    PAAA                 3      4  0
025400990324     D   PAMM                  5      6  0
025500990324     D  PADD                   7      8  0
025600010130     DPARAM2           DS
025700010130     d pamember                1     10a
025800110531      //
025900930206     D                UDS
026000930206     D  OAICA                  3      6
026100930206     D  OAPRFX                 7     12
026200110531
026300110531
026301110531      /FREE
026400110531       READ KRKRN1W;
026401110531       *IN01 = %EOF;
026402110531      /END-FREE
026500930202     C                   MOVE      AUBANK        #BANK             4
026600110531      //  SKRIFA HAUSA Í LISTA
026601110531      /FREE
026700110531       CLEAR UBNAFN;
026800110531       CHAIN AUBANK DBUTB;
026801110531       *IN31 = NOT %FOUND;
026900110531       //
027000110531       DOW *IN01 = '0';
027001110531         wrkcrdno = %trim(aukort) + %editc(aukrtn : 'X');
027002110531         prtcrd = dbxMaskPan(wrkcrdno);
027100110531         //
027200110531N        IF *IN92 = *ON;
027300110531           CHAIN AUBANK DBUTB;
027301110531           *IN31 = NOT %FOUND;
027400110531N          WRITE KRKRN2L1;
027401110531           *IN92 = *OFF;
027600110531N        ENDIF;
027700110531
027800110531         CHAIN AUKORT DBKM;
027801110531         *IN02 = NOT %FOUND;
027900110531
028000110531         IF *IN02 = '0';
028001110531      /END-FREE
028100930217     C                   Z-ADD     0             #SKULD
028200911122     C                   Z-ADD     0             SELEOK
028300930205     C                   Z-ADD     0             FJOK1
028400930205     C                   Z-ADD     0             FJOK2
028500930205     C                   Z-ADD     0             FJRJ1
028600930205     C                   Z-ADD     0             FJRJ2
028700930205     C                   Z-ADD     0             FJLP1
028800930205     C                   Z-ADD     0             FJLP2
028900930205     C                   Z-ADD     0             FJUN1
029000930205     C                   Z-ADD     0             FJUN2
029100970123     C                   Z-ADD     KMDOO         PDOO
029200930202     C                   Z-ADD     KMDAA         PDAA
029300930202     C                   Z-ADD     KMDMM         PDMM
029400930202     C                   Z-ADD     KMDDD         PDDD
029500110531      //
029600930316     C                   MOVE      ' '           LOKADG            1
029601110531      /FREE
029700110531           IF KMLOKK <> ' ';
029701110531      /END-FREE
029800930316     C                   Z-ADD     1             X
029900930316     C     KMLOKK        LOOKUP    T2(X)                                  89
029901110531      /FREE
030000110531             IF *IN89 = '1';
030001110531      /END-FREE
030100930316     C                   ADD       1             FJT2(X)
030200930316     C                   MOVE      T2A(X)        LOKADG
030201110531      /FREE
030300110531             ENDIF;                                                           // *IN89
030400110531           ENDIF;                                                             // KMLOKK
030500110531
030602110531           KMMED = *OFF;
030603110531
030700110531           IF LOKADG <> 'D'
030800110531           AND LOKADG <> 'P'
030900110531           AND LOKADG <> 'R'
031000110531           AND LOKADG <> '1'
031100110531           AND LOKADG <> '2';
031101110531             KMMED = *ON;
031300110531           ENDIF;
031400110531           //
031500110531           DOW *IN01 = '0';
031600110531             // **
031700110531             IF KMMED = *ON;
031800110531               //
031801110531      /END-FREE
031900971002     C                   MOVE      ' '           LOKADG            1
031901110531      /FREE
032000110531               IF AULOKK <> ' ';
032001110531      /END-FREE
032100971002     C                   Z-ADD     1             X
032200971002     C     AULOKK        LOOKUP    T2(X)                                  89
032201110531      /FREE
032300110531                 IF *IN89 = '1';
032301110531      /END-FREE
032400971002     C                   ADD       1             FJT2(X)
032500971002     C                   MOVE      T2A(X)        LOKADG
032501110531      /FREE
032600110531                 ENDIF;                                                       // *IN89
032700110531               ENDIF;                                                         // AULOKK
032800110531               //
032900110531             ENDIF;
033000110531             // **
033100110531             //
033200110531             IF AUGOYM = PAOAM;
033300110531               //  EF LOKUNARKÓDI/AÐGERÐARKÓDI ='1' OG EKKI AÐALKORT,
033400110531               //  EKKI ENDURNÝJA
033500110531               IF LOKADG = '1'
033600110531               AND AUTEGU <> 'A';
033601110531      /END-FREE
033700930316     C                   ADD       1             FJEKKI            5 0
033701110531      /FREE
033800110531               ELSE;
033900110531                 //  EF LOKUNARKÓDI/AÐGERÐARKÓDI ='2' OG AÐALKORT,
034000110531                 //  EKKI ENDURNÝJA
034100110531                 IF LOKADG = '2'
034200110531                   AND AUTEGU = 'A';
034201110531      /END-FREE
034300930316     C                   ADD       1             FJEKKI            5 0
034301110531      /FREE
034400110531                 ELSE;
034500110531                   //
034501110531      /END-FREE
034600930217     C                   ADD       1             FJALLS            5 0
034700911122     C                   ADD       1             SELEOK
034701110531      /FREE
034800110531                   CLEAR NAFN;
034900110531                   CLEAR PGILD;
035000110531                   CLEAR PKRNR2;
035100110531                   CLEAR NAFN2;
035200110531                   CLEAR PGILD2;
035300110531                   CLEAR PKRNR3;
035400110531                   CLEAR NAFN3;
035500110531                   CLEAR PGILD3;
035600110531      /SPACE
035700110531                   CHAIN AUKENN DBNI;
035701110531                   *IN89 = NOT %FOUND;
035800110531                   IF *IN89 = *OFF;
035900110531                     SELECT;
036000110531                     WHEN SELEOK = 1;
036001110531      /END-FREE
036100930201     C                   MOVEL     NINAFN        NAFN             25
036200000920     C                   MOVEL     NIKENT        IDNR
036201110531      /FREE
036300110531                       PGOO = AUGOO;
036301110531      /END-FREE
036400930202     C                   Z-ADD     AUGAA         PGAA
036500930202     C                   Z-ADD     AUGMM         PGMM
036600930202     C                   Z-ADD     AUGDD         PGDD
036601110531      /FREE
036700110531                       *in40 = *off;
036800110531                       *in41 = *off;
036900110531                       *in49 = *off;
037000110531                       if kmtegk <> 'P';
037100110531                         IF T2LKOD <> 'A'                                     //Viðbót Snorri
037200110531                         OR T2LKOD <> 'L'                                     //Viðbót Snorri
037300110531                         OR T2LKOD <> 'E'                                     //Viðbót Snorri
037400110531                         OR T2LKOD <> 'W'                                     //Viðbót Snorri
037500110531                         OR T2LKOD <> '3';                                    //Viðbót Snorri
037600110531                         //**** RB hættir með vanskil EXSR      RB_Vanskil
037700110531                         EXSR RB_Lokskra;                                     //Viðbót Snorri
037800110531                         ENDIF;                                               //Viðbót Snorri
037900110531                       endif;
038000110531                     WHEN SELEOK = 2;
038001110531      /END-FREE
038100930202     C                   MOVEL     NINAFN        NAFN2            25
038200930202     C                   Z-ADD     AUKRTN        PKRNR2
038201110531      /FREE
038300110531                       PGOO2 = AUGOO;
038301110531      /END-FREE
038400930202     C                   Z-ADD     AUGAA         PGAA2
038500930202     C                   Z-ADD     AUGMM         PGMM2
038600930202     C                   Z-ADD     AUGDD         PGDD2
038601110531      /FREE
038700110531                     OTHER;
038701110531      /END-FREE
038800930202     C                   MOVEL     NINAFN        NAFN3            25
038900930202     C                   Z-ADD     AUKRTN        PKRNR3
038901110531      /FREE
039000110531                       PGOO3 = AUGOO;
039001110531      /END-FREE
039100930202     C                   Z-ADD     AUGAA         PGAA3
039200930202     C                   Z-ADD     AUGMM         PGMM3
039300930202     C                   Z-ADD     AUGDD         PGDD3
039301110531      /FREE
039400110531                     ENDSL;
039500110531                   ENDIF;
039600110531      /SPACE
039700110531                   IF SELEOK = 1;
039800110531                     CLEAR #HVORT;
039801110531      /END-FREE
039900930130     C                   ADD       1             FJEND             5 0
039901110531      /FREE
040000110531                     CHAIN KMREGL DBRK;
040001110531                     *IN89 = NOT %FOUND;
040100110531                     CHAIN KMREGL DBRKRN;
040101110531                     *IN89 = NOT %FOUND;
040200110531 B2                  IF KMVIPK = *BLANKS;
040201110531      /END-FREE
040300930217 |   C                   Z-ADD     RNFJV1        #FJVAF            7 0
040400930217 |   C                   Z-ADD     RNFVG1        #REGL1            2 0
040500930217 |   C                   Z-ADD     RNFVE1        #REGL2            2 0
040501110531      /FREE
040600110531 X2                  ELSE;
040601110531      /END-FREE
040700930208 |   C                   Z-ADD     RNFJV2        #FJVAF
040800930216 |   C                   Z-ADD     RNFVG2        #REGL1
040900930216 |   C                   Z-ADD     RNFVE2        #REGL2
040901110531      /FREE
041000110531 E2                  ENDIF;
041100110531                     //
041200110531                     if autegk = 'C';                                         //  Veltukort
041300110531                       EXSR ath_veltu_sk;
041400110531                     else;                                                    //  Önnur kort
041500110531                       EXSR TELJAV;
041600110531                     endif;
041700110531                     //
041701110531      /END-FREE
041800930202     C                   Z-ADD     KMIHEI        PIHEI
041900930205     C                   Z-ADD     FJOK1         MFJOK1
042000930205     C                   Z-ADD     FJOK2         MFJOK2
042100930205     C                   Z-ADD     FJRJ1         MFJRJ1
042200930205     C                   Z-ADD     FJRJ2         MFJRJ2
042300930205     C                   Z-ADD     FJLP1         MFJLP1
042400930205     C                   Z-ADD     FJLP2         MFJLP2
042500930205     C                   Z-ADD     FJUN1         MFJUN1
042600930205     C                   Z-ADD     FJUN2         MFJUN2
042700110531      //
042800110531      //  ATHUGA HVORT KORTHAFI SKULDI MEIRA EN SÍÐASTA GÍRÓSEÐIL
042900110531      //
042901110531      /FREE
043000110531                   ENDIF;                        // SELEOK
043100110531                   //
043200110531                   //  AÐGERÐARKÓDI LOKUNARKÓDI SEGIR TIL HVORT MEGI ENDURNÝJA
043300110531                   //
043400110531                   IF LOKADG = 'D'                              // EKKI
043500110531                   OR LOKADG = 'P'                              // ENDURNÝJA
043600110531                   OR LOKADG = 'R';                             // ÞESSA KÓDA
043700110531                     SELECT;
043800110531                     WHEN SELEOK = 1;
043801110531      /END-FREE
043900930217     C                   ADD       1             FJEKKI            5 0
043901110531      /FREE
044000110531                     OTHER;
044100110531                     ENDSL;
044200110531                     //                 AÐRIR KÓDAR
044300110531                   ELSE;              // KOMA TIL
044400110531                     //                  GREINA.
044500110531                     //
044600110531                     if kmtegk = 'P';                        //Verið að athuga
044700110531                       ihkort1 = aukort;                    //hvort einhverjar
044800110531                       ihkort2 = 0;                         //hreyfingar hafi
044900110531                       chain ih00p dbih;                    //komið á +kort.
045000110531                       if %found(dbih);
045100110531                         ih_til = *on;
045200110531                         *in43 = *off;
045300110531                       else;
045400110531                         ih_til = *off;
045500110531                         *in43 = *on;
045600110531                       endif;
045700110531                     else;
045800110531                       *in43 = *off;
045900110531                       ih_til = *on;                   //  til að allir hinir
046000110531                     endif;                            //  komi með.
046100030812
046200110531                     if kmutge1 = '05' and kmtegk = 'P';  //MC+ v/Íslandsb.
046300110531                       vidmid = 3000;                     // Meiga skulda 3000kr
046301110531                       RCKODI = 'EO';
046500110531                     else;                                //Allt annað
046600110531                       vidmid = 0;
046601110531                       if kmutge='1520' and kmtegk = 'P'  //KK plús endurn bréf
046602110531                          and *IN43 = *ON;
046604110531                         RCKODI = 'R0';
046605110531                       else;
046606110531                         RCKODI = '**';
046607110531                       ENDIF;
046800110531                     endif;
046900110531                     //
047000110531                     //  EKKI ENDURNÝJAÐ V/SKULD, SKRIFA Í LISTA EF SKULD
047100110531                     IF #SKULD > vidmid or ih_til = *off;
047200030624
047300110531                       IF *IN91 = *ON;
047400110531                         WRITE KRKRN1L1;
047401110531                         *IN91 = *OFF;
047600110531                       ENDIF;
047700110607
047800110531                       SELECT;
047900110531                       WHEN SELEOK = 1;
048000110531                         EXSR WRRCRD;
048100110531                         WRITE KRKRN1L2;
048101110531      /END-FREE
048200001116     C                   MOVEL     IDNR          IDNRGEYM                       Viðbót Snorri
048300930216     C                   MOVE      *ON           #HVORT            1
048400930216     C                   MOVE      *ON           SKRIF1            1
048500930217     C                   ADD       #SKULD        SKUTT
048600930202     C                   ADD       1             FJSK
048700110531      //
048800930215     C                   ADD       FJOK1         SFJOK1            5 0
048900930215     C                   ADD       FJOK2         SFJOK2            5 0
049000930215     C                   ADD       FJRJ1         SFJRJ1            5 0
049100930215     C                   ADD       FJRJ2         SFJRJ2            5 0
049200930215     C                   ADD       FJLP1         SFJLP1            5 0
049300930215     C                   ADD       FJLP2         SFJLP2            5 0
049400930215     C                   ADD       FJUN1         SFJUN1            5 0
049500930215     C                   ADD       FJUN2         SFJUN2            5 0
049600930217     C                   ADD       #SKULD        SSALD            13 2
049700110531      //
049701110531      /FREE
049800110531                       WHEN SELEOK = 2;
049900110531                         WRITE KRKRN1L3;
050000110531                       OTHER;
050100110531                         WRITE KRKRN1L4;
050200110531                       ENDSL;
050300110531                       *IN87 = *ON;
050400030624
050500110531                     ELSE;                                                    //SKULD
050600030624
050700110531                       IF FJRJ1 > #FJVAF;                                     //V
050800110531                         IF *IN91 = *ON
050900110531                         AND SELEOK = 1;
051000110607                   //      WRITE KRKRN1L1;  vilja aðeins skuldara
051001110607                   //      *IN91 = *OFF;
051200110531                         ENDIF;
051300110531      /SPACE
051400110531                         SELECT;
051500110531                         WHEN SELEOK = 1;
051600110531                         EXSR WRRCRD;
051700110607                   //      WRITE KRKRN1L2;   vilja aðeins skuldara
051701110531      /END-FREE
051800001116     C                   MOVEL     IDNR          IDNRGEYM                       Viðbót Snorri
051900930216     C                   MOVE      *ON           #HVORT
052000020919     C                   MOVE      *ON           SKRIF1
052100930217     C                   ADD       #SKULD        VUTT
052200930217     C                   ADD       1             FJRJ                           FJ REJECT
052300110531      //
052400930215     C                   ADD       FJOK1         SFJOK1            5 0
052500930215     C                   ADD       FJOK2         SFJOK2            5 0
052600930215     C                   ADD       FJRJ1         SFJRJ1            5 0
052700930215     C                   ADD       FJRJ2         SFJRJ2            5 0
052800930215     C                   ADD       FJLP1         SFJLP1            5 0
052900930215     C                   ADD       FJLP2         SFJLP2            5 0
053000930215     C                   ADD       FJUN1         SFJUN1            5 0
053100930215     C                   ADD       FJUN2         SFJUN2            5 0
053200930217     C                   ADD       #SKULD        SSALD            13 2
053300110531      //
053301110531      /FREE
053400110531                         WHEN SELEOK = 2;
053500110607                    //     WRITE KRKRN1L3;  vilja aðeins skuldara
053501110531      /END-FREE
053600110607     C**   40              WRITE     KRKRN1L4A                                    Viðbót Snorri
053700110607     C**   41              WRITE     KRKRN1L4B                                    Viðbót Snorri
053701110531      /FREE
053800110531                         OTHER;
053900110607                 //        WRITE KRKRN1L4;   vilja aðeins skuldara
053901110531      /END-FREE
054000110607     C**   40              WRITE     KRKRN1L4A                                    Viðbót Snorri
054100110607     C**   41              WRITE     KRKRN1L4B                                    Viðbót Snorri
054101110531      /FREE
054200110531                         ENDSL;
054300110531                         *IN88 = *ON;
054400110531
054500110531                       ELSE;                                                  //FJ V
054600110531                         IF SELEOK = 1;
054700110531                         IF FJLP1 > 0;
054701110531                           fjlp += 1;
054900110531                         ENDIF;
055002110531                         FJOK += 1;
055100110531                         ENDIF;
055200110531                       ENDIF;                                                 //FJ V
055300110531                     ENDIF;                                                   //SKULD
055400110531
055500110531                   ENDIF;                                                     // LOKADG
055600110531
055700110531                   IF *IN92 = *ON
055800110609                      AND SELEOK = 1;
055900110531                     WRITE KRKRN2L1;
055901110531                     *IN92 = *OFF;
056100110531                   ENDIF;
056200110531
056300110531                   SELECT;
056400110531                   WHEN SELEOK = 1;
056500110531                     WRITE KRKRN2L2;
056501110531      /END-FREE
056600930216     C                   MOVE      *ON           SKRIF2            1
056700110531      //
056800930215     C                   ADD       FJOK1         HFJOK1            5 0
056900930215     C                   ADD       FJOK2         HFJOK2            5 0
057000930215     C                   ADD       FJRJ1         HFJRJ1            5 0
057100930215     C                   ADD       FJRJ2         HFJRJ2            5 0
057200930215     C                   ADD       FJLP1         HFJLP1            5 0
057300930215     C                   ADD       FJLP2         HFJLP2            5 0
057400930215     C                   ADD       FJUN1         HFJUN1            5 0
057500930215     C                   ADD       FJUN2         HFJUN2            5 0
057600930217     C                   ADD       #SKULD        HSALD            13 2
057700110531      //
057701110531      /FREE
057800110531                   WHEN SELEOK = 2;
057900110531                     WRITE KRKRN2L3;
057901110531      /END-FREE
058000001110     C   40              WRITE     KRKRN2L4A                                    Viðbót Snorri
058100001128     C   41              WRITE     KRKRN2L4B                                    Viðbót Snorri
058101110531      /FREE
058200110531                   OTHER;
058300110531                     WRITE KRKRN2L4;
058500110531                   ENDSL;
058600110531                   //
058700110531                 ENDIF;                                            // AÐG.+AUKAK
058800110531               ENDIF;                                            // AÐG.+AÐALK
058900110531               EXCEPT PVVGEN;                                   // FILE TO  GEN PVV
059000110531             ENDIF;                                             // AUGYM
059100110531
059200110531             UUPRFX = %subst(aukort:1:6);
059300110531             UUFLOK = auflok;
059400110531             chain uu01l dbumdspl1;
059500110531             if %found(dbumdspl1);
059600110531               if UUSTAT = 'X' and UUDEFL = 'J';
059700110607                 //   má ekki taka síhringikóda af
059800110531               else;
059900040521
060000110531                 if auauk1 = 'J';
060100110531                   if fjrj1 <= 4 and #skuld = 0;
060200110531                     auauk1 = *hival;
060300110531                     update aurec1;
060400110531                   endif;
060500110531                 endif;
060600040521
060700110531               endif;
060800040521
060900110531             else;
061000040521
061100110531               if auauk1 = 'J';
061200110531                 if fjrj1 <= 4 and #skuld = 0;
061300110531                   auauk1 = *hival;
061400110531                   update aurec1;
061500110531                 endif;
061600110531               endif;
061700040521
061800110531             endif;
061900040521
062000110531             READE AUKEY KRKRN1W;
062001110531             *IN01 = %EOF;
062100110531           ENDDO;                                                             // *IN01
062200110531           //
062300110531           SELECT;
062400110531           WHEN SELEOK = 1;
062500110531             IF #HVORT = *ON;
062600110531               WRITE KRKRN1L3;
062601110531      /END-FREE
062700001108     C                   MOVEL     NIKENT        IDNR                           Viðbót Snorri
062800001214     C   40              WRITE     KRKRN1L4A                                    Viðbót Snorri
062801110531      /FREE
062900110531             ENDIF;
063000110531             IF IDNRGEYM <> NIKENT;                                           //Viðbót Snorri
063100110531               IF *IN40 = *ON;                                                //Viðbót Snorri
063200110531                 IF *IN91 = *ON;                                              //Viðbót Snorri
063300110531                   WRITE KRKRN1L1;                                            //Viðbót Snorri
063301110531                   *IN91 = *OFF;
063500110531                 ENDIF;                                                       //Viðbót Snorri
063600110531                 WRITE KRKRN1L2;                                              //Viðbót Snorri
063601110531                 SKRIF1 = *ON;
063800110531                 WRITE KRKRN1L3;                                              //Viðbót Snorri
063801110531      /END-FREE
063900001110     C                   MOVEL     NIKENT        IDNR                           Viðbót Snorri
063901110531      /FREE
064000110531                 WRITE KRKRN1L4A;                                             //Viðbót Snorri
064100110531                 EXSR WRRCRD;                                                 //Viðbót Snorri
064200110531               ENDIF;                                                         //in40 Viðbót Snorri
064300110531               IF *IN41 = *ON;
064400110531                 IF *IN91 = *ON;                                              //Viðbót Snorri
064500110531                   WRITE KRKRN1L1;                                            //Viðbót Snorri
064501110531                   *IN91 = *OFF;
064700110531                 ENDIF;                                                       //Viðbót Snorri
064701110531      /END-FREE
064800001207     C  N40              WRITE     KRKRN1L2                                     Viðbót Snorri
064900020919     C                   MOVE      *ON           SKRIF1
065000001207     C  N40              WRITE     KRKRN1L3                                     Viðbót Snorri
065100001207     C  N40              MOVEL     NIKENT        IDNR                           Viðbót Snorri
065101110531      /FREE
065200110531                 WRITE KRKRN1L4B;                                             //Viðbót Snorri
065201110531      /END-FREE
065300001207     C  N40              EXSR      WRRCRD                                       Viðbót Snorri
065301110531      /FREE
065400110531               ENDIF;                                                         //in41 Viðbót Snorri
065500110531             ENDIF;                                                           //NIKENT Viðbót Snorri
065600110531             WRITE KRKRN2L3;
065601110531      /END-FREE
065700001110     C                   MOVEL     NIKENT        IDNR                           Viðbót Snorri
065800001214     C   40              WRITE     KRKRN2L4A                                    Viðbót Snorri
065900001214     C   41              WRITE     KRKRN2L4B                                    Viðbót Snorri
065901110531      /FREE
066000110531           ENDSL;
066100110531           //
066200110531         ENDIF;                                                               // *IN02
066300110531         //
066400110531         SETGT AUKEY KRKRN1W;
066500110531         READ KRKRN1W;
066501110531         *IN01 = %EOF;
066600110531         //
066700110531         IF AUBANK <> #BANK;
066800110531           //
066900110531           IF SKRIF2 = *ON;
066901110531      /END-FREE
067000930216     C                   MOVE      *OFF          SKRIF2
067001110531      /FREE
067100110531             CHAIN AUBANK DBUTB;
067101110531             *IN31 = NOT %FOUND;
067200110531             WRITE KRKRN2L1;
067201110531      /END-FREE
067300930218     C                   MOVE      *OFF          *IN92
067400110531      //
067500930215     C                   ADD       HFJOK1        AFJOK1            5 0
067600930215     C                   ADD       HFJOK2        AFJOK2            5 0
067700930215     C                   ADD       HFJRJ1        AFJRJ1            5 0
067800930215     C                   ADD       HFJRJ2        AFJRJ2            5 0
067900930215     C                   ADD       HFJLP1        AFJLP1            5 0
068000930215     C                   ADD       HFJLP2        AFJLP2            5 0
068100930215     C                   ADD       HFJUN1        AFJUN1            5 0
068200930215     C                   ADD       HFJUN2        AFJUN2            5 0
068300930215     C                   ADD       HSALD         ASALD            13 2
068301110531      /FREE
068400110531           ENDIF;
068500110531           //
068600110531           CLEAR HFJOK1;
068700110531           CLEAR HFJOK2;
068800110531           CLEAR HFJRJ1;
068900110531           CLEAR HFJRJ2;
069000110531           CLEAR HFJLP1;
069100110531           CLEAR HFJLP2;
069200110531           CLEAR HFJUN1;
069300110531           CLEAR HFJUN2;
069400110531           CLEAR HSALD;
069500110531           //
069600110531           IF SKRIF1 = *ON;
069601110531      /END-FREE
069700930216     C                   MOVE      *OFF          SKRIF1
069701110531      /FREE
069800110531             IF *IN91 = *ON;
069900110531               WRITE KRKRN1L1;
069901110607               *IN91 = *OFF;
070100110531             ENDIF;
070200110531             WRITE KRKRN1L5;
070300110531             //
070301110531      /END-FREE
070400930215     C                   ADD       SFJOK1        TFJOK1            5 0
070500930215     C                   ADD       SFJOK2        TFJOK2            5 0
070600930215     C                   ADD       SFJRJ1        TFJRJ1            5 0
070700930215     C                   ADD       SFJRJ2        TFJRJ2            5 0
070800930215     C                   ADD       SFJLP1        TFJLP1            5 0
070900930215     C                   ADD       SFJLP2        TFJLP2            5 0
071000930215     C                   ADD       SFJUN1        TFJUN1            5 0
071100930215     C                   ADD       SFJUN2        TFJUN2            5 0
071200930215     C                   ADD       SSALD         TSALD            13 2
071201110531      /FREE
071300110531           ENDIF;
071400110531           //                                                                         4
071500110531           CLEAR SFJOK1;
071600110531           CLEAR SFJOK2;
071700110531           CLEAR SFJRJ1;
071800110531           CLEAR SFJRJ2;
071900110531           CLEAR SFJLP1;
072000110531           CLEAR SFJLP2;
072100110531           CLEAR SFJUN1;
072200110531           CLEAR SFJUN2;
072300110531           CLEAR SSALD;
072400110531           //
072401110531      /END-FREE
072500930202     C                   MOVE      AUBANK        #BANK
072501110531      /FREE
072600110531           CLEAR UBNAFN;
072700110531           CHAIN AUBANK DBUTB;
072701110531           *IN31 = NOT %FOUND;
072800110531           *in91 = *on;
072900110531         ENDIF;
073000110531         //
073100110531       ENDDO;                                                                 // *IN01
073101110607
073102110607       *INLR = *ON;
073300110607
073400110607            //  SKRIFA SAMTÖLUR
073500110607
073600110531       clear aubank;
073700110531       clear ubnafn;
073800110607
073801110531      /END-FREE
073900930215     C                   ADD       HFJOK1        AFJOK1            5 0
074000930215     C                   ADD       HFJOK2        AFJOK2            5 0
074100930215     C                   ADD       HFJRJ1        AFJRJ1            5 0
074200930215     C                   ADD       HFJRJ2        AFJRJ2            5 0
074300930215     C                   ADD       HFJLP1        AFJLP1            5 0
074400930215     C                   ADD       HFJLP2        AFJLP2            5 0
074500930215     C                   ADD       HFJUN1        AFJUN1            5 0
074600930215     C                   ADD       HFJUN2        AFJUN2            5 0
074700930215     C                   ADD       HSALD         ASALD            13 2
074701110531      /FREE
074800110531       IF *IN92 = *ON;
074900110531         WRITE KRKRN2L1;
074901110607         *IN92 = *OFF;
075100110531       ENDIF;
075200110607
075201110531      /END-FREE
075300930215     C                   ADD       SFJOK1        TFJOK1            5 0
075400930215     C                   ADD       SFJOK2        TFJOK2            5 0
075500930215     C                   ADD       SFJRJ1        TFJRJ1            5 0
075600930215     C                   ADD       SFJRJ2        TFJRJ2            5 0
075700930215     C                   ADD       SFJLP1        TFJLP1            5 0
075800930215     C                   ADD       SFJLP2        TFJLP2            5 0
075900930215     C                   ADD       SFJUN1        TFJUN1            5 0
076000930215     C                   ADD       SFJUN2        TFJUN2            5 0
076100930215     C                   ADD       SSALD         TSALD            13 2
076200030103
076201110531      /FREE
076300110531       IF SKRIF1 = *ON;
076301110607          SKRIF1 = *OFF;
076500110531         IF *IN91 = *ON;
076600110531           WRITE KRKRN1L1;
076601110607           *IN91 = *OFF;
076800110531         ENDIF;
076900110531         WRITE KRKRN1L5;
077000110531       ENDIF;
077100110607
077101110531      /END-FREE
077200911122     C     VUTT          ADD       SKUTT         TOTUTT
077300930217     C     FJALLS        SUB       FJEND         FJM
077301110531      /FREE
077400110531       WRITE KRKRN1L1;
077500110531       WRITE KRKRN1L7;
077600110607
077700110531       WRITE KRKRN2L1;
077800110531       WRITE KRKRN2L7;
077900110531       WRITE KRKRN2L8;
078000110607
078001110531      /END-FREE
078100930217     C                   DO        99            X
078101110531      /FREE
078200110531         IF FJT2(X) <> 0;
078201110531      /END-FREE
078300930217     C                   Z-ADD     FJT2(X)       PFJT2
078400930217     C                   MOVEL     T2T(X)        PT2T
078401110531      /FREE
078500110531           WRITE KRKRN2L6;
078600110531         ENDIF;                                                               // FJT2,X
078700110531       ENDDO;                                                                 // DO
078800110531       //
078900110531       //*************************************************************
079000110531       //  SKRIFA FÆRSLUR SEM EKKI EIGA AÐ FÁ ENDURNÝJUN Í SÉR SKRÁ **
079100110531       //  TIL MEÐHÖNDLUNAR AF KORTADEILD                           **
079200110531       //*************************************************************
079300110531       BEGSR WRRCRD;
079301110531      /END-FREE
079400911122     C                   MOVEL     AUKORT        RCKORT
079500911122     C                   MOVE      AUKRTN        RCKORT
079600970123     C                   MOVE      AUGILD        RCGILD
079700930217     C                   Z-ADD     #SKULD        RCUPPH
079701110531      /FREE
079800110531         WRITE RCREC1;
079900110531       ENDSR;
080000110531       //
080100110531       //*********************************
080200110531       //  Athuga skuldir á veltukortum  *
080300110531       //*********************************
080400110531       begsr ath_veltu_sk;
080500010221
080600110531|        CLEAR #SKUL#;
080700110531|        CLEAR #SKULD;
080800010219
080801110531      /END-FREE
080900010221     C                   MOVE      '000'         ScKORT
081000010219     C                   MOVEL     KMKORT        ScKORT
081100010221     c                   move      *hival        ScGJLD
081200010219
081201110531      /FREE
081300110531         SETgt ScKEY DBSkc1;
081400110531         READpe ScKORT DBSKc1;
081401110531         *IN89 = %EOF;
081500110531B1       if *in89 = *off;
081600010219|
081700110531|          // EIND.
081800010219|
081801110531      /END-FREE
081900010219|    C                   ADD       Scminp        #SKULD           11 2
082000010219|    C                   ADD       Scvxtm        #SKULD
082100010219|    C                   SUB       ScINbm        #SKULD
082200010219|
082300010219|    C     Scminp        ADD       scvxtm        #SKUL#           11 2
082400010219|    C                   SUB       scinbm        #SKUL#
082500010219|
082501110531      /FREE
082600110531         endif;
082700010219
082800110531       endsr;
082900110531       //
083000110531       //*********************************
083100110531       //  Telja fjölda V merkinga      **
083200110531       //*********************************
083300110531       BEGSR TELJAV;
083400110531         //
083401110531      /END-FREE
083500930201     C                   MOVE      '000'         SKKORT
083600930201     C                   MOVEL     KMKORT        SKKORT
083700930201     C                   Z-ADD     1             SKGJDD
083800990324     C                   MOVE      PAMM          SKGJMM
083900991220     C     PAOA          SUB       2             SKGJOY
084000990326     C     PAOAM         SUB       100           WRKOYM            6 0
084100110531      //
084101110531      /FREE
084200110531         SETLL SKKEY DBSK1;
084300110531         READE SKKORT DBSK1;
084301110531         *IN89 = %EOF;
084400110531B1       DOW *IN89 = '0';
084500110531|          //
084600110531|          // EIND.
084601110531      /END-FREE
084700990324     C     *ISO          MOVE      SKEIND        #EIND
084800990324     C                   ADDDUR    RKHDAG:*D     #EIND
084900990324     C                   ADDDUR    #REGL2:*D     #EIND
085000110531|     //
085001110531      /FREE
085100110531|          CLEAR #SKUL#;
085200110607|
085300110607           IF #DAGS1 > #EIND;    // #dags1=udate - 1mán
085400110607|                                // #eind=eind. skuldar
085401110531      /END-FREE
085500930217|    C                   ADD       SKUPPH        #SKULD           11 2
085600930217|    C                   ADD       SKUPPV        #SKULD
085700930217|    C                   SUB       SKINNB        #SKULD
085800110531|     //
085900930421|    C     SKUPPV        ADD       SKUPPH        #SKUL#           11 2
086000930420|    C                   SUB       SKINNB        #SKUL#
086100110531|     //
086101110531      /FREE
086200110531|          ENDIF;
086300110607|
086301110531      /END-FREE
086400990324     C     *ISO          MOVE      SKEIND        #EIND1
086500990324     C                   ADDDUR    #REGL1:*D     #EIND1
086600110531|     // INNBD.
086601110531      /FREE
086700110531           IF SKDINB = 0;
086800110531             #INBD = *LOVAL;
086900110531           ELSE;
086901110531      /END-FREE
087000990324     C     *ISO          MOVE      SKDINB        #INBD
087001110531      /FREE
087100110531           ENDIF;
087200110531|          //
087300110531|B2        IF SKINNB = 0;
087400110531||B3         IF SKEIOYM > WRKOYM;
087401110531      /END-FREE
087500930205|||  C                   ADD       1             FJUN1             3 0
087501110531      /FREE
087600110531||X3         ELSE;
087601110531      /END-FREE
087700930205|||  C                   ADD       1             FJUN2             3 0
087701110531      /FREE
087800110531||E3         ENDIF;
087900110531|X2        ELSE;
088000110531             IF #DAGS > #EIND AND
088100110531|||                #SKUL# > 0;
088200110531|||B4          IF SKEIOYM > WRKOYM;
088201110531      /END-FREE
088300930216|||| C                   ADD       1             FJRJ1             3 0
088301110531      /FREE
088400110531|||X4          ELSE;
088401110531      /END-FREE
088500930216|||| C                   ADD       1             FJRJ2             3 0
088501110531      /FREE
088600110531|||E4          ENDIF;
088700110531||X3         ELSE;
088800110531               IF #INBD > #EIND;
088900110531||||5            IF SKEIOYM > WRKOYM;
088901110531      /END-FREE
089000930206|||| C                   ADD       1             FJRJ1             3 0
089001110531      /FREE
089100110531||||5            ELSE;
089101110531      /END-FREE
089200930206|||| C                   ADD       1             FJRJ2             3 0
089201110531      /FREE
089300110531||||5            ENDIF;
089400110531|||X4          ELSE;
089500110531                 IF #INBD > #EIND1;
089600110531||||6              IF SKEIOYM > WRKOYM;
089601110531      /END-FREE
089700930216|||| C                   ADD       1             FJLP1             3 0
089701110531      /FREE
089800110531||||6              ELSE;
089801110531      /END-FREE
089900930216|||| C                   ADD       1             FJLP2             3 0
089901110531      /FREE
090000110531||||6              ENDIF;
090100110531||||5            ELSE;
090200110531||||6              IF SKEIOYM > WRKOYM;
090201110531      /END-FREE
090300930216|||| C                   ADD       1             FJOK1             3 0
090301110531      /FREE
090400110531||||6              ELSE;
090401110531      /END-FREE
090500930216|||| C                   ADD       1             FJOK2             3 0
090501110531      /FREE
090600110531||||6              ENDIF;
090700110531||||5            ENDIF;
090800110531|||E4          ENDIF;
090900110531||E3         ENDIF;
091000110531|E2        ENDIF;
091100110531|          READE SKKORT DBSK1;
091101110531           *IN89 = %EOF;
091200110531E1       ENDDO;
091300110531      /SPACE
091400110531       ENDSR;                                                                 //TELJAV
091500110531       //****************************************************
091600110531       // Fletta upp í vanskilaskrá RB                      *
091700110531       //
091800110531       // Svarkodi = '0'  ==> Er á vanskilaskrá
091900110531       // Svarkodi = '1'  ==> Er ekki á vanskilaskrá
092000110531       // Svarkodi = '9'  ==> Samband næst ekki við RB
092100110531       //****************************************************
092200110531       BEGSR RB_Vanskil;
092300110531
092400110531         Tegund = 'V';
092500110531         KENN12 = NIKENT;
092600110531         *IN40 = *OFF;
092601110531         *IN49 = *OFF;
092700110531
092800110531         Svarkodi = 'E';
092900110531         Fjoldi = '00';
092901110531      /END-FREE
093000080915     C                   Call      'KRKRBVLR'
093100080915     C                   Parm                    Kenn12
093200080915     C                   Parm                    Tegund
093300080915     C                   Parm                    Svarkodi
093400080915     C                   Parm                    Fjoldi
093500001006     C
093501110531      /FREE
093600110531         If Svarkodi = '0';
093700110531           *IN40 = *ON;
093701110531      /END-FREE
093800001129     C                   ADD       1             FJAVSSKRA                      Snorri
093801110531      /FREE
093900110531         Endif;
094000110531         If Svarkodi = '9';
094100110531           *IN49 = *ON;
094200110531         Endif;
094300110531
094400110531
094500110531       ENDSR;
094600110531       //****************************************************
094700110531       // Fletta upp í lokunarskrá RB                       *
094800110531       //
094900110531       // Svarkodi = '0'  ==> Er á lokunarskrá
095000110531       // Svarkodi = '1'  ==> Er ekki á lokunarskrá
095100110531       // Svarkodi = '9'  ==> Samband næst ekki við RB
095200110531       //****************************************************
095300110531       BEGSR RB_Lokskra;
095400110531
095500110531         Tegund = 'L';
095600110531         Fjolda = '00';
095700110531         Fjoldb = '00';
095800110531         KENN12 = NIKENT;
095900110531         *IN41 = *OFF;
095901110531         *IN49 = *OFF;
096000110531
096100110531         Svarkodi = 'E';
096101110531      /END-FREE
096200080915     C                   Call      'KRKRBVLR'
096300080915     C                   Parm                    Kenn12
096400080915     C                   Parm                    Tegund
096500080915     C                   Parm                    Svarkodi
096600080915     C                   Parm                    Fjolda
096700001128     C
096701110531      /FREE
096800110531         If Svarkodi = '0';
096900110531           *IN41 = *ON;
096901110531      /END-FREE
097000001129     C                   ADD       1             FJALKSKRA                      Snorri
097001110531      /FREE
097100110531         Endif;
097200110531         If Svarkodi = '9';
097300110531           *IN49 = *ON;
097400110531         Endif;
097500110531
097600110531
097700110531       ENDSR;
097800110531       //****************************************
097900110531       //  UPPSETNING BREYTNA OG LYKILSVÆÐA    **
098000110531       //****************************************
098100110531       BEGSR *INZSR;
098101110531      /END-FREE
098200911121     C     *ENTRY        PLIST
098300010130     C                   PARM                    PARAM1
098400010130     C                   PARM                    PARAM2
098500110531      //$C                   MOVE      PAOAM         OAM               6 0
098600110531      //$C                   MOVEL     PAOA          PRMOA             4 0
098700010219
098800010219     C     ScKEY         KLIST
098900010219     C                   KFLD                    ScKORT
099000010221     C                   KFLD                    ScGJLD
099100010219
099200930201     C     SKKEY         KLIST
099300930201     C                   KFLD                    SKKORT
099400930201     C                   KFLD                    SKGJLD
099500110531      //
099600930202     C     AUKEY         KLIST
099700930202     C                   KFLD                    AUBANK
099800930202     C                   KFLD                    AUKORT
099900030812
100000030812     c     ih00p         klist
100100030812     c                   kfld                    ihkort
100200040521
100300040521     c     uu01l         klist
100400040521     c                   kfld                    UUPRFX
100500040521     c                   kfld                    UUFLOK
100600030812
100601110531      /FREE
100700110531         select;
100800110531         when pamember = 'BORG';
100900110531           pfyrt = 'Borgun       ';
101000110531         when pamember = 'EURO';
101100110607           pfyrt = 'Kreditkort   ';
101200110531         when pamember = 'ISLB';
101300110531           pfyrt = 'Íslandsbanki ';
101400110531         when pamember = 'LANDSB';
101500110531           pfyrt = 'Landsbankinn ';
101600110531         when pamember = 'BUNB';
101700110531           pfyrt = 'Búnaðarbankinn';
101800110531         when pamember = 'SPRON';
101900110531           pfyrt = 'SPRON';
102000110531         when pamember = 'SPV';
102100110531           pfyrt = 'Sparisjóður Vélstjóra';
102200110531         when pamember = 'SPH';
102300110531           pfyrt = 'Sparisjóður Hafnafjarðar';
102400110531         when pamember = 'SPK';
102500110531           pfyrt = 'Sparisjóður Kópavogs';
102600110531         when pamember = 'SPKF';
102700110531           pfyrt = 'Sparisjóður Keflavíkur';
102800110531         when pamember = 'S24';
102900110531           pfyrt = 'S24 Kringla';
103000110531         when pamember = 'SPBO';
103100110531           pfyrt = 'Sparisjóður Bolungarvíkur';
103200110531         when pamember = 'SPHN';
103300110531           pfyrt = 'Sparisjóður Hornafjarðar og nágr';
103400110531         when pamember = 'SPHO';
103500110531           pfyrt = 'Sparisjóður Hólahrepps';
103600110531         when pamember = 'SPHOHV';
103700110531           pfyrt = 'Sparisjóður Höfðahverfinga';
103800110531         when pamember = 'SPHS';
103900110531           pfyrt = 'Sparisjóður Húnaþings og Stranda';
104000110531         when pamember = 'SPMS';
104100110531           pfyrt = 'Sparisjóður Mýrasýslu';
104200110531         when pamember = 'SPNL';
104300110531           pfyrt = 'Sparisjóður Norðlendinga';
104400110531         when pamember = 'SPNO';
104500110531           pfyrt = 'Sparisjóður Norðfjarðar';
104600110531         when pamember = 'SPOL';
104700110531           pfyrt = 'Sparisjóður Ólafsfjarðar';
104800110531         when pamember = 'SPOV';
104900110531           pfyrt = 'Sparisjóður Ólafsvíkur';
105000110531         when pamember = 'SPSE';
105100110531           pfyrt = 'Sparisjóðurinn Suðureyri';
105200110531         when pamember = 'SPSI';
105300110531           pfyrt = 'Sparisjóður Siglufjarðar';
105400110531         when pamember = 'SPSL';
105500110531           pfyrt = 'Sparisjóðurinn Suðurlandi';
105600110531         when pamember = 'SPSTH';
105700110531           pfyrt = 'Sparisjóður Suður-Þingeyinga';
105800110531         when pamember = 'SPSTR';
105900110531           pfyrt = 'Sparisjóður Strandamanna';
106000110531         when pamember = 'SPSV';
106100110531           pfyrt = 'Sparisjóður Svarfdæla';
106200110531         when pamember = 'SPTH';
106300110531           pfyrt = 'Sparisjóður Þingeyrarhrepps';
106400110531         when pamember = 'SPTHN';
106500110531           pfyrt = 'Sparisjóður Þórshafnar og nágr.';
106600110531         when pamember = 'SPVE';
106700110531           pfyrt = 'Sparisjóður Vestmannaeyja';
106800110531         when pamember = 'NETB';
106900110531           pfyrt = 'Netbankinn';
107000110531         other;
107100110531         endsl;
107200010129
107300110531      /SPACE
107301110531      /END-FREE
107400990324     C                   Z-ADD     99            WWTELJ            3 0
107500911121     C                   Z-ADD     0             X                 3 0
107600930217     C                   Z-ADD     0             FJSK              5 0
107700911121     C                   Z-ADD     0             FV                3 0
107800911122     C                   Z-ADD     0             SELEOK            3 0
107900911122     C                   Z-ADD     0             TOTUTT           15 2
108000911122     C                   Z-ADD     0             SKUTT            13 2
108100911122     C                   Z-ADD     0             VUTT             13 2
108200110531      //
108300990324     C                   MOVE      *DATE         #DAGS
108400060103     C                   MOVE      *DATE         #DAGS1
108500060103     c                   subdur    1:*m          #dags1
108600110531      //
108601110531      /FREE
108700110531         READ DBT2;
108701110531         *IN89 = %EOF;
108800110531         DOW *IN89 = '0';
108801110531      /END-FREE
108900911121     C                   ADD       1             X
109000911121     C                   MOVE      T2LKOD        T2(X)
109100911121     C                   MOVE      T2TEXT        T2T(X)
109200911125     C                   MOVE      T2ADGE        T2A(X)
109300911121     C                   Z-ADD     0             FJT2(X)
109301110531      /FREE
109400110531           READ DBT2;
109401110531           *IN89 = %EOF;
109500110531         ENDDO;                                                               // *IN89
109600110531         //
109601110531      /END-FREE
109700930218     C                   MOVE      *ON           *IN91
109800930218     C                   MOVE      *ON           *IN92
109801110531      /FREE
109900110531         CLEAR KRKRN2L2;
110000110531         CLEAR KRKRN2L3;
110100110531         CLEAR KRKRN2L4;
110200110531         //
110300110531       ENDSR;
110400110531       //-----------------------------------------------
110401110531      /END-FREE
110500930130     ODBGENPVV  EADD         PVVGEN
110600930130     O                       AUKORT              13
110700930130     O                       AUKRTN        X     16
