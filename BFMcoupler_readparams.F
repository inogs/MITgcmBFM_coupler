C $Header: /MITgcm/pkg/BFMcoupler/BFMcoupler_readparms.F,v 1.1 2014/04/09
C -----------------------------------------------------------------------------

C Copyright (C) 2016 Gianpiero Cossarini (gcossarini@inogs.it)

C This program is free software; you can redistribute it and/or modify it
C under the terms of the GNU General Public License as published by the Free
C Software Foundation; either version 3 of the License, or (at your option)
C any later version.
C
C This program is distributed in the hope that it will be useful,
C but WITHOUT ANY WARRANTY; without even the implied warranty of
C MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
C GNU General Public License for more details.

C -----------------------------------------------------------------------------

#include "BFMcoupler_OPTIONS.h"
CBOP
C !ROUTINE: BFMcoupler_READPARMS
C !INTERFACE: ==========================================================
      SUBROUTINE BFMcoupler_READPARMS( myThid )

C     !DESCRIPTION: \bv
C     *==========================================================*
C     | S/R BFMcoupler_READPARMS
C     | o Initialise Memory of BFM and read BFM package parameters
C     | from BFM namelist
C     *==========================================================*
C     \ev

C     !USES:
C     === uses module
C ANY MODULEs of BFM are needed?


      IMPLICIT NONE
C     === Global variables ===
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#include "BFMcoupler_VARS.h"
       

C     !INPUT/OUTPUT PARAMETERS:
C     === Routine arguments ===
C     myThid    :: My Thread Id. number
      INTEGER myThid
CEOP
#ifdef ALLOW_BFMCOUPLER
C     === Local variables ===
C     msgBuf    :: Informational/error message buffer
C     iUnit     :: Work variable for IO unit number
      CHARACTER*(MAX_LEN_MBUF) msgBuf
      INTEGER iUnit

      NAMELIST /BFMcoupler_FORCING/
     &          BFMcoupler_atmospFile,
     &          BFMcoupler_PCO2File
#ifdef READ_xESP
     &          ,BFMcoupler_xESPFile
#endif

     &          ,BFMcoupler_sparFile

     &          ,BFMcoupler_N1pDepFile,BFMcoupler_N3nDepFile,
     &          BFMcoupler_forcingPeriod, BFMcoupler_forcingCycle
#ifdef USE_SINK
     &          ,vsed
#endif
#ifdef USE_SHADE
     &          ,p_espP1,p_espP2,p_espP3,p_espP4,p_espWATER  
#endif
     &          ,p_burial,p_fluxC_bot,p_fluxN_bot
     &          ,p_fluxP_bot,p_fluxSi_bot

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|

      _BEGIN_MASTER(myThid)

       BFMcoupler_atmospFile= ' '
       BFMcoupler_PCO2File  = ' '
       BFMcoupler_xESPFile  = ' '
       BFMcoupler_sparFile  = ' '
       BFMcoupler_N1pDepFile= ' '
       BFMcoupler_N3nDepFile= ' '
       BFMcoupler_forcingPeriod = externForcingPeriod
       BFMcoupler_forcingCycle  = externForcingCycle
#ifdef USE_SINK
       vsed=3.0
#endif
#ifdef USE_SHADE
       p_espP1=10.0E-3 ! [m2 mgCHL-1] use default if not present in NAMELIST
       p_espP2=8.0E-3 ! [m2 mgCHL-1] use default if not present in NAMELIST
       p_espP3=8.0E-3 ! [m2 mgCHL-1] use default if not present in NAMELIST
       p_espP4=8.0E-3 ! [m2 mgCHL-1] use default if not present in NAMELIST
       p_espWATER=0.035 ! [m-1] use default if not present in NAMELIST
#endif

       p_burial=0.0001 ! [1/s] use default if not present in NAMELIST
       p_fluxC_bot=0.0 ! [mmol/m3/s] set to ZERO if not present in NAMELIST
       p_fluxN_bot=0.0 ! [mmol/m3/s] set to ZERO if not present in NAMELIST
       p_fluxP_bot=0.0 ! [mmol/m3/s] set to ZERO if not present in NAMELIST
       p_fluxSi_bot=0.0 ! [mmol/m3/s] set to ZERO if not present in NAMELIST

      WRITE(msgBuf,'(A)')'BFMcoupler_READPARMS:check on light use: '
      CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     I                    SQUEEZE_RIGHT, myThid )
#ifdef USE_SHADE
      WRITE(msgBuf,'(A)')'USE_SHADE defined: atten from shelfshading'
      CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     I                    SQUEEZE_RIGHT, myThid )
#ifdef READ_xESP
      WRITE(msgBuf,'(A)')'xESPfile used as background values for water'
      CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     I                    SQUEEZE_RIGHT, myThid )
#else
      WRITE(msgBuf,'(A)')'background from p_espWATER parameter'
      CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     I                    SQUEEZE_RIGHT, myThid )
#endif
#else
#ifdef READ_xESP
      WRITE(msgBuf,'(A)')'atten read from xESPfile  '
      CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     I                    SQUEEZE_RIGHT, myThid )
#else
      WRITE(msgBuf,'(A)')'USE_SHADE and READ_xESP not defined::  error'
      CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     I                    SQUEEZE_RIGHT, myThid )
      STOP  'ABNORMAL END: BFMcoupler_readparams'
#endif 
#endif
      WRITE(msgBuf,'(A)')'BFMcoupler_READPARMS: opening data.BFMcoupler'
      CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     I                    SQUEEZE_RIGHT, myThid )

      CALL OPEN_COPY_DATA_FILE('data.BFMcoupler','BFMcoupler_READPARMS',
     O                          iUnit, myThid )
C-    forcing filenames and parameters
      READ(UNIT=iUnit,NML=BFMcoupler_FORCING)

      WRITE(msgBuf,'(A)')
     &   ' BFMcoupler_READPARMS: finished reading data.BFMcoupler'
      CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     I                    SQUEEZE_RIGHT, myThid )

C--   Close the open data file
      CLOSE(iUnit)


C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|
C Inizialize Libraries of BFM model 

      WRITE(msgBuf,'(A)') 'BFMcoupler: Inizializing BFM libraries model'
      CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     I                    SQUEEZE_RIGHT, myThid )

      call BFM0D_NO_BOXES(1,1,1,1,1)
      call BFM_Initialize()
C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|

      _END_MASTER(myThid)

C--   Everyone else must wait for the parameters to be loaded
      _BARRIER

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|



#endif /* ALLOW_BFMCOUPLER */

      RETURN
      END




