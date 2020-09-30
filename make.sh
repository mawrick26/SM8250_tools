#!/bin/bash

MAGISKBOOT="../bin/x86/magiskboot"
#MAGISKBOOT="../bin/arm/magiskboot"

print (){
case ${2} in
	"red")
	echo -e "\033[31m $1 \033[0m";;

	"blue")
	echo -e "\033[34m $1 \033[0m";;

	"yellow")
	echo -e "\033[33m $1 \033[0m";;

	"purple")
	echo -e "\033[35m $1 \033[0m";;

	"sky")
	echo -e "\033[36m $1 \033[0m";;

	"green")
	echo -e "\033[32m $1 \033[0m";;

	*)
	echo $1
	;;
	esac
}

mkdir work
cd work
print "Unpacking boot.img" yellow
${MAGISKBOOT} unpack ../boot.img

mkdir ../tmp
cd ../tmp
cp ../Image* . 2>/dev/null

if [ -e Image.*-dtb ]
then
	for i in Image.*-dtb
	do
		print "Found ${i}, splitting..." yellow
		${MAGISKBOOT} split ${i}
		rm ${i}
		mv kernel Image
	done
fi

if [ -e Image.* ]
then
	for i in Image.*
	do
		print "Found ${i}, decompressing..." yellow
		${MAGISKBOOT} decompress ${i} Image
		rm ${i}
	done
fi

if [ -e Image ]
then
print "New kernel Image found, copying to workspace..." yellow
cp Image ../work/kernel
fi

if [[ "-e ../*dtb" ]]
then
	for i in ../*dtb
	do
		if [[ ${i} != *Image* ]]
		then
			print "Custom dtb found, replacing the kernel dtb..." yellow
			rm kernel_dtb 2>/dev/null
			cp ${i} .
		fi
	done
fi

if [ "-e *dtb" ]
then
	cat *dtb > ../work/dtb
fi

cd ../work
print "Making boot_new.img" yellow
${MAGISKBOOT} repack ../boot.img ../boot_new.img

cd ..
rm -rf work
rm -rf tmp

print "All done. Find it at boot_new.img" yellow
