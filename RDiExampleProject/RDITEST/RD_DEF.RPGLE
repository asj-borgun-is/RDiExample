000100120925      /if defined(ow_def)
000200060405      /eof
000300060405      /endif
000400120925      /define ow_def
000500060405
000600210105      /copy qrpgsrc,dbxdef
000700121109
000800060410      * Common definition specs
000900120925      * 25.09.2012 Aðalsteinn Jónsson
                  * 15.03.2022 Aðalsteinn. GitHub experiment.
001000051010
001100060405      * Dummy null pointer for structure defines
001200120925     dowNullP          s               *   inz(*null)
001300051010
001400081031      * Constants --------------------------------------------------------------
001500081117
001600121011     dOWX_ACT_ADD      c                   'Add'
001601171109     dOWX_ACT_UPDATE   c                   'Update'
001602200812     dOWX_ACT_DISABLE  c                   'Disable'
001603201008     dOWX_ACT_DELETE   c                   'Delete'
001604201008     dOWX_ACT_ADD_OR_UPDATE...
001605121206     d                 c                   'AddOrUpdate'
001700121217     dOWX_ACT_ACTIVATE_PERSONAL...
001701121217     d                 c                   'ActivatePersonal'
001702130528     dOWX_ACTIONCODE_ACCEPT_MC...
001703130528     d                 c                   'ACCEPT_MC'
001704130528     dOWX_ACTIONCODE_ACCEPT_VC...
001705130528     d                 c                   'ACCEPT_VC'
001706130528     dOWX_ACTIONCODE_TEMPLATE_SO...
001707130528     d                 c                   'TEMPLATE_SO'
001708130528     dOWX_ACTIONCODE_MISC...
001709130528     d                 c                   'MISC_'
001710130528     dOWX_ACTIONCODE_PAYMENT_OK...
001711130528     d                 c                   'PAYMENT_OK'
001712130521     dOWX_ADDRESSTYPE_BNK_ADDR...
001713130521     d                 c                   'BNK_ADDR_'
001714130521     dOWX_ADDRESSTYPE_BNK_ADDR_1...
001715130521     d                 c                   'BNK_ADDR_1'
001716130521     dOWX_ADDRESSTYPE_CB_ADDR...
001717121213     d                 c                   'CB_ADDR'
001718121213     dOWX_ADDRESSTYPE_REG_ADDR...
001719121206     d                 c                   'REG_ADDR'
001720121206     dOWX_ADDRESSTYPE_STMT...
001800121011     d                 c                   'STMT'
001900120928     dOWX_BORGUN_ACQ   c                   '7001'
002000160812     dOWX_BORGUN_ACQ_V3...
002001160812     d                 c                   '1501'
002002160812     dOWX_CLIENT_NUMBER_CO...
002100121011     d                 c                   'CO'
002200121011     dOWX_CLIENT_NUMBER_IPSP...
002300121011     d                 c                   'IPSP'
002400121011     dOWX_CLIENT_NUMBER_ISO...
002500121002     d                 c                   'ISO'
002600121011     dOWX_CLIENT_NUMBER_ST...
002700121011     d                 c                   'ST'
002800121002     dOWX_CLIENT_TYPE_M_NRES...
002900121001     d                 c                   'M_NRES'
003000121001     dOWX_CLIENT_TYPE_M_RES...
003001130513     d                 c                   'M_RES'
003002130513     dOWX_CONTRACT_K1_SETTLE...
003003130528     d                 c                   '001-MERCHANT_FEE'
003004141030     dOWX_COUNTRY_ISL  c                   'ISL'
003005141030     dOWX_DELIVERYTYPE_RB...
003006141030     d                 c                   'RB'
003007141030     dOWX_DELIVERYTYPE_SWIFT...
003008130522     d                 c                   'SWIFT'
003100130513     dOWX_FILETYPE_XML...
003300120928     d                 c                   'xml'
003301150716     dOWX_FILETYPE_001...
003302150716     d                 c                   '001'
003303170407     dOWX_FININST_DOM_1501...
003304170407     d                 c                   '1501'
003305170407     dOWX_FININST_INT_7001...
003306170407     d                 c                   '7001'
003307170407     dOWX_GROUPTYPE_ISO...
003308121130     d                 c                   'ISO'
003400121130     dOWX_GROUPTYPE_IPSP...
003401121130     d                 c                   'IPSP'
003402121204     dOWX_GROUPTYPE_ST...
003403121204     d                 c                   'ST'
003404141029     dOWX_GROUPTYPE_DCI...
003405141029     d                 c                   'DCI'
003406141029     dOWX_KMAST_FLKA_OW...
003500120928     d                 c                   'OW'
003600160613     dOWX_GROUPTYPE_V3...
003601160613     d                 c                   'V3'
003602170302     dOWX_GROUPTYPE_FIX...
003603170302     d                 c                   'FIX'
003604170302     dOWX_KMAST_FLKA_VERSL...
003700120928     d                 c                   'VERSL'
003800121011     dOWX_KMAST_FLKB_CRSBKENN...
003900121011     d                 c                   'CRSBKENN'
004000140331     dOWX_KMAST_FLKB_ISO...
004001140331     d                 c                   'ISO'
004002140331     dOWX_KMAST_FLKB_ISOC...
004100120928     d                 c                   'ISOC'
004200120928     dOWX_KMAST_FLKB_OWX...
004300120928     d                 c                   'OWX'
004400130527     dOWX_KMAST_FLKB_SFTP...
004401130527     d                 c                   'SFTP'
004402130528     dOWX_KMAST_FLKB_UPPGJREGL...
004403130528     d                 c                   'UPPGJREGL'
004404130531     dOWX_KMAST_FLKB_TEGGJ...
004405130531     d                 c                   'TEGGJ'
004406161018     dOWX_KMAST_FLKB_SWTBNK...
004407161018     d                 c                   'SWTBNK'
004408180130     dOWX_KMAST_FLKB_LANG...
004409180130     d                 c                   'LANG'
004410190131     dOWX_KMAST_FLKB_WWBLN1CLSF...
004411190131     d                 c                   'WWBLN1CLSF'
004412190131     dOWX_JA           c                   'J'
004413130528     dOWX_LANG_ENG     c                   'ENG'
004500121001     dOWX_LANG_ISL     c                   'ISL'
004600121113     dOWX_LST_DIM      c                   64
004700130821     dOWX_MSGCODE_PAY_RSV...
004701130821     d                 c                   'PAYFMRR'
004702130821     dOWX_MSGCODE_PAY_SET...
004703130528     d                 c                   'PAYMACC'
004704130528     dOWX_MSGCODE_PAY_NEG_SET...
004705130528     d                 c                   'PAYFMACC'
004706130528     dOWX_NEI          c                   'N'
004707130528     dOWX_OBJ_CLIENT_ADDRESS...
004708121206     d                 c                   'ClientAddress'
004709121206     dOWX_OBJ_CLIENT_CONTRACT...
004800121011     d                 c                   'ClientContract'
004900121204     dOWX_OBJ_CONTRACT...
004901121204     d                 c                   'Contract'
004902140113     dOWX_OBJ_CLIENT...
004903140113     d                 c                   'Client'
004904140113     dOWX_OBJ_ORDER    c                   'Order'
004905130528     dOWX_OBJ_EVENT    c                   'Event'
004906130530     dOWX_OBJ_TARIFF   c                   'Tariff'
004907170407     dOWX_ORDERDPRT_DOM_1501...
004908170407     d                 c                   '1501'
004909170407     dOWX_ORDERDPRT_INT_0101...
004912170407     d                 c                   '0101'
004913170407     dOWX_PARMCODE_SETNO...
004914130513     d                 c                   'SETNO'
004915121204     dOWX_PREFIX_APPF  c                   'xadvapl700100'
005000160825     dOWX_PREFIX_APPF_V3...
005001160825     d                 c                   'xadvapl150100'
005002160825     dOWX_PREFIX_DOC   c                   'IIC_Doc_700100'
005003130510     dOWX_PRODUCT_EC_ISO...
005100121011     d                 c                   'EC-ISO'
005200121011     dOWX_PRODUCT_EC_ISO_IPSP...
005300121011     d                 c                   'EC-ISO-IPSP'
005400131211     dOWX_PRODUCT_EC_ISO_ST...
005403130528     d                 c                   'EC-ISO-ST'
005404130528     dOWX_PRODUCT_EC_ISO_IPSP_ST...
005405130528     d                 c                   'EC-ISO-IPSP-ST'
005406130528     dOWX_PRODUCT_EC_ISO_IPSP_W1_ST...
005407121130     d                 c                   'EC-ISO-IPSP_W1-ST'
005408130521     dOWX_PRODUCT_EC_ISO_ST_W3...
005409130521     d                 c                   'EC-ISO-ST_W3'
005410130528     dOWX_PRODUCT_EC_ST...
005411130528     d                 c                   'EC-ST'
005412160407     dOWX_PRODUCT_EC_V2_ISO...
005413160407     d                 c                   'EC-V2-ISO'
005414160407     dOWX_PRODUCT_EC_V2_ISO_IPSP...
005415160407     d                 c                   'EC-V2-ISO-IPSP'
005416160407     dOWX_PRODUCT_EC_V2_ISO_ST...
005417160407     d                 c                   'EC-V2-ISO-ST'
005418160407     dOWX_PRODUCT_EC_V2_ISO_IPSP_ST...
005419160407     d                 c                   'EC-V2-ISO-IPSP-ST'
005420160407     dOWX_PRODUCT_EC_V2_ISO_IPSP_W1_ST...
005421160407     d                 c                   'EC-V2-ISO-IPSP_W1-ST'
005422160407     dOWX_PRODUCT_EC_V2_ISO_ST_W3...
005423160407     d                 c                   'EC-V2-ISO-ST_W3'
005424160407     dOWX_PRODUCT_EC_V2_ST...
005425160407     d                 c                   'EC-V2-ST'
005426160407     dOWX_PRODUCT_DCI_ST...
005427160321     d                 c                   'DCI-ST'
005428160321     dOWX_PRODUCT_DCI_ST_W2...
005429160321     d                 c                   'DCI-ST_W2'
005430160321     dOWX_PRODUCT_DCI_ST_W3...
005431160321     d                 c                   'DCI-ST_W3'
005432160321     dOWX_PRODUCT_DCI_ST_D...
005433160321     d                 c                   'DCI-ST_D'
005434160321     dOWX_PRODUCT_DCI_V2_ST...
005435141028     d                 c                   'DCI-V2-ST'
005436141120     dOWX_PRODUCT_DCI_V2_ST_W2...
005437141120     d                 c                   'DCI-V2-ST_W2'
005438141124     dOWX_PRODUCT_DCI_V2_ST_W3...
005439141124     d                 c                   'DCI-V2-ST_W3'
005440151210     dOWX_PRODUCT_DCI_V2_ST_D...
005441151210     d                 c                   'DCI-V2-ST_D'
005442151210     dOWX_REG_NUMBER_SSN...
005500121011     d                 c                   'SSN'
005600121108     dOWX_SENDER       c                   '000100'
005601130426     dOWX_RUN_GROUPID_IDX...
005602130426     d                 c                   2
005603130426     dOWX_RUNTYPE_MER  c                   'MER'
005700130426     dOWX_RUNTYPE_RSV  c                   'RSV'
005701130426     dOWX_RUNTYPE_SET  c                   'SET'
005702130426     dOWX_SENDER_SUFFIX...
005800120928     d                 c                   '00'
005801121217     dOWX_SO_PAY_      c                   'SO_PAY_'
005802141028     dOWX_SO_EARLY_PAY_...
005804131112     d                 c                   'SO_Early_PAY_'
005805131112     dOWX_TAG_ACTIONTYPE...
006100121011     d                 c                   'ActionType'
006200121011     dOWX_TAG_ADDRESSLINE1...
006300121011     d                 c                   'AddressLine1'
006400121011     dOWX_TAG_ADDRESSLINE2...
006500121011     d                 c                   'AddressLine2'
006600121011     dOWX_TAG_ADDRESSLINE3...
006700121011     d                 c                   'AddressLine3'
006800121011     dOWX_TAG_ADDRESSLINE4...
006900121011     d                 c                   'AddressLine4'
007000121011     dOWX_TAG_ADDRESSTYPE...
007100121011     d                 c                   'AddressType'
007200121011     dOWX_TAG_APPREGNUMBER...
007300121011     d                 c                   'AppRegNumber'
007400121011     dOWX_TAG_CLIENTNUMBER...
007500121001     d                 c                   'ClientNumber'
007600121001     dOWX_TAG_CLIENTTYPE...
007700121001     d                 c                   'ClientType'
007800121001     dOWX_TAG_COMPANYNAME...
007900121001     d                 c                   'CompanyName'
008000121011     dOWX_TAG_CITY...
008100121011     d                 c                   'City'
008200121011     dOWX_TAG_COUNTRY...
008300121011     d                 c                   'Country'
008400121011     dOWX_TAG_CREATIONDATE...
008500120927     d                 c                   'CreationDate'
008600120927     dOWX_TAG_CREATIONTIME...
008700120927     d                 c                   'CreationTime'
008800121001     dOWX_TAG_DATEOPEN...
008900121001     d                 c                   'DateOpen'
009000121001     dOWX_TAG_EMAIL...
009100121001     d                 c                   'EMail'
009200121001     dOWX_TAG_FIRSTNAME...
009300121001     d                 c                   'FirstName'
009400121001     dOWX_TAG_INSTITUTION...
009500121001     d                 c                   'Institution'
009600121001     dOWX_TAG_LANGUAGE...
009700121001     d                 c                   'Language'
009800121015     dOWX_TAG_MAINCONTRACT...
009900121015     d                 c                   'MainContract'
010000121015     dOWX_TAG_MOBILEPHONENUMBER...
010100121011     d                 c                   'MobilePhoneNumber'
010200121011     dOWX_TAG_NUMBER...
010300120927     d                 c                   'Number'
010400121011     dOWX_TAG_OBJECTTYPE...
010500121011     d                 c                   'ObjectType'
010600121011     dOWX_TAG_PHONETYPE...
010700121011     d                 c                   'PhoneType'
010800121012     dOWX_TAG_POSTALCODE...
010900121012     d                 c                   'PostalCode'
011000121012     dOWX_TAG_PRODUCTCODE1...
011100121012     d                 c                   'ProductCode1'
011200121012     dOWX_TAG_REGNUMBER...
011300121011     d                 c                   'RegNumber'
011400121011     dOWX_TAG_SENDER...
011500121001     d                 c                   'Sender'
011600121011     dOWX_TAG_WORKPHONENUMBER...
011700121011     d                 c                   'WorkPhoneNumber'
011701130522
011702130530     dOWX_TARGETMEMBERID_ERL_SWIFT...
011704130522     d                 c                   'ERL_SWIFT'
011800141030     dOWX_TARGETMEMBERID_INL_RB...
011801141030     d                 c                   'INL_RB'
011802170914     dOWX_TARIFF_OMIT  c                   '(OMIT)'
011803141030     dOWX_TEMPLATE_APPF...
012000120927     d                 c                   'OWXAPPFX'
012001130513     dOWX_VARIANT_ISO...
012200121011     d                 c                   '1'
012300121011     dOWX_VARIANT_IPSP...
012400121011     d                 c                   '2'
012401160902     dOWX_VER_3        c                   '3 '
012402160902     dOWX_SUBVER_EC    c                   'EC'
012403160909     dOWX_VER_3_SUBVER_AC...
012404160909     d                 c                   '3 AC'
012405160902     dOWX_VGJ_TEGJ_SWIFT...
012406130530     d                 c                   'SWIFT'
012500141106     dOWX_VGJ_TEGJ_CHARGEFEE...
012501141106     d                 c                   'CHARGEFEE'
012502160609
012503160609     dOWX_NODETYPE_EL_ELEMENT...
012504160609     d                 c                   'EL'
012505160609     dOWX_NODETYPE_AT_ATTRIBUTE...
012506160609     d                 c                   'AT'
012507160609
012600120925      * Field definitions ------------------------------------------------------
012700121108     dowFldDef         ds                  based(owNullP) qualified
012800121108     d ClientNumber                  20    varying
012900121001     d Code                          20    varying
013000121001     d FileSeqNo                      5p 0
013100121001     d FileSeqNoCh                    5
013200121001     d IsoDate                        8p 0
013300121001     d Language                       3
013400121001     d LibName                       10
013500121001     d MbrName                       10
013600121001     d ObjName                       10
013700121002     d RegNumber                     30    varying
013800121204     d ObjectType                    30    varying
013801121204     d ActionType                    30    varying
013802130528     d ActionCode                    30    varying
013803130528     d Sender                         6
013900121116     d Name                          40    varying
014000121116     d Phone                         20    varying
014100121116     d Email                        300    varying
014200130521     d URL                          300    varying
014201130521     d Address                       40    varying
014300121116     d Country                        3
014400121116     d City                          20    varying
014500121116     d PostalCode                    10    varying
014600120927     d XmlDate                       10
014700120927     d XmlTime                        8
014701130513     d XmlDateTime                   19
014800121109     d XmlTag                        64    varying
014900140128     d XmlValue                     320    varying
015000160609     d XmlRecStr                    453    varying
015100160609     d XmlFixRecStr                 453
015200130514     d XmlAmount                     21    varying
015201130531     d XmlPercent                     7    varying
015202160609     d XmlNodeType                    2
015203130514     d IfsName                      256    varying
015204121217     d TargetNumber                  20    varying
015205121217     d OrderDetails                  20    varying
015206130510     d CmdLinStr                     32
015207130513     d Description                  128    varying
015208130513     d Currency                       3
015209130514     d Amount                        19p 4
015210130527     d Uker                           5p 0
015211130527     d DateCh                         8
015212130604     d Contract                      25    varying
015213130613     d Condition                    200    varying
015214131212     d ProductCode                   30    varying
015215140114     d SubDomain                      9    varying
015216140114     d BigCode                       40    varying
015217151210     d TermId                        10
015218161116     d Comment                       40    varying
015219170308     d FinInst                        4
015220140114
015301121130      * Column reference -------------------------------------------------------
015302121130     dowxColRef      e ds                  based(owNullP) qualified
015303121130     d                                     extname(owxColRef)
015304121130
015400121001      * Various structures -----------------------------------------------------
015500121001
015600121109     dowxAttr          ds                  based(owNullP) qualified
015700121112     d Tag                                 like(owFldDef.XmlTag)
015800121109     d Value                               like(owFldDef.XmlValue)
015900121109
016000121001      * File sequence data area ------------------------------------------------
016100121001     dowxFseqA         ds                  based(owNullP) qualified
016200121001     d IsoDate                        8s 0
016300121001     d SeqNo                          5s 0
016400121001
016500120928      * Config structures ------------------------------------------------------
016600120928
016700120928      * KMAST.OW.OWX
016800120928     dowxKmastOwOwx...
016900120928     d                 ds                  based(owNullP) qualified
017000130527     d Outbox                        50
017001130527     d RemoteDir                     50
017100120928
017101130527      * KMAST.OW.SFTP
017102130527     dowxKmastOwSftp...
017103130527     d                 ds                  based(dbxNullP) qualified
017104130527     d LocalUser                     10
017105130527     d RemoteUser                    20
017106130527     d RemoteHost                    20
017107130527     d RemotePort                     5
017108130527     d LogDir                        50
017109130527
017110130528      * KMAST.OW.UPPGJREGL
017111130528     dowxKmastOwUppgjregl...
017112130528     d                 ds                  based(owNullP) qualified
017113130528     d W4Key                         10
017114130528
017115130531      * KMAST.OW.TEGGJ
017116130531     dowxKmastOwTeggj...
017117130531     d                 ds                  based(owNullP) qualified
017118130531     d TariffCode                    25
017119130531     d ConcCurr                       1
017120130531     d IsClientLevel                  1
017121130531     d IsPercent                      1
017122130531     d IsAmount                       1
017123140407     d OvrSubd                        1
017124140408     d Inter                          1
017125140408     d Intra                          1
017126140408     d Domestic                       1
017127160504     d TariffCodeExt                 25
017128160504
017200121011      * KMAST.VERSL.CRSBKENN
017300121011     dowxKmastVerslCrsbKenn...
017400121011     d                 ds                  based(owNullP) qualified
017500121011     d Heim1                         40
017600121011     d Heim2                         40
017700121011     d Heim3                         40
017800121011     d Postnr                        12
017900121011     d PostnrHeiti                   30
018000121011     d Land                          30
018100160818     d Ipsp                           1
018300160818     d ContractNumber                25
018500160818     d Pf                             1
018600121011
018601180129      * KMAST.OW.CRSBKENN
018602180129     dowxKmastOwCrsbKenn...
018603180129     d                 ds                  based(owNullP) qualified
018604180129     d Ipsp                           1
018611180129     d ContractNumber                25
018612180129     d Pf                             1
018613200211     d GroupClass                    25
018614200211
018700120928      * KMAST.VERSL.ISO
018800120928     dowxKmastVerslIso...
018900120928     d                 ds                  based(owNullP) qualified
019000120928     d Nafn                          40
019100120928     d Heim1                         40
019200120928     d Heim2                         40
019300121116     d ContractNumber                40
019400120928     d NetfIso                      200
019500120928     d NetfBorgun                   200
019600120928     d VidskReikn                    15
019700120928     d Excel                          1
019800120928     d DecDot                         1
019900120928     d Innl                           1
020000120928     d SamnMynt                       3
020100121116     d RegNumber                     20
020200120928
020201140331      * KMAST.OW.ISO
020202140331     dowxKmastOwIso...
020203140331     d                 ds                  based(owNullP) qualified
020204181127     d TarDomain                     20
020205170118     d UseIsoCurr                     1
020206180205     d DefaultCurr                    3
020207180205     d OtherCurr1                     3
020208180205     d OtherCurr2                     3
020209180205     d OtherCurr3                     3
020210181114     d GroupClass                    25
020211190326     d IsNotIso                       1
020212190709     d SetVat                         1
020213191112     d MifPp                          1
020214140331
020215161018      * KMAST.OW.SWTBNK
020216161018     dowxKmastOwSwtbnk...
020217161018     d                 ds                  based(owNullP) qualified
020218161018     d PayMethod                     20
020219161018     d BirthName                     40
020220180314     d CalendarType                  20
020221161018
020222180130      * KMAST.OW.LANG
020223180130     dowxKmastOwLang...
020224180130     d                 ds                  based(owNullP) qualified
020225180130     d Language                       3
020226180130
020227190131      * KMAST.OW.WWBLN1CLSF
020228190131     dowxKmastOwWwbln1Clsf...
020229190131     d                 ds                  based(owNullP) qualified
020230190131     d Code                          20
020231190131     d Value                         40
020232190131
020300120925      * Procedure prototypes ---------------------------------------------------
020400120925
020401130514      * Amount to xml **********************************************************
020402130514     dowxAmountToXml...
020403130514     d                 pr                  like(owFldDef.XmlAmount)
020405130514     d pAmount                             like(owFldDef.Amount) const
020406130514
020500120927      * Date to xml ************************************************************
020600120927     dowxDateToXml...
020700120927     d                 pr                  like(owFldDef.XmlDate)
020800120927     d pDate                           d   datfmt(*iso) const
020900120927
021000120927      * Time to xml ************************************************************
021100120927     dowxTimeToXml...
021200120927     d                 pr                  like(owFldDef.XmlTime)
021300120927     d pTime                           t   const
021400120927
021500121112      * Initialize Xml file ****************************************************
021600121112     dowxInit          pr
021700130510     d pRunType                            const like(owxColRef.RUNTYPE)
021701130510     d                                     options(*nopass:*omit)
021702140206     d pFileCode                           const like(owFldDef.Code)
021703160609     d                                     options(*nopass:*omit)
021705160609     d pDoHead                         n   const options(*nopass:*omit)
021706170308     d pFinInst                            const like(owFldDef.FinInst)
021707170308     d                                     options(*nopass:*omit)
021708170308
021800121109      * Dynamic xml element ****************************************************
021900121109     dowxDynElem       pr
022000121109     d pTag                                const like(owFldDef.XmlTag)
022100121109     d                                     options(*varsize)
022200121109     d pProc                           *   const procptr
022300121113     d pAttr                               likeds(owxAttr) dim(OWX_LST_DIM)
022400121109     d                                     options(*varsize:*nopass)
022500121109     d pAttrNo                             const like(dbxFldRef.Index)
022600121109     d                                     options(*nopass)
022700121109
022800121113      * Data xml element *******************************************************
022900121113     dowxDtaElem       pr
023000121113     d pTag                                const like(owFldDef.XmlTag)
023100121113     d                                     options(*varsize)
023200121113     d pValue                              const like(owFldDef.XmlValue)
023300121113     d                                     options(*varsize:*nopass:*omit)
023400121113     d pAttr                               likeds(owxAttr) dim(OWX_LST_DIM)
023500121113     d                                     options(*varsize:*nopass)
023600121113     d pAttrElem                           const like(dbxFldRef.Index)
023700121113     d                                     options(*nopass)
023800121113
023900121113      * Data list element ******************************************************
024000121113     dowxDtaLstElem    pr
024100121113     d pTag                                const like(owFldDef.XmlTag)
024200121113     d                                     options(*varsize)
024300121113     d pDtaLst                             likeds(owxAttr) dim(OWX_LST_DIM)
024400121113     d                                     options(*varsize)
024500121113     d pDtaLstElem                         const like(dbxFldRef.Index)
024600121113     d pAttr                               likeds(owxAttr) dim(OWX_LST_DIM)
024700121113     d                                     options(*varsize:*nopass)
024800121113     d pAttrElem                           const like(dbxFldRef.Index)
024900121113     d                                     options(*nopass)
025000121113
025100121112      * Xml header *************************************************************
025200121112     dowxHeader        pr
025300121112
025400121112      * Close Xml work file ****************************************************
025500121112     dowxCloseWork     pr
025600121112
025700121112      * Write Xml stream file **************************************************
025800121112     dowxWriteIfs      pr
025900121112
026000121113      * Assign to list *********************************************************
026100121113     dowxAssgnLst      pr
026200121113     d pLst                                likeds(owxAttr) dim(OWX_LST_DIM)
026300121113     d                                     options(*varsize)
026400121113     d pLstElem                            const like(dbxFldRef.Index)
026500121113     d pTag1                               like(owFldDef.XmlTag)
026600121113     d                                     const options(*varsize)
026700121113     d pValue1                             like(owFldDef.XmlValue)
026800121113     d                                     const options(*varsize)
026900121113     d pTag2                               like(owFldDef.XmlTag)
027000121113     d                                     const options(*varsize:*nopass)
027100121113     d pValue2                             like(owFldDef.XmlValue)
027200121113     d                                     const options(*varsize:*nopass)
027300121113     d pTag3                               like(owFldDef.XmlTag)
027400121113     d                                     const options(*varsize:*nopass)
027500121113     d pValue3                             like(owFldDef.XmlValue)
027600121113     d                                     const options(*varsize:*nopass)
027700121113     d pTag4                               like(owFldDef.XmlTag)
027800121113     d                                     const options(*varsize:*nopass)
027900121113     d pValue4                             like(owFldDef.XmlValue)
028000121113     d                                     const options(*varsize:*nopass)
028100121113     d pTag5                               like(owFldDef.XmlTag)
028200121113     d                                     const options(*varsize:*nopass)
028300121113     d pValue5                             like(owFldDef.XmlValue)
028400121113     d                                     const options(*varsize:*nopass)
028500121113     d pTag6                               like(owFldDef.XmlTag)
028600121113     d                                     const options(*varsize:*nopass)
028700121113     d pValue6                             like(owFldDef.XmlValue)
028800121113     d                                     const options(*varsize:*nopass)
028900121113     d pTag7                               like(owFldDef.XmlTag)
029000121113     d                                     const options(*varsize:*nopass)
029100121113     d pValue7                             like(owFldDef.XmlValue)
029200121113     d                                     const options(*varsize:*nopass)
029300121113     d pTag8                               like(owFldDef.XmlTag)
029400121113     d                                     const options(*varsize:*nopass)
029500121113     d pValue8                             like(owFldDef.XmlValue)
029600121113     d                                     const options(*varsize:*nopass)
029700121113     d pTag9                               like(owFldDef.XmlTag)
029800121113     d                                     const options(*varsize:*nopass)
029900121113     d pValue9                             like(owFldDef.XmlValue)
030000121113     d                                     const options(*varsize:*nopass)
030100121113     d pTag10                              like(owFldDef.XmlTag)
030200121113     d                                     const options(*varsize:*nopass)
030300121113     d pValue10                            like(owFldDef.XmlValue)
030400121113     d                                     const options(*varsize:*nopass)
030500121113     d pTag11                              like(owFldDef.XmlTag)
030600121113     d                                     const options(*varsize:*nopass)
030700121113     d pValue11                            like(owFldDef.XmlValue)
030800121113     d                                     const options(*varsize:*nopass)
030900121113     d pTag12                              like(owFldDef.XmlTag)
031000121113     d                                     const options(*varsize:*nopass)
031100121113     d pValue12                            like(owFldDef.XmlValue)
031200121113     d                                     const options(*varsize:*nopass)
031300121113     d pTag13                              like(owFldDef.XmlTag)
031400121113     d                                     const options(*varsize:*nopass)
031500121113     d pValue13                            like(owFldDef.XmlValue)
031600121113     d                                     const options(*varsize:*nopass)
031700121113     d pTag14                              like(owFldDef.XmlTag)
031800121113     d                                     const options(*varsize:*nopass)
031900121113     d pValue14                            like(owFldDef.XmlValue)
032000121113     d                                     const options(*varsize:*nopass)
032100121113     d pTag15                              like(owFldDef.XmlTag)
032200121113     d                                     const options(*varsize:*nopass)
032300121113     d pValue15                            like(owFldDef.XmlValue)
032400121113     d                                     const options(*varsize:*nopass)
032500121113     d pTag16                              like(owFldDef.XmlTag)
032600121113     d                                     const options(*varsize:*nopass)
032700121113     d pValue16                            like(owFldDef.XmlValue)
032800121113     d                                     const options(*varsize:*nopass)
032900121113
033000121115      * Start xml tag **********************************************************
033100121115     dowxStartTag      pr
033200121115     d pTag                                like(owFldDef.XmlTag)
033300121115     d                                     const options(*varsize)
033400121115
033500121115      * End xml tag ************************************************************
033600121115     dowxEndTag        pr
033700121115     d pTag                                like(owFldDef.XmlTag)
033800121115     d                                     const options(*varsize)
033900121115
034000121115      * Simple data element ****************************************************
034100121116     dowxSimDtaElem    pr
034200121115     d pTag                                const like(owFldDef.XmlTag)
034300121115     d                                     options(*varsize)
034400121115     d pValue                              const like(owFldDef.XmlValue)
034500121116     d                                     options(*varsize:*nopass:*omit)
034600121116     d pCond                           n   const options(*nopass)
034700121116
034800121116      * Simple data element string *********************************************
034900121116     dowxSimDtaElemStr...
035000121116     d                 pr                  like(owFldDef.XmlRecStr)
035100121116     d pTag                                const like(owFldDef.XmlTag)
035200121116     d                                     options(*varsize)
035300121116     d pValue                              const like(owFldDef.XmlValue)
035400121116     d                                     options(*varsize:*nopass:*omit)
035500121116     d pCond                           n   const options(*nopass)
035600121116
035700121115      * File sequence number ***************************************************
035800121115     dowxFileSeqNo     pr                  like(owFldDef.FileSeqNoCh)
035900121115
035901121130      * File Name **************************************************************
035902121130     dowxFileName      pr                  like(owFldDef.IfsName)
035904121130
035905160609      * Add XML node ***********************************************************
035906160609     dowyAddNode       pr                  like(dbxFldRef.BigInt)
035908160609     d pParNodeId                          like(dbxFldRef.BigInt) const
035909160609     d pTag                                like(owFldDef.XmlTag) const
035910160609     d pValue                              like(owFldDef.XmlValue) const
035911160609     d                                     options(*nopass:*omit)
035912160609     d pCond                           n   const options(*nopass:*omit)
035913160609     d pType                               like(owFldDef.XmlNodeType)
035914160610     d                                     const options(*nopass: *omit)
035915160609
035916160610      * Add XML node to current node *******************************************
035917160610     dowyAddNodeCurr   pr                  like(dbxFldRef.BigInt)
035919160610     d pTag                                like(owFldDef.XmlTag) const
035920160610     d pValue                              like(owFldDef.XmlValue) const
035921160610     d                                     options(*nopass:*omit)
035922160610     d pCond                           n   const options(*nopass:*omit)
035923160610     d pType                               like(owFldDef.XmlNodeType)
035924160610     d                                     const options(*nopass: *omit)
035925160610
035926160620      * Add XML node to current node and set current ***************************
035927160620     dowyAddNodeCurrSet...
035928160620     d                 pr                  like(dbxFldRef.BigInt)
035930160620     d pTag                                like(owFldDef.XmlTag) const
035931160620     d pValue                              like(owFldDef.XmlValue) const
035932160620     d                                     options(*nopass:*omit)
035933160620     d pCond                           n   const options(*nopass:*omit)
035934160620     d pType                               like(owFldDef.XmlNodeType)
035935160620     d                                     const options(*nopass: *omit)
035936160620
035937160622      * Add XML node to current node and push current **************************
035938160622     dowyAddNodeCurrPush...
035939160622     d                 pr                  like(dbxFldRef.BigInt)
035940160622     d pTag                                like(owFldDef.XmlTag) const
035941160622     d pValue                              like(owFldDef.XmlValue) const
035942160622     d                                     options(*nopass:*omit)
035943160622     d pCond                           n   const options(*nopass:*omit)
035944160622     d pType                               like(owFldDef.XmlNodeType)
035945160622     d                                     const options(*nopass: *omit)
035946160622
035947160622      * Set current XML node ***************************************************
035948160610     dowySetCurrNode   pr                  like(dbxFldRef.BigInt)
035949160610     d pNodeId                             like(dbxFldRef.BigInt) const
035950160610
035951160610      * Get current XML node ***************************************************
035952160610     dowyGetCurrNode   pr                  like(dbxFldRef.BigInt)
035953160610
035954160620      * Reset current XML node *************************************************
035955160620     dowyResetCurrNode...
035956160702     d                 pr
035957160620
035958160610      * Generate XML file ******************************************************
035959160610     dowyGenFile       pr
035960160610     d pNodeId                             like(dbxFldRef.BigInt) const
035961160610
035962160615      * Push current XML node **************************************************
035963160615     dowyPushCurrNode  pr
035964160615     d pNodeId                             like(dbxFldRef.BigInt) const
035965160615
035966160615      * Pop current XML node ***************************************************
035967160615     dowyPopCurrNode   pr
035968160615
035969180301      * Delete XML node ********************************************************
035970180301     dowyDeleteNode    pr
035971180301     d pNodeId                             like(dbxFldRef.BigInt) const
035973180301
035974180301      * XML node element count *************************************************
035975180301     dowyElementCount  pr                  like(dbxFldRef.RecCount)
035976180301     d pNodeId                             like(dbxFldRef.BigInt) const
035978180301
036000120927      * Program prototypes -----------------------------------------------------
036100120927
036200120927      * Test program for OWXUTILR **********************************************
036300120927     dowxUtilTr        pr                  extpgm('OWXUTILTR')
036400120927     d pTest                          1
036500130510     d pParm1                              const options(*nopass)
036501130510     d                                     like(owFldDef.CmdLinStr)
036600130510     d pParm2                              const options(*nopass)
036601130510     d                                     like(owFldDef.CmdLinStr)
036700120927
036800120927      * OW Merchant migration **************************************************
036900120927     dowxMerMr         pr                  extpgm('OWXMERMR')
037000130510     d pGroupIdCh                          const
037001130510     d                                     like(owFldDef.CmdLinStr)
037100150415     d pFinal                              const options(*nopass)
037101150415     d                                     like(owFldDef.CmdLinStr)
037102150415     d pComment                            const options(*nopass)
037103130510     d                                     like(owFldDef.CmdLinStr)
037104121130
037105150401      * OW Merchant migration daily ********************************************
037106150401     dowxMerMDr        pr                  extpgm('OWXMERMDR')
037107150407     d pProd                               const like(owFldDef.CmdLinStr)
037108150407     d                                     options(*nopass)
037109180307     d pDoDci                          n   const options(*nopass)
037110180307
037111130527      * OW Settlement migration ************************************************
037112130510     dowxSetMr         pr                  extpgm('OWXSETMR')
037113130510     d pUker                               const
037114130527     d                                     like(owFldDef.Uker)
037115130510     d pComment                            const options(*nopass)
037116130510     d                                     like(owFldDef.CmdLinStr)
037117130510
037118130527      * OW Pick settlements for migration **************************************
037119130527     dowxPSetMr        pr                  extpgm('OWXPSETMR')
037120130527     d pDupp                               const options(*nopass)
037121130527     d                                     like(owFldDef.DateCh)
037122130527     d pComment                            const options(*nopass)
037123130527     d                                     like(owFldDef.CmdLinStr)
037124130527
037125130820      * OW Rolling Reserve migration *******************************************
037126130820     dowxRsvMr         pr                  extpgm('OWXRSVMR')
037127130820     d pUker                               const
037128130820     d                                     like(owFldDef.Uker)
037129130820     d pComment                            const options(*nopass)
037130130820     d                                     like(owFldDef.CmdLinStr)
037131130820
037132160609      * OW Merchant migration V3 ***********************************************
037133160609     dowxMerM3R        pr                  extpgm('OWXMERM3R')
037134160609     d pGroupIdCh                          const
037135160609     d                                     like(owFldDef.CmdLinStr)
037136160609     d pFinal                              const options(*nopass)
037137160609     d                                     like(owFldDef.CmdLinStr)
037138160609     d pComment                            const options(*nopass)
037139160609     d                                     like(owFldDef.CmdLinStr)
037140190305     d pGetLck                             const options(*nopass)
037141190304     d                                     like(owFldDef.CmdLinStr)
037142190304
