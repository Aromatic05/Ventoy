#!/bin/bash

rm -rf edk2-edk2-stable201911

unzip edk2-edk2-stable201911.zip > /dev/null

/bin/cp -a ./edk2_mod/edk2-edk2-stable201911  ./

cd edk2-edk2-stable201911
sed -i 's/if name == '\''ucs-2'\'':/if name.replace("_", "-") == "ucs-2":/' BaseTools/Source/Python/AutoGen/UniClassObject.py
sed -i 's/\.tostring()/\.tobytes()/g' BaseTools/Source/Python/{Common/Misc.py,GenFds/GenFdsGlobalVariable.py,Eot/EotMain.py}
sed -i '/^DEFINE GCC48_ALL_CC_FLAGS/s/-Werror/-Werror -Wno-error -fno-pie -no-pie/' BaseTools/Conf/tools_def.template
make -j 4 -C BaseTools/ EXTRA_OPTFLAGS=-Wno-error
cd ..

echo '======== build EDK2 for i386-efi ==============='
bash ./build.sh ia32 || exit 1

echo '======== build EDK2 for arm64-efi ==============='
bash ./build.sh aa64 || exit 1

echo '======== build EDK2 for x86_64-efi ==============='
bash ./build.sh || exit 1


echo '======== build EDK2 for x86_64-efi ==============='
bash ./build_shim.sh || exit 1
