symbolsPerSample=$1 #number of symbols per sample
durationOfOneSample=$2
noOfSamples=$3
symbolFile=$4
project=$5

if [ -z $KALDI_ROOT ]; then
    echo "Please ensure KALDI_ROOT env variable is set"
    exit 1
fi

if [ -z $5 ]; then
    echo "Please specify 5 parameters in the format: "
    echo "record_samples.sh <symbolsPerSample> <durationOfOneSample> <noOfSamples> <symbolFile> <project>"
    echo ""
    echo "this script will populate the <project> directory under $KALDI_ROOT with a speaker's sample data"
    exit 1
fi

PROJECT_ROOT=${KALDI_ROOT}/egs/${project}/

START=1
END=$noOfSamples
i=$START
read -p "Enter Speaker ID/Name : " name
read -p "Enter Speaker gender(m/f) : " gender
read -p "Data type - default is 'train' (test/train)?" captureType
captureType="${captureType:-train}"

mkdir -p ${PROJECT_ROOT}/train ${PROJECT_ROOT}/test ${PROJECT_ROOT}/data/local/dict local

echo "${name} ${gender}" >> data/spk2gender
while [ $i -le $END ]
do
    toBeSpoken=`shuf -n $symbolsPerSample ${symbolFile} | awk '{print}' ORS=' '`
    fileRoot=`echo $toBeSpoken | tr ' ' '_'`
    utteranceID="${name}_${fileRoot}"
    echo "Say ${toBeSpoken} within ${durationOfOneSample} seconds."
    record -d ${durationOfOneSample} -f cd -t wav "${PROJECT_ROOT}/${captureType}/${name}/${fileRoot}.wav"${fileRoot}.wav &
    timer.sh ${durationOfOneSample}
    echo "${utteranceID} ${PROJECT_ROOT}/${captureType}/${name}/${fileRoot}.wav" >> data/wav.scp
    echo "${utteranceID} ${toBeSpoken}" >> data/text
    echo "${utteranceID} ${name}" >> utt2spk
    echo "${toBeSpoken}" >> data/local/corpus.txt
    i=$(( i+1 ))
done

#Copy tthe scripts over
cp -r ${PROJECT_ROOT}/wsj/utils utils
cp -r ${PROJECT_ROOT}/wsj/steps steps
cp -r ${PROJECT_ROOT}/voxforge/s5/local/score.sh local/score.sh




