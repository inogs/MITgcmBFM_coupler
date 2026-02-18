# include "BFMcoupler_OPTIONS.h"

C--  File BFMcoupler_exf_load.F: Routines to read BFM fields with EXF                      
C--   Contents
C--   o BFMcoupler_EXF_LOAD                      
C--   o BFMcoupler_EXF_READ_XY
      
C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|                              

CBOP
C     !ROUTINE: BFMcoupler_EXF_LOAD                                
C     !INTERFACE:       
      SUBROUTINE BFMcoupler_EXF_LOAD (
     I                           myTime, myIter, myThid )

C     !DESCRIPTION:                   
C     *==============================================================*                 
C     | SUBROUTINE BFMcoupler_EXF_LOAD
C     *==============================================================*    
C     | read BFM forcings from file
C     | N.B.: * uses exf and cal routines for file/record handling
C     |       * uses ctrl routines for control variable handling
C     *==============================================================*

C     !USES:
      IMPLICIT NONE
C     == Global variables ==                        
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#include "BFMcoupler_VARS.h"
#include "BFMcoupler_LOAD.h"
#ifdef ALLOW_EXF
# include "EXF_PARAM.h"
#endif

C     !INPUT/OUTPUT PARAMETERS:  
      _RL     myTime
      INTEGER myIter
      INTEGER myThid

#if ( defined ALLOW_EXF ) && ( defined ALLOW_BFMCOUPLER )
C     !LOCAL VARIABLES:             
CEOP
      
      CALL BFMcouplerS_EXF_READ_XY (
     I     'BFMcoupler Surf', useBFMcouplerYearlyFields,
     I     BFMcouplerSstartTime, BFMcouplerSperiod, BFMcouplerSrepCycle,
     U     AtmosP,    atmosp0,    atmosp1,   BFMcoupler_AtmosPFile,
     U     AtmosPCO2, atmospco20, atmospco21,BFMcoupler_PCO2File,
#ifdef READ_PAR
     U     spar,      spar0,      spar1,     BFMcoupler_sparFile,
#endif
     U     N1p_surfF, N1p_surfF0, N1p_surfF1,BFMcoupler_N1pSurfForcFile,
     U     N3n_surfF, N3n_surfF0, N3n_surfF1,BFMcoupler_N3nSurfForcFile,
     U     N5s_surfF, N5s_surfF0, N5s_surfF1,BFMcoupler_N5sSurfForcFile,
     U     O3c_surfF, O3c_surfF0, O3c_surfF1,BFMcoupler_O3cSurfForcFile,
     U     O3h_surfF, O3h_surfF0, O3h_surfF1,BFMcoupler_O3hSurfForcFile,
     I     myTime, myIter, myThid )

      CALL BFMcouplerB_EXF_READ_XY (
     I     'BFMcoupler Bot', useBFMcouplerYearlyFields,
     I     BFMcouplerBstartTime, BFMcouplerBperiod, BFMcouplerBrepCycle,
     U     N1p_botF,  N1p_botF0,  N1p_botF1,BFMcoupler_N1pBotForcFile,
     U     N3n_botF,  N3n_botF0,  N3n_botF1,BFMcoupler_N3nBotForcFile,
     U     N4n_botF,  N4n_botF0,  N4n_botF1,BFMcoupler_N4nBotForcFile,
     U     O2o_botF,  O2o_botF0,  O2o_botF1,BFMcoupler_O2oBotForcFile,
     U     O3c_botF,  O3c_botF0,  O3c_botF1,BFMcoupler_O3cBotForcFile,
     U     O3h_botF,  O3h_botF0,  O3h_botF1,BFMcoupler_O3hBotForcFile,
     U     CONC01_botF, CONC01_botF0, CONC01_botF1,
     U     BFMcoupler_CONC01BotForcFile,
     U     CONC02_botF, CONC02_botF0, CONC02_botF1,
     U     BFMcoupler_CONC02BotForcFile,
     I     myTime, myIter, myThid )

      CALL BFMcouplerK_EXF_READ_XY (
     I     'BFMcoupler Kext', useBFMcouplerYearlyFields,
     I     BFMcouplerKstartTime, BFMcouplerKperiod, BFMcouplerKrepCycle,
#ifdef READ_xESP
     U     xESP,      xESP0,      xESP1,     BFMcoupler_xESPFile,
#endif
     I     myTime, myIter, myThid )

      RETURN
      END

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|                                         

