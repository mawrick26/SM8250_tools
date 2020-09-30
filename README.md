# Boot Maker
A simple script to replace kernel &amp; dtb in android boot image

### How to use ?
- Clone this repo
- Copy your `Image / Image.* / Image.*-dtb` from kernel output folder to the root folder of the repo
( Also you can copy bare Image + *.dtb files, dtb files will be automatically merged and put into boot image  )
- cd the repo folder
- Run `make.sh` and a new boot image will be generated

### Notice
- Edit the script and change `${MAGISKBOOT}` from x86 to arm if you are running this on an arm-based device

### Credit
- [magiskboot](https://github.com/topjohnwu/Magisk)
( This script is totally based on magiskboot binary )
