 1 Commands used 
    1    pvs
    2  pvdisplay
    3  pvcreate /dev/nvme1n1 /dev/nvme2n1
    4  clear
    5  pvs
    6  vgcreate ria-vg  /dev/nvme1n1  /dev/nvme2n1
    7  vgs
    8  vgdisplay
    9  lvcreate -L 5G -n ria-lv ria-vg
   10  lsblk
   11  lvcreate -L 5G -n ria-lv1 ria-vg
   12  lsblk
   13  mkfs.ext4 /dev/ria-vg/ria-lv
   14  munt /dev/ria-vg/ria-lv /mnt/data
   15  mount /dev/ria-vg/ria-lv /mnt/data
   16  mount/dev/ria-vg/ria-lv /mnt/data
   17  mount /dev/ria-vg/ria-lv /mnt/data
   18  mkdir -p /mnt/data
   19  ls -ld  /mnt/data
   20  mount /dev/ria-vg/ria-lv /mnt/data
   21  df -h
   22  lsblk -f
   23  cd ..
   24  history
root@ip-172-31-12-183:/#
Screenshots of outputs: 
<img width="1226" height="767" alt="image" src="https://github.com/user-attachments/assets/b4065fda-c9d2-464a-9185-32db38c1db12" />

<img width="1126" height="454" alt="image" src="https://github.com/user-attachments/assets/bee32b65-0273-430a-8c40-6aa5129c4fbd" />

<img width="1125" height="707" alt="image" src="https://github.com/user-attachments/assets/8aa03535-57f4-4ee0-88af-336b160f346c" />

<img width="1188" height="717" alt="image" src="https://github.com/user-attachments/assets/7f5f11e3-ff19-4e75-8b85-1b93441d628c" />

<img width="1624" height="543" alt="image" src="https://github.com/user-attachments/assets/c7b796ed-b262-4402-8a6d-a811a74637f0" />

What you learned (3 points)
>> ☁️ When creating cloud storage volumes, I need to make sure the volume is created in the same AWS Region as the instance where I want to attach it.