CBOP                                                                             
C     !ROUTINE: BFMcouplerS_EXF_READ_XY             
C     !INTERFACE:                            
      SUBROUTINE BFMcouplerS_EXF_READ_XY (
     I     bfmName, useYearlyFields,
     I     bfmStartTime, bfmPeriod, bfmRepeatCycle,
     U     AtmosP,    atmosp0,    atmosp1,   BFMcoupler_AtmosPFile,
     U     AtmosPCO2, atmospco20, atmospco21,BFMcoupler_PCO2File,
#ifdef READ_PAR
     U     spar,      spar0,      spar1,     BFMcoupler_sparFile,
#endif
     U     N1p_surfF, N1p_surfF0, N1p_surfF1,BFMcoupler_N1pSurfForcFile,
     U     N3n_surfF, N3n_surfF0, N3n_surfF1,BFMcoupler_N3nSurfForcFile,
     U     N5s_surfF, N5s_surfF0, N5s_surfF1,BFMcoupler_N5sSurfForcFile,
     U     O3c_surfF, O3c_surfF0, O3c_surfF1,BFMcoupler_O3cSurfForcFile,
     U     O3h_surfF, O3h_surfF0, O3h_surfF1,BFMcoupler_O3hSurfForcFile,
     I     myTime, myIter, myThid )

C     !DESCRIPTION:                          
C     *==============================================================*
C     | SUBROUTINE BFMcouplerS_EXF_READ_XY                                   
C     *==============================================================*
C     | read BFM surface forcing from file                       
C     | N.B.: * uses exf and cal routines for file/record handling    
C     |       * uses ctrl routines for control variable handling      
C     *==============================================================*

C     !USES:                                 
      IMPLICIT NONE
C     == Global variables ==                 
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#ifdef ALLOW_EXF
# include "EXF_PARAM.h"
#endif

