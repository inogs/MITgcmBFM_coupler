C $Header:/MITgcm/pkg/BFMcoupler/BFMcoupler_diagnostics_init.F,v 1.01
C 2014/04/10

#include "GCHEM_OPTIONS.h"

C !INTERFACE: ==========================================================
      SUBROUTINE BFMcoupler_DIAGNOSTICS_INIT(myThid )

C !DESCRIPTION:
C define diagnostics for BFMcoupler package
C experiment

C !USES: ===============================================================
      IMPLICIT NONE
#include "SIZE.h"
#include "EEPARAMS.h"

C !INPUT PARAMETERS: ===================================================
C  myThid               :: thread number
      INTEGER myThid
CEOP

#ifdef ALLOW_DIAGNOSTICS

C     !LOCAL VARIABLES:
      INTEGER       diagNum
      CHARACTER*8   diagName
      CHARACTER*16  diagCode
      CHARACTER*16  diagUnits
      CHARACTER*(80) diagTitle

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|
C     Define diagnostics Names :

      diagName  = 'PPG'
      diagTitle = 'GrossPrimaryProduction'
      diagUnits = 'mgC/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'NPP'
      diagTitle = 'NetPrimaryProduction'
      diagUnits = 'mgC/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'BPP'
      diagTitle = 'BacterialProduction'
      diagUnits = 'mgC/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'DIC'
      diagTitle = 'DIC'
      diagUnits = 'umol/kg'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'CO2'
      diagTitle = 'CO2'
      diagUnits = 'umol/kg'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'HCO3'
      diagTitle = 'HCO3'
      diagUnits = 'umol/kg'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'CO3'
      diagTitle = 'CO3'
      diagUnits = 'umol/kg'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'Ac'
      diagTitle = 'Alkalinity'
      diagUnits = 'umol/kg'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'pH'
      diagTitle = 'pH'
      diagUnits = 'pH'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'pCO2'
      diagTitle = 'pCO2'
      diagUnits = 'ppm'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'F01'
      diagTitle = 'CO2airflux'
      diagUnits = 'mgC/m2/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'F02'
      diagTitle = 'NO3PO4toALK'
      diagUnits = 'mmol/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'F03'
      diagTitle = 'NH4toALK'
      diagUnits = 'mmol/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'F04'
      diagTitle = 'RespDiat'
      diagUnits = 'mgC/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'F05'
      diagTitle = 'RespFlag'
      diagUnits = 'mgC/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'F06'
      diagTitle = 'RespPico'
      diagUnits = 'mgC/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'F07'
      diagTitle = 'RespDino'
      diagUnits = 'mgC/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'F08'
      diagTitle = 'RespBact'
      diagUnits = 'mgC/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'F09'
      diagTitle = 'RespMicr'
      diagUnits = 'mgC/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'F10'
      diagTitle = 'RespNanoFl'
      diagUnits = 'mgC/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'F11'
      diagTitle = 'RespMesoCarn'
      diagUnits = 'mgC/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'F12'
      diagTitle = 'RespMesoOmn'
      diagUnits = 'mgC/m3/d'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
C     diagName  = 'F13'
C     diagTitle = 'Mescolato'
C     diagUnits = 'davedere'
C     diagCode  = 'SMRP    MR'
C     CALL DIAGNOSTICS_ADDTOLIST( diagNum,
C    I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'xpar'
      diagTitle = 'PAR'
      diagUnits = 'Ein/s'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'wspeed'
      diagTitle = 'WSPEED'
      diagUnits = 'm/s'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'RHOSitu'
      diagTitle = 'RHOSitu'
      diagUnits = 'kg/m3'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
      diagName  = 'PCO2atm'
      diagTitle = 'PCO2atm'
      diagUnits = 'kg/m3'
      diagCode  = 'SMRP    MR'
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )
C 
C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|

#endif /* ALLOW_DIAGNOSTICS */

      RETURN
      END
