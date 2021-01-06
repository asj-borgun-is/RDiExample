000001210106**FREE
000002210106// ----------------------------------------------------------------------
000003210106// Example conversion of source to RPG Free form
000004210106//     done by Arcad Transformer RPG
000005210106//     with a temporary free trial license    ( 2 / 10 )
000006210106//     submitted by ASJ      2021-01-06    11.44.40
000007210106// (C) Copyright 1992,2015 ARCAD Software
000008210106// note : these comments do not appear with a permanent license
000009210106// ----------------------------------------------------------------------
000100120925/if defined(ow_def)
000200060405/eof
000300060405/endif
000400120925/define ow_def
000500060405
000600210105/copy qrpgsrc,dbxdef
000700121109
000800060410// Common definition specs
000900120925// 25.09.2012 Aðalsteinn Jónsson
001000051010
001100060405// Dummy null pointer for structure defines
001200120925dcl-s owNullP         pointer         inz(*null);
001300051010
001400081031// Constants --------------------------------------------------------------
001500081117
001600121011dcl-c OWX_ACT_ADD     'Add';
001601171109dcl-c OWX_ACT_UPDATE  'Update';
001602200812dcl-c OWX_ACT_DISABLE 'Disable';
001603201008dcl-c OWX_ACT_DELETE  'Delete';
001605121206dcl-c OWX_ACT_ADD_OR_UPDATE 'AddOrUpdate';
001701121217dcl-c OWX_ACT_ACTIVATE_PERSONAL 'ActivatePersonal';
001703130528dcl-c OWX_ACTIONCODE_ACCEPT_MC 'ACCEPT_MC';
001705130528dcl-c OWX_ACTIONCODE_ACCEPT_VC 'ACCEPT_VC';
001707130528dcl-c OWX_ACTIONCODE_TEMPLATE_SO 'TEMPLATE_SO';
001709130528dcl-c OWX_ACTIONCODE_MISC 'MISC_';
001711130528dcl-c OWX_ACTIONCODE_PAYMENT_OK 'PAYMENT_OK';
001713130521dcl-c OWX_ADDRESSTYPE_BNK_ADDR 'BNK_ADDR_';
001715130521dcl-c OWX_ADDRESSTYPE_BNK_ADDR_1 'BNK_ADDR_1';
001717121213dcl-c OWX_ADDRESSTYPE_CB_ADDR 'CB_ADDR';
001719121206dcl-c OWX_ADDRESSTYPE_REG_ADDR 'REG_ADDR';
001800121011dcl-c OWX_ADDRESSTYPE_STMT 'STMT';
001900120928dcl-c OWX_BORGUN_ACQ  '7001';
002001160812dcl-c OWX_BORGUN_ACQ_V3 '1501';
002100121011dcl-c OWX_CLIENT_NUMBER_CO 'CO';
002300121011dcl-c OWX_CLIENT_NUMBER_IPSP 'IPSP';
002500121002dcl-c OWX_CLIENT_NUMBER_ISO 'ISO';
002700121011dcl-c OWX_CLIENT_NUMBER_ST 'ST';
002900121001dcl-c OWX_CLIENT_TYPE_M_NRES 'M_NRES';
003001130513dcl-c OWX_CLIENT_TYPE_M_RES 'M_RES';
003003130528dcl-c OWX_CONTRACT_K1_SETTLE '001-MERCHANT_FEE';
003004141030dcl-c OWX_COUNTRY_ISL 'ISL';
003006141030dcl-c OWX_DELIVERYTYPE_RB 'RB';
003008130522dcl-c OWX_DELIVERYTYPE_SWIFT 'SWIFT';
003300120928dcl-c OWX_FILETYPE_XML 'xml';
003302150716dcl-c OWX_FILETYPE_001 '001';
003304170407dcl-c OWX_FININST_DOM_1501 '1501';
003306170407dcl-c OWX_FININST_INT_7001 '7001';
003308121130dcl-c OWX_GROUPTYPE_ISO 'ISO';
003401121130dcl-c OWX_GROUPTYPE_IPSP 'IPSP';
003403121204dcl-c OWX_GROUPTYPE_ST 'ST';
003405141029dcl-c OWX_GROUPTYPE_DCI 'DCI';
003500120928dcl-c OWX_KMAST_FLKA_OW 'OW';
003601160613dcl-c OWX_GROUPTYPE_V3 'V3';
003603170302dcl-c OWX_GROUPTYPE_FIX 'FIX';
003700120928dcl-c OWX_KMAST_FLKA_VERSL 'VERSL';
003900121011dcl-c OWX_KMAST_FLKB_CRSBKENN 'CRSBKENN';
004001140331dcl-c OWX_KMAST_FLKB_ISO 'ISO';
004100120928dcl-c OWX_KMAST_FLKB_ISOC 'ISOC';
004300120928dcl-c OWX_KMAST_FLKB_OWX 'OWX';
004401130527dcl-c OWX_KMAST_FLKB_SFTP 'SFTP';
004403130528dcl-c OWX_KMAST_FLKB_UPPGJREGL 'UPPGJREGL';
004405130531dcl-c OWX_KMAST_FLKB_TEGGJ 'TEGGJ';
004407161018dcl-c OWX_KMAST_FLKB_SWTBNK 'SWTBNK';
004409180130dcl-c OWX_KMAST_FLKB_LANG 'LANG';
004411190131dcl-c OWX_KMAST_FLKB_WWBLN1CLSF 'WWBLN1CLSF';
004412190131dcl-c OWX_JA          'J';
004413130528dcl-c OWX_LANG_ENG    'ENG';
004500121001dcl-c OWX_LANG_ISL    'ISL';
004600121113dcl-c OWX_LST_DIM     64;
004701130821dcl-c OWX_MSGCODE_PAY_RSV 'PAYFMRR';
004703130528dcl-c OWX_MSGCODE_PAY_SET 'PAYMACC';
004705130528dcl-c OWX_MSGCODE_PAY_NEG_SET 'PAYFMACC';
004706130528dcl-c OWX_NEI         'N';
004708121206dcl-c OWX_OBJ_CLIENT_ADDRESS 'ClientAddress';
004800121011dcl-c OWX_OBJ_CLIENT_CONTRACT 'ClientContract';
004901121204dcl-c OWX_OBJ_CONTRACT 'Contract';
004903140113dcl-c OWX_OBJ_CLIENT  'Client';
004904140113dcl-c OWX_OBJ_ORDER   'Order';
004905130528dcl-c OWX_OBJ_EVENT   'Event';
004906130530dcl-c OWX_OBJ_TARIFF  'Tariff';
004908170407dcl-c OWX_ORDERDPRT_DOM_1501 '1501';
004912170407dcl-c OWX_ORDERDPRT_INT_0101 '0101';
004914130513dcl-c OWX_PARMCODE_SETNO 'SETNO';
004915121204dcl-c OWX_PREFIX_APPF 'xadvapl700100';
005001160825dcl-c OWX_PREFIX_APPF_V3 'xadvapl150100';
005002160825dcl-c OWX_PREFIX_DOC  'IIC_Doc_700100';
005100121011dcl-c OWX_PRODUCT_EC_ISO 'EC-ISO';
005300121011dcl-c OWX_PRODUCT_EC_ISO_IPSP 'EC-ISO-IPSP';
005403130528dcl-c OWX_PRODUCT_EC_ISO_ST 'EC-ISO-ST';
005405130528dcl-c OWX_PRODUCT_EC_ISO_IPSP_ST 'EC-ISO-IPSP-ST';
005407121130dcl-c OWX_PRODUCT_EC_ISO_IPSP_W1_ST 'EC-ISO-IPSP_W1-ST';
005409130521dcl-c OWX_PRODUCT_EC_ISO_ST_W3 'EC-ISO-ST_W3';
005411130528dcl-c OWX_PRODUCT_EC_ST 'EC-ST';
005413160407dcl-c OWX_PRODUCT_EC_V2_ISO 'EC-V2-ISO';
005415160407dcl-c OWX_PRODUCT_EC_V2_ISO_IPSP 'EC-V2-ISO-IPSP';
005417160407dcl-c OWX_PRODUCT_EC_V2_ISO_ST 'EC-V2-ISO-ST';
005419160407dcl-c OWX_PRODUCT_EC_V2_ISO_IPSP_ST 'EC-V2-ISO-IPSP-ST';
005420160407dcl-c OWX_PRODUCT_EC_V2_ISO_IPSP_W1_ST
005421160407                      'EC-V2-ISO-IPSP_W1-ST';
005423160407dcl-c OWX_PRODUCT_EC_V2_ISO_ST_W3 'EC-V2-ISO-ST_W3';
005425160407dcl-c OWX_PRODUCT_EC_V2_ST 'EC-V2-ST';
005427160321dcl-c OWX_PRODUCT_DCI_ST 'DCI-ST';
005429160321dcl-c OWX_PRODUCT_DCI_ST_W2 'DCI-ST_W2';
005431160321dcl-c OWX_PRODUCT_DCI_ST_W3 'DCI-ST_W3';
005433160321dcl-c OWX_PRODUCT_DCI_ST_D 'DCI-ST_D';
005435141028dcl-c OWX_PRODUCT_DCI_V2_ST 'DCI-V2-ST';
005437141120dcl-c OWX_PRODUCT_DCI_V2_ST_W2 'DCI-V2-ST_W2';
005439141124dcl-c OWX_PRODUCT_DCI_V2_ST_W3 'DCI-V2-ST_W3';
005441151210dcl-c OWX_PRODUCT_DCI_V2_ST_D 'DCI-V2-ST_D';
005500121011dcl-c OWX_REG_NUMBER_SSN 'SSN';
005600121108dcl-c OWX_SENDER      '000100';
005602130426dcl-c OWX_RUN_GROUPID_IDX 2;
005603130426dcl-c OWX_RUNTYPE_MER 'MER';
005700130426dcl-c OWX_RUNTYPE_RSV 'RSV';
005701130426dcl-c OWX_RUNTYPE_SET 'SET';
005800120928dcl-c OWX_SENDER_SUFFIX '00';
005801121217dcl-c OWX_SO_PAY_     'SO_PAY_';
005804131112dcl-c OWX_SO_EARLY_PAY_ 'SO_Early_PAY_';
006100121011dcl-c OWX_TAG_ACTIONTYPE 'ActionType';
006300121011dcl-c OWX_TAG_ADDRESSLINE1 'AddressLine1';
006500121011dcl-c OWX_TAG_ADDRESSLINE2 'AddressLine2';
006700121011dcl-c OWX_TAG_ADDRESSLINE3 'AddressLine3';
006900121011dcl-c OWX_TAG_ADDRESSLINE4 'AddressLine4';
007100121011dcl-c OWX_TAG_ADDRESSTYPE 'AddressType';
007300121011dcl-c OWX_TAG_APPREGNUMBER 'AppRegNumber';
007500121001dcl-c OWX_TAG_CLIENTNUMBER 'ClientNumber';
007700121001dcl-c OWX_TAG_CLIENTTYPE 'ClientType';
007900121001dcl-c OWX_TAG_COMPANYNAME 'CompanyName';
008100121011dcl-c OWX_TAG_CITY    'City';
008300121011dcl-c OWX_TAG_COUNTRY 'Country';
008500120927dcl-c OWX_TAG_CREATIONDATE 'CreationDate';
008700120927dcl-c OWX_TAG_CREATIONTIME 'CreationTime';
008900121001dcl-c OWX_TAG_DATEOPEN 'DateOpen';
009100121001dcl-c OWX_TAG_EMAIL   'EMail';
009300121001dcl-c OWX_TAG_FIRSTNAME 'FirstName';
009500121001dcl-c OWX_TAG_INSTITUTION 'Institution';
009700121001dcl-c OWX_TAG_LANGUAGE 'Language';
009900121015dcl-c OWX_TAG_MAINCONTRACT 'MainContract';
010100121011dcl-c OWX_TAG_MOBILEPHONENUMBER 'MobilePhoneNumber';
010300120927dcl-c OWX_TAG_NUMBER  'Number';
010500121011dcl-c OWX_TAG_OBJECTTYPE 'ObjectType';
010700121011dcl-c OWX_TAG_PHONETYPE 'PhoneType';
010900121012dcl-c OWX_TAG_POSTALCODE 'PostalCode';
011100121012dcl-c OWX_TAG_PRODUCTCODE1 'ProductCode1';
011300121011dcl-c OWX_TAG_REGNUMBER 'RegNumber';
011500121001dcl-c OWX_TAG_SENDER  'Sender';
011700121011dcl-c OWX_TAG_WORKPHONENUMBER 'WorkPhoneNumber';
011701130522
011704130522dcl-c OWX_TARGETMEMBERID_ERL_SWIFT 'ERL_SWIFT';
011801141030dcl-c OWX_TARGETMEMBERID_INL_RB 'INL_RB';
011802170914dcl-c OWX_TARIFF_OMIT '(OMIT)';
012000120927dcl-c OWX_TEMPLATE_APPF 'OWXAPPFX';
012200121011dcl-c OWX_VARIANT_ISO '1';
012400121011dcl-c OWX_VARIANT_IPSP '2';
012401160902dcl-c OWX_VER_3       '3 ';
012402160902dcl-c OWX_SUBVER_EC   'EC';
012404160909dcl-c OWX_VER_3_SUBVER_AC '3 AC';
012406130530dcl-c OWX_VGJ_TEGJ_SWIFT 'SWIFT';
012501141106dcl-c OWX_VGJ_TEGJ_CHARGEFEE 'CHARGEFEE';
012502160609
012504160609dcl-c OWX_NODETYPE_EL_ELEMENT 'EL';
012506160609dcl-c OWX_NODETYPE_AT_ATTRIBUTE 'AT';
012507160609
012600120925// Field definitions ------------------------------------------------------
012700121108dcl-ds owFldDef based(owNullP) qualified;
012800121108  ClientNumber    varchar(20);
012900121001  Code            varchar(20);
013000121001  FileSeqNo       packed(5:0);
013100121001  FileSeqNoCh     char(5);
013200121001  IsoDate         packed(8:0);
013300121001  Language        char(3);
013400121001  LibName         char(10);
013500121001  MbrName         char(10);
013600121001  ObjName         char(10);
013700121002  RegNumber       varchar(30);
013800121204  ObjectType      varchar(30);
013801121204  ActionType      varchar(30);
013802130528  ActionCode      varchar(30);
013803130528  Sender          char(6);
013900121116  Name            varchar(40);
014000121116  Phone           varchar(20);
014100121116  Email           varchar(300);
014200130521  URL             varchar(300);
014201130521  Address         varchar(40);
014300121116  Country         char(3);
014400121116  City            varchar(20);
014500121116  PostalCode      varchar(10);
014600120927  XmlDate         char(10);
014700120927  XmlTime         char(8);
014701130513  XmlDateTime     char(19);
014800121109  XmlTag          varchar(64);
014900140128  XmlValue        varchar(320);
015000160609  XmlRecStr       varchar(453);
015100160609  XmlFixRecStr    char(453);
015200130514  XmlAmount       varchar(21);
015201130531  XmlPercent      varchar(7);
015202160609  XmlNodeType     char(2);
015203130514  IfsName         varchar(256);
015204121217  TargetNumber    varchar(20);
015205121217  OrderDetails    varchar(20);
015206130510  CmdLinStr       char(32);
015207130513  Description     varchar(128);
015208130513  Currency        char(3);
015209130514  Amount          packed(19:4);
015210130527  Uker            packed(5:0);
015211130527  DateCh          char(8);
015212130604  Contract        varchar(25);
015213130613  Condition       varchar(200);
015214131212  ProductCode     varchar(30);
015215140114  SubDomain       varchar(9);
015216140114  BigCode         varchar(40);
015217151210  TermId          char(10);
015218161116  Comment         varchar(40);
015219170308  FinInst         char(4);
015220210106end-ds;
015221140114
015301121130// Column reference -------------------------------------------------------
015302121130dcl-ds owxColRef extname('OWXCOLREF') based(owNullP) qualified;
015304210106end-ds;
015305121130
015400121001// Various structures -----------------------------------------------------
015500121001
015600121109dcl-ds owxAttr based(owNullP) qualified;
015700121112  Tag             like(owFldDef.XmlTag);
015800121109  Value           like(owFldDef.XmlValue);
015801210106end-ds;
015900121109
016000121001// File sequence data area ------------------------------------------------
016100121001dcl-ds owxFseqA based(owNullP) qualified;
016200121001  IsoDate         zoned(8:0);
016300121001  SeqNo           zoned(5:0);
016301210106end-ds;
016400121001
016500120928// Config structures ------------------------------------------------------
016600120928
016700120928// KMAST.OW.OWX
016900120928dcl-ds owxKmastOwOwx based(owNullP) qualified;
017000130527  Outbox          char(50);
017001130527  RemoteDir       char(50);
017002210106end-ds;
017100120928
017101130527// KMAST.OW.SFTP
017103130527dcl-ds owxKmastOwSftp based(dbxNullP) qualified;
017104130527  LocalUser       char(10);
017105130527  RemoteUser      char(20);
017106130527  RemoteHost      char(20);
017107130527  RemotePort      char(5);
017108130527  LogDir          char(50);
017109210106end-ds;
017110130527
017111130528// KMAST.OW.UPPGJREGL
017112130528dcl-ds owxKmastOwUppgjregl based(owNullP) qualified;
017113130528  W4Key           char(10);
017114210106end-ds;
017115130528
017116130531// KMAST.OW.TEGGJ
017117130531dcl-ds owxKmastOwTeggj based(owNullP) qualified;
017118130531  TariffCode      char(25);
017119130531  ConcCurr        char(1);
017120130531  IsClientLevel   char(1);
017121130531  IsPercent       char(1);
017122130531  IsAmount        char(1);
017123140407  OvrSubd         char(1);
017124140408  Inter           char(1);
017125140408  Intra           char(1);
017126140408  Domestic        char(1);
017127160504  TariffCodeExt   char(25);
017128210106end-ds;
017129160504
017200121011// KMAST.VERSL.CRSBKENN
017400121011dcl-ds owxKmastVerslCrsbKenn based(owNullP) qualified;
017500121011  Heim1           char(40);
017600121011  Heim2           char(40);
017700121011  Heim3           char(40);
017800121011  Postnr          char(12);
017900121011  PostnrHeiti     char(30);
018000121011  Land            char(30);
018100160818  Ipsp            char(1);
018300160818  ContractNumber  char(25);
018500160818  Pf              char(1);
018501210106end-ds;
018600121011
018601180129// KMAST.OW.CRSBKENN
018603180129dcl-ds owxKmastOwCrsbKenn based(owNullP) qualified;
018604180129  Ipsp            char(1);
018611180129  ContractNumber  char(25);
018612180129  Pf              char(1);
018613200211  GroupClass      char(25);
018614210106end-ds;
018615200211
018700120928// KMAST.VERSL.ISO
018900120928dcl-ds owxKmastVerslIso based(owNullP) qualified;
019000120928  Nafn            char(40);
019100120928  Heim1           char(40);
019200120928  Heim2           char(40);
019300121116  ContractNumber  char(40);
019400120928  NetfIso         char(200);
019500120928  NetfBorgun      char(200);
019600120928  VidskReikn      char(15);
019700120928  Excel           char(1);
019800120928  DecDot          char(1);
019900120928  Innl            char(1);
020000120928  SamnMynt        char(3);
020100121116  RegNumber       char(20);
020101210106end-ds;
020200120928
020201140331// KMAST.OW.ISO
020203140331dcl-ds owxKmastOwIso based(owNullP) qualified;
020204181127  TarDomain       char(20);
020205170118  UseIsoCurr      char(1);
020206180205  DefaultCurr     char(3);
020207180205  OtherCurr1      char(3);
020208180205  OtherCurr2      char(3);
020209180205  OtherCurr3      char(3);
020210181114  GroupClass      char(25);
020211190326  IsNotIso        char(1);
020212190709  SetVat          char(1);
020213191112  MifPp           char(1);
020214210106end-ds;
020215140331
020216161018// KMAST.OW.SWTBNK
020217161018dcl-ds owxKmastOwSwtbnk based(owNullP) qualified;
020218161018  PayMethod       char(20);
020219161018  BirthName       char(40);
020220180314  CalendarType    char(20);
020221210106end-ds;
020222161018
020223180130// KMAST.OW.LANG
020224180130dcl-ds owxKmastOwLang based(owNullP) qualified;
020225180130  Language        char(3);
020226210106end-ds;
020227180130
020228190131// KMAST.OW.WWBLN1CLSF
020229190131dcl-ds owxKmastOwWwbln1Clsf based(owNullP) qualified;
020230190131  Code            char(20);
020231190131  Value           char(40);
020232210106end-ds;
020233190131
020300120925// Procedure prototypes ---------------------------------------------------
020400120925
020401130514// Amount to xml **********************************************************
020403130514dcl-pr owxAmountToXml like(owFldDef.XmlAmount);
020405130514  pAmount         like(owFldDef.Amount) const;
020406210106end-pr;
020407130514
020500120927// Date to xml ************************************************************
020700120927dcl-pr owxDateToXml like(owFldDef.XmlDate);
020800120927  pDate           date(*iso)      const;
020801210106end-pr;
020900120927
021000120927// Time to xml ************************************************************
021200120927dcl-pr owxTimeToXml like(owFldDef.XmlTime);
021300120927  pTime           time            const;
021301210106end-pr;
021400120927
021500121112// Initialize Xml file ****************************************************
021600121112dcl-pr owxInit;
021700130510  pRunType        const like(owxColRef.RUNTYPE)
021701130510                  options(*nopass:*omit);
021702140206  pFileCode       const like(owFldDef.Code)
021703160609                  options(*nopass:*omit);
021705160609  pDoHead         ind             const options(*nopass:*omit);
021706170308  pFinInst        const like(owFldDef.FinInst)
021707170308                  options(*nopass:*omit);
021708210106end-pr;
021709170308
021800121109// Dynamic xml element ****************************************************
021900121109dcl-pr owxDynElem;
022000121109  pTag            const like(owFldDef.XmlTag)
022100121109                  options(*varsize);
022200121109  pProc           pointer(*proc)  const;
022300121113  pAttr           likeds(owxAttr) dim(OWX_LST_DIM)
022400121109                  options(*varsize:*nopass);
022500121109  pAttrNo         const like(dbxFldRef.Index)
022600121109                  options(*nopass);
022601210106end-pr;
022700121109
022800121113// Data xml element *******************************************************
022900121113dcl-pr owxDtaElem;
023000121113  pTag            const like(owFldDef.XmlTag)
023100121113                  options(*varsize);
023200121113  pValue          const like(owFldDef.XmlValue)
023300121113                  options(*varsize:*nopass:*omit);
023400121113  pAttr           likeds(owxAttr) dim(OWX_LST_DIM)
023500121113                  options(*varsize:*nopass);
023600121113  pAttrElem       const like(dbxFldRef.Index)
023700121113                  options(*nopass);
023701210106end-pr;
023800121113
023900121113// Data list element ******************************************************
024000121113dcl-pr owxDtaLstElem;
024100121113  pTag            const like(owFldDef.XmlTag)
024200121113                  options(*varsize);
024300121113  pDtaLst         likeds(owxAttr) dim(OWX_LST_DIM)
024400121113                  options(*varsize);
024500121113  pDtaLstElem     const like(dbxFldRef.Index);
024600121113  pAttr           likeds(owxAttr) dim(OWX_LST_DIM)
024700121113                  options(*varsize:*nopass);
024800121113  pAttrElem       const like(dbxFldRef.Index)
024900121113                  options(*nopass);
024901210106end-pr;
025000121113
025100121112// Xml header *************************************************************
025200121112dcl-pr owxHeader end-pr;
025300121112
025400121112// Close Xml work file ****************************************************
025500121112dcl-pr owxCloseWork end-pr;
025600121112
025700121112// Write Xml stream file **************************************************
025800121112dcl-pr owxWriteIfs end-pr;
025900121112
026000121113// Assign to list *********************************************************
026100121113dcl-pr owxAssgnLst;
026200121113  pLst            likeds(owxAttr) dim(OWX_LST_DIM)
026300121113                  options(*varsize);
026400121113  pLstElem        const like(dbxFldRef.Index);
026500121113  pTag1           like(owFldDef.XmlTag)
026600121113                  const options(*varsize);
026700121113  pValue1         like(owFldDef.XmlValue)
026800121113                  const options(*varsize);
026900121113  pTag2           like(owFldDef.XmlTag)
027000121113                  const options(*varsize:*nopass);
027100121113  pValue2         like(owFldDef.XmlValue)
027200121113                  const options(*varsize:*nopass);
027300121113  pTag3           like(owFldDef.XmlTag)
027400121113                  const options(*varsize:*nopass);
027500121113  pValue3         like(owFldDef.XmlValue)
027600121113                  const options(*varsize:*nopass);
027700121113  pTag4           like(owFldDef.XmlTag)
027800121113                  const options(*varsize:*nopass);
027900121113  pValue4         like(owFldDef.XmlValue)
028000121113                  const options(*varsize:*nopass);
028100121113  pTag5           like(owFldDef.XmlTag)
028200121113                  const options(*varsize:*nopass);
028300121113  pValue5         like(owFldDef.XmlValue)
028400121113                  const options(*varsize:*nopass);
028500121113  pTag6           like(owFldDef.XmlTag)
028600121113                  const options(*varsize:*nopass);
028700121113  pValue6         like(owFldDef.XmlValue)
028800121113                  const options(*varsize:*nopass);
028900121113  pTag7           like(owFldDef.XmlTag)
029000121113                  const options(*varsize:*nopass);
029100121113  pValue7         like(owFldDef.XmlValue)
029200121113                  const options(*varsize:*nopass);
029300121113  pTag8           like(owFldDef.XmlTag)
029400121113                  const options(*varsize:*nopass);
029500121113  pValue8         like(owFldDef.XmlValue)
029600121113                  const options(*varsize:*nopass);
029700121113  pTag9           like(owFldDef.XmlTag)
029800121113                  const options(*varsize:*nopass);
029900121113  pValue9         like(owFldDef.XmlValue)
030000121113                  const options(*varsize:*nopass);
030100121113  pTag10          like(owFldDef.XmlTag)
030200121113                  const options(*varsize:*nopass);
030300121113  pValue10        like(owFldDef.XmlValue)
030400121113                  const options(*varsize:*nopass);
030500121113  pTag11          like(owFldDef.XmlTag)
030600121113                  const options(*varsize:*nopass);
030700121113  pValue11        like(owFldDef.XmlValue)
030800121113                  const options(*varsize:*nopass);
030900121113  pTag12          like(owFldDef.XmlTag)
031000121113                  const options(*varsize:*nopass);
031100121113  pValue12        like(owFldDef.XmlValue)
031200121113                  const options(*varsize:*nopass);
031300121113  pTag13          like(owFldDef.XmlTag)
031400121113                  const options(*varsize:*nopass);
031500121113  pValue13        like(owFldDef.XmlValue)
031600121113                  const options(*varsize:*nopass);
031700121113  pTag14          like(owFldDef.XmlTag)
031800121113                  const options(*varsize:*nopass);
031900121113  pValue14        like(owFldDef.XmlValue)
032000121113                  const options(*varsize:*nopass);
032100121113  pTag15          like(owFldDef.XmlTag)
032200121113                  const options(*varsize:*nopass);
032300121113  pValue15        like(owFldDef.XmlValue)
032400121113                  const options(*varsize:*nopass);
032500121113  pTag16          like(owFldDef.XmlTag)
032600121113                  const options(*varsize:*nopass);
032700121113  pValue16        like(owFldDef.XmlValue)
032800121113                  const options(*varsize:*nopass);
032801210106end-pr;
032900121113
033000121115// Start xml tag **********************************************************
033100121115dcl-pr owxStartTag;
033200121115  pTag            like(owFldDef.XmlTag)
033300121115                  const options(*varsize);
033301210106end-pr;
033400121115
033500121115// End xml tag ************************************************************
033600121115dcl-pr owxEndTag;
033700121115  pTag            like(owFldDef.XmlTag)
033800121115                  const options(*varsize);
033801210106end-pr;
033900121115
034000121115// Simple data element ****************************************************
034100121116dcl-pr owxSimDtaElem;
034200121115  pTag            const like(owFldDef.XmlTag)
034300121115                  options(*varsize);
034400121115  pValue          const like(owFldDef.XmlValue)
034500121116                  options(*varsize:*nopass:*omit);
034600121116  pCond           ind             const options(*nopass);
034601210106end-pr;
034700121116
034800121116// Simple data element string *********************************************
035000121116dcl-pr owxSimDtaElemStr like(owFldDef.XmlRecStr);
035100121116  pTag            const like(owFldDef.XmlTag)
035200121116                  options(*varsize);
035300121116  pValue          const like(owFldDef.XmlValue)
035400121116                  options(*varsize:*nopass:*omit);
035500121116  pCond           ind             const options(*nopass);
035501210106end-pr;
035600121116
035700121115// File sequence number ***************************************************
035800121115dcl-pr owxFileSeqNo like(owFldDef.FileSeqNoCh) end-pr;
035900121115
035901121130// File Name **************************************************************
035902121130dcl-pr owxFileName like(owFldDef.IfsName) end-pr;
035904121130
035905160609// Add XML node ***********************************************************
035906160609dcl-pr owyAddNode like(dbxFldRef.BigInt);
035908160609  pParNodeId      like(dbxFldRef.BigInt) const;
035909160609  pTag            like(owFldDef.XmlTag) const;
035910160609  pValue          like(owFldDef.XmlValue) const
035911160609                  options(*nopass:*omit);
035912160609  pCond           ind             const options(*nopass:*omit);
035913160609  pType           like(owFldDef.XmlNodeType)
035914160610                  const options(*nopass: *omit);
035915210106end-pr;
035916160609
035917160610// Add XML node to current node *******************************************
035918160610dcl-pr owyAddNodeCurr like(dbxFldRef.BigInt);
035919160610  pTag            like(owFldDef.XmlTag) const;
035920160610  pValue          like(owFldDef.XmlValue) const
035921160610                  options(*nopass:*omit);
035922160610  pCond           ind             const options(*nopass:*omit);
035923160610  pType           like(owFldDef.XmlNodeType)
035924160610                  const options(*nopass: *omit);
035925210106end-pr;
035926160610
035927160620// Add XML node to current node and set current ***************************
035928160620dcl-pr owyAddNodeCurrSet like(dbxFldRef.BigInt);
035930160620  pTag            like(owFldDef.XmlTag) const;
035931160620  pValue          like(owFldDef.XmlValue) const
035932160620                  options(*nopass:*omit);
035933160620  pCond           ind             const options(*nopass:*omit);
035934160620  pType           like(owFldDef.XmlNodeType)
035935160620                  const options(*nopass: *omit);
035936210106end-pr;
035937160620
035938160622// Add XML node to current node and push current **************************
035939160622dcl-pr owyAddNodeCurrPush like(dbxFldRef.BigInt);
035940160622  pTag            like(owFldDef.XmlTag) const;
035941160622  pValue          like(owFldDef.XmlValue) const
035942160622                  options(*nopass:*omit);
035943160622  pCond           ind             const options(*nopass:*omit);
035944160622  pType           like(owFldDef.XmlNodeType)
035945160622                  const options(*nopass: *omit);
035946210106end-pr;
035947160622
035948160622// Set current XML node ***************************************************
035949160610dcl-pr owySetCurrNode like(dbxFldRef.BigInt);
035950160610  pNodeId         like(dbxFldRef.BigInt) const;
035951210106end-pr;
035952160610
035953160610// Get current XML node ***************************************************
035954160610dcl-pr owyGetCurrNode like(dbxFldRef.BigInt) end-pr;
035955160610
035956160620// Reset current XML node *************************************************
035957160702dcl-pr owyResetCurrNode end-pr;
035958160620
035959160610// Generate XML file ******************************************************
035960160610dcl-pr owyGenFile;
035961160610  pNodeId         like(dbxFldRef.BigInt) const;
035962210106end-pr;
035963160610
035964160615// Push current XML node **************************************************
035965160615dcl-pr owyPushCurrNode;
035966160615  pNodeId         like(dbxFldRef.BigInt) const;
035967210106end-pr;
035968160615
035969160615// Pop current XML node ***************************************************
035970160615dcl-pr owyPopCurrNode end-pr;
035971160615
035972180301// Delete XML node ********************************************************
035973180301dcl-pr owyDeleteNode;
035974180301  pNodeId         like(dbxFldRef.BigInt) const;
035975210106end-pr;
035976180301
035977180301// XML node element count *************************************************
035978180301dcl-pr owyElementCount like(dbxFldRef.RecCount);
035979180301  pNodeId         like(dbxFldRef.BigInt) const;
035980210106end-pr;
035981180301
036000120927// Program prototypes -----------------------------------------------------
036100120927
036200120927// Test program for OWXUTILR **********************************************
036300120927dcl-pr owxUtilTr extpgm('OWXUTILTR');
036400120927  pTest           char(1);
036500130510  pParm1          const options(*nopass)
036501130510                  like(owFldDef.CmdLinStr);
036600130510  pParm2          const options(*nopass)
036601130510                  like(owFldDef.CmdLinStr);
036602210106end-pr;
036700120927
036800120927// OW Merchant migration **************************************************
036900120927dcl-pr owxMerMr extpgm('OWXMERMR');
037000130510  pGroupIdCh      const
037001130510                  like(owFldDef.CmdLinStr);
037100150415  pFinal          const options(*nopass)
037101150415                  like(owFldDef.CmdLinStr);
037102150415  pComment        const options(*nopass)
037103130510                  like(owFldDef.CmdLinStr);
037104210106end-pr;
037105121130
037106150401// OW Merchant migration daily ********************************************
037107150401dcl-pr owxMerMDr extpgm('OWXMERMDR');
037108150407  pProd           const like(owFldDef.CmdLinStr)
037109150407                  options(*nopass);
037110180307  pDoDci          ind             const options(*nopass);
037111210106end-pr;
037112180307
037113130527// OW Settlement migration ************************************************
037114130510dcl-pr owxSetMr extpgm('OWXSETMR');
037115130510  pUker           const
037116130527                  like(owFldDef.Uker);
037117130510  pComment        const options(*nopass)
037118130510                  like(owFldDef.CmdLinStr);
037119210106end-pr;
037120130510
037121130527// OW Pick settlements for migration **************************************
037122130527dcl-pr owxPSetMr extpgm('OWXPSETMR');
037123130527  pDupp           const options(*nopass)
037124130527                  like(owFldDef.DateCh);
037125130527  pComment        const options(*nopass)
037126130527                  like(owFldDef.CmdLinStr);
037127210106end-pr;
037128130527
037129130820// OW Rolling Reserve migration *******************************************
037130130820dcl-pr owxRsvMr extpgm('OWXRSVMR');
037131130820  pUker           const
037132130820                  like(owFldDef.Uker);
037133130820  pComment        const options(*nopass)
037134130820                  like(owFldDef.CmdLinStr);
037135210106end-pr;
037136130820
037137160609// OW Merchant migration V3 ***********************************************
037138160609dcl-pr owxMerM3R extpgm('OWXMERM3R');
037139160609  pGroupIdCh      const
037140160609                  like(owFldDef.CmdLinStr);
037141160609  pFinal          const options(*nopass)
037142160609                  like(owFldDef.CmdLinStr);
037143160609  pComment        const options(*nopass)
037144160609                  like(owFldDef.CmdLinStr);
037145190305  pGetLck         const options(*nopass)
037146190304                  like(owFldDef.CmdLinStr);
037147210106end-pr;
037148190304