C     !INPUT/OUTPUT PARAMETERS: 
      CHARACTER*(*) bfmName
      LOGICAL useYearlyFields
      _RL bfmStartTime, bfmPeriod, bfmRepeatCycle
      _RL  AtmosPCO2(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  AtmosP(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
#ifdef READ_PAR
      _RL  spar(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
#endif
      _RL  N1p_surfF(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  N3n_surfF(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  N5s_surfF(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  O3c_surfF(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  O3h_surfF(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)

      _RS AtmosPCO20  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS AtmosPCO21  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS AtmosP0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS AtmosP1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N1p_surfF0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N1p_surfF1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N3n_surfF0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N3n_surfF1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N5s_surfF0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N5s_surfF1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS O3c_surfF0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS O3c_surfF1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS O3h_surfF0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS O3h_surfF1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
#ifdef READ_PAR
      _RS spar0 (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS spar1 (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
#endif

      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_atmospFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_PCO2File
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_sparFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_N1pSurfForcFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_N3nSurfForcFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_N5sSurfForcFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_O3cSurfForcFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_O3hSurfForcFile

      _RL     myTime
      INTEGER myIter
      INTEGER myThid

#if defined ALLOW_EXF
C     !LOCAL VARIABLES:                               
C     msgBuf     :: Informational/error message buffer
      CHARACTER*(MAX_LEN_MBUF) msgBuf
c      CHARACTER*(6) fldName
      LOGICAL first, changed
      INTEGER count0, count1
      INTEGER year0, year1
      _RL     fac
CEOP

      IF ( useCAL .AND. bfmPeriod .EQ. -12. _d 0 ) THEN
# ifdef ALLOW_CAL
C-    BFMcouplerPeriod=-12 means input file contains 12 monthly means 
C     records, corresponding to Jan. (rec=1) through Dec. (rec=12)
        CALL cal_GetMonthsRec(
     O              fac, first, changed,
     O              count0, count1, year0, year1,
     I              myTime, myIter, myThid )
# endif /* ALLOW_CAL */
      ELSEIF ( useCal .AND. bfmPeriod .EQ. -1. _d 0 ) THEN
C-    BFMcouplerPeriod=-1 means fields are monthly means.
C     With useYearlyFields=.TRUE., each yearly input file contains
C     12 monthly mean records.  Otherwise, a single input file contains
C     monthly mean records starting at the month BFMcouplerStartTime falls in.
# ifdef ALLOW_CAL
        CALL EXF_GetMonthsRec(
     I              bfmStartTime, useYearlyFields,
     O              fac, first, changed,
     O              count0, count1, year0, year1,
     I              myTime, myIter, myThid )
# endif /* ALLOW_CAL */
      ELSEIF ( bfmPeriod .LT. 0. _d 0 ) THEN
        WRITE(msgBuf,'(A,1PE16.8,3A)')
     &        'BFMcoupler_EXF_READ_XY: Invalid BFMcouplerPeriod=',
     &        bfmPeriod,
     &        ' for ', bfmName, ' BFMcoupler files'
        CALL PRINT_ERROR( msgBuf, myThid )
        STOP 'ABNORMAL END: S/R BFMcoupler_EXF_READ_XY'
      ELSE
C-    get record numbers and interpolation factor             
        CALL EXF_GetFFieldRec(
     I              bfmStartTime, bfmPeriod,
     I              bfmRepeatCycle,
     I              bfmName, useYearlyFields,
     O              fac, first, changed,
     O              count0, count1, year0, year1,
     I              myTime, myIter, myThid )
      ENDIF
      IF ( exf_debugLev.GE.debLevD ) THEN
         _BEGIN_MASTER( myThid )
         WRITE(msgBuf,'(4A)') ' BFMcoupler_EXF_READ_XY: ',
     &     'processing ', bfmName, '- files'
         CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                       SQUEEZE_RIGHT, myThid )
         WRITE(msgBuf,'(2A,I10,2I7)') ' BFMcoupler_EXF_READ_XY: ',
     &     ' myIter, count0, count1:', myIter, count0, count1
         CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                       SQUEEZE_RIGHT, myThid )
         WRITE(msgBuf,'(2A,2(L2,2X),E16.9)') 'BFMcoupler_EXF_READ_XY: ',
     &     ' first, changed, fac:  ', first, changed, fac
         CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                       SQUEEZE_RIGHT, myThid )
         _END_MASTER( myThid )
      ENDIF

      IF ( BFMcoupler_atmospFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( AtmosP, atmosp0, atmosp1,
     I                   BFMcoupler_atmospFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
      IF ( BFMcoupler_PCO2File .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( AtmosPCO2, AtmospCO20, AtmospCO21,
     I                   BFMcoupler_PCO2File,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
      IF ( BFMcoupler_N1pSurfForcFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( N1p_surfF, N1p_surfF0, N1p_surfF1,
     I                   BFMcoupler_N1pSurfForcFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
      IF ( BFMcoupler_N3nSurfForcFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( N3n_surfF, N3n_surfF0, N3n_surfF1,
     I                   BFMcoupler_N3nSurfForcFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
      IF ( exf_debugLev.GE.debLevD ) THEN
         _BEGIN_MASTER( myThid )
         WRITE(msgBuf,'(A,F13.11)') ' N3n_surfF: ',
     &     N3n_surfF(2,2,1,1)
         CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                       SQUEEZE_RIGHT, myThid )
         _END_MASTER( myThid )
      ENDIF
      IF ( BFMcoupler_N5sSurfForcFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( N5s_surfF, N5s_surfF0, N5s_surfF1,
     I                   BFMcoupler_N5sSurfForcFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
      IF ( BFMcoupler_O3cSurfForcFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( O3c_surfF, O3c_surfF0, O3c_surfF1,
     I                   BFMcoupler_O3cSurfForcFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
      IF ( BFMcoupler_O3hSurfForcFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( O3h_surfF, O3h_surfF0, O3h_surfF1,
     I                   BFMcoupler_O3hSurfForcFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
#ifdef READ_PAR
      IF ( BFMcoupler_sparFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( spar, spar0, spar1,
     I                   BFMcoupler_sparFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
       ENDIF
#endif      

#endif /* ALLOW_EXF */
      RETURN
      END


C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|                                         

CBOP                                                                             
C     !ROUTINE: BFMcouplerB_EXF_READ_XY             
C     !INTERFACE:                            
      SUBROUTINE BFMcouplerB_EXF_READ_XY (
     I     bfmName, useYearlyFields,
     I     bfmStartTime, bfmPeriod, bfmRepeatCycle,
     U     N1p_botF,  N1p_botF0,  N1p_botF1,BFMcoupler_N1pBotForcFile,
     U     N3n_botF,  N3n_botF0,  N3n_botF1,BFMcoupler_N3nBotForcFile,
     U     N4n_botF,  N4n_botF0,  N4n_botF1,BFMcoupler_N4nBotForcFile,
     U     O2o_botF,  O2o_botF0,  O2o_botF1,BFMcoupler_O2oBotForcFile,
     U     O3c_botF,  O3c_botF0,  O3c_botF1,BFMcoupler_O3cBotForcFile,
     U     O3h_botF,  O3h_botF0,  O3h_botF1,BFMcoupler_O3hBotForcFile,
     U     CONC01_botF, CONC01_botF0, CONC01_botF1,
     U     BFMcoupler_CONC01BotForcFile,
     U     CONC02_botF, CONC02_botF0, CONC02_botF1,
     U     BFMcoupler_CONC02BotForcFile,
     I     myTime, myIter, myThid )

C     !DESCRIPTION:                          
C     *==============================================================*
C     | SUBROUTINE BFMcoupler_EXF_READ_XY                                   
C     *==============================================================*
C     | read BFM bottom forcing from file                       
C     | N.B.: * uses exf and cal routines for file/record handling    
C     |       * uses ctrl routines for control variable handling      
C     *==============================================================*

C     !USES:                                 
      IMPLICIT NONE
C     == Global variables ==                 
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#ifdef ALLOW_EXF
# include "EXF_PARAM.h"
#endif

C     !INPUT/OUTPUT PARAMETERS: 
      CHARACTER*(*) bfmName
      LOGICAL useYearlyFields
      _RL  bfmStartTime, bfmPeriod, bfmRepeatCycle
      _RL  N1p_botF(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  N3n_botF(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  N4n_botF(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  O2o_botF(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  O3c_botF(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  O3h_botF(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  CONC01_botF(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL  CONC02_botF(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)

      _RS N1p_botF0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N1p_botF1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N3n_botF0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N3n_botF1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N4n_botF0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS N4n_botF1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS O2o_botF0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS O2o_botF1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS O3c_botF0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS O3c_botF1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS O3h_botF0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS O3h_botF1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS CONC01_botF0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS CONC01_botF1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS CONC02_botF0  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS CONC02_botF1  (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)

      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_N1pBotForcFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_N3nBotForcFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_N4nBotForcFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_O2oBotForcFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_O3cBotForcFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_O3hBotForcFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_CONC01BotForcFile
      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_CONC02BotForcFile

      _RL     myTime
      INTEGER myIter
      INTEGER myThid

#if defined ALLOW_EXF
C     !LOCAL VARIABLES:                               
C     msgBuf     :: Informational/error message buffer
      CHARACTER*(MAX_LEN_MBUF) msgBuf
c      CHARACTER*(6) fldName
      LOGICAL first, changed
      INTEGER count0, count1
      INTEGER year0, year1
      _RL     fac
CEOP

      IF ( useCAL .AND. bfmPeriod .EQ. -12. _d 0 ) THEN
# ifdef ALLOW_CAL
C-    BFMcouplerPeriod=-12 means input file contains 12 monthly means 
C     records, corresponding to Jan. (rec=1) through Dec. (rec=12)
        CALL cal_GetMonthsRec(
     O              fac, first, changed,
     O              count0, count1, year0, year1,
     I              myTime, myIter, myThid )
# endif /* ALLOW_CAL */
      ELSEIF ( useCal .AND. bfmPeriod .EQ. -1. _d 0 ) THEN
C-    BFMcouplerPeriod=-1 means fields are monthly means.
C     With useYearlyFields=.TRUE., each yearly input file contains
C     12 monthly mean records.  Otherwise, a single input file contains
C     monthly mean records starting at the month BFMcouplerStartTime falls in.
# ifdef ALLOW_CAL
        CALL EXF_GetMonthsRec(
     I              bfmStartTime, useYearlyFields,
     O              fac, first, changed,
     O              count0, count1, year0, year1,
     I              myTime, myIter, myThid )
# endif /* ALLOW_CAL */
      ELSEIF ( bfmPeriod .LT. 0. _d 0 ) THEN
        WRITE(msgBuf,'(A,1PE16.8,3A)')
     &        'BFMcoupler_EXF_READ_XY: Invalid BFMcouplerPeriod=',
     &        bfmPeriod,
     &        ' for ', bfmName, ' BFMcoupler files'
        CALL PRINT_ERROR( msgBuf, myThid )
        STOP 'ABNORMAL END: S/R BFMcoupler_EXF_READ_XY'
      ELSE
C-    get record numbers and interpolation factor             
        CALL EXF_GetFFieldRec(
     I              bfmStartTime, bfmPeriod,
     I              bfmRepeatCycle,
     I              bfmName, useYearlyFields,
     O              fac, first, changed,
     O              count0, count1, year0, year1,
     I              myTime, myIter, myThid )
      ENDIF
      IF ( exf_debugLev.GE.debLevD ) THEN
         _BEGIN_MASTER( myThid )
         WRITE(msgBuf,'(4A)') ' BFMcoupler_EXF_READ_XY: ',
     &     'processing ', bfmName, '- files'
         CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                       SQUEEZE_RIGHT, myThid )
         WRITE(msgBuf,'(2A,I10,2I7)') ' BFMcoupler_EXF_READ_XY: ',
     &     ' myIter, count0, count1:', myIter, count0, count1
         CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                       SQUEEZE_RIGHT, myThid )
         WRITE(msgBuf,'(2A,2(L2,2X),E16.9)') 'BFMcoupler_EXF_READ_XY: ',
     &     ' first, changed, fac:  ', first, changed, fac
         CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                       SQUEEZE_RIGHT, myThid )
         _END_MASTER( myThid )
      ENDIF

      IF ( BFMcoupler_N1pBotForcFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( N1p_botF, N1p_botF0, N1p_botF1,
     I                   BFMcoupler_N1pBotForcFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
      IF ( BFMcoupler_N3nBotForcFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( N3n_botF, N3n_botF0, N3n_botF1,
     I                   BFMcoupler_N3nBotForcFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
      IF ( BFMcoupler_N4nBotForcFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( N4n_botF, N4n_botF0, N4n_botF1,
     I                   BFMcoupler_N4nBotForcFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
      IF ( BFMcoupler_O2oBotForcFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( O2o_botF, O2o_botF0, O2o_botF1,
     I                   BFMcoupler_O2oBotForcFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I        myTime, myIter, myThid )
      ENDIF
      IF ( BFMcoupler_O3cBotForcFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( O3c_botF, O3c_botF0, O3c_botF1,
     I                   BFMcoupler_O3cBotForcFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
      IF ( BFMcoupler_O3hBotForcFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( O3h_botF, O3h_botF0, O3h_botF1,
     I                   BFMcoupler_O3hBotForcFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
      IF ( BFMcoupler_CONC01BotForcFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( CONC01_botF, CONC01_botF0, CONC01_botF1,
     I                   BFMcoupler_CONC01BotForcFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
      IF ( BFMcoupler_CONC02BotForcFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( CONC02_botF, CONC02_botF0, CONC02_botF1,
     I                   BFMcoupler_CONC02BotForcFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
      
#endif /* ALLOW_EXF */
      RETURN
      END


C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|                                         

CBOP                                                                             
C     !ROUTINE: BFMcouplerK_EXF_READ_XY             
C     !INTERFACE:                            
      SUBROUTINE BFMcouplerK_EXF_READ_XY (
     I     bfmName, useYearlyFields,
     I     bfmStartTime, bfmPeriod, bfmRepeatCycle, 
#ifdef READ_xESP
     U     xESP,      xESP0,      xESP1,     BFMcoupler_xESPFile,
#endif
     I     myTime, myIter, myThid )

C     !DESCRIPTION:                          
C     *==============================================================*
C     | SUBROUTINE BFMcouplerK_EXF_READ_XY                                   
C     *==============================================================*
C     | read BFM Kext forcing from file                       
C     | N.B.: * uses exf and cal routines for file/record handling    
C     |       * uses ctrl routines for control variable handling      
C     *==============================================================*

C     !USES:                                 
      IMPLICIT NONE
C     == Global variables ==                 
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#ifdef ALLOW_EXF
# include "EXF_PARAM.h"
#endif

C     !INPUT/OUTPUT PARAMETERS: 
      CHARACTER*(*) bfmName
      LOGICAL useYearlyFields
      _RL  bfmStartTime, bfmPeriod, bfmRepeatCycle
#ifdef READ_xESP      
      _RL  xESP(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
#endif
#ifdef READ_xESP
      _RS xESP0 (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RS xESP1 (1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
#endif

      CHARACTER*(MAX_LEN_FNAM) BFMcoupler_xESPFile

      _RL     myTime
      INTEGER myIter
      INTEGER myThid

#if defined ALLOW_EXF
C     !LOCAL VARIABLES:                               
C     msgBuf     :: Informational/error message buffer
      CHARACTER*(MAX_LEN_MBUF) msgBuf
c      CHARACTER*(6) fldName
      LOGICAL first, changed
      INTEGER count0, count1
      INTEGER year0, year1
      _RL     fac
CEOP

      IF ( useCAL .AND. bfmPeriod .EQ. -12. _d 0 ) THEN
# ifdef ALLOW_CAL
C-    BFMcouplerPeriod=-12 means input file contains 12 monthly means 
C     records, corresponding to Jan. (rec=1) through Dec. (rec=12)
        CALL cal_GetMonthsRec(
     O              fac, first, changed,
     O              count0, count1, year0, year1,
     I              myTime, myIter, myThid )
# endif /* ALLOW_CAL */
      ELSEIF ( useCal .AND. bfmPeriod .EQ. -1. _d 0 ) THEN
C-    BFMcouplerPeriod=-1 means fields are monthly means.
C     With useYearlyFields=.TRUE., each yearly input file contains
C     12 monthly mean records.  Otherwise, a single input file contains
C     monthly mean records starting at the month BFMcouplerStartTime falls in.
# ifdef ALLOW_CAL
        CALL EXF_GetMonthsRec(
     I              bfmStartTime, useYearlyFields,
     O              fac, first, changed,
     O              count0, count1, year0, year1,
     I              myTime, myIter, myThid )
# endif /* ALLOW_CAL */
      ELSEIF ( bfmPeriod .LT. 0. _d 0 ) THEN
        WRITE(msgBuf,'(A,1PE16.8,3A)')
     &        'BFMcoupler_EXF_READ_XY: Invalid BFMcouplerPeriod=',
     &        bfmPeriod,
     &        ' for ', bfmName, ' BFMcoupler files'
        CALL PRINT_ERROR( msgBuf, myThid )
        STOP 'ABNORMAL END: S/R BFMcoupler_EXF_READ_XY'
      ELSE
C-    get record numbers and interpolation factor             
        CALL EXF_GetFFieldRec(
     I              bfmStartTime, bfmPeriod,
     I              bfmRepeatCycle,
     I              bfmName, useYearlyFields,
     O              fac, first, changed,
     O              count0, count1, year0, year1,
     I              myTime, myIter, myThid )
      ENDIF
      IF ( exf_debugLev.GE.debLevD ) THEN
         _BEGIN_MASTER( myThid )
         WRITE(msgBuf,'(4A)') ' BFMcoupler_EXF_READ_XY: ',
     &     'processing ', bfmName, '- files'
         CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                       SQUEEZE_RIGHT, myThid )
         WRITE(msgBuf,'(2A,I10,2I7)') ' BFMcoupler_EXF_READ_XY: ',
     &     ' myIter, count0, count1:', myIter, count0, count1
         CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                       SQUEEZE_RIGHT, myThid )
         WRITE(msgBuf,'(2A,2(L2,2X),E16.9)') 'BFMcoupler_EXF_READ_XY: ',
     &     ' first, changed, fac:  ', first, changed, fac
         CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                       SQUEEZE_RIGHT, myThid )
         _END_MASTER( myThid )
      ENDIF

#ifdef READ_xESP
      IF ( BFMcoupler_xESPFile .NE. ' ' ) THEN
       CALL EXF_SET_BFMcoupler( xESP, xESP0, xESP1,
     I                   BFMcoupler_xESPFile,'c',
     I                   fac, first, changed, useYearlyFields,
     I                   bfmPeriod, count0, count1, year0, year1,
     I                   myTime, myIter, myThid )
      ENDIF
#endif
      
#endif /* ALLOW_EXF */
      RETURN
      END
