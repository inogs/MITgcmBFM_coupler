C BFMcoupler/BFMcoupler_init_fixed.F, v 1.0
C -----------------------------------------------------------------------------

C Copyright (C) 2017 Gianpiero Cossarini (gcossarini@inogs.it)

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

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|
CBOP
C     !ROUTINE: BFMcoupler_INIT_FIXED

C     !INTERFACE:
      SUBROUTINE BFMcoupler_INIT_FIXED( myThid )

C     !DESCRIPTION:
C     Initialize fixed quantities

C     !USES:
      IMPLICIT NONE
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#include "GRID.h"
#include "BFMcoupler_VARS.h"

C     !INPUT PARAMETERS:
C     myThid       :: my Thread Id number
      INTEGER myThid
CEOP

#ifdef ALLOW_BFMCOUPLER
      INTEGER k
      CHARACTER*(MAX_LEN_MBUF) msgBuf
      INTEGER iUnit

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|

      _BEGIN_MASTER(myThid)

C--   Print out nlev values :
      iUnit = standardMessageUnit
      WRITE(msgBuf,'(A)') ' '
      CALL PRINT_MESSAGE(msgBuf,iUnit,SQUEEZE_RIGHT,myThid)
      WRITE(msgBuf,'(A)') '// ==================================='
      CALL PRINT_MESSAGE(msgBuf,iUnit,SQUEEZE_RIGHT,myThid)
      WRITE(msgBuf,'(A)') '//  BFMcoupler_INIT_FIXED parameters :'
      CALL PRINT_MESSAGE(msgBuf,iUnit,SQUEEZE_RIGHT,myThid)

      _END_MASTER(myThid)

#ifdef ALLOW_DIAGNOSTICS
      IF ( useDIAGNOSTICS ) THEN
        CALL BFMcoupler_DIAGNOSTICS_INIT( myThid )
      ENDIF
#endif /* ALLOW_DIAGNOSTICS */

#endif /* ALLOW_BFMCOUPLER */

      RETURN
      END
