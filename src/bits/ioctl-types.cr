require "../asm/ioctls"

lib LibC
  struct Winsize
    ws_row : UShort
    ws_col : UShort
    ws_xpixel : UShort
    ws_ypixel : UShort
  end

  NCC = 8

  struct Termio
    c_iflag : UShort # input mode flags
    c_oflag : UShort # output mode flags
    c_cflag : UShort # control mode flags
    c_lflag : UShort # local mode flags
    c_line : UChar # line discipline
    c_cc : UChar[NCC]
  end

  # modem lines
  TIOCM_LE  = 0x001
  TIOCM_DTR = 0x002
  TIOCM_RTS = 0x004
  TIOCM_ST  = 0x008
  TIOCM_SR  = 0x010
  TIOCM_CTS = 0x020
  TIOCM_CAR = 0x040
  TIOCM_RNG = 0x080
  TIOCM_DSR = 0x100
  TIOCM_CD  = TIOCM_CAR
  TIOCM_RI  = TIOCM_RNG

  # ioctl (fd, TIOCSERGETLSR, &result) where result may be as below

  # line disciplines
  N_TTY          = 0
  N_SLIP         = 1
  N_MOUSE        = 2
  N_PPP          = 3
  N_STRIP        = 4
  N_AX25         = 5
  N_X25          = 6	# X.25 async
  N_6PACK        = 7
  N_MASC         = 8	# Mobitex module
  N_R3964        = 9	# Simatic R3964 module
  N_PROFIBUS_FDL = 10 # Profibus
  N_IRDA         = 11 # Linux IR
  N_SMSBLOCK     = 12	# SMS block mode
  N_HDLC         = 13	# synchronous HDLC
  N_SYNC_PPP     = 14	# synchronous PPP
  N_HCI          = 15	# Bluetooth HCI UART
end
