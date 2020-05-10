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

PROJECT_ROOT="${KALDI_ROOT}/egs/${project}"


validate(){
    #Accepts $1 as an array of allowed values for $2. Exits if $2 is not one of those values.
    #If the retrn value is not empty then $2 is valid
    #TODO: need to work out how to use this in a whele agaist another variable ??!!??
    for i in "${1[@]}"; do
        if [[ $2 == $i ]]; then
            echo "valid"
        fi
    done
}

getInput(){

while [ -z ${value} ]
do
    read -p "$1" value
done
}

name="$(getInput 'Enter Speaker ID/Name : ' )"
gender="$(getInput 'Enter Speaker gender(m/f) : ' )"
captureType="$(getInput 'Capture type - default is <train> (test/train)?' )"
captureType="${captureType:-train}"

AUDIO_PATH="${PROJECT_ROOT}/${project}_audio"
mkdir -p "${AUDIO_PATH}/train" "${AUDIO_PATH}/test" "${PROJECT_ROOT}/data/local/dict" "${PROJECT_ROOT}/local"

echo "${name} ${gender}" >> ${PROJECT_ROOT}/data/spk2gender

START=1
END=$noOfSamples
i=$START
while [ $i -le $END ]
do
    toBeSpoken=`shuf -n $symbolsPerSample ${symbolFile} | awk '{print}' ORS=' '`
    fileRoot=`echo $toBeSpoken | tr ' ' '_'`
    utteranceID="${name}_${fileRoot}"
    echo "Say ${toBeSpoken} within ${durationOfOneSample} seconds."
    record -d ${durationOfOneSample} -f cd -t wav "${PROJECT_ROOT}/${captureType}/${name}/${fileRoot}.wav"${fileRoot}.wav &
    timer.sh ${durationOfOneSample}
    echo "${utteranceID} ${PROJECT_ROOT}/${captureType}/${name}/${fileRoot}.wav" >> ${PROJECT_ROOT}/data/wav.scp
    echo "${utteranceID} ${toBeSpoken}" >> ${PROJECT_ROOT}/data/text
    echo "${utteranceID} ${name}" >> utt2spk
    echo "${toBeSpoken}" >> ${PROJECT_ROOT}/data/local/corpus.txt
    i=$(( i+1 ))
done

