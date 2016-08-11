C $Header: /pkg/BFMcouler/BFMcoupler_OPTIONS.h,v 1.01 2014/04/24

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




