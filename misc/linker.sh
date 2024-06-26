#!/bin/zsh

# NOTE: This ultimately didn't work, but really only because I didn't want to patch the kernel, or update the kernel itself just for driver support
# Sound alerady works with speakers plugged in, it's just the internals that has issues.
# https://asus-linux.org/guides/cirrus-amps/

SOURCE=10431503
TARGET=10431d1f
CS_DIR=cs35l41
V_6_78="$CS_DIR/v6.78.0"

SHARED_SOURCE="$V_6_78/halo_cspl_RAM_revB2_29.80.0.wmfw"

# Get Firmware files from 24.04 "demo", @ '/lib/firmware/cirrus'
# # TODO: pushd/popd for this
# # # Unzip (.zst) files
# # unzstd z-cirrus -rf --output-dir-mirror cirrus

pushd target

# rm cs35l41-dsp1-spk-{cali,prot}-10431d1f*
rm ./*.{bin,wmfw}
# Find Source of files, and copy to here
find ../../from-ubu-24/cirrus/z-cirrus -iregex ".*10431503.*" -exec cp {} ./ \;
# Copy dir used for linking wmfw files
rm -rf "./$CS_DIR"
mkdir -p "$CS_DIR"
cp -r ../../from-ubu-24/cirrus/z-cirrus/cs35l41/v6.78.0 "$CS_DIR"

WANTED_FILES="find . -iregex '.*.bin' | sed 'h;s/$SOURCE/$TARGET/;x;G;s/\n/ /'"
FILE_LIST=( "${(@f)$(eval $WANTED_FILES)}" )

for i in "${FILE_LIST[@]}"; do
  # ln -s "$i"
  FILES=( ${(@s: :)i} )
  source_file=$(echo $FILES[1] | sed 's/\.\///g')
  target_file=$(echo $FILES[2] | sed 's/\.\///g')
  ln -s $source_file $target_file
  # echo "$source_file $target_file"
done

WANTED_WMFW="find . -iregex '.*$SOURCE.wmfw'"
WMFW_LIST=( "${(@f)$(eval $WANTED_WMFW)}" )

for i in "${WMFW_LIST[@]}"; do
  source_wmfw=$(echo "$i" | sed 's/\.\///g')
  target_wmfw=$(echo "$source_wmfw" | sed "s/$SOURCE/$TARGET/g")
  echo "$source_wmfw"
  mv "$source_wmfw" "$(echo $source_wmfw).bak"
  ln -s "$SHARED_SOURCE" "$source_wmfw"
  ln -s "$SHARED_SOURCE" "$target_wmfw"
done

rm ./*.bak

# sudo cp -r "$V_6_78" "/lib/firmware/cirrus/$CS_DIR"
# sudo cp -P ./*.{bin,wmfw} /lib/firmware/cirrus/

popd

