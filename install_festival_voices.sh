mkdir hts_tmp
cd hts_tmp/

#The voices below do not seem to work out of the box
#wget -c http://hts.sp.nitech.ac.jp/archives/2.1/festvox_nitech_us_awb_arctic_hts-2.1.tar.bz2
#wget -c http://hts.sp.nitech.ac.jp/archives/2.1/festvox_nitech_us_bdl_arctic_hts-2.1.tar.bz2
#wget -c http://hts.sp.nitech.ac.jp/archives/2.1/festvox_nitech_us_clb_arctic_hts-2.1.tar.bz2
#wget -c http://hts.sp.nitech.ac.jp/archives/2.1/festvox_nitech_us_jmk_arctic_hts-2.1.tar.bz2
#wget -c http://hts.sp.nitech.ac.jp/archives/2.1/festvox_nitech_us_rms_arctic_hts-2.1.tar.bz2
#wget -c http://hts.sp.nitech.ac.jp/archives/2.1/festvox_nitech_us_slt_arctic_hts-2.1.tar.bz2

#for t in `ls` ; do tar xvf $t ; done

#sudo mkdir -p /usr/share/festival/voices/us
#sudo mv lib/voices/us/* /usr/share/festival/voices/us/
#sudo mv lib/hts.scm /usr/share/festival/hts.scm

wget http://www.speech.cs.cmu.edu/cmu_arctic/packed/cmu_us_slt_arctic-0.95-release.tar.bz2
tar xf cmu_us_slt_arctic-0.95-release.tar.bz2
sudo mv cmu_us_slt_arctic /usr/share/festival/voices/us/cmu_us_slt_arctic_clunits
sudo echo "(set! voice_default 'voice_cmu_us_slt_arctic_clunits)" >> /etc/festival.scm

#Install some more voices
FESTIVAL_VOICES=http://festvox.org/packed/festival/2.5/voices/
FESTIVAL_VOICES=http://tts.speech.cs.cmu.edu/awb/festival-2.5/voices
wget ${FESTIVAL_VOICES}/festvox_cmu_us_aew_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_ahw_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_aup_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_awb_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_axb_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_bdl_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_clb_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_eey_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_fem_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_gka_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_jmk_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_ksp_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_ljm_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_lnh_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_rms_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_rxr_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_slt_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_cmu_us_slp_cg.tar.gz
wget ${FESTIVAL_VOICES}/festvox_kallpc16k.tar.gz
wget ${FESTIVAL_VOICES}/festvox_rablpc16k.tar.gz

tar xf festvox*.gz
sudo find . -type d -name "festvox*" -exec mv '{}' /usr/share/festival/voices/us/ \;

echo "Well done Abraham. are you not just Fada? I think it's time to audiofy some books" > test.txt
festival --tts test.txt

cd ..
rm -rf hts_tmp
