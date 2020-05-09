
project=$1

if [ -z $KALDI_ROOT ]; then
    echo "Please ensure KALDI_ROOT env variable is set"
    exit 1
fi

if [ -z $5 ]; then
    echo "Please specify 5 parameters in the format: "
    echo "record_samples.sh <symbolsPerSample> <durationOfOneSample> <noOfSamples> <symbolFile> <project>"
    echo ""
    echo "this script will delete the <project> directory under $KALDI_ROOT "
    exit 1
fi

PROJECT_ROOT="${KALDI_ROOT}/egs/${project}"

rm -rf $PROJECT_ROOT
