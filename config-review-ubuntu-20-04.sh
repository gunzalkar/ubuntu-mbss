
rm -rf results
rm -rf tempfiles 
mkdir -p results
mkdir -p tempfiles

# Check if the script is run as root
if [ "$EUID" -ne 0 ]
then
    echo "Please run as root"
    exit
fi



# OS and version: <Capture from system>




# Date and time: <Capture from system>
var_date1=$(date)

varfile1="Config_Review_"$var_date1"
# echo "$varfile1"
varfile1=${varfile1// /_}
varfile1=${varfile1//:/-}
varfile1=${varfile1//./-}
# echo "$varfile1"
varfilename="results/"$varfile1".csv"
# echo "$varfilename"

echo "NST Cyber Configuration Review v0.1 Beta" >> $varfilename
echo "Date and time: "$var_date1 >> $varfilename
echo "Serial No#,Control Objective,Compliance Status,Additional Comments" >> $varfilename

# Filesystem Configuration

# 1,Ensure mounting of cramfs filesystems is disabled
#---------------------------------------------#
modprobe -n -v cramfs | grep -E '(cramfs|install)' >/dev/null 2>&1

var1=$(lsmod | grep cramfs >/dev/null 2>&1)

if [ -z "$var1" ]
then
      echo "1,Ensure mounting of cramfs filesystems is disabled,Compliant" >> $varfilename
else
      echo "1,Ensure mounting of cramfs filesystems is disabled,Non-Compliant" >> $varfilename
fi

# 2,Ensure mounting of freevxfs filesystems is disabled

modprobe -n -v freevxfs | grep -E '(freevxfs|install)' >/dev/null 2>&1

var1=$(lsmod | grep freevxfs)

if [ -z "$var1" ]
then
      echo "2,Ensure mounting of freevxfs filesystems is disabled,Compliant" >> $varfilename
else
      echo "2,Ensure mounting of freevxfs filesystems is disabled,Non-Compliant" >> $varfilename
fi

# 3,Ensure mounting of jffs2 filesystems is disabled

modprobe -n -v jffs2 | grep -E '(jffs2|install)' >/dev/null 2>&1

var1=$(lsmod | grep jffs2)

if [ -z "$var1" ]
then
      echo "3,Ensure mounting of jffs2 filesystems is disabled,Compliant" >> $varfilename
else
      echo "3,Ensure mounting of jffs2 filesystems is disabled,Non-Compliant" >> $varfilename
fi

# 4,Ensure mounting of hfs filesystems is disabled

modprobe -n -v hfs | grep -E '(hfs|install)' >/dev/null 2>&1

var1=$(lsmod | grep hfs)

if [ -z "$var1" ]
then
      echo "4,Ensure mounting of hfs filesystems is disabled,Compliant" >> $varfilename
else
      echo "4,Ensure mounting of hfs filesystems is disabled,Non-Compliant" >> $varfilename
fi

# 5,Ensure mounting of hfsplus filesystems is disabled

modprobe -n -v hfsplus | grep -E '(hfsplus|install)' >/dev/null 2>&1

var1=$(lsmod | grep hfsplus)

if [ -z "$var1" ]
then
      echo "5,Ensure mounting of hfsplus filesystems is disabled,Compliant" >> $varfilename
else
      echo "5,Ensure mounting of hfsplus filesystems is disabled,Non-Compliant" >> $varfilename
fi

# 6,Ensure mounting of udf filesystems is disabled

modprobe -n -v udf | grep -E '(udf|install)' >/dev/null 2>&1

var1=$(lsmod | grep udf)

if [ -z "$var1" ]
then
      echo "6,Ensure mounting of udf filesystems is disabled,Compliant" >> $varfilename
else
      echo "6,Ensure mounting of udf filesystems is disabled,Non-Compliant" >> $varfilename
fi

# 7,Ensure /tmp is configured

var_tmp1=$(findmnt -n /tmp | grep -c "/tmp")
# var_tmp1=1
if [ "$var_tmp1" -eq 0 ]
then
      echo "7,Ensure /tmp is configured,Non-Compliant" >> $varfilename
else
      echo "7,Ensure /tmp is configured,Compliant" >> $varfilename
fi

# 8,Ensure nodev option set on /tmp partition

var_tmp2=$(findmnt -n /tmp | grep -v nodev)
# var_tmp1="1"
# var_tmp2="1"
if [ "$var_tmp1" -eq 0 ]
then
      echo "8,Ensure nodev option set on /tmp partition,Non-Compliant" >> $varfilename
elif [ -z "var_tmp2" ]
then
    echo "8,Ensure nodev option set on /tmp partition,Compliant" >> $varfilename
else
    echo "8,Ensure nodev option set on /tmp partition,Non-Compliant" >> $varfilename
fi

# 9,Ensure nosuid option set on /tmp partition

var_tmp3=$(findmnt -n /tmp | grep -v nosuid)
# var_tmp1="1"
# var_tmp2="1"
if [ "$var_tmp1" -eq 0 ]
then
      echo "9,Ensure nosuid option set on /tmp partition,Non-Compliant" >> $varfilename
elif [ -z "var_tmp3" ]
then
    echo "9,Ensure nosuid option set on /tmp partition,Compliant" >> $varfilename
else
    echo "9,Ensure nosuid option set on /tmp partition,Non-Compliant" >> $varfilename
fi

# 10,Ensure noexec option set on /tmp partition

var_tmp4=$(findmnt -n /tmp | grep -v nosuid)
# var_tmp1="1"
# var_tmp2="1"
if [ "$var_tmp1" -eq 0 ]
then
      echo "10,Ensure noexec option set on /tmp partition,Non-Compliant" >> $varfilename
elif [ -z "var_tmp3" ]
then
    echo "10,Ensure noexec option set on /tmp partition,Compliant" >> $varfilename
else
    echo "10,Ensure noexec option set on /tmp partition,Non-Compliant" >> $varfilename
fi

# 11,Ensure /dev/shm is configured

var_devshm1=$(findmnt -n /dev/shm | grep -c "/dev/shm")
# var_tmp1=1
if [ "$var_devshm1" -eq 0 ]
then
      echo "11,Ensure /dev/shm is configured,Non-Compliant" >> $varfilename
else
      echo "11,Ensure /dev/shm is configured,Compliant" >> $varfilename
fi

# 12,Ensure nodev option set on /dev/shm partition

# var_devshm2="\0"
var_devshm2=$(findmnt -n /dev/shm | grep -c "nodev")
# var_tmp1="1"
# var_tmp2="1"
if [ "$var_devshm1" -eq 0 ]
then
      echo "12,Ensure nodev option set on /dev/shm partition,Non-Compliant" >> $varfilename
elif [ "$var_devshm2" -eq 0 ]
then
    echo "12,Ensure nodev option set on /dev/shm partition,Non-Compliant" >> $varfilename
else
    echo "12,Ensure nodev option set on /dev/shm partition,Compliant" >> $varfilename
fi

# 13,Ensure nosuid option set on /dev/shm partition

var_devshm3=$(findmnt -n /dev/shm | grep -c "nosuid")
# var_tmp1="1"
# var_tmp2="1"
if [ "$var_devshm1" -eq 0 ]
then
      echo "13,Ensure nosuid option set on /dev/shm partition,Non-Compliant" >> $varfilename
elif [ "$var_devshm3" -eq 0 ]
then
    echo "13,Ensure nosuid option set on /dev/shm partition,Non-Compliant" >> $varfilename
else
    echo "13,Ensure nosuid option set on /dev/shm partition,Compliant" >> $varfilename
fi

# 14,Ensure noexec option set on /dev/shm partition

var_devshm4=$(findmnt -n /dev/shm | grep -c "noexec")
# var_tmp1="1"
# var_tmp2="1"
if [ "$var_devshm1" -eq 0 ]
then
      echo "14,Ensure noexec option set on /dev/shm partition,Non-Compliant" >> $varfilename
elif [ "$var_devshm4" -eq 0 ]
then
    echo "14,Ensure noexec option set on /dev/shm partition,Non-Compliant" >> $varfilename
else
    echo "14,Ensure noexec option set on /dev/shm partition,Compliant" >> $varfilename
fi

# 15,Ensure /var/tmp partition includes the nodev option

var_vartmp1=$(findmnt -n /var/tmp | grep -c "nodev")
# var_tmp1=1
if [ "$var_vartmp1" -eq 0 ]
then
      echo "15,Ensure /var/tmp partition includes the nodev option,Non-Compliant" >> $varfilename
else
      echo "15,Ensure /var/tmp partition includes the nodev option,Compliant" >> $varfilename
fi

# 16,Ensure /var/tmp partition includes the nosuid option

var_vartmp2=$(findmnt -n /var/tmp | grep -c "nosuid")
# var_tmp1=1
if [ "$var_vartmp2" -eq 0 ]
then
      echo "16,Ensure /var/tmp partition includes the nosuid option,Non-Compliant" >> $varfilename
else
      echo "16,Ensure /var/tmp partition includes the nosuid option,Compliant" >> $varfilename
fi

# 17,Ensure /var/tmp partition includes the noexec option

var_vartmp3=$(findmnt -n /var/tmp | grep -c "noexec")
# var_tmp1=1
if [ "$var_vartmp3" -eq 0 ]
then
      echo "17,Ensure /var/tmp partition includes the noexec option,Non-Compliant" >> $varfilename
else
      echo "17,Ensure /var/tmp partition includes the noexec option,Compliant" >> $varfilename
fi

# 18,Ensure /home partition includes the nodev option

var_home1=$(findmnt -n /home | grep -c "nodev")
# var_tmp1=1
if [ "$var_home1" -eq 0 ]
then
      echo "18,Ensure /home partition includes the nodev option,Non-Compliant" >> $varfilename
else
      echo "18,Ensure /home partition includes the nodev option,Compliant" >> $varfilename
fi

# 19,Ensure nodev option set on removable media partitions

source list-removable.sh
var19_int1=0
# echo "before loop"
# echo $var90_int1
if [ -s files/removables.txt ]; then
    while IFS= read -r line; do
            varint_1=$(findmnt -n $line | grep -v nodev)
            if [ -z "$varint_1" ]
            then
                  var19_int1=0
                  # echo $line
            else
                  var19_int1=$((var19_int1+1))
            fi   
      done < tempfiles/removables.txt
fi
if [ "$var19_int1" -eq 0 ]
then
    echo "19,Ensure nodev option set on removable media partitions,Compliant" >> $varfilename
else
    echo "19,Ensure nodev option set on removable media partitions,Non-Compliant" >> $varfilename
fi

# 20,Ensure nosuid option set on removable media partitions

source list-removable.sh
var20_int1=0
# echo "before loop"
# echo $var90_int1
if [ -s tempfiles/removables.txt ]; then
    while IFS= read -r line; do
        varint_1=$(findmnt -n $line | grep -v nosuid)
        if [ -z "$varint_1" ]
        then
            var20_int1=0
            # echo $line
        else
            var20_int1=$((var20_int1+1))
        fi   
    done < tempfiles/removables.txt
fi
if [ "$var20_int1" -eq 0 ]
then
    echo "20,Ensure nosuid option set on removable media partitions,Compliant" >> $varfilename
else
    echo "20,Ensure nosuid option set on removable media partitions,Non-Compliant" >> $varfilename
fi

# 21,Ensure noexec option set on removable media partitions

source list-removable.sh
var21_int1=0
# echo "before loop"
# echo $var90_int1
if [ -s tempfiles/removables.txt ]; then
    while IFS= read -r line; do
        varint_1=$(findmnt -n $line | grep -v nosuid)
        if [ -z "$varint_1" ]
        then
            var21_int1=0
            # echo $line
        else
            var21_int1=1
        fi   
    done < tempfiles/removables.txt
fi
if [ "$var21_int1" -eq 0 ]
then
    echo "21,Ensure noexec option set on removable media partitions,Compliant" >> $varfilename
else
    echo "21,Ensure noexec option set on removable media partitions,Non-Compliant" >> $varfilename
fi


# 22,Ensure sticky bit is set on all world-writable directories

worldwrite1=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null)

if [ -z "$worldwrite1" ]
then
      echo "22,Ensure sticky bit is set on all world-writable directories,Compliant" >> $varfilename
else
      echo "22,Ensure sticky bit is set on all world-writable directories,Non-Compliant" >> $varfilename
fi

# 23,Disable Automounting

automount1=$(systemctl is-enabled autofs | grep -c "enabled")

if [ "$automount1" -eq 0 ]
then
      echo "23,Disable Automounting,Compliant" >> $varfilename
else
      echo "23,Disable Automounting,Non-Compliant" >> $varfilename
fi

# 24,Disable USB Storage

modprobe -n -v usb-storage >/dev/null 2>&1 

usbstore1=$(lsmod | grep -c "usb-storage")

if [ "$usbstore1" -eq 0 ]
then
      echo "24,Disable USB Storage,Compliant" >> $varfilename
else
      echo "24,Disable USB Storage,Non-Compliant" >> $varfilename
fi

# Configure Software Updates

# 25,Ensure package manager repositories are configured
      # Manual - To Do - Manual Validation Required
      echo "25,Ensure package manager repositories are configured,Manual Validation,Manual Validation Required" >> $varfilename
# 26,Ensure GPG keys are configured
      echo "26,Ensure GPG keys are configured,Manual Validation,Manual Validation Required" >> $varfilename

# Secure Boot Settings

# 27,Ensure permissions on bootloader config are not overridden

var27=$(grep -E '^\s*chmod\s+[0-7][0-7][0-7]\s+\$\{grub_cfg\}\.new' -A 1 -B1 /usr/sbin/grub-mkconfig | grep -oP "(?<=chmod).*(?={grub_cfg})" | sed 's/ //g')
if [ "$var27" == "400$" ]
then
      echo "27,Ensure permissions on bootloader config are not overridden,Compliant" >> $varfilename
else
      echo "27,Ensure permissions on bootloader config are not overridden,Non-Compliant" >> $varfilename
fi

# 28,Ensure bootloader password is set
var28_usr=$(grep "^set superusers" /boot/grub/grub.cfg | grep -oP "(?<=set superusers=).*" | sed 's/ //g')
var28_pass_usr=$(grep "^set superusers" /boot/grub/grub.cfg)
var28_pass_usr1=$(echo $var28_pass_usr | awk '{print $2}')

if [ -z "$var28_pass_usr" ] && [ -z "$var28_pass_usr1" ]
then
    echo "28,Ensure bootloader password is set,Non-Compliant" >> $varfilename
else    
    echo "28,Ensure bootloader password is set,Compliant" >> $varfilename
fi

# 29,Ensure permissions on bootloader config are configured
uid29=$(stat /boot/grub/grub.cfg | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
gid29=$(stat /boot/grub/grub.cfg | grep -oP "(?<=Gid:).*"| sed 's/ //g')
# echo $uid29 
# echo $gid29
if [ "$uid29" == "$gid29" ]
then
      echo "29,Ensure permissions on bootloader config are configured,Compliant" >> $varfilename
else
      echo "29,Ensure permissions on bootloader config are configured,Non-Compliant" >> $varfilename
fi

# 30,Ensure authentication required for single user mode
auth30=$(sudo grep -Eq '^root:\$[0-9]' /etc/shadow || echo "root is locked")
if [ -z "$auth30" ]
then
      echo "30,Ensure authentication required for single user mode,Compliant" >> $varfilename
else
      echo "30,Ensure authentication required for single user mode,Non-Compliant" >> $varfilename
fi


# Additional Process Hardening

# 31,Ensure address space layout randomization (ASLR) is enabled

aslr31=$(sysctl kernel.randomize_va_space | sed 's/ //g')
aslr31_1=$(grep -Es "^\s*kernel\.randomize_va_space\s*=\s*([0-1]|[3-9]|[1-9][0-9]+)" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /run/sysctl.d/*.conf)

if [ -z "$aslr31_1" ] &&  [ "$aslr31" == "kernel.randomize_va_space=2" ]
then
      # echo $aslr31
      echo "31,Ensure address space layout randomization ASLR is enabled,Compliant" >> $varfilename
else
      # echo $aslr31
      echo "31,Ensure address space layout randomization ASLR is enabled,Non-Compliant" >> $varfilename
fi

# 32,Ensure prelink is not installed

# prelink32=$(dpkg -s prelink | grep -E '(Status:|not installed)')
dpkg -s prelink 2>tempfiles/32-temp.txt

if [ "$prelink32" == "Status: install ok installed" ]
then
      # echo $aslr31
      echo "32,Ensure prelink is not installed,Non-Compliant" >> $varfilename
else
      # echo $aslr31
      echo "32,Ensure prelink is not installed,Compliant" >> $varfilename
fi

# 33,Ensure core dumps are restricted
# systemctl is-enabled coredump.service not saved in variable??

coredmp33_1=$(grep -Es '^(\*|\s).*hard.*core.*(\s+#.*)?$' /etc/security/limits.conf /etc/security/limits.d/*)
coredmp33_2=$(sysctl fs.suid_dumpable)
coredmp33_3=$(grep "fs.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/*)
coredmp33_4=$(systemctl is-enabled coredump.service 2>/dev/null)

if [[ "$coredmp33_4" != *"enabled"* || "$coredmp33_4" != *"disabled"* || "$coredmp33_4" != *"masked"* ]] && [ "$coredmp33_1" == *"* hard core 0" ] && [ "$coredmp33_2" == "fs.suid_dumpable = 0" ] && [ "$coredmp33_3" == "fs.suid_dumpable = 0" ];
then
      # echo $aslr31
      echo "33,Ensure core dumps are restricted,Compliant" >> $varfilename
else
      # echo $aslr31
      echo "33,Ensure core dumps are restricted,Non-Compliant" >> $varfilename
fi


# Warning Banners

# 34,Ensure message of the day is configured properly

message34=$(grep -Eis "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/motd >/dev/null 2>&1)
if [ -z "$message34" ]
then
      echo "34,Ensure message of the day is configured properly,Compliant" >> $varfilename
else
      echo "34,Ensure message of the day is configured properly,Non-Compliant" >> $varfilename
fi

# 35,Ensure local login warning banner is configured properly
var35_1=$(grep 'PRETTY_NAME=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g')
var35_2=$(cat /etc/issue)
var35_lc=$(grep -c '.' /etc/issue)

if [ "$var35_lc" -le 1 ] && [ -z "${var35_2##*$var35_1*}" ]
then
      echo "35,Ensure local login warning banner is configured properly,Non-Compliant" >> $varfilename
else
      echo "35,Ensure local login warning banner is configured properly,Compliant" >> $varfilename
fi


# 36,Ensure remote login warning banner is configured properly
var36=$(cat /etc/issue.net)
var36_1=$(grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue.net)
var36_2=$(grep 'PRETTY_NAME=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g')

# echo $var36_2

if [ "$var36_2" == "$var36" ] && [ -z "$var36_1" ]
then
    echo "36,Ensure remote login warning banner is configured properly,Non-Compliant" >> $varfilename
else
    echo "36,Ensure remote login warning banner is configured properly,Compliant" >> $varfilename
fi 

# 37,Ensure permissions on /etc/motd are configured
var37=$(stat -L /etc/motd | grep -v "No such file or directory")
var37_uid=$(stat -L /etc/motd | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var37_gid=$(stat -L /etc/motd | grep -oP "(?<=Gid:).*"| sed 's/ //g')
var37_access=$(stat -L /etc/motd | grep -oP "(?<=Access:).*(?=Uid:)" | sed 's/ //g')
# echo $var98_uid
# echo $var98_gid
# echo $var98_access
if [ -z var37 ]
then
      echo "37,Ensure permissions on /etc/motd are configured,Compliant" >> $varfilename
elif [ "$var37_access" == "(0644/-rw-r--r--)" ] && [ "$var37_gid" == "(0/root)" ] && [ "$var37_uid" == "(0/root)" ]
then
      echo "37,Ensure permissions on /etc/motd are configured,Compliant" >> $varfilename
else
      echo "37,Ensure permissions on /etc/motd are configured,Non-Compliant" >> $varfilename
fi

# 38,Ensure permissions on /etc/issue are configured
var38_uid=$(stat -L /etc/issue | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var38_gid=$(stat -L /etc/issue | grep -oP "(?<=Gid:).*"| sed 's/ //g')
var38_access=$(stat -L /etc/motd | grep -oP "(?<=Access:).*(?=Uid:)" | sed 's/ //g')
# echo $var38_uid
# echo $var38_gid
# echo $var38_access
if [ "$var38_access" == "(0644/-rw-r--r--)" ] && [ "$var38_gid" == "(0/root)" ] && [ "$var38_uid" == "(0/root)" ]
then
      echo "38,Ensure permissions on /etc/issue are configured,Compliant" >> $varfilename
else
      echo "38,Ensure permissions on /etc/issue are configured,Non-Compliant" >> $varfilename
fi

# 39,Ensure permissions on /etc/issue.net are configured
var39_uid=$(stat -L /etc/issue.net | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var39_gid=$(stat -L /etc/issue.net | grep -oP "(?<=Gid:).*"| sed 's/ //g')
var39_access=$(stat -L /etc/issue.net | grep -oP "(?<=Access:).*(?=Uid:)" | sed 's/ //g')
# echo $var39_uid
# echo $var39_gid
# echo $var39_access
if [ "$var39_access" == "(0644/-rw-r--r--)" ] && [ "$var39_gid" == "(0/root)" ] && [ "$var39_uid" == "(0/root)" ]
then
      echo "39,Ensure permissions on /etc/issue.net are configured,Compliant" >> $varfilename
else
      echo "39,Ensure permissions on /etc/issue.net are configured,Non-Compliant" >> $varfilename
fi

# Initial Setup Updates

# 40,Ensure updates, patches, and additional security software are installed
      #Manual
touch tempfiles/40file.txt
rm tempfiles/40file.txt
var40_int1=0
apt -s upgrade > tempfiles/40file.txt >/dev/null 2>&1
while IFS= read -r line; do
    varint_1=$(echo $line | grep -oP "(?<=Inst).*")
    if [ -z "$varint_1" ]
    then
      var40_int1=0
    else
      var40_int1=$((var40_int1+1))
    fi  
done < tempfiles/40file.txt
# echo $var40_int1

if [ "$var40_int1" -eq 0 ]
then
      echo "40,Ensure updates patches and additional security software are installed,Compliant,Manual validation is recommended" >> $varfilename
else
      echo "40,Ensure updates patches and additional security software are installed,Non-Compliant,Manual validation is recommended" >> $varfilename
fi

# Services

# 41,Ensure time synchronization is in use
#----------------------------#
time41=$(systemctl is-enabled systemd-timesyncd)
time41_1=$(dpkg -s chrony | grep -c "install ok installed")
time41_2=$(dpkg -s ntp | grep -c "install ok installed")

if [ "$time41" == "enabled" ] || [ "$time41_1" -eq "1" ] || [ "$time41_2" -eq "1" ]
then
      echo "41,Ensure time synchronization is in use,Compliant" >> $varfilename
else
      echo "41,Ensure time synchronization is in use,Non-Compliant" >> $varfilename
fi

# 42,Ensure ntp is configured
#----------------------------#

ntp1=$(dpkg -s chrony | grep -E '(Status:|not installed)' | grep -c "install ok" )
ntp2=$(systemctl is-enabled systemd-timesyncd)
if [ "$ntp1" -ne "1" ] && [ "$ntp2" == "masked" ] #ToDo check multiple values from - grep "^restrict" /etc/ntp.conf - skip - part of domain - it is ntp synced
then
      echo "42,Ensure ntp is configured,Compliant" >> $varfilename
else
      echo "42,Ensure ntp is configured,Non-Compliant" >> $varfilename
fi

# 43,Ensure X Window System is not installed
#----------------------------#
var43_int1=0
dpkg -l xserver-xorg* > tempfiles/43file.txt
while IFS= read -r line; do
    varint_1=$(echo $line | grep -oP "(?<=xserver-xorg).*")
    # echo $varint_1
    if [ -z "$varint_1" ]
    then
      var43_int1=0
    else
      var43_int1=$((var43_int1+1))
    fi  
done < tempfiles/43file.txt
# echo $var43_int1

if [ "$var43_int1" -eq 0 ]
then
      echo "43,Ensure X Window System is not installed,Compliant" >> $varfilename
else
      echo "43,Ensure X Window System is not installed,Non-Compliant" >> $varfilename
fi

# Network

# 44,Ensure packet redirect sending is disabled
#----------------------------#

packtredir1=$(sysctl net.ipv4.conf.all.send_redirects)
packtredir2=$(sysctl net.ipv4.conf.default.send_redirects)
packtredir3=$(grep -E "^\s*net\.ipv4\.conf\.all\.send_redirects" /etc/sysctl.conf /etc/sysctl.d/*)
packtredir4=$(grep -E "^\s*net\.ipv4\.conf\.default\.send_redirects" /etc/sysctl.conf /etc/sysctl.d/*)
if [ "$packtredir1" == "1net.ipv4.conf.all.send_redirects = 0" ] && [ "$packtredir2" == "net.ipv4.conf.default.send_redirects = 0" ] && [ "$packtredir3" == "net.ipv4.conf.all.send_redirects = 0" ] && [ "$packtredir4" == "net.ipv4.conf.default.send_redirects= 0" ] 
then
      echo "44,Ensure packet redirect sending is disabled,Compliant" >> $varfilename
else
      echo "44,Ensure packet redirect sending is disabled,Non-Compliant" >> $varfilename
fi


# 45,Ensure IP forwarding is disabled
#----------------------------#

ipforward1=$(sysctl net.ipv4.conf.all.send_redirects)
ipforward2=$(grep -E -s "^\s*net\.ipv4\.ip_forward\s*=\s*1" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf)

if [ "$ipforward1" == "net.ipv4.ip_forward = 0" ] && [ -z "$ipforward2" ]
then
      echo "45,Ensure IP forwarding is disabled,Compliant" >> $varfilename
else
      echo "45,Ensure IP forwarding is disabled,Non-Compliant" >> $varfilename
fi

# Logging - rsyslog

# 46,Ensure rsyslog is installed
#----------------------------#

rsyslog1=$(dpkg -s rsyslog | grep -E '(Status:|install ok installed)')
rsyslog2=$(dpkg -s syslog-ng | grep -E '(Status:|install ok installed)')
if [ "$rsyslog1" == "Status: install ok installed" ] || [ "$rsyslog2" == "Status: install ok installed" ]
then
      echo "46,Ensure rsyslog is installed,Compliant" >> $varfilename
else
      echo "46,Ensure rsyslog is installed,Non-Compliant" >> $varfilename
fi

# 47,Ensure rsyslog Service is enabled
#----------------------------#

rsyslogen1=$(systemctl is-enabled rsyslog)

if [ "$rsyslogen1" == "enabled" ]
then
      echo "47,Ensure rsyslog Service is enabled,Compliant" >> $varfilename
else
      echo "47,Ensure rsyslog Service is enabled,Non-Compliant" >> $varfilename
fi

# 48,Ensure logging is configured
echo "48,Ensure logging is configured,Manual Validation Required" >> $varfilename

# 49,Ensure rsyslog default file permissions configured
rsyslogperm1=$(grep ^\s*\$FileCreateMode /etc/rsyslog.conf /etc/rsyslog.d/*.conf | grep -c "$FileCreateMode")
rsyslogperm2=$(grep ^\s*\$FileCreateMode /etc/rsyslog.conf /etc/rsyslog.d/*.conf | grep -c "0640")
rsyslogperm3=$(grep ^\s*\$FileCreateMode /etc/rsyslog.conf /etc/rsyslog.d/*.conf | grep -c "0644")

if [ "$rsyslogperm1" -eq "1" ] && ([ "$rsyslogperm2" -eq "1" ] || [ "$rsyslogperm3" -eq "1" ])
then
      echo "49,Ensure rsyslog default file permissions configured,Compliant" >> $varfilename
else
      echo "49,Ensure rsyslog default file permissions configured,Non-Compliant" >> $varfilename
fi

# 50,Ensure rsyslog is configured to send logs to a remote log host
var50=$(grep -oP "(^\*.\*[^I][^I]*@).*" /etc/rsyslog.conf)
# echo "$var50"

# "$string" | sed -e "s/^$prefix//"

var50_1=$(echo "$var50" | sed -e "s/^*.* @//")
var50_2=$(echo "$var50" | sed -e "s/^*.* @@//")
# b=$("$a" | grep -oP "^*.*.*")
# echo "$var50_1"
# echo "$var50_2"

if [[ $var50_1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] || [[ $var50_2 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "50,Ensure rsyslog is configured to send logs to a remote log host,Compliant" >> $varfilename
else
  echo "50,Ensure rsyslog is configured to send logs to a remote log host,Non-Compliant" >> $varfilename
fi

# 51,Ensure remote rsyslog messages are only accepted on designated log hosts

$var_51_log=0sudo 

varout1=$(grep '$ModLoad imtcp' /etc/rsyslog.conf /etc/rsyslog.d/*.conf)
varout2=$(grep '$InputTCPServerRun' /etc/rsyslog.conf /etc/rsyslog.d/*.conf)

if ([ -z "$varout1" ] && [ -z "$varout2"] && [ "$var_51_log" -eq 0 ]) || ([ "$varout1" == "$ModLoad imtcp" ] && [ "$varout2" == "$InputTCPServerRun 514" ] && [ "$var_51_log" -eq 0 ])
then
      echo "51,Ensure remote rsyslog messages are only accepted on designated log hosts,Compliant" >> $varfilename
elif ([ "$varout1" == "$ModLoad imtcp" ] && [ "$varout2" == "$InputTCPServerRun 514" ] && [ "$var_51_log" -eq 1 ])
then
      echo "51,Ensure remote rsyslog messages are only accepted on designated log hosts,Compliant" >> $varfilename
else
      echo "51,Ensure remote rsyslog messages are only accepted on designated log hosts,Non-Compliant" >> $varfilename
fi

# Logging - journald
      # all data is sent to SIEM server

# 52,Ensure journald is configured to send logs to rsyslog
#---------------------------------#
var52=$(grep -e ForwardToSyslog /etc/systemd/journald.conf)
if [ "$var52" == "ForwardToSyslog=yes" ]
then
      echo "52,Ensure journald is configured to send logs to rsyslog,Compliant" >> $varfilename
else
      echo "52,Ensure journald is configured to send logs to rsyslog,Non-Compliant" >> $varfilename
fi

# 53,Ensure journald is configured to compress large log files

var53=$(grep -e Compress /etc/systemd/journald.conf)
if [ "$var53" == "Compress=yes" ]
then
      echo "53,Ensure journald is configured to compress large log files,Compliant" >> $varfilename
else
      echo "53,Ensure journald is configured to compress large log files,Non-Compliant" >> $varfilename
fi

# 54,Ensure journald is configured to write logfiles to persistent disk

var54=$(grep -e Storage /etc/systemd/journald.conf)
if [ "$var54" == "Storage=persistent" ]
then
      echo "54,Ensure journald is configured to write logfiles to persistent disk,Compliant" >> $varfilename
else
      echo "54,Ensure journald is configured to write logfiles to persistent disk,Non-Compliant" >> $varfilename
fi

# 55,Ensure permissions on all logfiles are configured
echo "55,Ensure permissions on all logfiles are configured, Manual Validation Required" >> $varfilename

# 56,Ensure logrotate is configured
      #Manual - Review /etc/logrotate.conf and /etc/logrotate.d/rsyslog and verify logs are rotated according to site policy.
echo "56,Ensure logrotate is configured, Manual Validation Required" >> $varfilename

# 57,Ensure logrotate assigns appropriate permissions
var57=$(grep -Es "^\s*create\s+\S+" /etc/logrotate.conf /etc/logrotate.d/* | grep -E -v "\s(0)?[0-6][04]0\s")
if [ -z "$var57" ]
then
      echo "57,Ensure logrotate assigns appropriate permissions,Compliant" >> $varfilename
else
      echo "57,Ensure logrotate assigns appropriate permissions,Non-Compliant" >> $varfilename
fi

# Access - Time Based Job Schedule

# 58,Ensure cron daemon is enabled and running

var58=$(systemctl is-enabled cron)
if [ "$var58" == "enabled" ]
then
      echo "58,Ensure cron daemon is enabled and running,Compliant" >> $varfilename
else
      echo "58,Ensure cron daemon is enabled and running,Non-Compliant" >> $varfilename
fi

# 59,Ensure permissions on /etc/crontab are configured
var59=$(systemctl status cron | grep 'Active: active (running) ' | grep -c "Active: active (running)")
if [ "$var59" -eq "1" ]
then
      echo "59,Ensure permissions on /etc/crontab are configured,Compliant" >> $varfilename
else
      echo "59,Ensure permissions on /etc/crontab are configured,Non-Compliant" >> $varfilename
fi

# 60,Ensure permissions on /etc/cron.hourly are configured
      #Todo - check  Access does not grant permissions to group or other: -gary to get back by evening
var60_1=$(stat /etc/cron.hourly/ | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var60_2=$(stat /etc/cron.hourly/ | grep -oP "(?<=Gid:).*"| sed 's/ //g')
if [ "$var60_1" == "(0/root)" ] && [ "$var60_2" == "(0/root)" ]
then
      echo "60,Ensure permissions on /etc/cron.hourly are configured,Compliant" >> $varfilename
else
      echo "60,Ensure permissions on /etc/cron.hourly are configured,Non-Compliant" >> $varfilename
fi

# 61,Ensure permissions on /etc/cron.daily are configured
      #Todo - check  Access does not grant permissions to group or other:
var61_1=$(stat /etc/cron.daily/ | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var61_2=$(stat /etc/cron.daily/ | grep -oP "(?<=Gid:).*"| sed 's/ //g')
if [ "$var61_1" == "(0/root)" ] && [ "$var61_2" == "(0/root)" ]
then
      echo "61,Ensure permissions on /etc/cron.daily are configured,Compliant" >> $varfilename
else
      echo "61,Ensure permissions on /etc/cron.daily are configured,Non-Compliant" >> $varfilename
fi

# 62,Ensure permissions on /etc/cron.weekly are configured
      #Todo - check  Access does not grant permissions to group or other:
var62_1=$(stat /etc/cron.weekly/ | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var62_2=$(stat /etc/cron.weekly/ | grep -oP "(?<=Gid:).*"| sed 's/ //g')
if [ "$var62_1" == "(0/root)" ] && [ "$var62_2" == "(0/root)" ]
then
      echo "62,Ensure permissions on /etc/cron.weekly are configured,Compliant" >> $varfilename
else
      echo "62,Ensure permissions on /etc/cron.weekly are configured,Non-Compliant" >> $varfilename
fi

# 63,Ensure permissions on /etc/cron.monthly are configured
      #Todo - check  Access does not grant permissions to group or other:
var63_1=$(stat /etc/cron.monthly/ | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var63_2=$(stat /etc/cron.monthly/ | grep -oP "(?<=Gid:).*"| sed 's/ //g')
if [ "$var63_1" == "(0/root)" ] && [ "$var63_2" == "(0/root)" ]
then
      echo "63,Ensure permissions on /etc/cron.monthly are configured,Compliant" >> $varfilename
else
      echo "63,Ensure permissions on /etc/cron.monthly are configured,Non-Compliant" >> $varfilename
fi

# 64,Ensure permissions on /etc/cron.d are configured
      #Todo - check  Access does not grant permissions to group or other:
var64_1=$(stat /etc/cron.monthly/ | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var64_2=$(stat /etc/cron.monthly/ | grep -oP "(?<=Gid:).*"| sed 's/ //g')
if [ "$var64_1" == "(0/root)" ] && [ "$var64_2" == "(0/root)" ]
then
      echo "64,Ensure permissions on /etc/cron.d are configured,Compliant" >> $varfilename
else
      echo "64,Ensure permissions on /etc/cron.d are configured,Non-Compliant" >> $varfilename
fi

# Sudo

# 65,Ensure sudo is installed

var65_1=$(dpkg -s sudo | grep -E '(Status: install ok installed)' 2>/dev/null)
var65_2=$(dpkg -s sudo-ldap | grep -E '(Status: install ok installed)' 2>/dev/null)
if [ "$var65_1" == "Status: install ok installed" ] || [ "$var65_2" == "Status: install ok installed" ]
then
      # echo $aslr31
      echo "65,Ensure sudo is installed,Compliant" >> $varfilename
else
      # echo $aslr31
      echo "65,Ensure sudo is installed,Non-Compliant" >> $varfilename
fi

# 66,Ensure sudo commands use pty

var66=$(sudo grep -Ei '^\s*Defaults\s+([^#]+,\s*)?use_pty(,\s+\S+\s*)*(\s+#.*)?$' /etc/sudoers /etc/sudoers.d/*)
var66_1="/etc/sudoers:Defaults use_pty"
if [ "$var66"=="$var66_1" ]
then
      echo "66,Ensure sudo commands use pty,Compliant" >> $varfilename
else
      echo "66,Ensure sudo commands use pty,Non-Compliant" >> $varfilename
fi

# 67,Ensure sudo log file exists

var67=$(grep -Ei '^\s*Defaults\s+logfile=\S+' /etc/sudoers /etc/sudoers.d/*)

if [ -z "$var67" ]
then
      echo "67,Ensure sudo log file exists,Non-Compliant" >> $varfilename
else
      echo "67,Ensure sudo log file exists,Compliant" >> $varfilename
fi

# SSH Server

# 68,Ensure permissions on /etc/ssh/sshd_config are configured

      #Todo - check  Access does not grant permissions to group or other:
var68_1=$(stat /etc/ssh/sshd_config | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var68_2=$(stat /etc/ssh/sshd_config | grep -oP "(?<=Gid:).*"| sed 's/ //g')
var68_3=$(stat /etc/ssh/sshd_config | grep -oP "(?<=Access:).*(?=Uid:)" | sed 's/ //g')
if [ "$var68_3" == "(0600/-rw-------)" ] && [ "$var68_1" == "(0/root)" ] && [ "$var68_2" == "(0/root)" ]
then
      echo "68,Ensure permissions on /etc/ssh/sshd_config are configured,Compliant" >> $varfilename
else
      echo "68,Ensure permissions on /etc/ssh/sshd_config are configured,Non-Compliant" >> $varfilename
fi

# 69,Ensure SSH access is limited
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}' >/dev/null 2>&1)" | grep -Ei '^\s*(allow|deny)(users|groups)\s+\S+' > tempfiles/69file.txt 
var69_1=$(grep -c "allowusers" "tempfiles/69file.txt")
var69_2=$(grep -c "allowgroups" "tempfiles/69file.txt")
var69_3=$(grep -c "denyusers" "tempfiles/69file.txt")
var69_4=$(grep -c "denygroups" "tempfiles/69file.txt")

if [ "$var69_1" -eq 1 ] || [ "$var69_1" -eq 2 ] || [ "$var69_3" -eq 1 ] || [ "$var69_4" -eq 1 ]
then
      echo "69,Ensure SSH access is limited,Compliant" >> $varfilename
else
      echo "69,Ensure SSH access is limited,Non-Compliant" >> $varfilename
fi


# 70,Ensure SSH LogLevel is appropriate
var70_result="Compliant"
var70=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep loglevel >/dev/null 2>&1) 
# var70_1=$(grep -is 'loglevel' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf | grep -Evi '(VERBOSE|INFO)'>/dev/null 2>&1)
var70_1=$(cat /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf | grep -Ei "^LogLevel")
#echo $var70_1
if ([ "$var70" == "LogLevel VERBOSE" ] || [ "$var70" == "LogLevel INFO" ]);
then
    var70_result="Compliant"
else
    var70_result="Non-Compliant"
fi

if ([ "$var70_1" == "LogLevel VERBOSE" ] || [ "$var70_1" == "LogLevel INFO" ]);
then
    var70_result="Compliant"
else
    var70_result="Non-Compliant"
fi

echo "70,Ensure SSH LogLevel is appropriate,$var70_result" >> $varfilename

# 71,Ensure SSH MaxAuthTries is set to 4 or less

# var50=$(grep -oP "(^\*.\*[^I][^I]*@).*" /etc/rsyslog.conf)

var71a=$(cat /etc/ssh/sshd_config | grep -i "^maxauthtries")
var71a_1=$(echo "$var71a" | sed -e "s/^MaxAuthTries //") 

var71b=$(cat /etc/ssh/sshd_config.d/*.conf | grep -i "^maxauthtries")
var71b_1=$(echo "$var71b" | sed -e "s/^MaxAuthTries //") 

# var71=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}' >/dev/null 2>&1)" | grep maxauthtries | grep -Po 'maxauthtries"\K.*?(?=")' | sed 's/ //g' >>/dev/null 2>&1)

var71_1=$(grep -Eis '^\s*maxauthtries\s+([5-9]|[1-9][0-9]+)' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf)

if [ -z "$var71a" ];
then
      echo "71,Ensure SSH MaxAuthTries is set to 4 or less,Non-Compliant" >> $varfilename
elif [[ "$var71a_1" -le "4" || "$var71b_1" -le "4" ]] && [ -z "$var71_1" ];
then
      echo "71,Ensure SSH MaxAuthTries is set to 4 or less,Compliant" >> $varfilename
else
      echo "71,Ensure SSH MaxAuthTries is set to 4 or less,Non-Compliant" >> $varfilename
fi

# 72,Ensure SSH IgnoreRhosts is enabled

var72a=$(cat /etc/ssh/sshd_config | grep -i "^IgnoreRhosts")
var72a_1=$(echo "$var72a" | sed -e "s/^IgnoreRhosts //")

var72b=$(cat /etc/ssh/sshd_config.d/*.conf | grep -i "^IgnoreRhosts" 2>/dev/null)
var72b_1=$(echo "$var72b" | sed -e "s/^IgnoreRhosts //")

var72c=$(cat /etc/hosts | grep -i "^IgnoreRhosts")
var72c_1=$(echo "$var72c" | sed -e "s/^IgnoreRhosts //")

if [[ ! -z "$var72a_1" || ! -z "$var72b_1" || ! -z "$var72c_1" ]];
then
      if [[ var72a_1=="yes" || var72b_1=="yes" || var72c_1=="yes" ]];
      then
            echo "72,Ensure SSH IgnoreRhosts is enabled,Compliant" >> $varfilename
      else
            echo "72,Ensure SSH IgnoreRhosts is enabled,Non-Compliant" >> $varfilename            
      fi
else
      echo "72,Ensure SSH IgnoreRhosts is enabled,Non-Compliant" >> $varfilename
fi

# 73,Ensure SSH HostbasedAuthentication is disabled

var73a=$(cat /etc/ssh/sshd_config | grep -i "^HostbasedAuthentication")
var73a_1=$(echo "$var73a" | sed -e "s/^HostbasedAuthentication //")
# echo $var73a_1

var73b=$(cat /etc/ssh/sshd_config.d/*.conf | grep -i "^HostbasedAuthentication" 2>/dev/null)
var73b_1=$(echo "$var73b" | sed -e "s/^HostbasedAuthentication //")

var73c=$(cat /etc/hosts | grep -i "^HostbasedAuthentication")
var73c_1=$(echo "$var73c" | sed -e "s/^HostbasedAuthentication //")

if [[ ! -z "$var73a_1" || ! -z "$var73b_1" || ! -z "$var73c_1" ]];
then
      if [[ var73a_1=="no" || var73b_1=="no" || var73c_1=="no" ]];
      then
            echo "73,Ensure SSH HostbasedAuthentication is disabled,Compliant" >> $varfilename
      else
            echo "73,Ensure SSH HostbasedAuthentication is disabled,Non-Compliant" >> $varfilename           
      fi
else
      echo "73,Ensure SSH HostbasedAuthentication is disabled,Non-Compliant" >> $varfilename
fi

# 74,Ensure SSH root login is disabled

var74=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permitrootlogin | grep -Po 'permitrootlogin"\K.*?(?=")' | sed 's/ //g')
var74_1=$(grep -Eis '^\s*PermitRootLogin\s+yes' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf)

if [ -z "$var74" ]
then
      echo "74,Ensure SSH root login is disabled,Non-Compliant" >> $varfilename
elif [ "$var74" == "no" ] && [ -z "$var74_1" ]
then
      echo "74,Ensure SSH root login is disabled,Compliant" >> $varfilename
else
      echo "74,Ensure SSH root login is disabled,Non-Compliant" >> $varfilename
fi

# 75,Ensure SSH PermitEmptyPasswords is disabled

var75_result="Compliant"
var75=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permitemptypasswords | grep -Po 'permitemptypasswords"\K.*?(?=")' | sed 's/ //g')
var75_1=$(cat /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf | grep -Ei "^PermitEmptyPasswords")
# echo $var75_1

if [ "$var75" == "PermitEmptyPasswords no" ];
then
    var75_result="Compliant"
else
    var75_result="Non-Compliant"
fi

if [ "$var75_1" == "PermitEmptyPasswords no" ];
then
    var75_result="Compliant"
else
    var75_result="Non-Compliant"
fi

echo "75,Ensure SSH PermitEmptyPasswords is disabled,$var75_result" >> $varfilename

# 76,Ensure SSH PermitUserEnvironment is disabled

var76_result="Compliant"
var76=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep PermitUserEnvironment | grep -Po 'PermitUserEnvironment"\K.*?(?=")' | sed 's/ //g')
var76_1=$(cat /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf | grep -Ei "^PermitUserEnvironment")
# echo $var76_1

if [ "$var76" == "PermitUserEnvironment no" ];
then
    var76_result="Compliant"
else
    var76_result="Non-Compliant"
fi

if [ "$var76_1" == "PermitUserEnvironment no" ];
then
    var76_result="Compliant"
else
    var76_result="Non-Compliant"
fi

echo "76,Ensure SSH PermitUserEnvironment is disabled,$var76_result" >> $varfilename

# 77,Ensure SSH Idle Timeout Interval is configured

var77=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep ClientAliveInterval | grep -Po 'ClientAliveInterval"\K.*?(?=")' | sed 's/ //g')
var77_1=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep ClientAliveCountMax | grep -Po 'ClientAliveCountMax"\K.*?(?=")' | sed 's/ //g')
var77_2=$(cat /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf | grep -Ei "^ClientAliveInterval")
var77_3=$(cat /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf | grep -Ei "^ClientAliveCountMax")

if [ "$var77" == "ClientAliveInterval 300" ];
then
    var77_result="Compliant"
else
    var77_result="Non-Compliant"
fi

if [ "$var77_1" == "ClientAliveCountMax 3" ];
then
    var77_result="Compliant"
else
    var77_result="Non-Compliant"
fi

if [ "$var77_2" == "ClientAliveInterval 300" ];
then
    var77_result="Compliant"
else
    var77_result="Non-Compliant"
fi

if [ "$var77_3" == "ClientAliveCountMax 3" ];
then
    var77_result="Compliant"
else
    var77_result="Non-Compliant"
fi

echo "77,Ensure SSH Idle Timeout Interval is configured,$var77_result" >> $varfilename

# 78,Ensure SSH LoginGraceTime is set to one minute or less

var78=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep LoginGraceTime | grep -Po 'LoginGraceTime"\K.*?(?=")' | sed 's/ //g')

var78_1=$(cat /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf | grep -Ei "^LoginGraceTime")

if [ "$var78" == "LoginGraceTime 60" ];
then
    var78_result="Compliant"
else
    var78_result="Non-Compliant"
fi

if [ "$var78_1" == "LoginGraceTime 60" ];
then
    var78_result="Compliant"
else
    var78_result="Non-Compliant"
fi

echo "78,Ensure SSH LoginGraceTime is set to one minute or less,$var78_result" >> $varfilename   

# 79,Ensure SSH warning banner is configured

var79=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep banner)
# var79_1=$(grep -Eis '^\s*Banner\s+"?none\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf)
var79_1=$(cat /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf | grep -Ei "^Banner")

if [ -z "$var79" ]
then
      echo "79,Ensure SSH warning banner is configured,Non-Compliant" >> $varfilename
elif [ "$var79" == "banner /etc/issue.net" ] && [ -z "$var79_1" ]
then
      echo "79,Ensure SSH warning banner is configured,Compliant" >> $varfilename
else
      echo "79,Ensure SSH warning banner is configured,Non-Compliant" >> $varfilename
fi 

# 80,Ensure SSH PAM is enabled

var80=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i usepam)
var80_1=$(grep -Eis '^\s*UsePAM\s+no' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf)

if [ -z "$var80" ]
then
      echo "80,Ensure SSH PAM is enabled,Non-Compliant" >> $varfilename
elif [ "$var80" == "usepam yes" ] && [ -z "$var80_1" ]
then
      echo "80,Ensure SSH PAM is enabled,Compliant" >> $varfilename
else
      echo "80,Ensure SSH PAM is enabled,Non-Compliant" >> $varfilename
fi 

# 81,Ensure SSH MaxStartups is configured
      #To Do - Checking MaxStartups is 10:30:60 or more restrictive
var81=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i maxstartups)
var81_1=$(grep -Eis '^\s*maxstartups\s+(((1[1-9]|[1-9][0-9][0-9]+):([0-9]+):([0-9]+))|(([0-9]+):(3[1-9]|[4-9][0-9]|[1-9][0-9][0-9]+):([0-9]+))|(([0-9]+):([0-9]+):(6[1-9]|[7-9][0-9]|[1-9][0-9][0-9]+)))' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf)

if [ -z "$var81" ]
then
      echo "81,Ensure SSH MaxStartups is configured,Non-Compliant" >> $varfilename
elif [ "$var81" == "maxstartups 10:30:60" ] && [ -z "$var81_1" ]
then
      echo "81,Ensure SSH MaxStartups is configured,Compliant" >> $varfilename
else
      echo "81,Ensure SSH MaxStartups is configured,Non-Compliant" >> $varfilename
fi 

# 82,Ensure SSH MaxSessions is limited

var82_result="Compliant"
var82=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i maxsessions | grep -Po 'maxsessions"\K.*?(?=")' | sed 's/ //g')
var82_1=$(cat /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf | grep -Ei "^MaxSessions")

if [ "$var82" == "MaxSessions 10" ];
then
    var82_result="Compliant"
else
    var82_result="Non-Compliant"
fi

if [ "$var82_1" == "MaxSessions 10" ];
then
    var82_result="Compliant"
else
    var82_result="Non-Compliant"
fi

echo "82,Ensure SSH MaxSessions is limited,$var82_result" >> $varfilename

# PAM

# 83,Ensure password creation requirements are configured

# var83=$(grep '^\s*minlen\s*' /etc/security/pwquality.conf | grep -Po 'minlen ="\K.*?(?=")' | sed 's/ //g')
var83=$(cat /etc/security/pwquality.conf | grep -i "^minlen" | sed -e "s/^minlen = //")
# echo "$var83"
# var83_1=$(grep '^\s*minclass\s*' /etc/security/pwquality.conf | grep -Po 'minclass ="\K.*?(?=")' | sed 's/ //g')
var83_1=$(cat /etc/security/pwquality.conf | grep -i "^minclass" | sed -e "s/^minclass = //")
# echo "$var83_1"
# var83_2=$(grep -E '^\s*[duol]credit\s*' /etc/security/pwquality.conf | grep -Po 'dcredit ="\K.*?(?=")' | sed 's/ //g')
var83_2=$(cat /etc/security/pwquality.conf | grep -i "^dcredit" | sed -e "s/^dcredit = //")
# echo "$var83_2"
# var83_3=$(grep -E '^\s*[duol]credit\s*' /etc/security/pwquality.conf | grep -Po 'ucredit ="\K.*?(?=")' | sed 's/ //g')
var83_3=$(cat /etc/security/pwquality.conf | grep -i "^ucredit" | sed -e "s/^ucredit = //")
# echo "$var83_3"
# var83_4=$(grep -E '^\s*[duol]credit\s*' /etc/security/pwquality.conf | grep -Po 'lcredit ="\K.*?(?=")' | sed 's/ //g')
var83_4=$(cat /etc/security/pwquality.conf | grep -i "^lcredit" | sed -e "s/^lcredit = //")
# echo "$var83_4"
# var83_5=$(grep -E '^\s*[duol]credit\s*' /etc/security/pwquality.conf | grep -Po 'ocredit ="\K.*?(?=")' | sed 's/ //g')
var83_5=$(cat /etc/security/pwquality.conf | grep -i "^ocredit" | sed -e "s/^ocredit = //")
# echo "$var83_5"
# var83_6=$(grep -E '^\s*password\s+(requisite|required)\s+pam_pwquality\.so\s+(\S+\s+)*retry=[1-3]\s*(\s+\S+\s*)*(\s+#.*)?$' /etc/pam.d/common-password | grep -Po 'pam_pwquality.so retry="\K.*?(?=")' | sed 's/ //g')
var83_6=$(cat  /etc/pam.d/common-password | grep -i "^retry" | sed -e "s/^retry = //")
# echo "$var83_6"

if [[ "$var83" -eq "10" && $var83_1 -eq "4" ]];
then
      if [[ "$var83_6" -eq "3" ]]; then
            # echo "inside 1 $var83_6"
            echo "83,Ensure password creation requirements are configured,Compliant" >> $varfilename
      else
            # echo "inside 2 $var83 $var83_1"
            echo "83,Ensure password creation requirements are configured,Non-Compliant" >> $varfilename
      fi
elif [[ "$var83_2" -eq "-1" && "$var83_3" -eq "-1" && "$var83_4" -eq "-1" && "$var83_5" -eq "-1" ]]; then
      if [[ "$var83_6" -eq "3" ]]; then
            # echo "inside 3"
            echo "83,Ensure password creation requirements are configured,Compliant" >> $varfilename
      else
            # echo "inside 4"
            echo "83,Ensure password creation requirements are configured,Non-Compliant" >> $varfilename
      fi
else
      # echo "inside 5"
      echo "83,Ensure password creation requirements are configured,Non-Compliant" >> $varfilename
fi 

# 84,Ensure lockout for failed password attempts is configured

onerr84=$(grep "pam_tally2" /etc/pam.d/common-auth | grep -oP "(?<=onerr=).*(?=audit silent)" | sed 's/ //g')
deny84=$(grep "pam_tally2" /etc/pam.d/common-auth | grep -oP "(?<=deny=).*(?=unlock_time)" | sed 's/ //g')
unlock84=$(grep "pam_tally2" /etc/pam.d/common-auth | grep -Po 'unlock_time="\K.*?(?=")' | sed 's/ //g')
pam84=$(grep -E '^\s*[duol]credit\s*' /etc/security/pwquality.conf)
if [ "$onerr84" == "fail" ] && [ "$deny84" -eq 5 ] && [ "$unlock84" -eq  900 ] && [ "$pam84" == *"pam_deny.so"* ] && [ "$pam84" == "pam_tally2.so" ]
then
      echo "84,Ensure lockout for failed password attempts is configured,Compliant" >> $varfilename
else
      echo "84,Ensure lockout for failed password attempts is configured,Non-Compliant" >> $varfilename
fi 

# 85,Ensure password reuse is limited

var85_result="Compliant"
# rem85=$(grep -E '^\s*password\s+required\s+pam_pwhistory\.so\s+([^#]+\s+)?remember=([5-9]|[1-9][0-9]+)\b' /etc/pam.d/common-password | grep -Po 'remember="\K.*?(?=")' | sed 's/ //g')
var85=$(cat /etc/pam.d/common-password | grep -Ei "^password        required                        pam_pwhistory.so remember=5")

if [ "$var85" == "password        required                        pam_pwhistory.so remember=5" ];
then
    var85_result="Compliant"
else
    var85_result="Non-Compliant"
fi

echo "85,Ensure password reuse is limited,$var85_result" >> $varfilename

# 86,Ensure password hashing algorithm is SHA-512

var86=$(cat /etc/pam.d/common-password | grep -E '^\s*password\s+(\[success=1\s+default=ignore\]|required)\s+pam_unix\.so\s+([^#]+\s+)?sha512\b')

var86_1=$(printf "%s\n" "${var86#*obscure }")
# echo $var86_1
test="sha512"

if [ "$var86_1" == "$test" ]
then
      echo "86,Ensure password hashing algorithm is SHA-512,Compliant" >> $varfilename
else
      echo "86,Ensure password hashing algorithm is SHA-512,Non-Compliant" >> $varfilename
fi 

# Shadow Password Suite 

# 87,Ensure minimum days between password changes is configured
# touch tempfiles/87_testfile1.txt
var87_min=$(grep PASS_MIN_DAYS /etc/login.defs | grep -v "#" | grep -oP "(?<=PASS_MIN_DAYS).*"| sed 's/ //g')
# echo $var87_min
sudo awk -F : '(/^[^:]+:[^!*]/ && $4 < 1){print $1 " " $4}' /etc/shadow > tempfiles/87min-users.txt
var87_int1=0
# echo "before loop"
# echo $var87_int1
while IFS= read -r line; do
    varint_1=$(echo $line | grep -oP "([0-9]+)")
    # echo "${varint_1}"
    if [ "$varint_1" -le 0 ]
    then
        var87_int1=$((var87_int1+1))
      #   echo $line
    fi   
done < tempfiles/87min-users.txt
# echo "inside"
# echo $var87_int1

if [ "$var87_min" -ge 1 ] || [ "$var87_int1" -eq 0 ]
then
      echo "87,Ensure minimum days between password changes is configured,Compliant" >> $varfilename
else
      echo "87,Ensure minimum days between password changes is configured,Non-Compliant" >> $varfilename
fi

# 88,Ensure password expiration is 60 days or less
#---------------------------------------------#

var88_max=$(grep PASS_MAX_DAYS /etc/login.defs | grep -v "#" | grep -oP "(?<=PASS_MAX_DAYS).*"| sed 's/ //g')
# echo $var88_max
sudo awk -F: '(/^[^:]+:[^!*]/ && ($5>365 || $5~/([0-1]|-1|\s*)/)){print $1 " " $5}' /etc/shadow > tempfiles/88max-users.txt
var88_int1=0
# echo "before loop"
# echo $var87_int1
while IFS= read -r line; do
    varint_1=$(echo $line | grep -oP "([0-9]+)")
    # echo "inside while"
    # echo "${varint_1}"
    if [ "$varint_1" -gt 60 ] && [ "$varint_1" -lt "$var87_min" ]
    then
        var88_int1=$((var88_int1+1))
        # echo $line
    fi   
done < tempfiles/88max-users.txt
# echo "inside"
# echo $var87_int1

if [ "$var88_max" -le 60 ] && [ "$var88_int1" -eq 0 ] && [ "$var88_max" -ge "$var87_min" ]
then
      echo "88,Ensure password expiration is 60 days or less,Compliant" >> $varfilename
else
      echo "88,Ensure password expiration is 60 days or less,Non-Compliant" >> $varfilename
fi

# 89,Ensure password expiration warning days is 7 or more
#---------------------------------------------#

var89=$(cat /etc/login.defs | grep -Ei "^PASS_WARN_AGE")

if [ "$var89" == "PASS_WARN_AGE	7" ]
then
    echo "89,Ensure password expiration warning days is 7 or more,Compliant" >> $varfilename
else
    cho "89,Ensure password expiration warning days is 7 or more,Non-Compliant" >> $varfilename
fi 

# 90,Ensure inactive password lock is 30 days or less
var90_inact=$(useradd -D | grep INACTIVE | grep -v "#" | grep -oP "(?<=INACTIVE=).*"| sed 's/ //g')

if [ "$var90_inact" -le 30 ]
then
      echo "90,Ensure inactive password lock is 30 days or less,Compliant" >> $varfilename
else
      echo "90,Ensure inactive password lock is 30 days or less,Non-Compliant" >> $varfilename
fi

# 91,Ensure default group for the root account is GID 0
#---------------------------------#
var91=$(grep "^root:" /etc/passwd | cut -f4 -d:)
if [ "$var91" -eq 0 ] 
then
      echo "91,Ensure default group for the root account is GID 0,Compliant" >> $varfilename
else
      echo "91,Ensure default group for the root account is GID 0,Non-Compliant" >> $varfilename
fi


# 92,Ensure default user shell timeout is 900 seconds or less
source 92_timeout.sh

# 93,Ensure root login is restricted to system console
var93_1=/etc/securetty
if test -f "$var93_1"; then
      echo "var93_1 exists."
      if [ -s /etc/securetty ]; then
            echo "93,Ensure root login is restricted to system console,Non-Compliant,Manually validate which virtual terminals (tty*) root is allowed to login from." >> $varfilename
      elif [ grep -q "pts/[0-9]*" "/etc/securetty"]; then
            echo "93,Ensure root login is restricted to system console,Non-Compliant,Manually validate which virtual terminals (tty*) root is allowed to login from." >> $varfilename
      else
            echo "93,Ensure root login is restricted to system console,Compliant,Manually validate which virtual terminals (tty*) root is allowed to login from." >> $varfilename
      fi  
else
      echo "93,Ensure root login is restricted to system console,Non-Compliant,Manually validate which virtual terminals (tty*) root is allowed to login from." >> $varfilename
fi

# 94,Ensure access to the su command is restricted
var94=$(awk -F: '($3 == 0) { print $1 }' /etc/passwd)
if [ "$var94" == "root" ]
then
      echo "94,Ensure access to the su command is restricted,Compliant" >> $varfilename
else
      echo "94,Ensure access to the su command is restricted,Non-Compliant" >> $varfilename
fi

# File Permissions

# 95,Ensure permissions on /etc/passwd are configured
var95=$(stat /etc/passwd)
var95_uid=$(stat /etc/passwd | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var95_gid=$(stat /etc/passwd | grep -oP "(?<=Gid:).*"| sed 's/ //g')
var95_access=$(stat /etc/passwd | grep -oP "(?<=Access:).*(?=Uid:)" | sed 's/ //g')
# echo $var95_uid
# echo $var95_gid
# echo $var95_access
if [ "$var95_access" == "(0644/-rw-r--r--)" ] && [ "$var95_gid" == "(0/root)" ] && [ "$var95_uid" == "(0/root)" ]
then
      echo "95,Ensure permissions on /etc/passwd are configured,Compliant" >> $varfilename
else
      echo "95,Ensure permissions on /etc/passwd are configured,Non-Compliant" >> $varfilename
fi


# 96,Ensure permissions on /etc/passwd- are configured
var96=$(stat /etc/passwd-)
var96_uid=$(stat /etc/passwd- | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var96_gid=$(stat /etc/passwd- | grep -oP "(?<=Gid:).*"| sed 's/ //g')
var96_access=$(stat /etc/passwd- | grep -oP "(?<=Access:).*(?=Uid:)" | sed 's/ //g')
# echo $var96_uid
# echo $var96_gid
# echo $var96_access
if [ "$var96_access" == "(0644/-rw-r--r--)" ] && [ "$var96_gid" == "(0/root)" ] && [ "$var96_uid" == "(0/root)" ]
then
      echo "96,Ensure permissions on /etc/passwd- are configured,Compliant" >> $varfilename
else
      echo "96,Ensure permissions on /etc/passwd- are configured,Non-Compliant" >> $varfilename
fi

# 97,Ensure permissions on /etc/group are configured
var97=$(stat /etc/group)
var97_uid=$(stat /etc/group | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var97_gid=$(stat /etc/group | grep -oP "(?<=Gid:).*"| sed 's/ //g')
var97_access=$(stat /etc/group | grep -oP "(?<=Access:).*(?=Uid:)" | sed 's/ //g')
# echo $var97_uid
# echo $var97_gid
# echo $var97_access
if [ "$var97_access" == "(0644/-rw-r--r--)" ] && [ "$var97_gid" == "(0/root)" ] && [ "$var97_uid" == "(0/root)" ]
then
      echo "97,Ensure permissions on /etc/group are configured,Compliant" >> $varfilename
else
      echo "97,Ensure permissions on /etc/group are configured,Non-Compliant" >> $varfilename
fi


# 98,Ensure permissions on /etc/group- are configured
var98=$(stat /etc/group-)
var98_uid=$(stat /etc/group- | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var98_gid=$(stat /etc/group- | grep -oP "(?<=Gid:).*"| sed 's/ //g')
var98_access=$(stat /etc/group- | grep -oP "(?<=Access:).*(?=Uid:)" | sed 's/ //g')
# echo $var98_uid
# echo $var98_gid
# echo $var98_access
if [ "$var98_access" == "(0644/-rw-r--r--)" ] && [ "$var98_gid" == "(0/root)" ] && [ "$var98_uid" == "(0/root)" ]
then
      echo "98,Ensure permissions on /etc/group- are configured,Compliant" >> $varfilename
else
      echo "98,Ensure permissions on /etc/group- are configured,Non-Compliant" >> $varfilename
fi

# 99,Ensure permissions on /etc/shadow are configured
var99=$(stat /etc/shadow)
var99_uid=$(stat /etc/shadow | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var99_gid=$(stat /etc/shadow | grep -oP "(?<=Gid:).*"| sed 's/ //g')
var99_access=$(stat /etc/shadow | grep -oP "(?<=Access:).*(?=Uid:)" | sed 's/ //g')
# echo $var99_uid
# echo $var99_gid
# echo $var99_access
if [ "$var99_access" == "(0640/-rw-r-----)" ] && ([ "$var99_gid" == "(0/root)" ] || [ "$var99_gid" == "(42/shadow)" ]) && [ "$var99_uid" == "(0/root)" ]
then
      echo "99,Ensure permissions on /etc/shadow are configured,Compliant" >> $varfilename
else
      echo "99,Ensure permissions on /etc/shadow are configured,Non-Compliant" >> $varfilename
fi


# 100,Ensure permissions on /etc/shadow- are configured

var100=$(stat /etc/shadow-)
var100_uid=$(stat /etc/shadow- | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var100_gid=$(stat /etc/shadow- | grep -oP "(?<=Gid:).*"| sed 's/ //g')
var100_access=$(stat /etc/shadow- | grep -oP "(?<=Access:).*(?=Uid:)" | sed 's/ //g')
# echo $var100_uid
# echo $var100_gid
# echo $var100_access
if [ "$var100_access" == "(0640/-rw-r-----)" ] && ([ "$var100_gid" == "(0/root)" ] || [ "$var100_gid" == "(42/shadow)" ]) && [ "$var100_uid" == "(0/root)" ]
then
      echo "100,Ensure permissions on /etc/shadow- are configured,Compliant" >> $varfilename
else
      echo "100,Ensure permissions on /etc/shadow- are configured,Non-Compliant" >> $varfilename
fi

# 101,Ensure permissions on /etc/gshadow are configured

var101=$(stat /etc/gshadow)
var101_uid=$(stat /etc/gshadow | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var101_gid=$(stat /etc/gshadow | grep -oP "(?<=Gid:).*"| sed 's/ //g')
var101_access=$(stat /etc/gshadow | grep -oP "(?<=Access:).*(?=Uid:)" | sed 's/ //g')
# echo $var101_uid
# echo $var101_gid
# echo $var101_access
if [ "$var101_access" == "(0640/-rw-r-----)" ] && ([ "$var101_gid" == "(0/root)" ] || [ "$var101_gid" == "(42/shadow)" ]) && [ "$var101_uid" == "(0/root)" ]
then
      echo "101,Ensure permissions on /etc/gshadow are configured,Compliant" >> $varfilename
else
      echo "101,Ensure permissions on /etc/gshadow are configured,Non-Compliant" >> $varfilename
fi

# 102,Ensure permissions on /etc/gshadow- are configured
var102=$(stat /etc/gshadow-)
var102_uid=$(stat /etc/gshadow- | grep -oP "(?<=Uid:).*(?=Gid:)" | sed 's/ //g')
var102_gid=$(stat /etc/gshadow- | grep -oP "(?<=Gid:).*"| sed 's/ //g')
var102_access=$(stat /etc/gshadow- | grep -oP "(?<=Access:).*(?=Uid:)" | sed 's/ //g')
# echo $var102_uid
# echo $var102_gid
# echo $var102_access
if [ "$var102_access" == "(0640/-rw-r-----)" ] && ([ "$var102_gid" == "(0/root)" ] || [ "$var102_gid" == "(42/shadow)" ]) && [ "$var102_uid" == "(0/root)" ]
then
      echo "102,Ensure permissions on /etc/gshadow- are configured,Compliant" >> $varfilename
else
      echo "102,Ensure permissions on /etc/gshadow- are configured,Non-Compliant" >> $varfilename
fi


# 103,Ensure no world writable files exist
var103=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002)
if [ -z "$var103" ]
then
      echo "103,Ensure no world writable files exist,Compliant" >> $varfilename
else
      echo "103,Ensure no world writable files exist,Non-Compliant" >> $varfilename
fi

# 104,Ensure no unowned files or directories exist
var104=$(df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser)
if [ -z "$var104" ]
then
      echo "104,Ensure no unowned files or directories exist,Compliant" >> $varfilename
else
      echo "104,Ensure no unowned files or directories exist,Non-Compliant" >> $varfilename
fi

# 105,Ensure no ungrouped files or directories exist
var105=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup)      
if [ -z "$var105" ]
then
      echo "105,Ensure no ungrouped files or directories exist,Compliant" >> $varfilename
else
      echo "105,Ensure no ungrouped files or directories exist,Non-Compliant" >> $varfilename
fi

# User and Group Settings

# 106,Ensure accounts in /etc/passwd use shadowed passwords
#---------------------------------#
var106=$(awk -F: '($2 != "x" ) { print $1 " is not set to shadowed passwords "}' /etc/passwd)
if [ -z "$var106" ]
then
      echo "106,Ensure accounts in /etc/passwd use shadowed passwords,Compliant" >> $varfilename
else
      echo "106,Ensure accounts in /etc/passwd use shadowed passwords,Non-Compliant" >> $varfilename
fi 


# 107,Ensure all groups in /etc/passwd exist in /etc/group
#---------------------------------#

source 107_script.sh

if [ -f "tempfiles/107-data.txt" ]
then
      echo "107,Ensure all groups in /etc/passwd exist in /etc/group,Non-Compliant" >> $varfilename
else
      echo "107,Ensure all groups in /etc/passwd exist in /etc/group,Compliant" >> $varfilename
fi 

# 108,Ensure root is the only UID 0 account
#---------------------------------#
touch tempfiles/108-data.txt
rm tempfiles/108-data.txt
awk -F: '($3 == 0) { print $1 }' /etc/passwd > tempfiles/108-data.txt
var_nonroot=0
while IFS= read -r line; do
      # echo "Text read from file: $line"
      if [ $line != "root" ]
      then
            var_nonroot = $((var_nonroot+1))
            # echo "Non Root!"
      fi      
done < tempfiles/108-data.txt
if [ "$var_nonroot" -eq 0 ]
then
      echo "108,Ensure root is the only UID 0 account,Compliant" >> $varfilename
else
      echo "108,Ensure root is the only UID 0 account,Non-Compliant" >> $varfilename
fi 

# 109,Ensure no duplicate UIDs exist
#---------------------------------#
source 109_script.sh

if [ -f "tempfiles/109-data.txt" ]
then
      echo "109,Ensure no duplicate UIDs exist,Non-Compliant" >> $varfilename
else
      echo "109,Ensure no duplicate UIDs exist,Compliant" >> $varfilename
fi 

# 110,Ensure no duplicate GIDs exist
#---------------------------------#
source 110_script.sh

if [ -f "tempfiles/110-data.txt" ]
then
      echo "110,Ensure no duplicate GIDs exist,Non-Compliant" >> $varfilename
else
      echo "110,Ensure no duplicate GIDs exist,Compliant" >> $varfilename
fi 

# 111,Ensure no duplicate user names exist
#---------------------------------#
source 111_script.sh
# var111_lc=$(grep -c '.' tempfiles/111-data.txt)
# echo $var111_lc

if [ -f "tempfiles/111-data.txt" ]
then
      echo "111,Ensure no duplicate group names exist,Non-Compliant" >> $varfilename
else
      echo "111,Ensure no duplicate group names exist,Compliant" >> $varfilename
fi 

# # 112,Ensure no duplicate group names exist
# #---------------------------------#
source 112_script.sh
# var112_lc=$(grep -c '.' tempfiles/112-data.txt)
# echo $var112_lc

if [ -f "tempfiles/112-data.txt" ]
then
      echo "112,Ensure no duplicate group names exist,Non-Compliant" >> $varfilename
else
      echo "112,Ensure no duplicate group names exist,Compliant" >> $varfilename
fi 


# 113,Ensure shadow group is empty
#---------------------------------#
var113_1=$(awk -F: '($1=="shadow") {print $NF}' /etc/group)
var113_2=$(awk -F: -v GID="$(awk -F: '($1=="shadow") {print $3}' /etc/group)" '($4==GID) {print $1}' /etc/passwd)
if [ -z "$var113_1" ] && [ -z "$var113_2" ]
then
      echo "113,Ensure shadow group is empty,Compliant" >> $varfilename
else
      echo "113,Ensure shadow group is empty,Non-Compliant" >> $varfilename
fi 

echo "#Clearing Temporary Files"
rm -rf tempfiles

echo "Ubuntu 20.04 NST Cyber Configuration Review - Completed"
