import argparse
def argument():
    parser = argparse.ArgumentParser(description = '''
    Applys a patch to the MITgcm source files
    ''', formatter_class=argparse.RawTextHelpFormatter)


    parser.add_argument(   '--inputfile','-i',
                                type = str,
                                required = True,
                                help = '''input file name''')
    parser.add_argument(   '--outfile','-o',
                                type = str,
                                required = True,
                                help = '''output file name''')


    return parser.parse_args()

args = argument()
from commons.utils import file2stringlist
import os

INCLUDE_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"#include \"BFMcoupler_OPTIONS.h\"",
"#endif"]

CALL_LINES=[
"#ifdef ALLOW_BFMCOUPLER",
"      IF ( useBFMcoupler) THEN",
"         CALL BFMcoupler_INI_FORCING(myThid)",
"      ENDIF",
"#endif"]


filename=args.inputfile
PKG=os.path.basename(filename).rsplit("_")[0].upper()
end_string="#endif /* ALLOW_%s */" %PKG

LINES=file2stringlist(filename)

nLINES=len(LINES)

for iline, line in enumerate(LINES):
    if line.find("INTERFACE: ==") >-1: interface_line=iline
    if line.find(end_string)>-1: end_line=iline
        
OUTLINES=[]
for iline in range(interface_line):
    OUTLINES.append(LINES[iline])

for line in INCLUDE_LINES: OUTLINES.append(line)
for iline in range(interface_line,end_line):
    OUTLINES.append(LINES[iline])

for line in CALL_LINES: OUTLINES.append(line)
for iline in range(end_line,nLINES):
    OUTLINES.append(LINES[iline])


OUTLINES=[line + "\n" for line in OUTLINES]

fid=open(args.outfile,'w')
fid.writelines(OUTLINES)
fid.close()


