#set -o nounset    # Exposes unset variables
set -o errexit    # Used to exit upon error, avoiding cascading errors

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


validate() {
    #Accepts $1 as an array of allowed values for $2. Exits if $2 is not one of those values.
    #If the retrn value is not empty then $2 is valid
    #TODO: need to work out how to use this in a whele agaist another variable ??!!??
    for i in "${1[@]}"; do
        if [[ $2 == $i ]]; then
            echo "valid"
        fi
    done
}

getInput() {
    while [ -z $value ]
    do
        read -p "$1" value
    done
    echo "$value"
}

DATA_PATH="${PROJECT_ROOT}/data"
mkdir -p "${DATA_PATH}/train" "${DATA_PATH}/test" "${DATA_PATH}/local/dict" "${PROJECT_ROOT}/local"

echo "--------SPEACH CAPTURE-----------"
name="$(getInput 'Enter Speaker ID/Name : ' )"
gender="$(getInput 'Enter Speaker gender(m/f) : ' )"
captureType="$(getInput 'Capture type - default is <train> (test/train)?' )"
captureType="${captureType:-train}"

echo "${name} ${gender}" >> ${PROJECT_ROOT}/data/spk2gender
mkdir -p "${DATA_PATH}/${captureType}/${name}"

read -p "Press ENTER to start recording samples...." junk

START=1
END=$noOfSamples
i=$START
while [ $i -le $END ]
do
    toBeSpoken=`shuf -n $symbolsPerSample ${symbolFile} | awk '{print}' ORS=' '`
    fileRoot=`echo $toBeSpoken | tr ' ' '_'`
    utteranceID="${name}_${fileRoot}"
    echo "Say '${toBeSpoken}' within ${durationOfOneSample} seconds."
    arecord -d ${durationOfOneSample} -f cd -t wav "${DATA_PATH}/${captureType}/${name}/${fileRoot}.wav" &
    ./timer.sh ${durationOfOneSample}
    echo "${utteranceID} ${DATA_PATH}/${captureType}/${name}/${fileRoot}.wav" >> ${DATA_PATH}/wav.scp
    echo "${utteranceID} ${toBeSpoken}" >> ${DATA_PATH}/text
    echo "${utteranceID} ${name}" >> ${DATA_PATH}/${captureType}/utt2spk
    echo "${toBeSpoken}" >> ${DATA_PATH}/local/corpus.txt
    echo "------------------------------------------------------------"
    echo ""
    i=$(( i+1 ))
done

echo "--------END OF SPEACH CAPTURE-----------"
