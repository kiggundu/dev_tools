set -o nounset    # Exposes unset variables
set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures


symbolsPerSample=$1 #number of symbols per sample
durationOfOneSample=$2 #the time in seconds for which a sample audio will be recorded
noOfSamples=$3 #the number of samples to be recorded from the symbol vocabulary per user
symbolFile=$4 #the symbol vocabulary file from which to pick symbols
project=$5      #the name of the ASR project

if [ -z $KALDI_ROOT ]; then
    echo "Please ensure KALDI_ROOT env variable is set"
    exit 1
fi

if [ -z $5 ]; then
    echo "Please specify 5 parameters in the format: "
    echo "start_kaldi_asr_project.sh <symbolsPerSample> <durationOfOneSample> <noOfSamples> <symbolFile> <project>"
    echo ""
    echo "this script will create the project directory (failing if it aready exists) then start populating it with the speaker's samples under $KALDI_ROOT/egs/<project>"
    exit 1
fi

PROJECT_ROOT=${KALDI_ROOT}/egs/${project}/

if [[ -e $PROJECT_ROOT ]]; then
    echo "Folder $PROJECT_ROOT already exists. Choose another name for the project.";
    exit 1
fi

while [[ -z $STOP ]]; do
   ./record_samples.sh $symbolsPerSample $durationOfOneSample $noOfSamples $symbolFile $project
   read -p "Enter to record another speaker, any char then enter to stop? " STOP
done

#make srilm.tgz exists in the kaldi tools area then cd to that tools directory and install
#if not already installed
if [[ ! -e $KALDI_ROOT/tools/srilm.tgz ]]; then
    cp $KALDI_ROOT/../../srilm-1.7.1.tar.gz $KALDI_ROOT/tools/srilm.tgz
    $(cd $KALDI_ROOT/tools && ./install_srilm.sh)
fi

#Some default config
mkdir -p  ${PROJECT_ROOT}/conf
echo "first_beam=10.0" >> ${PROJECT_ROOT}/conf/decode.config
echo "beam=13.0" >> ${PROJECT_ROOT}/conf/decode.config
echo "lattice_beam=6.0" >> ${PROJECT_ROOT}/conf/decode.config
echo "--use-energy=false" >> ${PROJECT_ROOT}/conf/mfcc.config

#Copy tthe scripts over
cp -r ${KALDI_ROOT}/egs/wsj/utils ${PROJECT_ROOT}/utils
cp -r ${KALDI_ROOT}/egs/wsj/steps ${PROJECT_ROOT}/steps
cp -r ${KALDI_ROOT}/egs/voxforge/s5/local/score.sh ${PROJECT_ROOT}/local/score.sh

#copy the template scripts to the project directory
cp cmd.sh ${PROJECT_ROOT}
cp path.sh ${PROJECT_ROOT}
cp run.sh ${PROJECT_ROOT}
cp ./reference.lexicon.txt ${PROJECT_ROOT}/data/local/dict/lexicon.txt
cp ./reference.silence_phones.txt ${PROJECT_ROOT}/data/local/dict/silence_phones.txt
cp ./reference_optional_silence.txt ${PROJECT_ROOT}/data/local/dict/optional_silence.txt
cp ./reference.nonsilence_phones.txt ${PROJECT_ROOT}/data/local/dict/nonsilence_phones.txt
echo "Project ready "
