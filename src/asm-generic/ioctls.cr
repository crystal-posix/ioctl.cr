require "./ioctl"

module IOCTLS
  # These are the most common definitions for tty ioctl numbers.
  # Most of them do not use the recommended _IOC(), but there is
  # probably some source code out there hardcoding the number,
  # so we might as well use them for all new platforms.
  #
  # The architectures that use different values here typically
  # try to be compatible with some Unix variants for the same
  # architecture.

  # 0x54 is just a magic number to make these relatively unique ('T')

  alias UInt = LibC::UInt
  alias Int  = LibC::Int
  alias Termios2 = LibC::Termios

  TCGETS		   = 0x5401_u32
  TCSETS		   = 0x5402_u32
  TCSETSW		   = 0x5403_u32
  TCSETSF		   = 0x5404_u32
  TCGETA		   = 0x5405_u32
  TCSETA		   = 0x5406_u32
  TCSETAW		   = 0x5407_u32
  TCSETAF		   = 0x5408_u32
  TCSBRK		   = 0x5409_u32
  TCXONC		   = 0x540A_u32
  TCFLSH		   = 0x540B_u32
  TIOCEXCL	   = 0x540C_u32
  TIOCNXCL	   = 0x540D_u32
  TIOCSCTTY	   = 0x540E_u32
  TIOCGPGRP	   = 0x540F_u32
  TIOCSPGRP	   = 0x5410_u32
  TIOCOUTQ	   = 0x5411_u32
  TIOCSTI		   = 0x5412_u32
  TIOCGWINSZ   = 0x5413_u32
  TIOCSWINSZ   = 0x5414_u32
  TIOCMGET	   = 0x5415_u32
  TIOCMBIS	   = 0x5416_u32
  TIOCMBIC	   = 0x5417_u32
  TIOCMSET     = 0x5418_u32
  TIOCGSOFTCAR = 0x5419_u32
  TIOCSSOFTCAR = 0x541A_u32
  FIONREAD	   = 0x541B_u32
  TIOCINQ		   = FIONREAD
  TIOCLINUX	   = 0x541C_u32
  TIOCCONS	   = 0x541D_u32
  TIOCGSERIAL	 = 0x541E_u32
  TIOCSSERIAL	 = 0x541F_u32
  TIOCPKT		   = 0x5420_u32
  FIONBIO		   = 0x5421_u32
  TIOCNOTTY	   = 0x5422_u32
  TIOCSETD	   = 0x5423_u32
  TIOCGETD	   = 0x5424_u32
  TCSBRKP		   = 0x5425_u32 # Needed for POSIX tcsendbreak()
  TIOCSBRK	   = 0x5427_u32 # BSD compatibility
  TIOCCBRK	   = 0x5428_u32 # BSD compatibility
  TIOCGSID	   = 0x5429_u32 # Return the session ID of FD
  TCGETS2      = ioctl_ior('T', 0x2A, Termios2)
  TCSETS2      = ioctl_iow('T', 0x2B, Termios2)
  TCSETSW2     = ioctl_iow('T', 0x2C, Termios2)
  TCSETSF2     = ioctl_iow('T', 0x2D, Termios2)
  TIOCGRS485   = 0x542E_u32
  TIOCSRS485   = 0x542F_u32
  TIOCGPTN     = ioctl_ior('T', 0x30, UInt) # Get Pty Number (of pty-mux device)
  TIOCSPTLCK   = ioctl_iow('T', 0x31, Int)  # Lock/unlock Pty
  TIOCGDEV     = ioctl_ior('T', 0x32, UInt) # Get primary device node of /dev/console
  TCGETX       = 0x5432_u32 # SYS5 TCGETX compatibility
  TCSETX       = 0x5433_u32
  TCSETXF      = 0x5434_u32
  TCSETXW      = 0x5435_u32
  TIOCSIG      = ioctl_IOW('T', 0x36, Int)  # pty: generate signal
  TIOCVHANGUP	 = 0x5437_u32
  TIOCGPKT     = ioctl_IOR('T', 0x38, Int) # Get packet mode state
  TIOCGPTLCK   = ioctl_IOR('T', 0x39, Int) # Get Pty lock state
  TIOCGEXCL    = ioctl_ior('T', 0x40, Int) # Get exclusive mode state
  TIOCGPTPEER	 = ioctl_io('T', 0x41) # Safely open the slave
  # TODO: 
  # TIOCGISO7816	ioctl_ior('T', 0x42, struct serial_iso7816)
  # TIOCSISO7816 = ioctl_iowr('T', 0x43, struct serial_iso7816)

  FIONCLEX        = 0x5450_u32
  FIOCLEX         = 0x5451_u32
  FIOASYNC	      = 0x5452_u32
  TIOCSERCONFIG   = 0x5453_u32
  TIOCSERGWILD    = 0x5454_u32
  TIOCSERSWILD	  = 0x5455_u32
  TIOCGLCKTRMIOS	= 0x5456_u32
  TIOCSLCKTRMIOS	= 0x5457_u32
  TIOCSERGSTRUCT	= 0x5458_u32 # For debugging only
  TIOCSERGETLSR   = 0x5459_u32 # Get line status register
  TIOCSERGETMULTI = 0x545A_u32 # Get multiport config
  TIOCSERSETMULTI = 0x545B_u32 # Set multiport config

  TIOCMIWAIT	= 0x545C_u32 # wait for a change on serial input line(s)
  TIOCGICOUNT	= 0x545D_u32 # read serial port __inline__ interrupt counts

  # Some arches already define FIOQSIZE due to a historical
  # conflict with a Hayes modem-specific ioctl value.
  FIOQSIZE = 0x5460_u32

  # Used for packet mode
  TIOCPKT_DATA       = 0_u32
  TIOCPKT_FLUSHREAD  = 1_u32
  TIOCPKT_FLUSHWRITE = 2_u32
  TIOCPKT_STOP       = 4_u32
  TIOCPKT_START      = 8_u32
  TIOCPKT_NOSTOP     = 16_u32
  TIOCPKT_DOSTOP     = 32_u32
  TIOCPKT_IOCTL      = 64_u32

  TIOCSER_TEMT = 0x01_u32 # Transmitter physically empty
end
