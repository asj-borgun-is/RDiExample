000100120925      /copy qsrcow,ow_h
000200120925     h nomain
000300120925
000400120925      * OW XML utilities.
000500120925      * 25.09.2012 Aðalsteinn Jónsson
000501160128
000502160128      * 28.01.2016 Aðalsteinn. Skrifa UTF-8 í stað iso-8859-1
000503160609      * 09.06.2016 Aðalsteinn. Breytingar fyrir V3.
000600120925
000700160609      * #type = SQLSRV
000800120925      * #glb = OW_GLB
000900120925      * #export = OWXUTILX
001000121112
001100160609     fOWXUTILF  uf a f  453        disk    usropn
001200120925
001300120925      * Common definitions
001400121109      /copy qsrcow,ow_def
001500121112      /copy qrpgsrc,dbxdef
001600121112      /copy qsrca,k2ad
001700121108
001800121112      * Local constants
001900160615     dcNodeStackDim    c                   20
001901160615
002000121112      * Config
002100121112     dmCfg             ds                  likeds(owxKmastOwOwx)
002200121112
002300121112      * Global
002400121203     dmStmfName        s                   like(owFldDef.IfsName)
002500121203     dmStmfPath        s                   like(owFldDef.IfsName)
002501121203     dmSender          s                   like(owFldDef.Sender)
002600121112     dmFileSeqNoCh     s                   like(owFldDef.FileSeqNoCh)
002700121112     dmToday           s                   like(dbxFldRef.IsoDate)
002701160610     dmCurrNode        s                   like(dbxFldRef.BigInt)
002800160615     dmNodeStack       s                   like(dbxFldRef.BigInt)
002801160615     d                                     dim(cNodeStackDim)
002802160615     dmNodeStackIx     s              3p 0
002803160615
002900121112      * File sequence data area
003000121112     dmFs              ds                  likeds(owxFseqA) dtaara(OWXFSEQA)
003100121112
003200121112      * Volatile
003300121108
003301130514      * Amount to xml **********************************************************
003302130514     powxAmountToXml...
003303130514     p                 b                   export
003304130514     d                 pi                  like(owFldDef.XmlAmount)
003305130514     d pAmount                             like(owFldDef.Amount) const
003306130514      * Local
003307130514     dlXamt            s                   like(owFldDef.XmlAmount)
003308130514     dlI               s                   like(dbxFldRef.Index)
003309130514      /free
003310130514       lXamt = %editc(pAmount:'P');
003311130514       lXamt = %xlate(',':'.':lXamt); // Decimal point
003312130514       // Remove trailing zeros
003313130514       lI = %len(lXamt);
003314130514       dow %subst(lXamt:lI:1) = '0';
003315130514         lI -= 1;
003318130514       enddo;
003319130514       // Remove decimal point if not needed
003320130514       if %subst(lXamt:lI:1) = '.';
003321130514         lI -= 1;
003322130514       endif;
003323130514
003324130514       return %trim(%subst(lXamt:1:lI));
003325130514      /end-free
003326130514     powxAmountToXml...
003327130514     p                 e
003328130514
003400120927      * Date to xml ************************************************************
003500120927     powxDateToXml...
003600120927     p                 b                   export
003700120927     d                 pi                  like(owFldDef.XmlDate)
003800120927     d pDate                           d   datfmt(*iso) const
003900120927      /free
004000120927       return %editw(%dec(pDate:*iso):'0   -  -  ');
004100120927      /end-free
004200120927     powxDateToXml...
004300120927     p                 e
004400120927
004500120927      * Time to xml ************************************************************
004600120927     powxTimeToXml...
004700120927     p                 b                   export
004800120927     d                 pi                  like(owFldDef.XmlTime)
004900120927     d pTime                           t   const
005000120927      /free
005100120927       return %trim(%editw(%dec(pTime):'0  :  :  '));
005200120927      /end-free
005300120927     powxTimeToXml...
005400120927     p                 e
005500121109
005600121112      * Initialize Xml file ****************************************************
005700121112     powxInit          b                   export
005800121112     d                 pi
005801130510     d pRunType                            const like(owxColRef.RUNTYPE)
005802130510     d                                     options(*nopass:*omit)
005803140206     d pFileCode                           const like(owFldDef.Code)
005804140206     d                                     options(*nopass:*omit)
005805160609     d pDoHead                         n   const options(*nopass:*omit)
005806170308     d pFinInst                            const like(owFldDef.FinInst)
005807170308     d                                     options(*nopass:*omit)
005808140206      * Local
005809140206     d lFileCode       s                   like(pFileCode)
005810160609     d lDoHead         s               n
005900170308     d lFinInst        s                   like(owFldDef.FinInst)
005901170308      /free
005902160613       mCurrNode = 0;
005903160615       clear mNodeStack;
005904160615       mNodeStackIx = 0;
005905160609       lDoHead = *on;
005906160609       if %parms >= %parmnum(pDoHead) and %addr(pDoHead) <> *null;
005907160609         lDoHead = pDoHead;
005908160609       endif;
006000121112       // Get config
006100121112       dbxLesaLominn(mCfg:OWX_KMAST_FLKA_OW:OWX_KMAST_FLKB_OWX);
006200121112       // Sender constant
006300121112       mSender = OWX_SENDER;
006400121112       // File sequence number
006500121112       mToday = dbxDateToIso(%date);
006600121112       in *lock mFs;
006700121112       mFs.IsoDate = mToday;
006800121112       if mFs.SeqNo = *hival;
006900121112         mFs.SeqNo = 1;
007000121112       else;
007100121112         mFs.SeqNo += 1;
007200121112       endif;
007300121112       out mFs;
007400121112       mFileSeqNoCh = %editc(mFs.SeqNo:'X');
007401140206       // File code
007402140206       if %parms >= %parmnum(pFileCode) and %addr(pFileCode) <> *null;
007403160825         lFileCode = %trim(pFileCode);
007404140206       endif;
007405170308       // Financial institution
007500170308       if %parms >= %parmnum(pFinInst) and %addr(pFinInst) <> *null;
007501170308         lFinInst = %trim(pFinInst);
007502170308       endif;
007503170308       // Stream file name
007504130510       select;
007505140206         when %parms < %parmnum(pRunType) or %addr(pRunType) = *null or
007506140206             pRunType = OWX_RUNTYPE_MER;
007507170308           if lFinInst <> *blanks;
007508170308             mStmfName = 'xadvapl' + lFinInst + '00_' + mFileSeqNoCh +
007509170308               '.' + OWX_FILETYPE_001;
007510170308           elseif lFileCode = OWX_VER_3 or lFileCode = OWX_VER_3_SUBVER_AC;
007511160825             mStmfName = OWX_PREFIX_APPF_V3 + '_' + mFileSeqNoCh +
007512160825               '.' + OWX_FILETYPE_001;
007513160825           else;
007600160825             mStmfName = OWX_PREFIX_APPF + '_' + mFileSeqNoCh +
007601160825               '.' + OWX_FILETYPE_001;
007602160825           endif;
007603130822         when pRunType = OWX_RUNTYPE_SET;
007604130510           mStmfName = OWX_PREFIX_DOC + '_' + mFileSeqNoCh +
007605130822             '_SET.' + OWX_FILETYPE_XML;
007606130822         when pRunType = OWX_RUNTYPE_RSV;
007607130822           mStmfName = OWX_PREFIX_DOC + '_' + mFileSeqNoCh +
007608130917             '_RSV.' + OWX_FILETYPE_XML;
007609130822       endsl;
007610130527       mStmfPath = %trim(mCfg.Outbox) + mStmfName;
007700121203       // Open workfile
007900121112       dbxNewWorkFile('OWXUTILF':%size(owFldDef.XmlFixRecStr));
008000121112       open OWXUTILF;
008100121112       // Header
008101160609       if lDoHead;
008200160609         owxHeader();
008201160609       endif;
008300121112      /end-free
008400121112     powxInit          e
008500121112
008600121109      * Dynamic xml element ****************************************************
008700121109     powxDynElem       b                   export
008800121109     d                 pi
008900121109     d pTag                                const like(owFldDef.XmlTag)
009000121109     d                                     options(*varsize)
009100121109     d pProcP                          *   const procptr
009200121113     d pAttr                               likeds(owxAttr) dim(OWX_LST_DIM)
009300121109     d                                     options(*varsize:*nopass)
009400121109     d pAttrElem                           const like(dbxFldRef.Index)
009500121109     d                                     options(*nopass)
009600121109      * The element procedure
009700121109     dlElemProc        pr                  extproc(pProcP)
009800121109      * Local
009900121112     dlAttrElem        s                   like(pAttrElem)
010000121112     dlI               s                   like(pAttrElem)
010100121112      /free
010200121112
010300121112       // Number of attributes
010400121112       if %parms >= %parmnum(pAttrElem);
010500121112         lAttrElem = pAttrElem;
010600121112       endif;
010700121112
010800121112       // No attributes
010900121112       if lAttrElem = 0;
011000121112         rOutput('<' + pTag + '>');
011100121112       // Produce attributes
011200121112       else;
011300121112         rOutput('<' + pTag);
011400121112         exsr sOutpAttr;
011500121112         rOutput('>');
011600121112       endif;
011700121112
011800121112       // Call element procedure to generate element body
011900121109       lElemProc();
012000121112
012100121112       // Close element
012200121112       rOutput('</' + pTag + '>');
012300121112
012400121112       //-----------------------------------------------------------------------
012500121112       begsr sOutpAttr;
012600121112         for lI = 1 to lAttrElem;
012700121112           rOutput(pAttr(lI).Tag + '="' + pAttr(lI).Value + '"');
012800121112         endfor;
012900121112       endsr;
013000121109      /end-free
013100121109     powxDynElem       e
013200121109
013300121113      * Data xml element *******************************************************
013400121113     powxDtaElem       b                   export
013500121113     d                 pi
013600121113     d pTag                                const like(owFldDef.XmlTag)
013700121113     d                                     options(*varsize)
013800121113     d pValue                              const like(owFldDef.XmlValue)
013900121113     d                                     options(*varsize:*nopass:*omit)
014000121113     d pAttr                               likeds(owxAttr) dim(OWX_LST_DIM)
014100121113     d                                     options(*varsize:*nopass)
014200121113     d pAttrElem                           const like(dbxFldRef.Index)
014300121113     d                                     options(*nopass)
014400121113      * Local
014500121113     dlAttrElem        s                   like(pAttrElem)
014600121113     dlI               s                   like(pAttrElem)
014700121113      /free
014800121113
014900121113       // Number of attributes
015000121113       if %parms >= %parmnum(pAttrElem);
015100121113         lAttrElem = pAttrElem;
015200121113       endif;
015300121113
015400121113       // No attributes
015500121113       if lAttrElem = 0;
015600121113         rOutput('<' + pTag + '>');
015700121113       // Produce attributes
015800121113       else;
015900121113         rOutput('<' + pTag);
016000121113         exsr sOutpAttr;
016100121113         rOutput('>');
016200121113       endif;
016300121113
016400121113       // Data
016500130606       rOutput(pValue);
016600121113
016700121113       // Close element
016800121113       rOutput('</' + pTag + '>');
016900121113
017000121113       //-----------------------------------------------------------------------
017100121113       begsr sOutpAttr;
017200121113         for lI = 1 to lAttrElem;
017300130606           rOutput(pAttr(lI).Tag + '="' + pAttr(lI).Value + '"');
017400121113         endfor;
017500121113       endsr;
017600121113      /end-free
017700121113     powxDtaElem       e
017800121113
017900121113      * Data list element ******************************************************
018000121113     powxDtaLstElem    b                   export
018100121113     d                 pi
018200121113     d pTag                                const like(owFldDef.XmlTag)
018300121113     d                                     options(*varsize)
018400121113     d pDtaLst                             likeds(owxAttr) dim(OWX_LST_DIM)
018500121113     d                                     options(*varsize)
018600121113     d pDtaLstElem                         const like(dbxFldRef.Index)
018700121113     d pAttr                               likeds(owxAttr) dim(OWX_LST_DIM)
018800121113     d                                     options(*varsize:*nopass)
018900121113     d pAttrElem                           const like(dbxFldRef.Index)
019000121113     d                                     options(*nopass)
019100121113      * Local
019200121113     dlAttrElem        s                   like(pAttrElem)
019300121113     dlI               s                   like(pAttrElem)
019400121113      /free
019500121113
019600121113       // Number of attributes
019700121113       if %parms >= %parmnum(pAttrElem);
019800121113         lAttrElem = pAttrElem;
019900121113       endif;
020000121113
020100121113       // No attributes
020200121113       if lAttrElem = 0;
020300121113         rOutput('<' + pTag + '>');
020400121113       // Produce attributes
020500121113       else;
020600121113         rOutput('<' + pTag);
020700121113         exsr sOutpAttr;
020800121113         rOutput('>');
020900121113       endif;
021000121113
021100121113       // Data
021200121113       exsr sOutDtaLst;
021300121113
021400121113       // Close element
021500121113       rOutput('</' + pTag + '>');
021600121113
021700121113       //-----------------------------------------------------------------------
021800121113       begsr sOutpAttr;
021900121113         for lI = 1 to lAttrElem;
022000130606           rOutput(pAttr(lI).Tag + '="' + pAttr(lI).Value + '"');
022100121113         endfor;
022200121113       endsr;
022300121113
022400121113       //-----------------------------------------------------------------------
022500121113       begsr sOutDtaLst;
022600121113         for lI = 1 to pDtaLstElem;
022700121113           owxDtaElem(pDtaLst(lI).Tag:pDtaLst(lI).Value);
022800121113         endfor;
022900121113       endsr;
023000121113      /end-free
023100121113     powxDtaLstElem    e
023200121113
023300121115      * Xml header *************************************************************
023400121112     powxHeader        b                   export
023500121112     d                 pi
023600121112      /free
023700160128       rOutput('<?xml version="1.0" encoding="utf-8"?>');
023800121112      /end-free
023900121112     powxHeader        e
024000121112
024100121112      * Close Xml work file ****************************************************
024200121112     powxCloseWork     b                   export
024300121112     d                 pi
024400121112      /free
024500121112       close OWXUTILF;
024600121112      /end-free
024700121112     powxCloseWork     e
024800121112
024900121112      * Write Xml stream file **************************************************
025000121112     powxWriteIfs      b                   export
025100121112     d                 pi
025200121112      * Local
025300121112     dlCmdStr          s            256    varying
025400121112      /free
025500121112       close OWXUTILF;
025600121112       lCmdStr =
025700121112         'CPYTOSTMF FROMMBR(''/qsys.lib/qtemp.lib/owxutilf.file/' +
025800121203         'owxutilf.mbr'') TOSTMF(''' + mStmfPath + ''') STMFOPT(*REPLACE) ' +
025900160128         'STMFCCSID(1208)';
026000121112       dbxCmdExc(lCmdStr:%len(lCmdStr));
026100121112      /end-free
026200121112     powxWriteIfs      e
026300121112
026400121113      * Assign to list *********************************************************
026500121113     powxAssgnLst      b                   export
026600121113     d                 pi
026700121113     d pLst                                likeds(owxAttr) dim(OWX_LST_DIM)
026800121113     d                                     options(*varsize)
026900121113     d pLstElem                            const like(dbxFldRef.Index)
027000121113     d pTag1                               like(owFldDef.XmlTag)
027100121113     d                                     const options(*varsize)
027200121113     d pValue1                             like(owFldDef.XmlValue)
027300121113     d                                     const options(*varsize)
027400121113     d pTag2                               like(owFldDef.XmlTag)
027500121113     d                                     const options(*varsize:*nopass)
027600121113     d pValue2                             like(owFldDef.XmlValue)
027700121113     d                                     const options(*varsize:*nopass)
027800121113     d pTag3                               like(owFldDef.XmlTag)
027900121113     d                                     const options(*varsize:*nopass)
028000121113     d pValue3                             like(owFldDef.XmlValue)
028100121113     d                                     const options(*varsize:*nopass)
028200121113     d pTag4                               like(owFldDef.XmlTag)
028300121113     d                                     const options(*varsize:*nopass)
028400121113     d pValue4                             like(owFldDef.XmlValue)
028500121113     d                                     const options(*varsize:*nopass)
028600121113     d pTag5                               like(owFldDef.XmlTag)
028700121113     d                                     const options(*varsize:*nopass)
028800121113     d pValue5                             like(owFldDef.XmlValue)
028900121113     d                                     const options(*varsize:*nopass)
029000121113     d pTag6                               like(owFldDef.XmlTag)
029100121113     d                                     const options(*varsize:*nopass)
029200121113     d pValue6                             like(owFldDef.XmlValue)
029300121113     d                                     const options(*varsize:*nopass)
029400121113     d pTag7                               like(owFldDef.XmlTag)
029500121113     d                                     const options(*varsize:*nopass)
029600121113     d pValue7                             like(owFldDef.XmlValue)
029700121113     d                                     const options(*varsize:*nopass)
029800121113     d pTag8                               like(owFldDef.XmlTag)
029900121113     d                                     const options(*varsize:*nopass)
030000121113     d pValue8                             like(owFldDef.XmlValue)
030100121113     d                                     const options(*varsize:*nopass)
030200121113     d pTag9                               like(owFldDef.XmlTag)
030300121113     d                                     const options(*varsize:*nopass)
030400121113     d pValue9                             like(owFldDef.XmlValue)
030500121113     d                                     const options(*varsize:*nopass)
030600121113     d pTag10                              like(owFldDef.XmlTag)
030700121113     d                                     const options(*varsize:*nopass)
030800121113     d pValue10                            like(owFldDef.XmlValue)
030900121113     d                                     const options(*varsize:*nopass)
031000121113     d pTag11                              like(owFldDef.XmlTag)
031100121113     d                                     const options(*varsize:*nopass)
031200121113     d pValue11                            like(owFldDef.XmlValue)
031300121113     d                                     const options(*varsize:*nopass)
031400121113     d pTag12                              like(owFldDef.XmlTag)
031500121113     d                                     const options(*varsize:*nopass)
031600121113     d pValue12                            like(owFldDef.XmlValue)
031700121113     d                                     const options(*varsize:*nopass)
031800121113     d pTag13                              like(owFldDef.XmlTag)
031900121113     d                                     const options(*varsize:*nopass)
032000121113     d pValue13                            like(owFldDef.XmlValue)
032100121113     d                                     const options(*varsize:*nopass)
032200121113     d pTag14                              like(owFldDef.XmlTag)
032300121113     d                                     const options(*varsize:*nopass)
032400121113     d pValue14                            like(owFldDef.XmlValue)
032500121113     d                                     const options(*varsize:*nopass)
032600121113     d pTag15                              like(owFldDef.XmlTag)
032700121113     d                                     const options(*varsize:*nopass)
032800121113     d pValue15                            like(owFldDef.XmlValue)
032900121113     d                                     const options(*varsize:*nopass)
033000121113     d pTag16                              like(owFldDef.XmlTag)
033100121113     d                                     const options(*varsize:*nopass)
033200121113     d pValue16                            like(owFldDef.XmlValue)
033300121113     d                                     const options(*varsize:*nopass)
033400121113      /free
033500121113       pLst(1).Tag = pTag1;
033600121113       pLst(1).Value = pValue1;
033700121113
033800121113       if %parms >= %parmnum(pValue2);
033900121113         pLst(2).Tag = pTag2;
034000121113         pLst(2).Value = pValue2;
034100121113       endif;
034200121113
034300121113       if %parms >= %parmnum(pValue3);
034400121113         pLst(3).Tag = pTag3;
034500121113         pLst(3).Value = pValue3;
034600121113       endif;
034700121113
034800121113       if %parms >= %parmnum(pValue4);
034900121113         pLst(4).Tag = pTag4;
035000121113         pLst(4).Value = pValue4;
035100121113       endif;
035200121113
035300121113       if %parms >= %parmnum(pValue5);
035400121113         pLst(5).Tag = pTag5;
035500121113         pLst(5).Value = pValue5;
035600121113       endif;
035700121113
035800121113       if %parms >= %parmnum(pValue6);
035900121113         pLst(6).Tag = pTag6;
036000121113         pLst(6).Value = pValue6;
036100121113       endif;
036200121113
036300121113       if %parms >= %parmnum(pValue7);
036400121113         pLst(7).Tag = pTag7;
036500121113         pLst(7).Value = pValue7;
036600121113       endif;
036700121113
036800121113       if %parms >= %parmnum(pValue8);
036900121113         pLst(8).Tag = pTag8;
037000121113         pLst(8).Value = pValue8;
037100121113       endif;
037200121113
037300121113       if %parms >= %parmnum(pValue9);
037400121113         pLst(9).Tag = pTag9;
037500121113         pLst(9).Value = pValue9;
037600121113       endif;
037700121113
037800121113       if %parms >= %parmnum(pValue10);
037900121113         pLst(10).Tag = pTag10;
038000121113         pLst(10).Value = pValue10;
038100121113       endif;
038200121113
038300121113       if %parms >= %parmnum(pValue11);
038400121113         pLst(11).Tag = pTag11;
038500121113         pLst(11).Value = pValue11;
038600121113       endif;
038700121113
038800121113       if %parms >= %parmnum(pValue12);
038900121113         pLst(12).Tag = pTag12;
039000121113         pLst(12).Value = pValue12;
039100121113       endif;
039200121113
039300121113       if %parms >= %parmnum(pValue13);
039400121113         pLst(13).Tag = pTag13;
039500121113         pLst(13).Value = pValue13;
039600121113       endif;
039700121113
039800121113       if %parms >= %parmnum(pValue14);
039900121113         pLst(14).Tag = pTag14;
040000121113         pLst(14).Value = pValue14;
040100121113       endif;
040200121113
040300121113       if %parms >= %parmnum(pValue15);
040400121113         pLst(15).Tag = pTag15;
040500121113         pLst(15).Value = pValue15;
040600121113       endif;
040700121113
040800121113       if %parms >= %parmnum(pValue16);
040900121113         pLst(16).Tag = pTag16;
041000121113         pLst(16).Value = pValue16;
041100121113       endif;
041200121113
041300121113      /end-free
041400121113     powxAssgnLst      e
041500121113
041600121115      * Start xml tag **********************************************************
041700121115     powxStartTag      b                   export
041800121115     d                 pi
041900121115     d pTag                                like(owFldDef.XmlTag)
042000121115     d                                     const options(*varsize)
042100121115      /free
042200121115       rOutput('<' + %trim(pTag) + '>');
042300121115      /end-free
042400121115     powxStartTag      e
042500121115
042600121115      * End xml tag ************************************************************
042700121115     powxEndTag        b                   export
042800121115     d                 pi
042900121115     d pTag                                like(owFldDef.XmlTag)
043000121115     d                                     const options(*varsize)
043100121115      /free
043200121115       rOutput('</' + %trim(pTag) + '>');
043300121115      /end-free
043400121115     powxEndTag        e
043500121115
043600121115      * Simple data element ****************************************************
043700121116     powxSimDtaElem    b                   export
043800121115     d                 pi
043900121115     d pTag                                const like(owFldDef.XmlTag)
044000121115     d                                     options(*varsize)
044100121115     d pValue                              const like(owFldDef.XmlValue)
044200121116     d                                     options(*varsize:*nopass:*omit)
044300121116     d pCond                           n   const options(*nopass)
044400121115      * Local
044500121116     dlStr             s                   like(owxSimDtaElemStr)
044600121115      /free
044700121116       if %parms >= 3;
044800130606         lStr = owxSimDtaElemStr(pTag:pValue:pCond);
044900121116       elseif %parms >= 2;
045000130606         lStr = owxSimDtaElemStr(pTag:pValue);
045100121116       else;
045200121116         lStr = owxSimDtaElemStr(pTag);
045300121116       endif;
045400121116
045500121116       if lStr = *blanks;
045600121116         return;
045700121116       endif;
045800121116
045900121116       rOutput(lStr);
046000121116
046100121116      /end-free
046200121116     powxSimDtaElem    e
046300121115
046400121116      * Simple data element string *********************************************
046500121116     powxSimDtaElemStr...
046600121116     p                 b                   export
046700121116     d                 pi                  like(owFldDef.XmlRecStr)
046800121116     d pTag                                const like(owFldDef.XmlTag)
046900121116     d                                     options(*varsize)
047000121116     d pValue                              const like(owFldDef.XmlValue)
047100121116     d                                     options(*varsize:*nopass:*omit)
047200121116     d pCond                           n   const options(*nopass)
047300121116      * Local
047400121116     dlNoValue         s               n
047500121116     dlTag             s                   like(pTag)
047600121116     dlReturn          s                   like(owFldDef.XmlRecStr)
047700121116      /free
047800121116       %len(lReturn) = 0;
047900121116       // No value passed
048000121116       lNoValue = (%parms < %parmnum(pValue)) or (%addr(pValue) = *null) or
048100121116         pValue = *blanks;
048200121116
048300121116       // Conditional element
048400121116       if %parms >= %parmnum(pCond) and pCond and lNoValue;
048500121116         return lReturn;
048600121116       endif;
048700121116
048800121116       lTag = %trim(pTag);
048900121116       if lNoValue;
049000121116         lReturn = '<' + lTag + '/>';
049100121116       else;
049200130606         lReturn = '<' + lTag + '>' + pValue + '</' + lTag + '>';
049300121116       endif;
049400121116
049500121116       return lReturn;
049600121116      /end-free
049700121116      * Simple data element string *********************************************
049800121116     powxSimDtaElemStr...
049900121116     p                 e
050000121116
050100121115      * File sequence number ***************************************************
050200121115     powxFileSeqNo     b                   export
050300121115     d                 pi                  like(owFldDef.FileSeqNoCh)
050400121115      /free
050500121115       return mFileSeqNoCh;
050600121115      /end-free
050700121115     powxFileSeqNo     e
050800121115
050801121130      * File Name **************************************************************
050802121130     powxFileName      b                   export
050803121130     d                 pi                  like(owFldDef.IfsName)
050804121130      /free
050805121203       return mStmfName;
050806121130      /end-free
050807121130     powxFileName      e
050808121130
050809160609      * Add XML node ***********************************************************
050810160609     powyAddNode       b                   export
050811160609     d                 pi                  like(dbxFldRef.BigInt)
050812160609     d pParNodeId                          like(dbxFldRef.BigInt) const
050813160609     d pTag                                like(owFldDef.XmlTag) const
050814160609     d pValue                              like(owFldDef.XmlValue) const
050815160609     d                                     options(*nopass:*omit)
050816160609     d pCond                           n   const options(*nopass:*omit)
050817160609     d pType                               like(owFldDef.XmlNodeType)
050818160610     d                                     const options(*nopass: *omit)
050819160609      * Local
050820160609     dlValue           s                   like(owFldDef.XmlValue)
050821160609     dlCond            s                   like(dbxFldRef.BoolCh)
050822160609     dlType            s                   like(owFldDef.XmlNodeType)
050823160609     dlReturn          s                   like(dbxFldRef.Bigint)
050824160609      /free
050825160609       // Optional parms
050826160609       lValue = '';
050827160609       if %parms >= %parmnum(pValue) and %addr(pValue) <> *null;
050829160609         lValue = pValue;
050830160609       endif;
050831160609       lCond = DBX_BOOL_FALSE;
050832160609       if %parms >= %parmnum(pCond) and %addr(pCond) <> *null;
050833160609         lCond = pCond;
050834160609       endif;
050835160609       lType = OWX_NODETYPE_EL_ELEMENT;
050836160609       if %parms >= %parmnum(pType) and %addr(pType) <> *null;
050837160609         lType = pType;
050838160609       endif;
050839160609       // Insert depending on parent id
050840160609       if pParNodeId = 0;
050841160609         exec sql INSERT INTO OWXNODE
050842160609           (NODETYPE, NODETAG, NODEVALUE, COND)
050843160610           VALUES (:lType, :pTag, :lValue, :lCond);
050844160609       else;
050845160609         exec sql INSERT INTO OWXNODE
050846160609           (PARNODEID, NODETYPE, NODETAG, NODEVALUE, COND)
050847160610           VALUES (:pParNodeId, :lType, :pTag, :lValue, :lCond);
050848160609       endif;
050849160609       rCheckSqlCode();
050850160609
050851160609       exec sql SET :lReturn  = VALUE(IDENTITY_VAL_LOCAL(), 0);
050852160609       return lReturn;
050853160609      /end-free
050854160609     powyAddNode       e
050855160609
050856160610      * Add XML node to current node *******************************************
050857160610     powyAddNodeCurr   b                   export
050858160610     d                 pi                  like(dbxFldRef.BigInt)
050859160610     d pTag                                like(owFldDef.XmlTag) const
050861160610     d pValue                              like(owFldDef.XmlValue) const
050862160610     d                                     options(*nopass:*omit)
050863160610     d pCond                           n   const options(*nopass:*omit)
050864160610     d pType                               like(owFldDef.XmlNodeType)
050865160610     d                                     const options(*nopass: *omit)
050866160610      /free
050867160610       select;
050868160610         when %parms = %parmnum(pTag);
050869160610           return owyAddNode(mCurrNode:pTag);
050870160610         when %parms = %parmnum(pValue);
050871160610           return owyAddNode(mCurrNode:pTag:pValue);
050872160610         when %parms = %parmnum(pCond);
050873160610           return owyAddNode(mCurrNode:pTag:pValue:pCond);
050874160610         when %parms = %parmnum(pType);
050875160610           return owyAddNode(mCurrNode:pTag:pValue:pCond:pType);
050876160610         other;
050877160610           return owyAddNode(mCurrNode:pTag:pValue:pCond:pType);
050878160610       endsl;
050879160610      /end-free
050881160610     powyAddNodeCurr   e
050882160610
050883160620      * Add XML node to current node and set current ***************************
050884160620     powyAddNodeCurrSet...
050885160620     p                 b                   export
050886160620     d                 pi                  like(dbxFldRef.BigInt)
050887160620     d pTag                                like(owFldDef.XmlTag) const
050888160620     d pValue                              like(owFldDef.XmlValue) const
050889160620     d                                     options(*nopass:*omit)
050890160620     d pCond                           n   const options(*nopass:*omit)
050891160620     d pType                               like(owFldDef.XmlNodeType)
050892160620     d                                     const options(*nopass: *omit)
050893160620      /free
050896160620       select;
050897160620         when %parms = %parmnum(pTag);
050898160620           mCurrNode = owyAddNode(mCurrNode:pTag);
050899160620           return mCurrNode;
050900160620         when %parms = %parmnum(pValue);
050901160620           mCurrNode = owyAddNode(mCurrNode:pTag:pValue);
050902160620           return mCurrNode;
050903160620         when %parms = %parmnum(pCond);
050904160620           mCurrNode = owyAddNode(mCurrNode:pTag:pValue:pCond);
050905160620           return mCurrNode;
050906160620         when %parms = %parmnum(pType);
050907160620           mCurrNode = owyAddNode(mCurrNode:pTag:pValue:pCond:pType);
050908160620           return mCurrNode;
050909160620         other;
050910160620           mCurrNode = owyAddNode(mCurrNode:pTag:pValue:pCond:pType);
050911160620           return mCurrNode;
050912160620       endsl;
050913160620      /end-free
050914160620     powyAddNodeCurrSet...
050915160620     p                 e
050916160620
050917160622      * Add XML node to current node and push current **************************
050918160622     powyAddNodeCurrPush...
050919160622     p                 b                   export
050920160622     d                 pi                  like(dbxFldRef.BigInt)
050921160622     d pTag                                like(owFldDef.XmlTag) const
050922160622     d pValue                              like(owFldDef.XmlValue) const
050923160622     d                                     options(*nopass:*omit)
050924160622     d pCond                           n   const options(*nopass:*omit)
050925160622     d pType                               like(owFldDef.XmlNodeType)
050926160622     d                                     const options(*nopass: *omit)
050927160622      * Local
050928160622     dlNode            s                   like(dbxFldRef.BigInt)
050929160622      /free
050930160622       select;
050931160622         when %parms = %parmnum(pTag);
050932160622           lNode = owyAddNode(mCurrNode:pTag);
050933160622           owyPushCurrNode(lNode);
050934160622           return lNode;
050935160622         when %parms = %parmnum(pValue);
050936160622           lNode = owyAddNode(mCurrNode:pTag:pValue);
050937160622           owyPushCurrNode(lNode);
050938160622           return lNode;
050939160622         when %parms = %parmnum(pCond);
050940160622           lNode = owyAddNode(mCurrNode:pTag:pValue:pCond);
050941160622           owyPushCurrNode(lNode);
050942160622           return lNode;
050943160622         when %parms = %parmnum(pType);
050944160622           lNode = owyAddNode(mCurrNode:pTag:pValue:pCond:pType);
050945160622           owyPushCurrNode(lNode);
050946160622           return lNode;
050947160622         other;
050948160622           lNode = owyAddNode(mCurrNode:pTag:pValue:pCond:pType);
050949160622           owyPushCurrNode(lNode);
050950160622           return lNode;
050951160622       endsl;
050952160622      /end-free
050953160622     powyAddNodeCurrPush...
050954160622     p                 e
050955160622
050956160610      * Set current XML node ***************************************************
050957160610     powySetCurrNode   b                   export
050958160610     d                 pi                  like(dbxFldRef.BigInt)
050959160610     d pNodeId                             like(dbxFldRef.BigInt) const
050960160610      * Local
050961160610     dlPrevCurr        s                   like(dbxFldRef.BigInt)
050962160610      /free
050963160610       lPrevCurr = mCurrNode;
050964160610       mCurrNode = pNodeId;
050965160610       return lPrevCurr;
050966160610      /end-free
050967160610     powySetCurrNode   e
050968160610
050969160610      * Get current XML node ***************************************************
050970160610     powyGetCurrNode   b                   export
050971160610     d                 pi                  like(dbxFldRef.BigInt)
050972160610      /free
050973160610       return mCurrNode;
050974160610      /end-free
050975160610     powyGetCurrNode   e
050976160610
050977160620      * Reset current XML node *************************************************
050978160620     powyResetCurrNode...
050979160620     p                 b                   export
050980160702     d                 pi
050981160702      /free
050984160702       mCurrNode = mNodeStack(mNodeStackIx);
050986160702      /end-free
050988160620     powyResetCurrNode...
050989160620     p                 e
050990160620
050991160610      * Generate XML file ******************************************************
050992160610     powyGenFile       b                   export
050993160610     d                 pi
050994160610     d pNodeId                             like(dbxFldRef.BigInt) const
050995160610      /free
050996160610       // Output header and generate supposed root element
050997160610       owxHeader();
050998160610       rGenElem(pNodeId);
050999160613       // Cleanup
051000160613       exec sql DELETE FROM OWXNODE WHERE NODEID = :pNodeId;
051001160613       rCheckSqlCode();
051002160610      /end-free
051003160610     powyGenFile       e
051004160610
051005160615      * Push current XML node **************************************************
051006160615     powyPushCurrNode  b                   export
051007160615     d                 pi
051008160615     d pNodeId                             like(dbxFldRef.BigInt) const
051009160615      /free
051010160615       mNodeStackIx += 1;
051011160702       mNodeStack(mNodeStackIx) = mCurrNode;
051012160615       mCurrNode = pNodeId;
051013160615      /end-free
051014160615     powyPushCurrNode  e
051015160615
051016160615      * Pop current XML node ***************************************************
051017160615     powyPopCurrNode   b                   export
051018160615     d                 pi
051019160615      /free
051020160702       mCurrNode = mNodeStack(mNodeStackIx);
051021160702       mNodeStack(mNodeStackIx) = 0;
051022160702       mNodeStackIx -= 1;
051025160702      /end-free
051029160615     powyPopCurrNode   e
051030160615
051031180301      * Delete XML node ********************************************************
051032180301     powyDeleteNode    b                   export
051033180301     d                 pi
051034180301     d pNodeId                             like(dbxFldRef.BigInt) const
051035180301      /free
051036180301       exec sql DELETE FROM OWXNODE WHERE NODEID = :pNodeId;
051041180301       rCheckSqlCode();
051042180301      /end-free
051043180301     powyDeleteNode    e
051044180301
051045180301      * XML node element count *************************************************
051046180301     powyElementCount  b                   export
051047180301     d                 pi                  like(dbxFldRef.RecCount)
051048180301     d pNodeId                             like(dbxFldRef.BigInt) const
051049180301      * Local
051050180301     dlRecCount        s                   like(dbxFldRef.RecCount)
051051180301      /free
051053180301       exec sql SELECT COUNT(*) INTO :lRecCount FROM OWXNODE
051054180301         WHERE PARNODEID = :pNodeId AND NODETYPE = 'EL';
051055180301       rCheckSqlCode();
051056180301       return lRecCount;
051057180301      /end-free
051058180301     powyElementCount  e
051059180301
051060160610      * Generate element *******************************************************
051061160610     prGenElem         b
051062160630     d                 pi              n
051063160610     d pNodeId                             like(dbxFldRef.BigInt) const
051064160610      * Local
051065160610     dlNode          e ds                  extname(OWXNODE) qualified
051066160610     dlHasAttr         s               n
051067160610     dlHasElem         s               n
051068160610     dlHasData         s               n
051069160610     dlNodeType        s                   like(owFldDef.XmlNodeType)
051070160613     dlInd             s                   like(dbxFldRef.SqlInd) dim(16)
051071160630     dlGen             s               n
051072160610      /free
051073160630       // Return *on if anything is generated
051074160630       lGen = *off;
051075160610       // Get node
051076160610       clear lNode;
051077160613       clear lInd;
051078160613       exec sql SELECT * INTO :lNode :lInd FROM OWXNODE WHERE NODEID = :pNodeId;
051079160610       rCheckSqlCode();
051080160610       // Has attributes
051081160610       lNodeType = OWX_NODETYPE_AT_ATTRIBUTE;
051082160610       exec sql SET :lHasAttr =
051083160610         VALUE((SELECT '1' FROM OWXNODE WHERE PARNODEID = :pNodeId
051084160610           AND NODETYPE = :lNodeType FETCH FIRST 1 ROW ONLY), '0');
051085160610       // Has child elements
051086160610       lNodeType = OWX_NODETYPE_EL_ELEMENT;
051087160610       exec sql SET :lHasELEM =
051088160610         VALUE((SELECT '1' FROM OWXNODE WHERE PARNODEID = :pNodeId
051089160610           AND NODETYPE = :lNodeType FETCH FIRST 1 ROW ONLY), '0');
051090160610       // Has data
051091160610       lHasData = (lNode.NODEVALUE <> *blanks);
051092160610       // Conditional and no attributes, child elements or data, skip
051093160610       if lNode.COND = *on and not lHasAttr and not lHasElem and not lHasData;
051094160630         return *off;
051095160610       endif;
051096160610       // No attributes or child elements, a simple data element
051097160610       if not lHasAttr and not lHasElem;
051098160610         rOutput('<' + lNode.NODETAG + '>' + lNode.NODEVALUE +
051099160610           '</' + lNode.NODETAG + '>');
051100160630         return *on;
051101160610       endif;
051102160610       // Attributes present
051103160610       if lHasAttr;
051104160610         rOutput('<' + lNode.NODETAG);
051105160610         rGenAttr(pNodeId); // Generate the attributes
051106160610         rOutput('>');
051107160630         lGen = *on;
051108160610       // No attributes
051109160610       else;
051110160610         rOutput('<' + lNode.NODETAG + '>');
051111160610       endif;
051112160610       // Data present
051113160610       if lHasData;
051114160610         rOutput(lNode.NODEVALUE);
051115160630         lGen = *on;
051116160610       endif;
051117160610       // Child elements present
051118160610       if lHasElem;
051119160630         if rGenChildElem(pNodeId);
051120160630           lGen = *on;
051121160630         endif;
051122160610       endif;
051123160630       // Element is conditional and nothing was generated, revoke start tag
051124160630       if lNode.COND = *on and not lGen;
051125160630         rRevokeOutput();
051126160630       // Else put closing tag
051127160630       else;
051128160630         rOutput('</' + lNode.NODETAG + '>');
051129160630       endif;
051130160630       // Return value
051131160630       return lGen;
051132160610      /end-free
051133160610     prGenElem         e
051134160610
051135160610      * Generate attributes ****************************************************
051136160610     prGenAttr         b
051137160610     d                 pi
051138160610     d pNodeId                             like(dbxFldRef.BigInt) const
051139160610      * Local
051140160610     dlNode          e ds                  extname(OWXNODE) qualified
051141160610     dlNodeType        s                   like(owFldDef.XmlNodeType)
051142160621     dlInd             s                   like(dbxFldRef.SqlInd) dim(16)
051143160621      /free
051144160610       lNodeType = OWX_NODETYPE_AT_ATTRIBUTE;
051145160610       exec sql DECLARE curAttr CURSOR FOR
051146160610         SELECT * FROM OWXNODE
051147160610           WHERE PARNODEID = :pNodeId AND NODETYPE = :lNodeType
051148160610           ORDER BY PARNODEID, NODEID;
051149160610       exec sql OPEN curAttr;
051150160610       rCheckSqlCode();
051151160621       exec sql FETCH curAttr INTO :lNode :lInd;
051152160610       rCheckSqlCode();
051153160610
051154160610       // Loop on attributes
051155160610       dow SQLCODE <> DBX_SQLCODE_NODATA;
051156160613         rOutput(lNode.NODETAG + '="' + lNode.NODEVALUE + '"');
051157160621         exec sql FETCH curAttr INTO :lNode :lInd;
051158160610         rCheckSqlCode();
051159160610       enddo;
051160160610
051161160610       exec sql CLOSE curAttr;
051162160610       rCheckSqlCode();
051163160610      /end-free
051164160610     prGenAttr         e
051165160610
051166160610      * Generate child elements ************************************************
051167160610     prGenChildElem    b
051168160630     d                 pi              n
051169160610     d pNodeId                             like(dbxFldRef.BigInt) const
051170160610      * Local file (Sql cursor virkar ekki í recursive procedure)
051171160610     fOWXNODEX1 if   e           k disk
051172160610      * Local
051173160610     dlNode          e ds                  extname(OWXNODEX1:*all) qualified
051174160630     dlGen             s               n
051175160610      /free
051176160630       // Return *on if anything is generated
051177160630       lGen = *off;
051178160630       // Loop through all child nodes
051179160610       setll pNodeId OWXNODEX1;
051180160610       reade pNodeId OWXNODEX1 lNode;
051181160610       dow not %eof(OWXNODEX1);
051182160610         // A child element
051183160610         if lNode.NODETYPE = OWX_NODETYPE_EL_ELEMENT;
051184160630           if rGenElem(lNode.NODEID);
051185160630             lGen = *on;
051186160630           endif;
051187160610         endif;
051188160610         // Next
051189160610         reade pNodeId OWXNODEX1 lNode;
051190160610       enddo;
051191160630       // Return value
051192160630       return lGen;
051193160630      /end-free
051194160610     prGenChildElem    e
051195160610
051196121115      * Output xml *************************************************************
051197121115     prOutput          b
051198121115     d                 pi
051200121115     d pRecStr                             like(owFldDef.XmlRecStr)
051300121115     d                                     const options(*varsize)
051400121115      * Local
051500121115     dlFixRecDs        ds
051600121115     dlFixRecStr                           like(owFldDef.XmlFixRecStr)
051700121115      /free
051800121115       lFixRecStr = pRecStr;
051900121115       write OWXUTILF lFixRecDs;
052000121115      /end-free
052100121115     prOutput          e
052200121115
052201160630      * Revoke output **********************************************************
052202160630     prRevokeOutput    b
052203160630     d                 pi
052204160630      * Local
052207160630     dlFixRecDs        ds
052208160630     dlFixRecStr                           like(owFldDef.XmlFixRecStr)
052209160630      /free
052210160630       // Read last and delete
052211160630       setll *end OWXUTILF;
052212160630       readp OWXUTILF lFixRecDs;
052213160630       if not %eof(OWXUTILF);
052214160630         delete OWXUTILF;
052215160630       endif;
052216160630      /end-free
052217160630     prRevokeOutput    e
052218160630
052219160609      * Check SQL code *********************************************************
052220160609     prCheckSqlCode    b
052221160609     d                 pi
052222160609      /free
052223160609       if SQLCODE <= DBX_SQLCODE_ERROR; // Blow up program with escape message
052224160609         k2aUtEscape(k2aFormat(
052225160609           'SQL error, code=\1, state=\2.'
052226160609           :%trim(%editc(SQLCODE:'P'))
052227160609           :SQLSTATE
052228160609         ));
052229160609       endif;
052230160609      /end-free
052231160609     prCheckSqlCode    e
052232160609
