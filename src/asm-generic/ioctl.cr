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
  IOC_NRBITS = 8
  IOC_TYPEBITS = 8

  # Let any architecture override either of the following before
  # including this file.
  IOC_SIZEBITS = 14
  DIRBITS  = 2

  IOC_NRMASK   = ((1 << IOC_NRBITS)-1)
  IOC_TYPEMASK = ((1 << IOC_TYPEBITS)-1)
  IOC_SIZEMASK = ((1 << IOC_SIZEBITS)-1)
  IOC_DIRMASK  = ((1 << IOC_DIRBITS)-1)

  IOC_NRSHIFT   = 0
  IOC_TYPESHIFT = IOC_NRSHIFT + IOC_NRBITS
  IOC_SIZESHIFT = IOC_TYPESHIFT + IOC_TYPEBITS
  IOC_DIRSHIFT  = IOC_SIZESHIFT + IOC_SIZEBITS

  # Direction bits, which any architecture can choose to override
  # before including this file.
  #
  # NOTE: _IOC_WRITE means userland is writing and kernel is
  # reading. _IOC_READ means userland is reading and kernel is writing.

  IOC_NONE  = 0_u32
  IOC_WRITE = 1_u32
  IOC_READ  = 2_u32

  # for the drivers/sound files...
  IOC_IN        = (IOC_WRITE << IOC_DIRSHIFT)
  IOC_OUT       = (IOC_READ << IOC_DIRSHIFT)
  IOC_INOUT     = ((IOC_WRITE | IOC_READ) << IOC_DIRSHIFT)
  IOCSIZE_MASK  = (IOC_SIZEMASK << IOC_SIZESHIFT)
  IOCSIZE_SHIFT = (IOC_SIZESHIFT)
end

macro ioctl_ioc(dir,type,nr,size)
	((({{ dir }})  << IOCTL::IOC_DIRSHIFT) | \
	 (({{ type }}) << IOCTL::IOC_TYPESHIFT) | \
	 (({{ nr }})   << IOCTL::IOC_NRSHIFT) | \
	 (({{ size }}) << IOCTL::IOC_SIZESHIFT))
end

macro ioctl_ioc_typecheck(t)
  sizeof({{ t }})
end

# Used to create numbers.
#
# NOTE: _IOW means userland is writing and kernel is reading. _IOR
# means userland is reading and kernel is writing.

macro ioctl_io(type,nr)
  ioctl_ioc(IOCTL::IOC_NONE,(type),(nr),0)
end

macro ioctl_ior(type,nr,size)
  ioctl_ioc(IOCTL::IOC_READ,(type),(nr),(ioctl_ioc_typecheck(size)))
end

macro ioctl_iow(type,nr,size)
  ioctl_ioc(IOCTL::IOC_WRITE,(type),(nr),(ioctl_ioc_typecheck(size)))
end

macro ioctl_iowr(type,nr,size)
  ioctl_ioc(IOCTL::IOC_READ | IOCTL::IOC_WRITE,(type),(nr),(ioctl_ioc_typecheck(size)))
end

macro ioctl_ior_bad(type,nr,size)
  ioctl_ioc(IOCTL::IOC_READ,(type),(nr),sizeof(size))
end

macro ioctl_iow_bad(type,nr,size)
  ioctl_ioc(IOCTL::IOC_WRITE,(type),(nr),sizeof(size))
end

macro ioctl_iowr_bad(type,nr,size)
  ioctl_ioc(IOCTL::IOC_READ | IOCTL::IOC_WRITE,(type),(nr),sizeof(size))
end

# used to decode ioctl numbers..
macro ioctl_dir(nr)
  ((({{ nr }}) >> IOCTL::IOC_DIRSHIFT) & IOCTL::IOC_DIRMASK)
end

macro ioctl_type(nr)
  ((({{ nr }}) >> IOCTL::IOC_TYPESHIFT) & IOCTL::IOC_TYPEMASK)
end

macro ioctl_nr(nr)
  ((({{ nr }}) >> IOCTL::IOC_NRSHIFT) & IOCTL::IOC_NRMASK)
end

macro ioctl_size(nr)
  ((({{ nr }}) >> IOCTL::IOC_SIZESHIFT) & IOCTL::IOC_SIZEMASK)
end
