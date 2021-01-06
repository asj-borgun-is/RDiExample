000001210105**FREE
000002210105// ----------------------------------------------------------------------
000003210105// Example conversion of source to RPG Free form
000004210105//     done by Arcad Transformer RPG
000005210105//     with a temporary free trial license    ( 1 / 10 )
000006210105//     submitted by ASJ      2021-01-05    16.56.50
000007210105// (C) Copyright 1992,2015 ARCAD Software
000008210105// note : these comments do not appear with a permanent license
000009210105// ----------------------------------------------------------------------
000100120925/copy qsrcow,ow_h
000200120925ctl-opt nomain;
000300120925
000400120925// OW XML utilities.
000500120925// 25.09.2012 Aðalsteinn Jónsson
000501160128
000502160128// 28.01.2016 Aðalsteinn. Skrifa UTF-8 í stað iso-8859-1
000503160609// 09.06.2016 Aðalsteinn. Breytingar fyrir V3.
000600120925
000700160609// #type = SQLSRV
000800201223// #glb = RD_GLB
000900201223// #export = RDIUTILX
001000121112
001100160609dcl-f OWXUTILF   DISK(453) usage(*update:*delete:*output) usropn;
001200120925
001300120925// Common definitions
001400210106/copy rditest,rd_deff
001500210105/copy qrpgsrc,dbxdef
001600210105/copy qsrca,k2ad
001700121108
001800121112// Local constants
001900160615dcl-c cNodeStackDim   20;
001901160615
002000121112// Config
002100121112dcl-ds mCfg likeds(owxKmastOwOwx);
002200121112
002300121112// Global
002400121203dcl-s mStmfName       like(owFldDef.IfsName);
002500121203dcl-s mStmfPath       like(owFldDef.IfsName);
002501121203dcl-s mSender         like(owFldDef.Sender);
002600121112dcl-s mFileSeqNoCh    like(owFldDef.FileSeqNoCh);
002700121112dcl-s mToday          like(dbxFldRef.IsoDate);
002701160610dcl-s mCurrNode       like(dbxFldRef.BigInt);
002800160615dcl-s mNodeStack      like(dbxFldRef.BigInt)
002801160615                    dim(cNodeStackDim);
002802160615dcl-s mNodeStackIx    packed(3:0);
002803160615
002900121112// File sequence data area
003000121112dcl-ds mFs dtaara('OWXFSEQA') likeds(owxFseqA);
003100121112
003200121112// Volatile
003300121108
003301130514// Amount to xml **********************************************************
003303130514dcl-proc owxAmountToXml export;
003304130514  dcl-pi *n like(owFldDef.XmlAmount);
003305130514    pAmount         like(owFldDef.Amount) const;
003306210105  end-pi;
003307130514// Local
003308130514  dcl-s lXamt           like(owFldDef.XmlAmount);
003309130514  dcl-s lI              like(dbxFldRef.Index);
003310130514lXamt = %editc(pAmount:'P');
003311130514lXamt = %xlate(',':'.':lXamt); // Decimal point
003312130514// Remove trailing zeros
003313130514lI = %len(lXamt);
003314130514dow %subst(lXamt:lI:1) = '0';
003315130514  lI -= 1;
003318130514enddo;
003319130514// Remove decimal point if not needed
003320130514if %subst(lXamt:lI:1) = '.';
003321130514  lI -= 1;
003322130514endif;
003323130514
003324130514return %trim(%subst(lXamt:1:lI));
003327130514end-proc owxAmountToXml;
003328130514
003400120927// Date to xml ************************************************************
003600120927dcl-proc owxDateToXml export;
003700120927  dcl-pi *n like(owFldDef.XmlDate);
003800120927    pDate           date(*iso)      const;
003801210105  end-pi;
004000120927return %editw(%dec(pDate:*iso):'0   -  -  ');
004300120927end-proc owxDateToXml;
004400120927
004500120927// Time to xml ************************************************************
004700120927dcl-proc owxTimeToXml export;
004800120927  dcl-pi *n like(owFldDef.XmlTime);
004900120927    pTime           time            const;
004901210105  end-pi;
005100120927return %trim(%editw(%dec(pTime):'0  :  :  '));
005400120927end-proc owxTimeToXml;
005500121109
005600121112// Initialize Xml file ****************************************************
005700121112dcl-proc owxInit export;
005800121112  dcl-pi *n;
005801130510    pRunType        const like(owxColRef.RUNTYPE)
005802130510                    options(*nopass:*omit);
005803140206    pFileCode       const like(owFldDef.Code)
005804140206                    options(*nopass:*omit);
005805160609    pDoHead         ind             const options(*nopass:*omit);
005806170308    pFinInst        const like(owFldDef.FinInst)
005807170308                    options(*nopass:*omit);
005808210105  end-pi;
005809140206// Local
005810140206  dcl-s lFileCode       like(pFileCode);
005811160609  dcl-s lDoHead         ind;
005900170308  dcl-s lFinInst        like(owFldDef.FinInst);
005902160613mCurrNode = 0;
005903160615clear mNodeStack;
005904160615mNodeStackIx = 0;
005905160609lDoHead = *on;
005906160609if %parms >= %parmnum(pDoHead) and %addr(pDoHead) <> *null;
005907160609  lDoHead = pDoHead;
005908160609endif;
006000121112// Get config
006100121112dbxLesaLominn(mCfg:OWX_KMAST_FLKA_OW:OWX_KMAST_FLKB_OWX);
006200121112// Sender constant
006300121112mSender = OWX_SENDER;
006400121112// File sequence number
006500121112mToday = dbxDateToIso(%date);
006600121112in *lock mFs;
006700121112mFs.IsoDate = mToday;
006800121112if mFs.SeqNo = *hival;
006900121112  mFs.SeqNo = 1;
007000121112else;
007100121112  mFs.SeqNo += 1;
007200121112endif;
007300121112out mFs;
007400121112mFileSeqNoCh = %editc(mFs.SeqNo:'X');
007401140206// File code
007402140206if %parms >= %parmnum(pFileCode) and %addr(pFileCode) <> *null;
007403160825  lFileCode = %trim(pFileCode);
007404140206endif;
007405170308// Financial institution
007500170308if %parms >= %parmnum(pFinInst) and %addr(pFinInst) <> *null;
007501170308  lFinInst = %trim(pFinInst);
007502170308endif;
007503170308// Stream file name
007504130510select;
007505140206  when %parms < %parmnum(pRunType) or %addr(pRunType) = *null or
007506140206      pRunType = OWX_RUNTYPE_MER;
007507170308    if lFinInst <> *blanks;
007508170308      mStmfName = 'xadvapl' + lFinInst + '00_' + mFileSeqNoCh +
007509170308        '.' + OWX_FILETYPE_001;
007510170308    elseif lFileCode = OWX_VER_3 or lFileCode = OWX_VER_3_SUBVER_AC;
007511160825      mStmfName = OWX_PREFIX_APPF_V3 + '_' + mFileSeqNoCh +
007512160825        '.' + OWX_FILETYPE_001;
007513160825    else;
007600160825      mStmfName = OWX_PREFIX_APPF + '_' + mFileSeqNoCh +
007601160825        '.' + OWX_FILETYPE_001;
007602160825    endif;
007603130822  when pRunType = OWX_RUNTYPE_SET;
007604130510    mStmfName = OWX_PREFIX_DOC + '_' + mFileSeqNoCh +
007605130822      '_SET.' + OWX_FILETYPE_XML;
007606130822  when pRunType = OWX_RUNTYPE_RSV;
007607130822    mStmfName = OWX_PREFIX_DOC + '_' + mFileSeqNoCh +
007608130917      '_RSV.' + OWX_FILETYPE_XML;
007609130822endsl;
007610130527mStmfPath = %trim(mCfg.Outbox) + mStmfName;
007700121203// Open workfile
007900121112dbxNewWorkFile('OWXUTILF':%size(owFldDef.XmlFixRecStr));
008000121112open OWXUTILF;
008100121112// Header
008101160609if lDoHead;
008200160609  owxHeader();
008201160609endif;
008400121112end-proc owxInit;
008500121112
008600121109// Dynamic xml element ****************************************************
008700121109dcl-proc owxDynElem export;
008800121109  dcl-pi *n;
008900121109    pTag            const like(owFldDef.XmlTag)
009000121109                    options(*varsize);
009100121109    pProcP          pointer(*proc)  const;
009200121113    pAttr           likeds(owxAttr) dim(OWX_LST_DIM)
009300121109                    options(*varsize:*nopass);
009400121109    pAttrElem       const like(dbxFldRef.Index)
009500121109                    options(*nopass);
009501210105  end-pi;
009600121109// The element procedure
009700121109  dcl-pr lElemProc extproc(pProcP) end-pr;
009800121109// Local
009900121112  dcl-s lAttrElem       like(pAttrElem);
010000121112  dcl-s lI              like(pAttrElem);
010200121112
010300121112// Number of attributes
010400121112if %parms >= %parmnum(pAttrElem);
010500121112  lAttrElem = pAttrElem;
010600121112endif;
010700121112
010800121112// No attributes
010900121112if lAttrElem = 0;
011000121112  rOutput('<' + pTag + '>');
011100121112// Produce attributes
011200121112else;
011300121112  rOutput('<' + pTag);
011400121112  exsr sOutpAttr;
011500121112  rOutput('>');
011600121112endif;
011700121112
011800121112// Call element procedure to generate element body
011900121109lElemProc();
012000121112
012100121112// Close element
012200121112rOutput('</' + pTag + '>');
012300121112
012400121112//-----------------------------------------------------------------------
012500121112begsr sOutpAttr;
012600121112  for lI = 1 to lAttrElem;
012700121112    rOutput(pAttr(lI).Tag + '="' + pAttr(lI).Value + '"');
012800121112  endfor;
012900121112endsr;
013100121109end-proc owxDynElem;
013200121109
013300121113// Data xml element *******************************************************
013400121113dcl-proc owxDtaElem export;
013500121113  dcl-pi *n;
013600121113    pTag            const like(owFldDef.XmlTag)
013700121113                    options(*varsize);
013800121113    pValue          const like(owFldDef.XmlValue)
013900121113                    options(*varsize:*nopass:*omit);
014000121113    pAttr           likeds(owxAttr) dim(OWX_LST_DIM)
014100121113                    options(*varsize:*nopass);
014200121113    pAttrElem       const like(dbxFldRef.Index)
014300121113                    options(*nopass);
014301210105  end-pi;
014400121113// Local
014500121113  dcl-s lAttrElem       like(pAttrElem);
014600121113  dcl-s lI              like(pAttrElem);
014800121113
014900121113// Number of attributes
015000121113if %parms >= %parmnum(pAttrElem);
015100121113  lAttrElem = pAttrElem;
015200121113endif;
015300121113
015400121113// No attributes
015500121113if lAttrElem = 0;
015600121113  rOutput('<' + pTag + '>');
015700121113// Produce attributes
015800121113else;
015900121113  rOutput('<' + pTag);
016000121113  exsr sOutpAttr;
016100121113  rOutput('>');
016200121113endif;
016300121113
016400121113// Data
016500130606rOutput(pValue);
016600121113
016700121113// Close element
016800121113rOutput('</' + pTag + '>');
016900121113
017000121113//-----------------------------------------------------------------------
017100121113begsr sOutpAttr;
017200121113  for lI = 1 to lAttrElem;
017300130606    rOutput(pAttr(lI).Tag + '="' + pAttr(lI).Value + '"');
017400121113  endfor;
017500121113endsr;
017700121113end-proc owxDtaElem;
017800121113
017900121113// Data list element ******************************************************
018000121113dcl-proc owxDtaLstElem export;
018100121113  dcl-pi *n;
018200121113    pTag            const like(owFldDef.XmlTag)
018300121113                    options(*varsize);
018400121113    pDtaLst         likeds(owxAttr) dim(OWX_LST_DIM)
018500121113                    options(*varsize);
018600121113    pDtaLstElem     const like(dbxFldRef.Index);
018700121113    pAttr           likeds(owxAttr) dim(OWX_LST_DIM)
018800121113                    options(*varsize:*nopass);
018900121113    pAttrElem       const like(dbxFldRef.Index)
019000121113                    options(*nopass);
019001210105  end-pi;
019100121113// Local
019200121113  dcl-s lAttrElem       like(pAttrElem);
019300121113  dcl-s lI              like(pAttrElem);
019500121113
019600121113// Number of attributes
019700121113if %parms >= %parmnum(pAttrElem);
019800121113  lAttrElem = pAttrElem;
019900121113endif;
020000121113
020100121113// No attributes
020200121113if lAttrElem = 0;
020300121113  rOutput('<' + pTag + '>');
020400121113// Produce attributes
020500121113else;
020600121113  rOutput('<' + pTag);
020700121113  exsr sOutpAttr;
020800121113  rOutput('>');
020900121113endif;
021000121113
021100121113// Data
021200121113exsr sOutDtaLst;
021300121113
021400121113// Close element
021500121113rOutput('</' + pTag + '>');
021600121113
021700121113//-----------------------------------------------------------------------
021800121113begsr sOutpAttr;
021900121113  for lI = 1 to lAttrElem;
022000130606    rOutput(pAttr(lI).Tag + '="' + pAttr(lI).Value + '"');
022100121113  endfor;
022200121113endsr;
022300121113
022400121113//-----------------------------------------------------------------------
022500121113begsr sOutDtaLst;
022600121113  for lI = 1 to pDtaLstElem;
022700121113    owxDtaElem(pDtaLst(lI).Tag:pDtaLst(lI).Value);
022800121113  endfor;
022900121113endsr;
023100121113end-proc owxDtaLstElem;
023200121113
023300121115// Xml header *************************************************************
023400121112dcl-proc owxHeader export;
023500121112  dcl-pi *n end-pi;
023700160128rOutput('<?xml version="1.0" encoding="utf-8"?>');
023900121112end-proc owxHeader;
024000121112
024100121112// Close Xml work file ****************************************************
024200121112dcl-proc owxCloseWork export;
024300121112  dcl-pi *n end-pi;
024500121112close OWXUTILF;
024700121112end-proc owxCloseWork;
024800121112
024900121112// Write Xml stream file **************************************************
025000121112dcl-proc owxWriteIfs export;
025100121112  dcl-pi *n end-pi;
025200121112// Local
025300121112  dcl-s lCmdStr         varchar(256);
025500121112close OWXUTILF;
025600121112lCmdStr =
025700121112  'CPYTOSTMF FROMMBR(''/qsys.lib/qtemp.lib/owxutilf.file/' +
025800121203  'owxutilf.mbr'') TOSTMF(''' + mStmfPath + ''') STMFOPT(*REPLACE) ' +
025900160128  'STMFCCSID(1208)';
026000121112dbxCmdExc(lCmdStr:%len(lCmdStr));
026200121112end-proc owxWriteIfs;
026300121112
026400121113// Assign to list *********************************************************
026500121113dcl-proc owxAssgnLst export;
026600121113  dcl-pi *n;
026700121113    pLst            likeds(owxAttr) dim(OWX_LST_DIM)
026800121113                    options(*varsize);
026900121113    pLstElem        const like(dbxFldRef.Index);
027000121113    pTag1           like(owFldDef.XmlTag)
027100121113                    const options(*varsize);
027200121113    pValue1         like(owFldDef.XmlValue)
027300121113                    const options(*varsize);
027400121113    pTag2           like(owFldDef.XmlTag)
027500121113                    const options(*varsize:*nopass);
027600121113    pValue2         like(owFldDef.XmlValue)
027700121113                    const options(*varsize:*nopass);
027800121113    pTag3           like(owFldDef.XmlTag)
027900121113                    const options(*varsize:*nopass);
028000121113    pValue3         like(owFldDef.XmlValue)
028100121113                    const options(*varsize:*nopass);
028200121113    pTag4           like(owFldDef.XmlTag)
028300121113                    const options(*varsize:*nopass);
028400121113    pValue4         like(owFldDef.XmlValue)
028500121113                    const options(*varsize:*nopass);
028600121113    pTag5           like(owFldDef.XmlTag)
028700121113                    const options(*varsize:*nopass);
028800121113    pValue5         like(owFldDef.XmlValue)
028900121113                    const options(*varsize:*nopass);
029000121113    pTag6           like(owFldDef.XmlTag)
029100121113                    const options(*varsize:*nopass);
029200121113    pValue6         like(owFldDef.XmlValue)
029300121113                    const options(*varsize:*nopass);
029400121113    pTag7           like(owFldDef.XmlTag)
029500121113                    const options(*varsize:*nopass);
029600121113    pValue7         like(owFldDef.XmlValue)
029700121113                    const options(*varsize:*nopass);
029800121113    pTag8           like(owFldDef.XmlTag)
029900121113                    const options(*varsize:*nopass);
030000121113    pValue8         like(owFldDef.XmlValue)
030100121113                    const options(*varsize:*nopass);
030200121113    pTag9           like(owFldDef.XmlTag)
030300121113                    const options(*varsize:*nopass);
030400121113    pValue9         like(owFldDef.XmlValue)
030500121113                    const options(*varsize:*nopass);
030600121113    pTag10          like(owFldDef.XmlTag)
030700121113                    const options(*varsize:*nopass);
030800121113    pValue10        like(owFldDef.XmlValue)
030900121113                    const options(*varsize:*nopass);
031000121113    pTag11          like(owFldDef.XmlTag)
031100121113                    const options(*varsize:*nopass);
031200121113    pValue11        like(owFldDef.XmlValue)
031300121113                    const options(*varsize:*nopass);
031400121113    pTag12          like(owFldDef.XmlTag)
031500121113                    const options(*varsize:*nopass);
031600121113    pValue12        like(owFldDef.XmlValue)
031700121113                    const options(*varsize:*nopass);
031800121113    pTag13          like(owFldDef.XmlTag)
031900121113                    const options(*varsize:*nopass);
032000121113    pValue13        like(owFldDef.XmlValue)
032100121113                    const options(*varsize:*nopass);
032200121113    pTag14          like(owFldDef.XmlTag)
032300121113                    const options(*varsize:*nopass);
032400121113    pValue14        like(owFldDef.XmlValue)
032500121113                    const options(*varsize:*nopass);
032600121113    pTag15          like(owFldDef.XmlTag)
032700121113                    const options(*varsize:*nopass);
032800121113    pValue15        like(owFldDef.XmlValue)
032900121113                    const options(*varsize:*nopass);
033000121113    pTag16          like(owFldDef.XmlTag)
033100121113                    const options(*varsize:*nopass);
033200121113    pValue16        like(owFldDef.XmlValue)
033300121113                    const options(*varsize:*nopass);
033301210105  end-pi;
033500121113pLst(1).Tag = pTag1;
033600121113pLst(1).Value = pValue1;
033700121113
033800121113if %parms >= %parmnum(pValue2);
033900121113  pLst(2).Tag = pTag2;
034000121113  pLst(2).Value = pValue2;
034100121113endif;
034200121113
034300121113if %parms >= %parmnum(pValue3);
034400121113  pLst(3).Tag = pTag3;
034500121113  pLst(3).Value = pValue3;
034600121113endif;
034700121113
034800121113if %parms >= %parmnum(pValue4);
034900121113  pLst(4).Tag = pTag4;
035000121113  pLst(4).Value = pValue4;
035100121113endif;
035200121113
035300121113if %parms >= %parmnum(pValue5);
035400121113  pLst(5).Tag = pTag5;
035500121113  pLst(5).Value = pValue5;
035600121113endif;
035700121113
035800121113if %parms >= %parmnum(pValue6);
035900121113  pLst(6).Tag = pTag6;
036000121113  pLst(6).Value = pValue6;
036100121113endif;
036200121113
036300121113if %parms >= %parmnum(pValue7);
036400121113  pLst(7).Tag = pTag7;
036500121113  pLst(7).Value = pValue7;
036600121113endif;
036700121113
036800121113if %parms >= %parmnum(pValue8);
036900121113  pLst(8).Tag = pTag8;
037000121113  pLst(8).Value = pValue8;
037100121113endif;
037200121113
037300121113if %parms >= %parmnum(pValue9);
037400121113  pLst(9).Tag = pTag9;
037500121113  pLst(9).Value = pValue9;
037600121113endif;
037700121113
037800121113if %parms >= %parmnum(pValue10);
037900121113  pLst(10).Tag = pTag10;
038000121113  pLst(10).Value = pValue10;
038100121113endif;
038200121113
038300121113if %parms >= %parmnum(pValue11);
038400121113  pLst(11).Tag = pTag11;
038500121113  pLst(11).Value = pValue11;
038600121113endif;
038700121113
038800121113if %parms >= %parmnum(pValue12);
038900121113  pLst(12).Tag = pTag12;
039000121113  pLst(12).Value = pValue12;
039100121113endif;
039200121113
039300121113if %parms >= %parmnum(pValue13);
039400121113  pLst(13).Tag = pTag13;
039500121113  pLst(13).Value = pValue13;
039600121113endif;
039700121113
039800121113if %parms >= %parmnum(pValue14);
039900121113  pLst(14).Tag = pTag14;
040000121113  pLst(14).Value = pValue14;
040100121113endif;
040200121113
040300121113if %parms >= %parmnum(pValue15);
040400121113  pLst(15).Tag = pTag15;
040500121113  pLst(15).Value = pValue15;
040600121113endif;
040700121113
040800121113if %parms >= %parmnum(pValue16);
040900121113  pLst(16).Tag = pTag16;
041000121113  pLst(16).Value = pValue16;
041100121113endif;
041200121113
041400121113end-proc owxAssgnLst;
041500121113
041600121115// Start xml tag **********************************************************
041700121115dcl-proc owxStartTag export;
041800121115  dcl-pi *n;
041900121115    pTag            like(owFldDef.XmlTag)
042000121115                    const options(*varsize);
042001210105  end-pi;
042200121115rOutput('<' + %trim(pTag) + '>');
042400121115end-proc owxStartTag;
042500121115
042600121115// End xml tag ************************************************************
042700121115dcl-proc owxEndTag export;
042800121115  dcl-pi *n;
042900121115    pTag            like(owFldDef.XmlTag)
043000121115                    const options(*varsize);
043001210105  end-pi;
043200121115rOutput('</' + %trim(pTag) + '>');
043400121115end-proc owxEndTag;
043500121115
043600121115// Simple data element ****************************************************
043700121116dcl-proc owxSimDtaElem export;
043800121115  dcl-pi *n;
043900121115    pTag            const like(owFldDef.XmlTag)
044000121115                    options(*varsize);
044100121115    pValue          const like(owFldDef.XmlValue)
044200121116                    options(*varsize:*nopass:*omit);
044300121116    pCond           ind             const options(*nopass);
044301210105  end-pi;
044400121115// Local
044500121116  dcl-s lStr            like(owxSimDtaElemStr);
044700121116if %parms >= 3;
044800130606  lStr = owxSimDtaElemStr(pTag:pValue:pCond);
044900121116elseif %parms >= 2;
045000130606  lStr = owxSimDtaElemStr(pTag:pValue);
045100121116else;
045200121116  lStr = owxSimDtaElemStr(pTag);
045300121116endif;
045400121116
045500121116if lStr = *blanks;
045600121116  return;
045700121116endif;
045800121116
045900121116rOutput(lStr);
046000121116
046200121116end-proc owxSimDtaElem;
046300121115
046400121116// Simple data element string *********************************************
046600121116dcl-proc owxSimDtaElemStr export;
046700121116  dcl-pi *n like(owFldDef.XmlRecStr);
046800121116    pTag            const like(owFldDef.XmlTag)
046900121116                    options(*varsize);
047000121116    pValue          const like(owFldDef.XmlValue)
047100121116                    options(*varsize:*nopass:*omit);
047200121116    pCond           ind             const options(*nopass);
047201210105  end-pi;
047300121116// Local
047400121116  dcl-s lNoValue        ind;
047500121116  dcl-s lTag            like(pTag);
047600121116  dcl-s lReturn         like(owFldDef.XmlRecStr);
047800121116%len(lReturn) = 0;
047900121116// No value passed
048000121116lNoValue = (%parms < %parmnum(pValue)) or (%addr(pValue) = *null) or
048100121116  pValue = *blanks;
048200121116
048300121116// Conditional element
048400121116if %parms >= %parmnum(pCond) and pCond and lNoValue;
048500121116  return lReturn;
048600121116endif;
048700121116
048800121116lTag = %trim(pTag);
048900121116if lNoValue;
049000121116  lReturn = '<' + lTag + '/>';
049100121116else;
049200130606  lReturn = '<' + lTag + '>' + pValue + '</' + lTag + '>';
049300121116endif;
049400121116
049500121116return lReturn;
049700121116  // Simple data element string *********************************************
049900121116end-proc owxSimDtaElemStr;
050000121116
050100121115// File sequence number ***************************************************
050200121115dcl-proc owxFileSeqNo export;
050300121115  dcl-pi *n like(owFldDef.FileSeqNoCh) end-pi;
050500121115return mFileSeqNoCh;
050700121115end-proc owxFileSeqNo;
050800121115
050801121130// File Name **************************************************************
050802121130dcl-proc owxFileName export;
050803121130  dcl-pi *n like(owFldDef.IfsName) end-pi;
050805121203return mStmfName;
050807121130end-proc owxFileName;
050808121130
050809160609// Add XML node ***********************************************************
050810160609dcl-proc owyAddNode export;
050811160609  dcl-pi *n like(dbxFldRef.BigInt);
050812160609    pParNodeId      like(dbxFldRef.BigInt) const;
050813160609    pTag            like(owFldDef.XmlTag) const;
050814160609    pValue          like(owFldDef.XmlValue) const
050815160609                    options(*nopass:*omit);
050816160609    pCond           ind             const options(*nopass:*omit);
050817160609    pType           like(owFldDef.XmlNodeType)
050818160610                    const options(*nopass: *omit);
050819210105  end-pi;
050820160609// Local
050821160609  dcl-s lValue          like(owFldDef.XmlValue);
050822160609  dcl-s lCond           like(dbxFldRef.BoolCh);
050823160609  dcl-s lType           like(owFldDef.XmlNodeType);
050824160609  dcl-s lReturn         like(dbxFldRef.Bigint);
050825160609// Optional parms
050826160609lValue = '';
050827160609if %parms >= %parmnum(pValue) and %addr(pValue) <> *null;
050829160609  lValue = pValue;
050830160609endif;
050831160609lCond = DBX_BOOL_FALSE;
050832160609if %parms >= %parmnum(pCond) and %addr(pCond) <> *null;
050833160609  lCond = pCond;
050834160609endif;
050835160609lType = OWX_NODETYPE_EL_ELEMENT;
050836160609if %parms >= %parmnum(pType) and %addr(pType) <> *null;
050837160609  lType = pType;
050838160609endif;
050839160609// Insert depending on parent id
050840160609if pParNodeId = 0;
050841160609  exec sql INSERT INTO OWXNODE
050842160609    (NODETYPE, NODETAG, NODEVALUE, COND)
050843160610    VALUES (:lType, :pTag, :lValue, :lCond);
050844160609else;
050845160609  exec sql INSERT INTO OWXNODE
050846160609    (PARNODEID, NODETYPE, NODETAG, NODEVALUE, COND)
050847160610    VALUES (:pParNodeId, :lType, :pTag, :lValue, :lCond);
050848160609endif;
050849160609rCheckSqlCode();
050850160609
050851160609exec sql SET :lReturn  = VALUE(IDENTITY_VAL_LOCAL(), 0);
050852160609return lReturn;
050854160609end-proc owyAddNode;
050855160609
050856160610// Add XML node to current node *******************************************
050857160610dcl-proc owyAddNodeCurr export;
050858160610  dcl-pi *n like(dbxFldRef.BigInt);
050859160610    pTag            like(owFldDef.XmlTag) const;
050861160610    pValue          like(owFldDef.XmlValue) const
050862160610                    options(*nopass:*omit);
050863160610    pCond           ind             const options(*nopass:*omit);
050864160610    pType           like(owFldDef.XmlNodeType)
050865160610                    const options(*nopass: *omit);
050866210105  end-pi;
050867160610select;
050868160610  when %parms = %parmnum(pTag);
050869160610    return owyAddNode(mCurrNode:pTag);
050870160610  when %parms = %parmnum(pValue);
050871160610    return owyAddNode(mCurrNode:pTag:pValue);
050872160610  when %parms = %parmnum(pCond);
050873160610    return owyAddNode(mCurrNode:pTag:pValue:pCond);
050874160610  when %parms = %parmnum(pType);
050875160610    return owyAddNode(mCurrNode:pTag:pValue:pCond:pType);
050876160610  other;
050877160610    return owyAddNode(mCurrNode:pTag:pValue:pCond:pType);
050878160610endsl;
050881160610end-proc owyAddNodeCurr;
050882160610
050883160620// Add XML node to current node and set current ***************************
050885160620dcl-proc owyAddNodeCurrSet export;
050886160620  dcl-pi *n like(dbxFldRef.BigInt);
050887160620    pTag            like(owFldDef.XmlTag) const;
050888160620    pValue          like(owFldDef.XmlValue) const
050889160620                    options(*nopass:*omit);
050890160620    pCond           ind             const options(*nopass:*omit);
050891160620    pType           like(owFldDef.XmlNodeType)
050892160620                    const options(*nopass: *omit);
050893210105  end-pi;
050896160620select;
050897160620  when %parms = %parmnum(pTag);
050898160620    mCurrNode = owyAddNode(mCurrNode:pTag);
050899160620    return mCurrNode;
050900160620  when %parms = %parmnum(pValue);
050901160620    mCurrNode = owyAddNode(mCurrNode:pTag:pValue);
050902160620    return mCurrNode;
050903160620  when %parms = %parmnum(pCond);
050904160620    mCurrNode = owyAddNode(mCurrNode:pTag:pValue:pCond);
050905160620    return mCurrNode;
050906160620  when %parms = %parmnum(pType);
050907160620    mCurrNode = owyAddNode(mCurrNode:pTag:pValue:pCond:pType);
050908160620    return mCurrNode;
050909160620  other;
050910160620    mCurrNode = owyAddNode(mCurrNode:pTag:pValue:pCond:pType);
050911160620    return mCurrNode;
050912160620endsl;
050915160620end-proc owyAddNodeCurrSet;
050916160620
050917160622// Add XML node to current node and push current **************************
050919160622dcl-proc owyAddNodeCurrPush export;
050920160622  dcl-pi *n like(dbxFldRef.BigInt);
050921160622    pTag            like(owFldDef.XmlTag) const;
050922160622    pValue          like(owFldDef.XmlValue) const
050923160622                    options(*nopass:*omit);
050924160622    pCond           ind             const options(*nopass:*omit);
050925160622    pType           like(owFldDef.XmlNodeType)
050926160622                    const options(*nopass: *omit);
050927210105  end-pi;
050928160622// Local
050929160622  dcl-s lNode           like(dbxFldRef.BigInt);
050930160622select;
050931160622  when %parms = %parmnum(pTag);
050932160622    lNode = owyAddNode(mCurrNode:pTag);
050933160622    owyPushCurrNode(lNode);
050934160622    return lNode;
050935160622  when %parms = %parmnum(pValue);
050936160622    lNode = owyAddNode(mCurrNode:pTag:pValue);
050937160622    owyPushCurrNode(lNode);
050938160622    return lNode;
050939160622  when %parms = %parmnum(pCond);
050940160622    lNode = owyAddNode(mCurrNode:pTag:pValue:pCond);
050941160622    owyPushCurrNode(lNode);
050942160622    return lNode;
050943160622  when %parms = %parmnum(pType);
050944160622    lNode = owyAddNode(mCurrNode:pTag:pValue:pCond:pType);
050945160622    owyPushCurrNode(lNode);
050946160622    return lNode;
050947160622  other;
050948160622    lNode = owyAddNode(mCurrNode:pTag:pValue:pCond:pType);
050949160622    owyPushCurrNode(lNode);
050950160622    return lNode;
050951160622endsl;
050954160622end-proc owyAddNodeCurrPush;
050955160622
050956160610// Set current XML node ***************************************************
050957160610dcl-proc owySetCurrNode export;
050958160610  dcl-pi *n like(dbxFldRef.BigInt);
050959160610    pNodeId         like(dbxFldRef.BigInt) const;
050960210105  end-pi;
050961160610// Local
050962160610  dcl-s lPrevCurr       like(dbxFldRef.BigInt);
050963160610lPrevCurr = mCurrNode;
050964160610mCurrNode = pNodeId;
050965160610return lPrevCurr;
050967160610end-proc owySetCurrNode;
050968160610
050969160610// Get current XML node ***************************************************
050970160610dcl-proc owyGetCurrNode export;
050971160610  dcl-pi *n like(dbxFldRef.BigInt) end-pi;
050973160610return mCurrNode;
050975160610end-proc owyGetCurrNode;
050976160610
050977160620// Reset current XML node *************************************************
050979160620dcl-proc owyResetCurrNode export;
050980160702  dcl-pi *n end-pi;
050984160702mCurrNode = mNodeStack(mNodeStackIx);
050989160620end-proc owyResetCurrNode;
050990160620
050991160610// Generate XML file ******************************************************
050992160610dcl-proc owyGenFile export;
050993160610  dcl-pi *n;
050994160610    pNodeId         like(dbxFldRef.BigInt) const;
050995210105  end-pi;
050996160610// Output header and generate supposed root element
050997160610owxHeader();
050998160610rGenElem(pNodeId);
050999160613// Cleanup
051000160613exec sql DELETE FROM OWXNODE WHERE NODEID = :pNodeId;
051001160613rCheckSqlCode();
051003160610end-proc owyGenFile;
051004160610
051005160615// Push current XML node **************************************************
051006160615dcl-proc owyPushCurrNode export;
051007160615  dcl-pi *n;
051008160615    pNodeId         like(dbxFldRef.BigInt) const;
051009210105  end-pi;
051010160615mNodeStackIx += 1;
051011160702mNodeStack(mNodeStackIx) = mCurrNode;
051012160615mCurrNode = pNodeId;
051014160615end-proc owyPushCurrNode;
051015160615
051016160615// Pop current XML node ***************************************************
051017160615dcl-proc owyPopCurrNode export;
051018160615  dcl-pi *n end-pi;
051020160702mCurrNode = mNodeStack(mNodeStackIx);
051021160702mNodeStack(mNodeStackIx) = 0;
051022160702mNodeStackIx -= 1;
051029160615end-proc owyPopCurrNode;
051030160615
051031180301// Delete XML node ********************************************************
051032180301dcl-proc owyDeleteNode export;
051033180301  dcl-pi *n;
051034180301    pNodeId         like(dbxFldRef.BigInt) const;
051035210105  end-pi;
051036180301exec sql DELETE FROM OWXNODE WHERE NODEID = :pNodeId;
051041180301rCheckSqlCode();
051043180301end-proc owyDeleteNode;
051044180301
051045180301// XML node element count *************************************************
051046180301dcl-proc owyElementCount export;
051047180301  dcl-pi *n like(dbxFldRef.RecCount);
051048180301    pNodeId         like(dbxFldRef.BigInt) const;
051049210105  end-pi;
051050180301// Local
051051180301  dcl-s lRecCount       like(dbxFldRef.RecCount);
051053180301exec sql SELECT COUNT(*) INTO :lRecCount FROM OWXNODE
051054180301  WHERE PARNODEID = :pNodeId AND NODETYPE = 'EL';
051055180301rCheckSqlCode();
051056180301return lRecCount;
051058180301end-proc owyElementCount;
051059180301
051060160610// Generate element *******************************************************
051061160610dcl-proc rGenElem;
051062160630  dcl-pi *n ind;
051063160610    pNodeId         like(dbxFldRef.BigInt) const;
051064210105  end-pi;
051065160610// Local
051066160610  dcl-ds lNode extname('OWXNODE') qualified end-ds;
051067160610  dcl-s lHasAttr        ind;
051068160610  dcl-s lHasElem        ind;
051069160610  dcl-s lHasData        ind;
051070160610  dcl-s lNodeType       like(owFldDef.XmlNodeType);
051071160613  dcl-s lInd            like(dbxFldRef.SqlInd) dim(16);
051072160630  dcl-s lGen            ind;
051073160630// Return *on if anything is generated
051074160630lGen = *off;
051075160610// Get node
051076160610clear lNode;
051077160613clear lInd;
051078160613exec sql SELECT * INTO :lNode :lInd FROM OWXNODE WHERE NODEID = :pNodeId;
051079160610rCheckSqlCode();
051080160610// Has attributes
051081160610lNodeType = OWX_NODETYPE_AT_ATTRIBUTE;
051082160610exec sql SET :lHasAttr =
051083160610  VALUE((SELECT '1' FROM OWXNODE WHERE PARNODEID = :pNodeId
051084160610    AND NODETYPE = :lNodeType FETCH FIRST 1 ROW ONLY), '0');
051085160610// Has child elements
051086160610lNodeType = OWX_NODETYPE_EL_ELEMENT;
051087160610exec sql SET :lHasELEM =
051088160610  VALUE((SELECT '1' FROM OWXNODE WHERE PARNODEID = :pNodeId
051089160610    AND NODETYPE = :lNodeType FETCH FIRST 1 ROW ONLY), '0');
051090160610// Has data
051091160610lHasData = (lNode.NODEVALUE <> *blanks);
051092160610// Conditional and no attributes, child elements or data, skip
051093160610if lNode.COND = *on and not lHasAttr and not lHasElem and not lHasData;
051094160630  return *off;
051095160610endif;
051096160610// No attributes or child elements, a simple data element
051097160610if not lHasAttr and not lHasElem;
051098160610  rOutput('<' + lNode.NODETAG + '>' + lNode.NODEVALUE +
051099160610    '</' + lNode.NODETAG + '>');
051100160630  return *on;
051101160610endif;
051102160610// Attributes present
051103160610if lHasAttr;
051104160610  rOutput('<' + lNode.NODETAG);
051105160610  rGenAttr(pNodeId); // Generate the attributes
051106160610  rOutput('>');
051107160630  lGen = *on;
051108160610// No attributes
051109160610else;
051110160610  rOutput('<' + lNode.NODETAG + '>');
051111160610endif;
051112160610// Data present
051113160610if lHasData;
051114160610  rOutput(lNode.NODEVALUE);
051115160630  lGen = *on;
051116160610endif;
051117160610// Child elements present
051118160610if lHasElem;
051119160630  if rGenChildElem(pNodeId);
051120160630    lGen = *on;
051121160630  endif;
051122160610endif;
051123160630// Element is conditional and nothing was generated, revoke start tag
051124160630if lNode.COND = *on and not lGen;
051125160630  rRevokeOutput();
051126160630// Else put closing tag
051127160630else;
051128160630  rOutput('</' + lNode.NODETAG + '>');
051129160630endif;
051130160630// Return value
051131160630return lGen;
051133160610end-proc rGenElem;
051134160610
051135160610// Generate attributes ****************************************************
051136160610dcl-proc rGenAttr;
051137160610  dcl-pi *n;
051138160610    pNodeId         like(dbxFldRef.BigInt) const;
051139210105  end-pi;
051140160610// Local
051141160610  dcl-ds lNode extname('OWXNODE') qualified end-ds;
051142160610  dcl-s lNodeType       like(owFldDef.XmlNodeType);
051143160621  dcl-s lInd            like(dbxFldRef.SqlInd) dim(16);
051144160610lNodeType = OWX_NODETYPE_AT_ATTRIBUTE;
051145160610exec sql DECLARE curAttr CURSOR FOR
051146160610  SELECT * FROM OWXNODE
051147160610    WHERE PARNODEID = :pNodeId AND NODETYPE = :lNodeType
051148160610    ORDER BY PARNODEID, NODEID;
051149160610exec sql OPEN curAttr;
051150160610rCheckSqlCode();
051151160621exec sql FETCH curAttr INTO :lNode :lInd;
051152160610rCheckSqlCode();
051153160610
051154160610// Loop on attributes
051155160610dow SQLCODE <> DBX_SQLCODE_NODATA;
051156160613  rOutput(lNode.NODETAG + '="' + lNode.NODEVALUE + '"');
051157160621  exec sql FETCH curAttr INTO :lNode :lInd;
051158160610  rCheckSqlCode();
051159160610enddo;
051160160610
051161160610exec sql CLOSE curAttr;
051162160610rCheckSqlCode();
051164160610end-proc rGenAttr;
051165160610
051166160610// Generate child elements ************************************************
051167160610dcl-proc rGenChildElem;
051168160630  dcl-pi *n ind;
051169160610    pNodeId         like(dbxFldRef.BigInt) const;
051170210105  end-pi;
051171160610// Local file (Sql cursor virkar ekki í recursive procedure)
051172160610dcl-f OWXNODEX1  keyed;
051173160610// Local
051174160610  dcl-ds lNode extname('OWXNODEX1':*all)
051175210105               qualified;
051176210105  end-ds;
051177160630  dcl-s lGen            ind;
051178160630// Return *on if anything is generated
051179160630lGen = *off;
051180160630// Loop through all child nodes
051181160610setll pNodeId OWXNODEX1;
051182160610reade pNodeId OWXNODEX1 lNode;
051183160610dow not %eof(OWXNODEX1);
051184160610  // A child element
051185160610  if lNode.NODETYPE = OWX_NODETYPE_EL_ELEMENT;
051186160630    if rGenElem(lNode.NODEID);
051187160630      lGen = *on;
051188160630    endif;
051189160610  endif;
051190160610  // Next
051191160610  reade pNodeId OWXNODEX1 lNode;
051192160610enddo;
051193160630// Return value
051194160630return lGen;
051195160610end-proc rGenChildElem;
051196160610
051197121115// Output xml *************************************************************
051198121115dcl-proc rOutput;
051199121115  dcl-pi *n;
051200121115    pRecStr         like(owFldDef.XmlRecStr)
051300121115                    const options(*varsize);
051301210105  end-pi;
051400121115// Local
051500121115  dcl-ds lFixRecDs;
051600121115    lFixRecStr      like(owFldDef.XmlFixRecStr);
051601210105  end-ds;
051800121115lFixRecStr = pRecStr;
051900121115write OWXUTILF lFixRecDs;
052100121115end-proc rOutput;
052200121115
052201160630// Revoke output **********************************************************
052202160630dcl-proc rRevokeOutput;
052203160630  dcl-pi *n end-pi;
052204160630// Local
052207160630  dcl-ds lFixRecDs;
052208160630    lFixRecStr      like(owFldDef.XmlFixRecStr);
052209210105  end-ds;
052210160630// Read last and delete
052211160630setll *end OWXUTILF;
052212160630readp OWXUTILF lFixRecDs;
052213160630if not %eof(OWXUTILF);
052214160630  delete OWXUTILF;
052215160630endif;
052217160630end-proc rRevokeOutput;
052218160630
052219160609// Check SQL code *********************************************************
052220160609dcl-proc rCheckSqlCode;
052221160609  dcl-pi *n end-pi;
052223160609if SQLCODE <= DBX_SQLCODE_ERROR; // Blow up program with escape message
052224160609  k2aUtEscape(k2aFormat(
052225160609    'SQL error, code=\1, state=\2.'
052226160609    :%trim(%editc(SQLCODE:'P'))
052227160609    :SQLSTATE
052228160609  ));
052229160609endif;
052231160609end-proc rCheckSqlCode;
052232160609
