### Bare Metal Hard Drive Specifications

#### Form Factors
* 2 1/2 inches
* 3 1/2 inches

#### Hard disk interface
* SCSI (Small Computer Systems Interface): 
* SAS (Serial Advanced SCSI):
* SATA (Serial Advanced Technology Attachment):
* FC (Fibre Channel):
* USB (Universal Serial Bus):
* eSATA (external SATA): SATA over USB.

#### RPMs and IOPs

#### Hard disk seek time and latency
Disks are divided into tracks and sectors. Time taken to travel from one track to another is seek time. Time taken to travel from one sector to another is latency. These travels are required for read/write to disc.

#### SSD Vs Hard discs
* have no moving parts
* much faster with extra bandwidth
* more durables
* use less power
* more costly today!

### RAID (Redundant Array of Independent Disks)
* To achive high performance 
* To achieve redundancy
* RAID can be software and/or hardware defined

#### Levels of RAID
* **RAID 0**: Also called Disk Striping
  * Min two disks required to setup RAID 0
  * Data can be written to multiple disks simultaneously
  * best performance but not redundant. watch out for disk failures.
* **RAID 1**: Also called disk mirroring
  * One disk used for writting and another is exact copy.
  * Need to maintain the exact hardware for both disks
  * Good redundancy but needs double number of disks
  * Good read performance as mirror device is available for read only
* **RAID 5**: Also called Disk striping with parity
  * Used for both high performance and basic redundancy
  * required minimum of 3 disks. 1/3 is used for redundacy.
  * two disks are required for writing and the third is used or parity. Simplified version of parity is x + y = z where x and y are the data written in two discs and z is the summation. this equation can be used to restore data when one goes missing.
  * Can tolerate 1 device going down and will allow the admin to restore the device. But remember when the disc is restored the device needs to recreate data from parity which taken time and resource.
* **RAID 6**: RAID 5 plus additional Parity
  * required minimum of 4 disks. 1/3 is used for redundacy.
  * Can tolerate 2 device going down
* **RAID 1+0**: Also called RAID TEN
  * Combined RAID 0 (Upper layer) with RAID 1 (lower layer)

#### Hot swappable and spare disks
* Damaged disks are swapped out with the new good one.
* Hot spare is already attached to the RAID to be used in case of failure.
* Cold spare are discs available with the admin (not on the rack).
* Combination of both hot and cold spares are used in the data centres.

#### Software Vs Hardware RAID
* Hardware RAID
  * Controller is responsible for establish the level of the RAID.
  * Controller can is built into the motherboard or it can go in the PCI slot. Idea is to control the devices in the RAID by the firmware on the controller. RAID Bios setup can be seen right after the initial boot.
    * At times there are OS specific raid controller provided by the RAID vendor to avoid Bios setup.
  * Software RAID
    * OS picks up the responsibility of establishing the RAID. 
    * Less performant than hardware RAID controller

### Storage technologies
* DAS (Direct Attached Storage)
  * magnetic drives or SSD
  * can be connected internally or externally
  * common interfaces are: SAS, SATA, eSATA, USB, iSCSI, Fiber Channel
  * easy to setup
  * It's one-to-one relationship with the server and the storage unit. Storage units can be single disc vs a collection of disc available over FC.
* NAS (Network Attached Storage)
  * makes storage available over IP as the NAS is plugged to your network switch
  * Provides centralised management via browser etc
  * Typically supports protocol like NFS, SMB, CIFS
  * They are file system offering file storage.
  * Fairly inexpensive and easy to setup
* SAN (Storage Area Network)
  * Offers block storage over network. 
  * Fibre Channel switch can be used to connect to the systems to storage array. Servers (Host Bus Adapter Card) --> FC Switch --> Storage Array (Logical Unit Number - LUN)
  * iSCSI protocol too can be used. Server (iSCSI initiators) --> IP Network Switch --> Server (iSCSI Target)
  * FCoE (Fibre Channel over Ethernet) 
  * FCIP (Fibre Channel over IP)

