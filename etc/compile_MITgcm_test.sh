#!/bin/bash

MYPRJ=CADEAU
MITGCM_WORKDIR=/gpfs/scratch/userexternal/squerin0/test_operational/${MYPRJ}
MYCODE=code_CADEAU_UWWTP
MAKECPU=8

####### root part #########################
MITGCM_ROOT=/gpfs/scratch/userexternal/squerin0/test_operational/MITgcm_c66j  
MITGCM_GNMK=${MITGCM_ROOT}/tools/genmake2
###########################################


###### build part #######################
#MITGCM_BLDOPT=linux_amd64_ifort11_test
#MITGCM_BLDOPT=linux_amd64_ifort11_test_flag
MITGCM_BLDOPT=linux_amd64_ifort11_test_galileo
MITGCM_OF=/gpfs/scratch/userexternal/squerin0/test_operational/build_options/${MITGCM_BLDOPT} 

# BUILD_DIR=${MITGCM_WORKDIR}/build_190p_BFM_CADEAU_test
BUILD_DIR=${MITGCM_WORKDIR}/build_190p_BFM_CADEAU_test_flag_ALD
# LOGDIR=${MITGCM_WORKDIR}/LOGS_190p
LOGDIR=${MITGCM_WORKDIR}/LOGS_190p_flag_ALD
#######################################################


##### devel part ######################################
MITGCM_CODE=/gpfs/scratch/userexternal/squerin0/test_operational/${MYCODE}

echo "start compiling ..."
module purge
module load profile/advanced # aggiunto da Valeria il 16 luglio 2018
module load autoload # su indicazione di Isabella
module load intel/pe-xe-2018--binary
module load intelmpi/2018--binary
module load netcdff/4.4.4--intel--pe-xe-2018--binary
module load gsl/2.5--intel--pe-xe-2018--binary

rm -rf $BUILD_DIR
mkdir -p  $BUILD_DIR
rm -rf $LOGDIR
mkdir -p $LOGDIR

echo "launching MITgcm genmake2 with project $MYPRJ and code $MITGCM_CODE and build_options $MITGCM_OF ..."
cd $BUILD_DIR

${MITGCM_GNMK} -mpi -gsl -of=${MITGCM_OF} -rootdir=${MITGCM_ROOT} -mods=${MITGCM_CODE} > $LOGDIR/genmake2.log 2>$LOGDIR/genmake2.err

ANS=$?
echo genmake2 exit status : $ANS
if [ $ANS -ne 0 ] ; then echo "ERROR " ; exit 1 ; fi

echo "launching dependencies compilation ..."
make depend > $LOGDIR/depend2.log 2>$LOGDIR/depend2.err
ANS=$?
echo make depend exit status : $ANS
if [ $ANS -ne 0 ] ; then echo "ERROR " ; exit 1 ; fi

echo "launching project compilation ..."
make -j $MAKECPU > $LOGDIR/make.log 2> $LOGDIR/make.err 
ANS=$?
echo make exit status : $ANS
if [ $ANS -ne 0 ] ; then echo "ERROR " ; exit 1 ; fi

echo "Compiling finished!"
