
#ifndef BFMcoupler_SIZE_H
#define BFMcoupler_SIZE_H

CBOP
C    !ROUTINE: BFMcoupler_SIZE.h
C    !INTERFACE:
C #include BFMcoupler_SIZE.h

C    !DESCRIPTION:
C Contains BFMcoupler tracer array size (number of tracers).

C BFMcoupler_Tr_num   :: defines how many BFMcoupler tracer are allocated.
      INTEGER BFMcoupler_Tr_num
      PARAMETER( BFMcoupler_Tr_num = 51 + 2 )

#endif /* BFMcoupler_SIZE_H */

CEH3 ;;; Local Variables: ***
CEH3 ;;; mode:fortran ***
CEH3 ;;; End: ***
