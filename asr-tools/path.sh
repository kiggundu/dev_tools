#Make sure $KALDI_ROOT is set
if [ -z $KALDI_ROOT ]; then
    echo "Please ensure KALDI_ROOT env variable is set"
    exit 1
fi

PROJECT_ROOT="."

# Setting paths to useful tools
export PATH=$PROJECT_ROOT/utils/:$KALDI_ROOT/src/bin:$KALDI_ROOT/tools/openfst/bin:$KALDI_ROOT/src/fstbin/:$KALDI_ROOT/src/gmmbin/:$KALDI_ROOT/src/featbin/:$KALDI_ROOT/src/lmbin/:$KALDI_ROOT/src/sgmm2bin/:$KALDI_ROOT/src/fgmmbin/:$KALDI_ROOT/src/latbin/:$PROJECT_ROOT:$PATH

# Defining audio data directory (modify it for your installation directory!)
export DATA_ROOT="${PROJECT_ROOT}/data"
# Enable SRILM
. $KALDI_ROOT/tools/env.sh
# Variable needed for proper data sorting
export LC_ALL=C
