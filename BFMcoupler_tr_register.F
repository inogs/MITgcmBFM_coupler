#include "BFMcoupler_OPTIONS.h"

CBOP
C     !ROUTINE: BFMcoupler_TR_REGISTER
C     !INTERFACE:
      SUBROUTINE BFMcoupler_TR_REGISTER(
     U                            tracer_num, sepFTr_num,
     I                            myThid )

C     !DESCRIPTION:
C     *==========================================================*
C     | SUBROUTINE BFMcoupler_TR_REGISTER
C     | o Register BFMcoupler tracer indices
C     *==========================================================*

C     !USES:
      IMPLICIT NONE

C     == GLobal variables ==
#include "SIZE.h"
#include "EEPARAMS.h"
c#include "PARAMS.h"
c#include "BFMcoupler_VARS.h"

C     !INPUT/OUTPUT PARAMETERS:
C     tracer_num :: current number of registered tracers
C     sepFTr_num :: number of registered tracers that use Separate Forcing
C     myThid     :: my Thread Id number
      INTEGER tracer_num
      INTEGER sepFTr_num
      INTEGER myThid

C     !LOCAL VARIABLES:
C     msgBuf     :: message buffer
      CHARACTER*(MAX_LEN_MBUF) msgBuf
      INTEGER BFMcoupler_Tr_num
CEOP
c     TODO generalized for a generic number of passive conc tracers
      BFMcoupler_Tr_num = 51 + 2

      WRITE(msgBuf,'(2A,2I5)') '  BFMcoupler_TR_REGISTER: ',
     &     ' number of BFMcoupler tracers=', BFMcoupler_Tr_num
      CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                    SQUEEZE_RIGHT, myThid )
      WRITE(msgBuf,'(2A,2I5)') '  BFMcoupler_TR_REGISTER: ',
     &     '  starting at pTrc num=', tracer_num + 1
      CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                    SQUEEZE_RIGHT, myThid )

      tracer_num =  BFMcoupler_Tr_num
      sepFTr_num = 0

      WRITE(msgBuf,'(2A,2I5)') ' BFMcoupler_TR_REGISTER: ',
     &     ' Numb. Trac & SepForc Trac:', tracer_num, sepFTr_num
      CALL PRINT_MESSAGE( msgBuf, standardMessageUnit,
     &                    SQUEEZE_RIGHT, myThid )

      RETURN
      END
