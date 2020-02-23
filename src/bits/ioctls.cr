require "../asm/ioctls"

module IOCTLS
  # Routing table calls.
  SIOCADDRT = 0x890B_u32		# add routing table entry
  SIOCDELRT = 0x890C_u32		# delete routing table entry
  SIOCRTMSG = 0x890D_u32		# call to routing system

  # Socket configuration controls.
  SIOCGIFNAME	       = 0x8910_u32	# get iface name
  SIOCSIFLINK	       = 0x8911_u32	# set iface channel
  SIOCGIFCONF	       = 0x8912_u32	# get iface list
  SIOCGIFFLAGS       = 0x8913_u32	# get flags
  SIOCSIFFLAGS       = 0x8914_u32	# set flags
  SIOCGIFADDR        = 0x8915_u32	# get PA address
  SIOCSIFADDR	       = 0x8916_u32	# set PA address
  SIOCGIFDSTADDR     = 0x8917_u32	# get remote PA address
  SIOCSIFDSTADDR     = 0x8918_u32	# set remote PA address
  SIOCGIFBRDADDR     = 0x8919_u32	# get broadcast PA address
  SIOCSIFBRDADDR     = 0x891a_u32	# set broadcast PA address
  SIOCGIFNETMASK     = 0x891b_u32	# get network PA mask
  SIOCSIFNETMASK     = 0x891c_u32	# set network PA mask
  SIOCGIFMETRIC	     = 0x891d_u32	# get metric
  SIOCSIFMETRIC	     = 0x891e_u32	# set metric
  SIOCGIFMEM         = 0x891f_u32	# get memory address (BSD)
  SIOCSIFMEM         = 0x8920_u32	# set memory address (BSD)
  SIOCGIFMTU         = 0x8921_u32	# get MTU size
  SIOCSIFMTU         = 0x8922_u32	# set MTU size
  SIOCSIFNAME	       = 0x8923_u32	# set interface name
  SIOCSIFHWADDR      = 0x8924_u32	# set hardware address
  SIOCGIFENCAP       = 0x8925_u32	# get/set encapsulations
  SIOCSIFENCAP       = 0x8926_u32
  SIOCGIFHWADDR      = 0x8927_u32	# Get hardware address
  SIOCGIFSLAVE       = 0x8929_u32	# Driver slaving support
  SIOCSIFSLAVE       = 0x8930_u32
  SIOCADDMULTI       = 0x8931_u32	# Multicast address lists
  SIOCDELMULTI       = 0x8932_u32
  SIOCGIFINDEX       = 0x8933_u32	# name -> if_index mapping
  SIOGIFINDEX        = SIOCGIFINDEX	# misprint compatibility :-)
  SIOCSIFPFLAGS      = 0x8934_u32 # set/get extended flags set
  SIOCGIFPFLAGS      = 0x8935_u32
  SIOCDIFADDR        = 0x8936_u32 # delete PA address
  SIOCSIFHWBROADCAST = 0x8937_u32 # set hardware broadcast addr
  SIOCGIFCOUNT       = 0x8938_u32 # get number of devices

  SIOCGIFBR = 0x8940_u32  # Bridging support
  SIOCSIFBR = 0x8941_u32  # Set bridging options

  SIOCGIFTXQLEN = 0x8942_u32  # Get the tx queue length
  SIOCSIFTXQLEN = 0x8943_u32  # Set the tx queue length


  # ARP cache control calls.
  #   0x8950 - 0x8952  * obsolete calls, don't re-use
  SIOCDARP = 0x8953_u32  # delete ARP table entry
  SIOCGARP = 0x8954_u32  # get ARP table entry
  SIOCSARP = 0x8955_u32  # set ARP table entry

  # RARP cache control calls.
  SIOCDRARP	= 0x8960_u32  # delete RARP table entry
  SIOCGRARP	= 0x8961_u32  # get RARP table entry
  SIOCSRARP	= 0x8962_u32  # set RARP table entry

  # Driver configuration calls

  SIOCGIFMAP = 0x8970_u32  # Get device parameters
  SIOCSIFMAP = 0x8971_u32  # Set device parameters

  # DLCI configuration calls
  SIOCADDDLCI	= 0x8980_u32 # Create new DLCI device
  SIOCDELDLCI	= 0x8981_u32 # Delete DLCI device

  # Device private ioctl calls.

  # These 16 ioctls are available to devices via the do_ioctl() device
  # vector.  Each device should include this file and redefine these
  # names as their own. Because these are device dependent it is a good
  # idea _NOT_ to issue them to random objects and hope.
  SIOCDEVPRIVATE = 0x89F0_u32 # to 89FF

  #
  #	These 16 ioctl calls are protocol private
  #
  SIOCPROTOPRIVATE = 0x89E0_u32 # to 89EF
end
