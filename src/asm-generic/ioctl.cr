module IOCTL
  # ioctl command encoding: 32 bits total, command in lower 16 bits,
  # size of the parameter structure in the lower 14 bits of the
  # upper 16 bits.
  # Encoding the size of the parameter structure in the ioctl request
  # is useful for catching programs compiled with old versions
  # and to avoid overwriting user space outside the user buffer area.
  # The highest 2 bits are reserved for indicating the ``access mode''.
  # NOTE: This limits the max parameter size to 16kB -1 !

  # The following is for compatibility across the various Linux
  # platforms.  The generic ioctl numbering scheme doesn't really enforce
  # a type field.  De facto, however, the top 8 bits of the lower 16
  # bits are indeed used as a type field, so we might just as well make
  # this explicit here.  Please be sure to use the decoding macros
  # below from now on.
  IOC_NRBITS   = 8
  IOC_TYPEBITS = 8

  # Let any architecture override either of the following before
  # including this file.
  IOC_SIZEBITS = 14
  DIRBITS      =  2

  IOC_NRMASK   = (1 << IOC_NRBITS) - 1
  IOC_TYPEMASK = (1 << IOC_TYPEBITS) - 1
  IOC_SIZEMASK = (1 << IOC_SIZEBITS) - 1
  IOC_DIRMASK  = (1 << IOC_DIRBITS) - 1

  IOC_NRSHIFT   = 0
  IOC_TYPESHIFT = IOC_NRSHIFT + IOC_NRBITS
  IOC_SIZESHIFT = IOC_TYPESHIFT + IOC_TYPEBITS
  IOC_DIRSHIFT  = IOC_SIZESHIFT + IOC_SIZEBITS

  # Direction bits, which any architecture can choose to override
  # before including this file.
  enum IOC : UInt32
    NONE
    # _IOC::WRITE means userland is writing and kernel is reading.
    WRITE
    # IOC::READ means userland is reading and kernel is writing.
    READ
  end

  # for the drivers/sound files...
  IOC_IN        = IOC_WRITE << IOC_DIRSHIF
  IOC_OUT       = IOC_READ << IOC_DIRSHIFT
  IOC_INOUT     = (IOC_WRITE | IOC_READ) << IOC_DIRSHIFT
  IOCSIZE_MASK  = IOC_SIZEMASK << IOC_SIZESHIFT
  IOCSIZE_SHIFT = IOC_SIZESHIFT

  # Used to create numbers.
  def _IOC(dir : IOC, type : Int | Char, nr : Int, size : Int) : UInt32
    (dir.value << IOC_DIRSHIFT) | \
      ((type.is_a?(Char) ? type.ord : type) << IOC_TYPESHIFT) | \
        (nr << IOC_NRSHIFT) | (size << IOC_SIZESHIFT)
  end

  def _IO(type : Char | Int, nr : Int) : UInt32
    _IOC IOC::NONE, type, nr, 0
  end

  # _IOR means userland is reading and kernel is writing.
  def _IOR(type : Char | Int, nr : Int, size : T.class) : UInt32 forall T
    _IOC IOC::READ, type, nr, sizeof(T)
  end

  # _IOW means userland is writing and kernel is reading.
  def _IOW(type : Char | Int, nr : Int, size : T.class) : UInt32 forall T
    _IOC IOC::WRITE, type, nr, sizeof(T)
  end

  def _IOWR(type : Char | Int, nr : Int, size : T.class) : UInt32 forall T
    _IOC IOC::READ | IOC::WRITE, type, nr, sizeof(T)
  end

  # Decodes ioctl `dir` number.
  def _IOC_DIR(dir : IOC)
    (dir.value >> IOC_DIRSHIFT) & IOC_DIRMASK
  end

  # Decodes ioctl `type` number.
  def _IOC_TYPE(type : Char | Int)
    ((type.is_a?(Char) ? type.ord : type) >> IOC_TYPESHIFT) & IOC_TYPEMASK
  end

  # Decodes ioctl `nr` number.
  def _IOC_NR(nr : Int)
    (nr >> IOC_NRSHIFT) & IOC_NRMASK
  end

  # Decodes ioctl `size` number.
  def _IOC_SIZE(size : Int)
    (size >> IOC_SIZESHIFT) & IOC_SIZEMASK
  end
end
