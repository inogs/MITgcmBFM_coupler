C BFMcoupler/BFMcoupler_VARDIAGlocal.h, v 1.0
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
C local variables of diagnostic for BFMcoupler_calc_tendency.f 
C 
      _RL   diaPPG(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaNPP(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaBPP(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaDIC(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaCO2(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaHCO3(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaCO3(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaAc(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diapH(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diapCO2(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaF01(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaF02(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaF03(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaF04(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaF05(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaF06(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaF07(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaF08(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaF09(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaF10(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaF11(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaF12(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaF13(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaxpar(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diawspeed(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaRHOSitu(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
      _RL   diaPCO2atm(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr)
