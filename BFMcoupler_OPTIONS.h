C $Header: /pkg/BFMcouler/BFMcoupler_OPTIONS.h,v 1.01 2014/04/24
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
#ifndef BFMcoupler_OPTIONS_H
#define BFMcoupler_OPTIONS_H
#include "PACKAGES_CONFIG.h"
#include "CPP_OPTIONS.h"

#ifdef ALLOW_BFMCOUPLER
C     Package-specific Options & Macros go here
c  eventual specific options for the BFMcoupler go here

#define USE_QSW
#undef READ_PAR
#define USE_SINK
c #undef USE_SINK
#define USE_SHADE
#define READ_xESP
#define BFMcoupler_DEBUG
#define USE_BURIAL
#define USE_BOT_FLUX


#endif /* ALLOW_BFMCOUPLER */
#endif /* BFMcoupler_OPTIONS_H */

CEH3 ;;; Local Variables: ***
CEH3 ;;; mode:fortran ***
CEH3 ;;; End: ***




