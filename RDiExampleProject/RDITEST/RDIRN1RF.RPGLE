000001990324       // ----------------------------------------------------------------------
000002990324       // Example conversion of source to RPG Free form
000003990324       //     done by Arcad Transformer RPG
000004990324       //     with a temporary free trial license    ( 4 / 10 )
000005990324       //     submitted by ASJ      2021-01-14    13.22.54
000006990324       // (C) Copyright 1992,2015 ARCAD Software
000007990324       // note : these comments do not appear with a permanent license
000008990324       // ----------------------------------------------------------------------
000100990324       ctl-opt DECEDIT('0,')  DATEDIT(*DMY.);
000101110531       // #Type   = BNDRPG
000102210114       // #Glb    = RD_GLB
000103110531       // #Commit = *NONE
000104110531       // #Fixnbr = *ZONED
000200110531       //*************************************************************************
000300110531       //  ÚTSKRIFT Á KORTUM SEM RENNA ÚT Í MÁNUÐINUM                            *
000400110531       //*                                                                       *
000500110531       //* SKRIFAÐ UPP ÚR FORRITI EFTIR GHB                                      *
000600110531       //* HARALDUR VÍÐISSON NÓV 1991                                            *
000700110531       //*                                                                       *
000800110531       //* BREYTT 30.01.1993 - GUÐM.J.JÓNSSON                                    *
000900110531       //*                     FERLI HF.                                         *
001000110531       //* BREYTT 21.09.2000 - Snorri Þórðarson                                  *
001100110531       //*   Bætti við kennitölu í listana og lagaði dálka í listunum            *
001200110531       //                                                                        *
001300110531       //  Breytt - 04.04.2001 - Guðm.J.Jónsson                                  *
001400110531       //           Sett '**' í RCKODI vegna síhringi merkinga í DBKMA           *
001500110531       //           Allar færslur sem ekki eru auðar í RCKODI , uppfæra          *
001600110531       //           DBKMA með síhringikóda( í forriti KRKRN7R).                  *
001700110531       //
001800110531       //  Breytt - 08.10.2001 - Guðm.J.Jónsson                                  *
001900110531       //           Member "S24" (banki 1113) bættt við                          *
002000110531       //------------------------------------------------------------------------*
002100110531       //  Breytt - 10.07.2002 - Guðm.J.Jónsson                                  *
002200110531       //           Taka síhringi kóta út hjá þeim korthöfum sem                 *
002300110531       //           eru skludlausir og fjv > 2                                   *
002400110531       //------------------------------------------------------------------------*
002500110531       //  Breytt - 02.01.2003 - Guðm.J.Jónsson                                  *
002600110531       //           Ýmsar lagfæringar v/brot á banka                             *
002700110531       //------------------------------------------------------------------------*
002800110531       //  Breytt - 03.05.2003 - Guðm.J.Jónsson                                  *
002900110531       //           Bætt við 19 memberum v/ýmisa sparisjóða .                    *
003000110531       //------------------------------------------------------------------------*
003100110531       //  Breytt - 23.06.2003 - Guðm.J.Jónsson                                  *
003200110531       //           Skuldaviðmiðum fyrir MC+ Íslandsbanka verði -3000kr.         *
003300110531       //------------------------------------------------------------------------*
003400110531       //  Breytt - 06.08.2003 - Guðm.J.Jónsson                                  *
003500110531       //           Member "NETB" (banki 1155) bættt við og                      *
003600110531       //           gerður að sér stofnun.                                       *
003700110531       //------------------------------------------------------------------------*
003800110531       //  Breytt - 11.08.2003 - Guðm.J.Jónsson                                  *
003900110531       //           Ekki skoða vanskilaskrá/lokunarskrá RB fyrir +kort           *
004000110531       //------------------------------------------------------------------------*
004100110531       //  Breytt - 12.08.2003 - GuðmþJ.Jónsson                                  *
004200110531       //           Ekk endurnýja +kort sem ekki hafa verið notuð                *
004300110531       //           (þ.e. það hefur aldrei komið innborgun).                     *
004400110531       //------------------------------------------------------------------------*
004500110531       //  Breytt - 21.05.2004 - Guðm.J.Jónsson                                  *
004600110531       //           Sækja upplýsingra um hvort megi taka síhringikóda af í       *
004700110531       //           skránna DBUMDSPL1.                                           *
004800110531       //------------------------------------------------------------------------*
004900110531       //  Breytt - 28.04.2005 - Guðm.J.Jónsson                                  *
005000110531       //           Fjöldi "greitt of seint" (fjrj1) til að taka af síhringikoda *
005100110531       //           af fjölgað úr 2 í 4.                                         *
005200110531       //------------------------------------------------------------------------*
005300110531       //  Breytt - 04.01.2006 - Guðm.J.Jónsson                                  *
005400110531       //           Korthafi má núna skulda tvo síðustu gíróseðla til að fá      *
005500110531       //           endurnýjun , einnig var viðmiðun á höfnun vegna fjölda "V"   *
005600110531       //           breytt í 99 í skránni DBRKRRN.                               *
005700110531       //------------------------------------------------------------------------*
005800110531       //  Breytt - 10.09.2008 - Guðm.J.Jónsson                                  *
005900110531       //           Nýr member fyrir Borgun og annað sem því fylgir.             *
005901110531       //------------------------------------------------------------------------*
005902110531       //  Breytt - 6.06.2011 - Haraldur Víðisson                                *
005903110531       //           Maska kortnúmer, einfalda endurnýjunarlista                  *
006000110531       //*************************************************************************
006100020708       dcl-f KRKRN1W    usage(*update:*delete) keyed;
006200930205       dcl-f DBKM       keyed;
006300010219       dcl-f DBSKc1     keyed;
006400010219       dcl-f DBSK1      keyed;
006500930130       dcl-f DBNI       keyed;
006600930130       dcl-f DBRK       keyed;
006700930206       dcl-f DBST       keyed;
006800930130       dcl-f DBT2       keyed;
006900930203       dcl-f DBUTB      keyed;
007000930204       dcl-f DBRKRN     keyed;
007100030812       dcl-f DBih       keyed;
007200040521       dcl-f dbumdspl1  keyed;
007300930130       dcl-f DBRCRD     usage(*output) keyed;
007400930130       dcl-f DBGENPVV   DISK(17) usage(*output);
007500930218       dcl-f KRKRN1P    PRINTER OFLIND(*IN91);
007600930218       dcl-f KRKRN2P    PRINTER OFLIND(*IN92);
007601110531      /copy qrpgsrc,dbxdef
007700110531       //-------------------------------------------------------------------------------------------
007800930130       dcl-s T2              char(1)         DIM(99);                           // LOKUNARKÓDAR
007900930130       dcl-s T2A             char(1)         DIM(99);                           // AÐGERÐ PR LOKKÓDA
008000930130       dcl-s FJT2            packed(7:0)     DIM(99);                           // FJÖLDI PR KÓDA
008100930130       dcl-s T2T             char(30)        DIM(99);                           // LOKUNARTEXTI
008200930130       dcl-s UTS             packed(11:2)    DIM(12);                           // UTTEKTIRINNL+ERL.
008300001006       dcl-s IDNR            char(10);                                          // Kennitala
008400001110       dcl-s IDNRGEYM        char(10);                                          // Ktalgeyma v/lista
008500001020       dcl-s KENN12          char(12);                                          // v/RB-fyrirspurnar
008600001006       dcl-s SVARKODI        char(5);                                           // v/RB-fyrirspurnar
008700001006       dcl-s TEGUND          char(1);                                           // v/RB-fyrirspurnar
008800001006       dcl-s FJOLDI          char(2);                                           // v/RB-fyrirspurnar
008900001128       dcl-s FJOLDA          char(2);                                           // v/RB-fyrirspurnar
009000001128       dcl-s FJOLDB          char(2);                                           // v/RB-fyrirspurnar
009100001130       dcl-s FJALKSKRA       packed(7:0);                                       // Fj. á lokunarskrá
009200001130       dcl-s FJAVSSKRA       packed(7:0);                                       // Fj.á vanskilaskrá
009300030623       dcl-s vidmid          packed(5:0);                                       // Skuldaviðmiðun
009400110531       //
009500060103       dcl-s #DAGS1          date;                                              // JULUDA
009600990324       dcl-s #DAGS           date;                                              // JULUDA
009700990324       dcl-s #EIND           date;                                              // JULDT1
009800990324       dcl-s #INBD           date;                                              // JULDT2
009900990324       dcl-s #EIND1          date;                                              // JULDT3
009901110531       dcl-s KMMED           ind;
009902110531       dcl-s wrkcrdno        char(16);
009903110531       dcl-s prtcrd          char(16);
010000110531       //
010100911120       dcl-ds *n;
010200970123         AUGILD          zoned(8:0)      pos(1);
010300990324         AUGOYM          zoned(6:0)      pos(1);
010400990324         AUGOO           zoned(2:0)      pos(1);
010500990324         AUGAA           zoned(2:0)      pos(3);
010600990324         AUGMM           zoned(2:0)      pos(5);
010700990324         AUGDD           zoned(2:0)      pos(7);
010701210114       end-ds;
010800930202       dcl-ds *n;
010900990324         PGILD           zoned(8:0)      pos(1);
011000930202         PGDD            zoned(2:0)      pos(1);
011100930202         PGMM            zoned(2:0)      pos(3);
011200990324         PGOO            zoned(2:0)      pos(5);
011300990324         PGAA            zoned(2:0)      pos(7);
011301210114       end-ds;
011400930202       dcl-ds *n;
011500990324         PGILD2          zoned(8:0)      pos(1);
011600930202         PGDD2           zoned(2:0)      pos(1);
011700930202         PGMM2           zoned(2:0)      pos(3);
011800990324         PGOO2           zoned(2:0)      pos(5);
011900990324         PGAA2           zoned(2:0)      pos(7);
011901210114       end-ds;
012000930202       dcl-ds *n;
012100970123         PDGLO           zoned(8:0)      pos(1);
012200930202         PDDD            zoned(2:0)      pos(1);
012300930202         PDMM            zoned(2:0)      pos(3);
012400970123         PDOO            zoned(2:0)      pos(5);
012500970123         PDAA            zoned(2:0)      pos(7);
012501210114       end-ds;
012600930202       dcl-ds *n;
012700990324         PGILD3          zoned(8:0)      pos(1);
012800930202         PGDD3           zoned(2:0)      pos(1);
012900930202         PGMM3           zoned(2:0)      pos(3);
013000990324         PGOO3           zoned(2:0)      pos(5);
013100990324         PGAA3           zoned(2:0)      pos(7);
013101210114       end-ds;
013200911122       dcl-ds *n;
013400911122         AUKORT          char(13)        pos(1);
013500911122         AUKRTN          zoned(3:0)      pos(14);
013501210114       end-ds;
013600911121       dcl-ds *n;
013700990324         RKLGIR          zoned(8:0)      pos(1);
013800990324         RKOO            zoned(2:0)      pos(1);
013900990324         RKYY            zoned(2:0)      pos(3);
014000990324         RKMM            zoned(2:0)      pos(5);
014100990324         RKDD            zoned(2:0)      pos(7);
014101210114       end-ds;
014200911121       dcl-ds *n;
014300990324         SKGJLD          zoned(8:0)      pos(1);
014400991220         SKGJOYM         zoned(6:0)      pos(1);
014500991220         SKGJOY          zoned(4:0)      pos(1);
014600991220         SKGJOO          zoned(2:0)      pos(1);
014700991220         SKGJYM          zoned(4:0)      pos(3);
014800991220         SKGJYY          zoned(2:0)      pos(3);
014900991220         SKGJMM          zoned(2:0)      pos(5);
015000990324         SKGJDD          zoned(2:0)      pos(7);
015001210114       end-ds;
015100010219       dcl-ds *n;
015200010219         ScGJLD          zoned(8:0)      pos(1);
015300010219         ScGJOYM         zoned(6:0)      pos(1);
015400010219         ScGJOY          zoned(4:0)      pos(1);
015500010219         ScGJOO          zoned(2:0)      pos(1);
015600010219         ScGJYM          zoned(4:0)      pos(3);
015700010219         ScGJYY          zoned(2:0)      pos(3);
015800010219         ScGJMM          zoned(2:0)      pos(5);
015900010219         ScGJDD          zoned(2:0)      pos(7);
015901210114       end-ds;
016000911125       dcl-ds *n;
016100990324         SKEIND          zoned(8:0)      pos(1);
016200990324         SKEIOYM         zoned(6:0)      pos(1);
016300990324         SKEIOO          zoned(2:0)      pos(1);
016400990324         SKEIYY          zoned(2:0)      pos(3);
016500990324         SKEIMM          zoned(2:0)      pos(5);
016600990324         SKEIDD          zoned(2:0)      pos(7);
016601210114       end-ds;
016700911125       dcl-ds *n;
016800990324         SKDINB          zoned(8:0)      pos(1);
016900990324         SKDIOO          zoned(2:0)      pos(1);
017000990324         SKDIYY          zoned(2:0)      pos(3);
017100990324         SKDIMM          zoned(2:0)      pos(5);
017200990324         SKDIDD          zoned(2:0)      pos(7);
017201210114       end-ds;
017300930202       dcl-ds *n;
017400970123         KMDGLO          zoned(8:0)      pos(1);
017500970123         KMDOO           zoned(2:0)      pos(1);
017600970123         KMDAA           zoned(2:0)      pos(3);
017700970123         KMDMM           zoned(2:0)      pos(5);
017800970123         KMDDD           zoned(2:0)      pos(7);
017801210114       end-ds;
017900911121       dcl-ds *n;
018000911121         KMU             zoned(11:2)     pos(1)
018100911121                           DIM(12);
018200911121         KMU01           zoned(11:2)     pos(1);
018300911121         KMU02           zoned(11:2)     pos(12);
018400911121         KMU03           zoned(11:2)     pos(23);
018500911121         KMU04           zoned(11:2)     pos(34);
018600911121         KMU05           zoned(11:2)     pos(45);
018700911121         KMU06           zoned(11:2)     pos(56);
018800911121         KMU07           zoned(11:2)     pos(67);
018900911121         KMU08           zoned(11:2)     pos(78);
019000911121         KMU09           zoned(11:2)     pos(89);
019100911121         KMU10           zoned(11:2)     pos(100);
019200911121         KMU11           zoned(11:2)     pos(111);
019300911121         KMU12           zoned(11:2)     pos(122);
019301210114       end-ds;
019400911121       dcl-ds *n;
019500911121         KME             zoned(11:2)     pos(1)
019600911121                           DIM(12);
019700911121         KME01           zoned(11:2)     pos(1);
019800911121         KME02           zoned(11:2)     pos(12);
019900911121         KME03           zoned(11:2)     pos(23);
020000911121         KME04           zoned(11:2)     pos(34);
020100911121         KME05           zoned(11:2)     pos(45);
020200911121         KME06           zoned(11:2)     pos(56);
020300911121         KME07           zoned(11:2)     pos(67);
020400911121         KME08           zoned(11:2)     pos(78);
020500911121         KME09           zoned(11:2)     pos(89);
020600911121         KME10           zoned(11:2)     pos(100);
020700911121         KME11           zoned(11:2)     pos(111);
020800911121         KME12           zoned(11:2)     pos(122);
020801210114       end-ds;
020900911121       dcl-ds *n;
021000911121         KMD             zoned(11:2)     pos(1)
021100911121                           DIM(12);
021200911121         KMD01           zoned(11:2)     pos(1);
021300911121         KMD02           zoned(11:2)     pos(12);
021400911121         KMD03           zoned(11:2)     pos(23);
021500911121         KMD04           zoned(11:2)     pos(34);
021600911121         KMD05           zoned(11:2)     pos(45);
021700911121         KMD06           zoned(11:2)     pos(56);
021800911121         KMD07           zoned(11:2)     pos(67);
021900911121         KMD08           zoned(11:2)     pos(78);
022000911121         KMD09           zoned(11:2)     pos(89);
022100911121         KMD10           zoned(11:2)     pos(100);
022200911121         KMD11           zoned(11:2)     pos(111);
022300911121         KMD12           zoned(11:2)     pos(122);
022301210114       end-ds;
022400911121       dcl-ds *n;
022500911121         KMI             zoned(11:2)     pos(1)
022600911121                           DIM(12);
022700911121         KMI01           zoned(11:2)     pos(1);
022800911121         KMI02           zoned(11:2)     pos(12);
022900911121         KMI03           zoned(11:2)     pos(23);
023000911121         KMI04           zoned(11:2)     pos(34);
023100911121         KMI05           zoned(11:2)     pos(45);
023200911121         KMI06           zoned(11:2)     pos(56);
023300911121         KMI07           zoned(11:2)     pos(67);
023400911121         KMI08           zoned(11:2)     pos(78);
023500911121         KMI09           zoned(11:2)     pos(89);
023600911121         KMI10           zoned(11:2)     pos(100);
023700911121         KMI11           zoned(11:2)     pos(111);
023800911121         KMI12           zoned(11:2)     pos(122);
023801210114       end-ds;
023900030624       dcl-ds *n;
024000030624         kmutge;
024100030624         kmutge1         char(2)         overlay(kmutge:1);
024101210114       end-ds;
024200030812       dcl-ds *n;
024300030812         ihkort;
024400030812         ihkort1         char(13)        overlay(ihkort:01);
024500030812         ihkort2         zoned(3:0)      overlay(ihkort:14);
024501210114       end-ds;
024600030812
024700030812       dcl-s ih_til          char(1);
024800110531       //
024801210114       dcl-s pDs_PiParm_001  pointer;
024900010130       dcl-ds PARAM1
024901210114                     based(pDs_PiParm_001);
025000990324         PAOAM           zoned(6:0)      pos(1);
025100990324         PAOA            zoned(4:0)      pos(1);
025200990324         PAOO            zoned(2:0)      pos(1);
025300990324         PAAA            zoned(2:0)      pos(3);
025400990324         PAMM            zoned(2:0)      pos(5);
025500990324         PADD            zoned(2:0)      pos(7);
025501210114       end-ds;
025502210114       dcl-s pDs_PiParm_002  pointer;
025600010130       dcl-ds PARAM2
025601210114                     based(pDs_PiParm_002);
025700010130         pamember        char(10)        pos(1);
025701210114       end-ds;
025800110531       //
025900930206       dcl-ds *n dtaara(*auto:*lda);
026000930206         OAICA           char(4)         pos(3);
026100930206         OAPRFX          char(6)         pos(7);
026101210114       end-ds;
026102210114
026103210114       dcl-ds PVVGEN len(17) qualified;
026104210114         aukort char(13);
026105210114         aukrtnch char(3);
026106210114       end-ds;
026107210114
026108210114       dcl-s #BANK           char(4);
026109210114       dcl-s LOKADG          char(1);
026110210114       dcl-s #FJVAF          packed(7:0);
026111210114       dcl-s #REGL1          packed(2:0);
026112210114       dcl-s #REGL2          packed(2:0);
026113210114       dcl-s #HVORT          char(1);
026114210114       dcl-s SKRIF1          char(1);
026115210114       dcl-s SFJOK1          packed(5:0);
026116210114       dcl-s SFJOK2          packed(5:0);
026117210114       dcl-s SFJRJ1          packed(5:0);
026118210114       dcl-s SFJRJ2          packed(5:0);
026119210114       dcl-s SFJLP1          packed(5:0);
026120210114       dcl-s SFJLP2          packed(5:0);
026121210114       dcl-s SFJUN1          packed(5:0);
026122210114       dcl-s SFJUN2          packed(5:0);
026123210114       dcl-s SKRIF2          char(1);
026124210114       dcl-s HFJOK1          packed(5:0);
026125210114       dcl-s HFJOK2          packed(5:0);
026126210114       dcl-s HFJRJ1          packed(5:0);
026127210114       dcl-s HFJRJ2          packed(5:0);
026128210114       dcl-s HFJLP1          packed(5:0);
026129210114       dcl-s HFJLP2          packed(5:0);
026130210114       dcl-s HFJUN1          packed(5:0);
026131210114       dcl-s HFJUN2          packed(5:0);
026132210114       dcl-s HSALD           packed(13:2);
026133210114       dcl-s TFJOK1          packed(5:0);
026134210114       dcl-s TFJOK2          packed(5:0);
026135210114       dcl-s TFJRJ1          packed(5:0);
026136210114       dcl-s TFJRJ2          packed(5:0);
026137210114       dcl-s TFJLP1          packed(5:0);
026138210114       dcl-s TFJLP2          packed(5:0);
026139210114       dcl-s TFJUN1          packed(5:0);
026140210114       dcl-s TFJUN2          packed(5:0);
026141210114       dcl-s #SKUL#          packed(11:2);
026142210114       dcl-s WRKOYM          packed(6:0);
026143210114       dcl-s FJUN1           packed(3:0);
026144210114       dcl-s FJUN2           packed(3:0);
026145210114       dcl-s FJRJ1           packed(3:0);
026146210114       dcl-s FJRJ2           packed(3:0);
026147210114       dcl-s FJLP1           packed(3:0);
026148210114       dcl-s FJLP2           packed(3:0);
026149210114       dcl-s FJOK1           packed(3:0);
026150210114       dcl-s FJOK2           packed(3:0);
026151210114       dcl-s WWTELJ          packed(3:0);
026152210114       dcl-s X               packed(3:0);
026153210114       dcl-s FV              packed(3:0);
026154210114       dcl-s SELEOK          packed(3:0);
026155210114       dcl-s TOTUTT          packed(15:2);
026156210114       dcl-s SKUTT           packed(13:2);
026157210114       dcl-s VUTT            packed(13:2);
026158210114       // Prototype for KRKRBVLR
026159210114       dcl-pr Pgm_KRKRBVLR extpgm('KRKRBVLR');
026160210114         Kenn12          char(12);
026161210114         Tegund          char(1);
026162210114         Svarkodi        char(5);
026163210114         Fjoldi          char(2);
026164210114       end-pr;
026165210114       // Prototype for RDIRN1R
026166210114       dcl-pr Pgm_RDIRN1R extpgm('RDIRN1R');
026167210114         Ds_PiParm_001   likeds(PARAM1);
026168210114         Ds_PiParm_002   likeds(PARAM2);
026169210114       end-pr;
026170210114       // Procedure interface for RDIRN1R
026171210114       dcl-pi Pgm_RDIRN1R;
026172210114         Ds_PiParm_001   likeds(PARAM1);
026173210114         Ds_PiParm_002   likeds(PARAM2);
026174210114       end-pi;
026200110531
026300110531
026301210114       pDs_PiParm_001 = %addr(Ds_PiParm_001);
026302210114       pDs_PiParm_002 = %addr(Ds_PiParm_002);
026400110531       READ KRKRN1W;
026401110531       *IN01 = %EOF;
026500930202X796   #BANK = AUBANK;
026600110531       //  SKRIFA HAUSA Í LISTA
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
028100930217X007       #SKULD = 0;
028200911122X007       SELEOK = 0;
028300930205X007       FJOK1 = 0;
028400930205X007       FJOK2 = 0;
028500930205X007       FJRJ1 = 0;
028600930205X007       FJRJ2 = 0;
028700930205X007       FJLP1 = 0;
028800930205X007       FJLP2 = 0;
028900930205X007       FJUN1 = 0;
029000930205X007       FJUN2 = 0;
029100970123X007       PDOO = KMDOO;
029200930202X007       PDAA = KMDAA;
029300930202X007       PDMM = KMDMM;
029400930202X007       PDDD = KMDDD;
029500110531           //
029600930316X796       LOKADG = ' ';
029700110531           IF KMLOKK <> ' ';
029800930316X007         X = 1;
029900930316X534         X = %lookup(KMLOKK : T2 : X);
029901210114X534         *in89 = (X > 0);
029902210114X534   // *CVTWNG : %Equal & %Found are not updated by %Lookup
029903210114X534         if X = 0;
029904210114X534           X = 1;
029905210114X534         endif;
030000110531             IF *IN89 = '1';
030100930316X006           FJT2(X) += 1;
030200930316X796           LOKADG = T2A(X);
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
031900971002X796           LOKADG = ' ';
032000110531               IF AULOKK <> ' ';
032100971002X007             X = 1;
032200971002X534             X = %lookup(AULOKK : T2 : X);
032201210114X534             *in89 = (X > 0);
032202210114X534   // *CVTWNG : %Equal & %Found are not updated by %Lookup
032203210114X534             if X = 0;
032204210114X534               X = 1;
032205210114X534             endif;
032300110531                 IF *IN89 = '1';
032400971002X006               FJT2(X) += 1;
032500971002X796               LOKADG = T2A(X);
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
033700930316X006             FJEKKI += 1;
033800110531               ELSE;
033900110531                 //  EF LOKUNARKÓDI/AÐGERÐARKÓDI ='2' OG AÐALKORT,
034000110531                 //  EKKI ENDURNÝJA
034100110531                 IF LOKADG = '2'
034200110531                   AND AUTEGU = 'A';
034300930316X006               FJEKKI += 1;
034400110531                 ELSE;
034500110531                   //
034600930217X006               FJALLS += 1;
034700911122X006               SELEOK += 1;
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
036100930201X692                     NAFN = NINAFN;
036200000920X692                     IDNR = NIKENT;
036300110531                       PGOO = AUGOO;
036400930202X007                     PGAA = AUGAA;
036500930202X007                     PGMM = AUGMM;
036600930202X007                     PGDD = AUGDD;
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
038100930202X692                     NAFN2 = NINAFN;
038200930202X007                     PKRNR2 = AUKRTN;
038300110531                       PGOO2 = AUGOO;
038400930202X007                     PGAA2 = AUGAA;
038500930202X007                     PGMM2 = AUGMM;
038600930202X007                     PGDD2 = AUGDD;
038700110531                     OTHER;
038800930202X692                     NAFN3 = NINAFN;
038900930202X007                     PKRNR3 = AUKRTN;
039000110531                       PGOO3 = AUGOO;
039100930202X007                     PGAA3 = AUGAA;
039200930202X007                     PGMM3 = AUGMM;
039300930202X007                     PGDD3 = AUGDD;
039400110531                     ENDSL;
039500110531                   ENDIF;
039600110531      /SPACE
039700110531                   IF SELEOK = 1;
039800110531                     CLEAR #HVORT;
039900930130X006                 FJEND += 1;
040000110531                     CHAIN KMREGL DBRK;
040001110531                     *IN89 = NOT %FOUND;
040100110531                     CHAIN KMREGL DBRKRN;
040101110531                     *IN89 = NOT %FOUND;
040200110531 B2                  IF KMVIPK = *BLANKS;
040300930217X007                   #FJVAF = RNFJV1;
040400930217X007                   #REGL1 = RNFVG1;
040500930217X007                   #REGL2 = RNFVE1;
040600110531 X2                  ELSE;
040700930208X007                   #FJVAF = RNFJV2;
040800930216X007                   #REGL1 = RNFVG2;
040900930216X007                   #REGL2 = RNFVE2;
041000110531 E2                  ENDIF;
041100110531                     //
041200110531                     if autegk = 'C';                                         //  Veltukort
041300110531                       EXSR ath_veltu_sk;
041400110531                     else;                                                    //  Önnur kort
041500110531                       EXSR TELJAV;
041600110531                     endif;
041700110531                     //
041800930202X007                 PIHEI = KMIHEI;
041900930205X007                 MFJOK1 = FJOK1;
042000930205X007                 MFJOK2 = FJOK2;
042100930205X007                 MFJRJ1 = FJRJ1;
042200930205X007                 MFJRJ2 = FJRJ2;
042300930205X007                 MFJLP1 = FJLP1;
042400930205X007                 MFJLP2 = FJLP2;
042500930205X007                 MFJUN1 = FJUN1;
042600930205X007                 MFJUN2 = FJUN2;
042700110531                     //
042800110531                     //  ATHUGA HVORT KORTHAFI SKULDI MEIRA EN SÍÐASTA GÍRÓSEÐIL
042900110531                     //
043000110531                   ENDIF;                        // SELEOK
043100110531                   //
043200110531                   //  AÐGERÐARKÓDI LOKUNARKÓDI SEGIR TIL HVORT MEGI ENDURNÝJA
043300110531                   //
043400110531                   IF LOKADG = 'D'                              // EKKI
043500110531                   OR LOKADG = 'P'                              // ENDURNÝJA
043600110531                   OR LOKADG = 'R';                             // ÞESSA KÓDA
043700110531                     SELECT;
043800110531                     WHEN SELEOK = 1;
043900930217X006                     FJEKKI += 1;
044000110531                     OTHER;
044100110531                     ENDSL;
044200110531                     //                 AÐRIR KÓDAR
044300110531                   ELSE;              // KOMA TIL
044400110531                     //                  GREINA.
044500110531                     //
044600110531                     if kmtegk = 'P';                        //Verið að athuga
044700110531                       ihkort1 = aukort;                    //hvort einhverjar
044800110531                       ihkort2 = 0;                         //hreyfingar hafi
044900110531                       chain ihkort dbih;                    //komið á +kort.
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
048200001116X692                       IDNRGEYM = IDNR;                                     // Viðbót Snorri
048300930216X796                       #HVORT = *on;
048400930216X796                       SKRIF1 = *on;
048500930217X006                       SKUTT += #SKULD;
048600930202X006                       FJSK += 1;
048700110531                           //
048800930215X006                       SFJOK1 += FJOK1;
048900930215X006                       SFJOK2 += FJOK2;
049000930215X006                       SFJRJ1 += FJRJ1;
049100930215X006                       SFJRJ2 += FJRJ2;
049200930215X006                       SFJLP1 += FJLP1;
049300930215X006                       SFJLP2 += FJLP2;
049400930215X006                       SFJUN1 += FJUN1;
049500930215X006                       SFJUN2 += FJUN2;
049600930217X006                       SSALD += #SKULD;
049700110531                           //
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
051800001116X692                         IDNRGEYM = IDNR;                                   // Viðbót Snorri
051900930216X796                         #HVORT = *on;
052000020919X796                         SKRIF1 = *on;
052100930217X006                         VUTT += #SKULD;
052200930217X006                         FJRJ += 1;                                         // FJ REJECT
052300110531                             //
052400930215X006                         SFJOK1 += FJOK1;
052500930215X006                         SFJOK2 += FJOK2;
052600930215X006                         SFJRJ1 += FJRJ1;
052700930215X006                         SFJRJ2 += FJRJ2;
052800930215X006                         SFJLP1 += FJLP1;
052900930215X006                         SFJLP2 += FJLP2;
053000930215X006                         SFJUN1 += FJUN1;
053100930215X006                         SFJUN2 += FJUN2;
053200930217X006                         SSALD += #SKULD;
053300110531                             //
053400110531                         WHEN SELEOK = 2;
053500110607                    //     WRITE KRKRN1L3;  vilja aðeins skuldara
053600110607                             //*   40              WRITE     KRKRN1L4A                Viðbót Snorri
053700110607                             //*   41              WRITE     KRKRN1L4B                Viðbót Snorri
053800110531                         OTHER;
053900110607                 //        WRITE KRKRN1L4;   vilja aðeins skuldara
054000110607                             //*   40              WRITE     KRKRN1L4A                Viðbót Snorri
054100110607                             //*   41              WRITE     KRKRN1L4B                Viðbót Snorri
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
056600930216X796                   SKRIF2 = *on;
056700110531                       //
056800930215X006                   HFJOK1 += FJOK1;
056900930215X006                   HFJOK2 += FJOK2;
057000930215X006                   HFJRJ1 += FJRJ1;
057100930215X006                   HFJRJ2 += FJRJ2;
057200930215X006                   HFJLP1 += FJLP1;
057300930215X006                   HFJLP2 += FJLP2;
057400930215X006                   HFJUN1 += FJUN1;
057500930215X006                   HFJUN2 += FJUN2;
057600930217X006                   HSALD += #SKULD;
057700110531                       //
057800110531                   WHEN SELEOK = 2;
057900110531                     WRITE KRKRN2L3;
057902210114                       if *in40;                                                // Viðbót Snorri
058000001110XF56                     write KRKRN2L4A;                                       // Viðbót Snorri
058001210114                       endif;                                                   // Viðbót Snorri
058002210114                       if *in41;                                                // Viðbót Snorri
058100001128XF56                     write KRKRN2L4B;                                       // Viðbót Snorri
058101210114                       endif;                                                   // Viðbót Snorri
058200110531                   OTHER;
058300110531                     WRITE KRKRN2L4;
058500110531                   ENDSL;
058600110531                   //
058700110531                 ENDIF;                                            // AÐG.+AUKAK
058800110531               ENDIF;                                            // AÐG.+AÐALK
058801210114               clear PVVGEN;
058802210114               PVVGEN.aukort = AUKORT;
058803210114               PVVGEN.aukrtnch = %editc(AUKRTN:'X');
058804210114               write DBGENPVV PVVGEN;
058900210114               //EXCEPT PVVGEN;                                   // FILE TO  GEN PVV
059000110531             ENDIF;                                             // AUGYM
059100110531
059200110531             UUPRFX = %subst(aukort:1:6);
059300110531             UUFLOK = auflok;
059400110531             chain (UUPRFX : UUFLOK) dbumdspl1;
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
062000110531             reade (AUBANK : AUKORT) KRKRN1W;
062001110531             *IN01 = %EOF;
062100110531           ENDDO;                                                             // *IN01
062200110531           //
062300110531           SELECT;
062400110531           WHEN SELEOK = 1;
062500110531             IF #HVORT = *ON;
062600110531               WRITE KRKRN1L3;
062700001108X692             IDNR = NIKENT;                                                 // Viðbót Snorri
062701210114                 if *in40;                                                      // Viðbót Snorri
062800001214XF56               write KRKRN1L4A;                                             // Viðbót Snorri
062801210114                 endif;                                                         // Viðbót Snorri
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
063900001110X692               IDNR = NIKENT;                                               // Viðbót Snorri
064000110531                 WRITE KRKRN1L4A;                                             //Viðbót Snorri
064100110531                 EXSR WRRCRD;                                                 //Viðbót Snorri
064200110531               ENDIF;                                                         //in40 Viðbót Snorri
064300110531               IF *IN41 = *ON;
064400110531                 IF *IN91 = *ON;                                              //Viðbót Snorri
064500110531                   WRITE KRKRN1L1;                                            //Viðbót Snorri
064501110531                   *IN91 = *OFF;
064700110531                 ENDIF;                                                       //Viðbót Snorri
064702210114                   if not *in40;                                                // Viðbót Snorri
064800001207XF56                 write KRKRN1L2;                                            // Viðbót Snorri
064801210114                   endif;                                                       // Viðbót Snorri
064900020919X796               SKRIF1 = *on;
064901210114                   if not *in40;                                                // Viðbót Snorri
065000001207XF56                 write KRKRN1L3;                                            // Viðbót Snorri
065001210114                   endif;                                                       // Viðbót Snorri
065002210114                   if not *in40;                                                // Viðbót Snorri
065100001207X692                 IDNR = NIKENT;                                             // Viðbót Snorri
065101210114                   endif;                                                       // Viðbót Snorri
065200110531                 WRITE KRKRN1L4B;                                             //Viðbót Snorri
065202210114                   if not *in40;                                                // Viðbót Snorri
065300001207XZ51                 exsr WRRCRD;                                               // Viðbót Snorri
065301210114                   endif;                                                       // Viðbót Snorri
065400110531               ENDIF;                                                         //in41 Viðbót Snorri
065500110531             ENDIF;                                                           //NIKENT Viðbót Snorri
065600110531             WRITE KRKRN2L3;
065700001110X692           IDNR = NIKENT;                                                   // Viðbót Snorri
065701210114               if *in40;                                                        // Viðbót Snorri
065800001214XF56             write KRKRN2L4A;                                               // Viðbót Snorri
065801210114               endif;                                                           // Viðbót Snorri
065802210114               if *in41;                                                        // Viðbót Snorri
065900001214XF56             write KRKRN2L4B;                                               // Viðbót Snorri
065901210114               endif;                                                           // Viðbót Snorri
066000110531           ENDSL;
066100110531           //
066200110531         ENDIF;                                                               // *IN02
066300110531         //
066400110531         setgt (AUBANK : AUKORT) KRKRN1W;
066500110531         READ KRKRN1W;
066501110531         *IN01 = %EOF;
066600110531         //
066700110531         IF AUBANK <> #BANK;
066800110531           //
066900110531           IF SKRIF2 = *ON;
067000930216X796         SKRIF2 = *off;
067100110531             CHAIN AUBANK DBUTB;
067101110531             *IN31 = NOT %FOUND;
067200110531             WRITE KRKRN2L1;
067300930218X719         *in92 = *off;
067400110531             //
067500930215X006         AFJOK1 += HFJOK1;
067600930215X006         AFJOK2 += HFJOK2;
067700930215X006         AFJRJ1 += HFJRJ1;
067800930215X006         AFJRJ2 += HFJRJ2;
067900930215X006         AFJLP1 += HFJLP1;
068000930215X006         AFJLP2 += HFJLP2;
068100930215X006         AFJUN1 += HFJUN1;
068200930215X006         AFJUN2 += HFJUN2;
068300930215X006         ASALD += HSALD;
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
069700930216X796         SKRIF1 = *off;
069800110531             IF *IN91 = *ON;
069900110531               WRITE KRKRN1L1;
069901110607               *IN91 = *OFF;
070100110531             ENDIF;
070200110531             WRITE KRKRN1L5;
070300110531             //
070400930215X006         TFJOK1 += SFJOK1;
070500930215X006         TFJOK2 += SFJOK2;
070600930215X006         TFJRJ1 += SFJRJ1;
070700930215X006         TFJRJ2 += SFJRJ2;
070800930215X006         TFJLP1 += SFJLP1;
070900930215X006         TFJLP2 += SFJLP2;
071000930215X006         TFJUN1 += SFJUN1;
071100930215X006         TFJUN2 += SFJUN2;
071200930215X006         TSALD += SSALD;
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
072500930202X796       #BANK = AUBANK;
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
073900930215X006   AFJOK1 += HFJOK1;
074000930215X006   AFJOK2 += HFJOK2;
074100930215X006   AFJRJ1 += HFJRJ1;
074200930215X006   AFJRJ2 += HFJRJ2;
074300930215X006   AFJLP1 += HFJLP1;
074400930215X006   AFJLP2 += HFJLP2;
074500930215X006   AFJUN1 += HFJUN1;
074600930215X006   AFJUN2 += HFJUN2;
074700930215X006   ASALD += HSALD;
074800110531       IF *IN92 = *ON;
074900110531         WRITE KRKRN2L1;
074901110607         *IN92 = *OFF;
075100110531       ENDIF;
075200110607
075300930215X006   TFJOK1 += SFJOK1;
075400930215X006   TFJOK2 += SFJOK2;
075500930215X006   TFJRJ1 += SFJRJ1;
075600930215X006   TFJRJ2 += SFJRJ2;
075700930215X006   TFJLP1 += SFJLP1;
075800930215X006   TFJLP2 += SFJLP2;
075900930215X006   TFJUN1 += SFJUN1;
076000930215X006   TFJUN2 += SFJUN2;
076100930215X006   TSALD += SSALD;
076200030103
076300110531       IF SKRIF1 = *ON;
076301110607          SKRIF1 = *OFF;
076500110531         IF *IN91 = *ON;
076600110531           WRITE KRKRN1L1;
076601110607           *IN91 = *OFF;
076800110531         ENDIF;
076900110531         WRITE KRKRN1L5;
077000110531       ENDIF;
077100110607
077200911122X005   TOTUTT = VUTT + SKUTT;
077300930217X009   FJM = FJALLS - FJEND;
077400110531       WRITE KRKRN1L1;
077500110531       WRITE KRKRN1L7;
077600110607
077700110531       WRITE KRKRN2L1;
077800110531       WRITE KRKRN2L7;
077900110531       WRITE KRKRN2L8;
078000110607
078100930217X297   for X = 1 To 99;
078200110531         IF FJT2(X) <> 0;
078300930217X007       PFJT2 = FJT2(X);
078400930217X693       %subst(PT2T:1:30) = T2T(X);
078500110531           WRITE KRKRN2L6;
078600110531         ENDIF;                                                               // FJT2,X
078700210114       EndFor;
078800110531       //
078900110531       //*************************************************************
079000110531       //  SKRIFA FÆRSLUR SEM EKKI EIGA AÐ FÁ ENDURNÝJUN Í SÉR SKRÁ **
079100110531       //  TIL MEÐHÖNDLUNAR AF KORTADEILD                           **
079200110531       //*************************************************************
079300110531       BEGSR WRRCRD;
079400911122X693     %subst(RCKORT:1:13) = AUKORT;
079500911122X787     %subst(RCKORT:14:3) = %editc(AUKRTN:'X');
079600970123X765     RCGILD = AUGILD;
079700930217X007     RCUPPH = #SKULD;
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
080900010221X798     %subst(ScKORT:14:3) = '000';
081000010219X693     %subst(ScKORT:1:13) = KMKORT;
081100010221X707     ScGJLD = *hival;
081200010219
081300110531         setgt (ScKORT : ScGJLD) DBSkc1;
081400110531         READpe ScKORT DBSKc1;
081401110531         *IN89 = %EOF;
081500110531B1       if *in89 = *off;
081600010219|
081700110531|          // EIND.
081800010219|
081900010219X006       #SKULD += Scminp;
082000010219X006       #SKULD += Scvxtm;
082100010219X008       #SKULD -= ScINbm;
082200010219|
082300010219X005       #SKUL# = Scminp + scvxtm;
082400010219X008       #SKUL# -= scinbm;
082500010219|
082600110531         endif;
082700010219
082800110531       endsr;
082900110531       //
083000110531       //*********************************
083100110531       //  Telja fjölda V merkinga      **
083200110531       //*********************************
083300110531       BEGSR TELJAV;
083400110531         //
083500930201X798     %subst(SKKORT:14:3) = '000';
083600930201X693     %subst(SKKORT:1:13) = KMKORT;
083700930201X007     SKGJDD = 1;
083800990324X765     SKGJMM = PAMM;
083900991220X009     SKGJOY = PAOA - 2;
084000990326X009     WRKOYM = PAOAM - 100;
084100110531         //
084200110531         setll (SKKORT : SKGJLD) DBSK1;
084300110531         READE SKKORT DBSK1;
084301110531         *IN89 = %EOF;
084400110531B1       DOW *IN89 = '0';
084500110531|          //
084600110531|          // EIND.
084700990324X734       #EIND = %date(SKEIND:*iso);
084800990324XD12       #EIND += %days(RKHDAG);
084900990324XD12       #EIND += %days(#REGL2);
085000110531           //
085100110531|          CLEAR #SKUL#;
085200110607|
085300110607           IF #DAGS1 > #EIND;    // #dags1=udate - 1mán
085400110607|                                // #eind=eind. skuldar
085500930217X006         #SKULD += SKUPPH;
085600930217X006         #SKULD += SKUPPV;
085700930217X008         #SKULD -= SKINNB;
085800110531             //
085900930421X005         #SKUL# = SKUPPV + SKUPPH;
086000930420X008         #SKUL# -= SKINNB;
086100110531             //
086200110531|          ENDIF;
086300110607|
086400990324X734       #EIND1 = %date(SKEIND:*iso);
086500990324XD12       #EIND1 += %days(#REGL1);
086600110531           // INNBD.
086700110531           IF SKDINB = 0;
086800110531             #INBD = *LOVAL;
086900110531           ELSE;
087000990324X734         #INBD = %date(SKDINB:*iso);
087100110531           ENDIF;
087200110531|          //
087300110531|B2        IF SKINNB = 0;
087400110531||B3         IF SKEIOYM > WRKOYM;
087500930205X006           FJUN1 += 1;
087600110531||X3         ELSE;
087700930205X006           FJUN2 += 1;
087800110531||E3         ENDIF;
087900110531|X2        ELSE;
088000110531             IF #DAGS > #EIND AND
088100110531|||                #SKUL# > 0;
088200110531|||B4          IF SKEIOYM > WRKOYM;
088300930216X006             FJRJ1 += 1;
088400110531|||X4          ELSE;
088500930216X006             FJRJ2 += 1;
088600110531|||E4          ENDIF;
088700110531||X3         ELSE;
088800110531               IF #INBD > #EIND;
088900110531||||5            IF SKEIOYM > WRKOYM;
089000930206X006               FJRJ1 += 1;
089100110531||||5            ELSE;
089200930206X006               FJRJ2 += 1;
089300110531||||5            ENDIF;
089400110531|||X4          ELSE;
089500110531                 IF #INBD > #EIND1;
089600110531||||6              IF SKEIOYM > WRKOYM;
089700930216X006                 FJLP1 += 1;
089800110531||||6              ELSE;
089900930216X006                 FJLP2 += 1;
090000110531||||6              ENDIF;
090100110531||||5            ELSE;
090200110531||||6              IF SKEIOYM > WRKOYM;
090300930216X006                 FJOK1 += 1;
090400110531||||6              ELSE;
090500930216X006                 FJOK2 += 1;
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
093001210114         Pgm_KRKRBVLR(Kenn12 : Tegund : Svarkodi : Fjoldi);
093500001006         //
093600110531         If Svarkodi = '0';
093700110531           *IN40 = *ON;
093800001129X006       FJAVSSKRA += 1;                                                      // Snorri
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
096201210114         Pgm_KRKRBVLR(Kenn12 : Tegund : Svarkodi : Fjolda);
096700001128         //
096800110531         If Svarkodi = '0';
096900110531           *IN41 = *ON;
097000001129X006       FJALKSKRA += 1;                                                      // Snorri
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
098101210114         pDs_PiParm_001 = %addr(Ds_PiParm_001);
098102210114         pDs_PiParm_002 = %addr(Ds_PiParm_002);
098500110531         //$C                   MOVE      PAOAM         OAM               6 0
098600110531         //$C                   MOVEL     PAOA          PRMOA             4 0
098700010219
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
107400990324X007     WWTELJ = 99;
107500911121X007     X = 0;
107600930217X007     FJSK = 0;
107700911121X007     FV = 0;
107800911122X007     SELEOK = 0;
107900911122X007     TOTUTT = 0;
108000911122X007     SKUTT = 0;
108100911122X007     VUTT = 0;
108200110531         //
108300990324X731     #DAGS = %date(*date);
108400060103X731     #DAGS1 = %date(*date);
108500060103XD32     #dags1 -= %months(1);
108600110531         //
108700110531         READ DBT2;
108701110531         *IN89 = %EOF;
108800110531         DOW *IN89 = '0';
108900911121X006       X += 1;
109000911121X796       T2(X) = T2LKOD;
109100911121X796       T2T(X) = T2TEXT;
109200911125X796       T2A(X) = T2ADGE;
109300911121X007       FJT2(X) = 0;
109400110531           READ DBT2;
109401110531           *IN89 = %EOF;
109500110531         ENDDO;                                                               // *IN89
109600110531         //
109700930218X719     *in91 = *on;
109800930218X719     *in92 = *on;
109900110531         CLEAR KRKRN2L2;
110000110531         CLEAR KRKRN2L3;
110100110531         CLEAR KRKRN2L4;
110200110531         //
110300110531       ENDSR;
110400210114
