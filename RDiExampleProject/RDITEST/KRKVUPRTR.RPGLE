000100100715      /copy qrpgsrc,dbhdr
000200100715
000300100715      * #type = BNDRPG
000400210115      * #glb = RD_GLB
000500100715
000600100715      * Prenta skýrslu.
000700100715      * 15.07.2010 Aðalsteinn Jónsson.
000800100715
000900100715      * Skýrslulína
001000101116     fDBINNLIN  if   e           k disk
001100100715      * Prentari
001200100715     fKRKVUPRTP o    f  198        printer oflind(*inoa) usropn
001300210115     f                                     infds(mPrtInf) prtctl(mPrtCtl)
001400100715
001500100715      * Common definitions
001600100715      /copy qrpgsrc,dbxdef
001700100715      /copy qsrca,k2ad
001800100715
001900100715      * Inn/Út
002000100715     dmLin           e ds                  extname(DBINNLIN:*input) qualified
002001210118
002200100715      * Víðvært
002300100715     dmStyr            ds                  likeds(dbxKmastSmaverkInnsky)
002400100715     dmPrtInf          ds                  likeds(k2aFileFeedbk)
002500100715     dmMaxRadnr        s                   like(mLin.RADNR)
002501210115     dmPrtCtl          ds                  likeds(dbxPrtCtl)
002600100715
002700100715      * Bruni
002800100715     dwCmd             s            256    varying
002801210118     dwOutput          ds                  qualified
002900210118     d Texti                               like(mLin.Texti)
003000100715     dwS               s                   like(dbxFldRef.SpaceNo)
003100100715
003200100715      * Færibreytur
003300100715     dpIdag            s                   like(dbxT3Ref.T3IDAG)
003400100715     dpInns            s                   like(dbxT3Ref.T3INNS)
003500100715     dpInnr            s                   like(dbxT3Ref.T3INNR)
003600100715     dpAudk            s                   like(dbxFldRef.AudkSkyr)
003700100715     dpDisp            s                   like(dbxFldRef.BoolCh)
003800100715
003900100715      * pIdag: Inntak. Innsendingardagur.
004000100715      * pInns: Inntak. Innsendingaraðili.
004100100715      * pInnr: Inntak. Innsendingarnúmer.
004200100715      * pAudk: Inntak. Auðkenni skýrslu.
004300100715      * pDisp: Inntak. Á aðeins að birta prentunina, rofi 0/1.
004400100715     c     *entry        plist
004500100715     c                   parm                    pIdag
004600100715     c                   parm                    pInns
004700100715     c                   parm                    pInnr
004800100715     c                   parm                    pAudk
004900100715     c                   parm                    pDisp
005000100715
005100100715      /free
005200100715
005300100715       exsr sInit;
005400100715
005500100715       exsr sMain;
005600100715
005700100715       exsr sEnd;
005800100715
005900100715       //-----------------------------------------------------------------------
006000100715       begsr sMain;
006001210115         mMaxRadnr = 0;
006200100715         // Rúlla í gegnum línur skýrslu og prenta
006300100715         setll (pIdag:pInns:pInnr:pAudk) DBINNLIN;
006400100715         reade (pIdag:pInns:pInnr:pAudk) DBINNLIN mLin;
006500100715         dow not %eof(DBINNLIN);
006501210118           mMaxRadnr = mLin.RADNR;
006600210118           // Output
008000210118           exsr sOutput;
008100100715           // Næsta lína
008200100715           reade (pIdag:pInns:pInnr:pAudk) DBINNLIN mLin;
008300100715         enddo;
008400100715       endsr;
008500100715
008600100715       //-----------------------------------------------------------------------
008700100715       begsr sInit;
008800100715         // Stýringar
008900100715         dbxLesaLominn(mStyr:DBX_KMAST_FLKA_SMAVERK:DBX_KMAST_FLKB_INNSKY:
009000100715           pAudk);
009100100715         // Override á prentara
009200100715         wCmd = 'OVRPRTF FILE(KRKVUPRTP) SECURE(*YES) SPLFNAME(' + pAudk + ')' +
009300100715           ' HOLD(*YES)';
009400100715         if mStyr.PrtF <> *blanks;
009500100715           wCmd += ' TOFILE(' + mStyr.PrtF + ')';
009600100722         else;
009700100722           wCmd += ' TOFILE(' + pAudk + ')';
009800100722         endif;
009900100715         if %open(KRKVUPRTP);
010000100715           close KRKVUPRTP;
010100100715         endif;
010200100715         dbxCmdExc(wCmd:%len(wCmd));
010300100715         open KRKVUPRTP;
010400100715       endsr;
010500100715
010600100715       //-----------------------------------------------------------------------
010700100715       begsr sEnd;
010800100715         close KRKVUPRTP;
010900100715         if mMaxRadnr > 0;
011000100715           // Aðeins birta
011100100715           if pDisp = *on;
011200100715             exsr sDisp;
011300100715             exsr sDltSplf;
011400100715           // Annars, athuga hvort á að sleppa
011500100715           elseif mStyr.SleppaSkra = *on;
011600100715             exsr sRlsSplf;
011700100715           endif;
011800100715         endif;
011900100715         *inlr = *on;
012000100715         return;
012100100715       endsr;
012200100715
012201210118       //-----------------------------------------------------------------------
012202210118       begsr sOutput;
012203210118         clear wOutput;
012204210118         clear mPrtCtl;
012205210118         mPrtCtl.SkipB = mLin.SKIPB;
012206210118         mPrtCtl.SpaceB = mLin.SPACEB;
012207210118         wOutput.Texti = mLin.Texti;
012208210118         write KRKVUPRTP wOutput;
012209210118       endsr;
012210210118
012300100715       //-----------------------------------------------------------------------
012400100715       begsr sDisp;
012500100715         wCmd = 'DSPSPLF FILE(' + pAudk + ') SPLNBR(' +
012600100715           %editc(mPrtInf.SPOOL_NUM:'Z') + ')';
012700100715         dbxCmdExc(wCmd:%size(wCmd));
012800100715       endsr;
012900100715
013000100715       //-----------------------------------------------------------------------
013100100715       begsr sDltSplf;
013200100715         wCmd = 'DLTSPLF FILE(' + pAudk + ') SPLNBR(' +
013300100715           %editc(mPrtInf.SPOOL_NUM:'Z') + ')';
013400100715         dbxCmdExc(wCmd:%size(wCmd));
013500100715       endsr;
013600100715
013700100715       //-----------------------------------------------------------------------
013800100715       begsr sRlsSplf;
013900100715         wCmd = 'RLSSPLF FILE(' + pAudk + ') SPLNBR(' +
014000100715           %editc(mPrtInf.SPOOL_NUM:'Z') + ')';
014100100715         dbxCmdExc(wCmd:%size(wCmd));
014200100715       endsr;
014300100715
014400100715      /end-free
014500100715
