require "./sys/ioctl"

module IOCTL
  VERSION = "0.1.0"

  include IOCTLS

  class Error < IO::Error
  end

  extend self

  # Executes an `ioctl` call, and returns an `Errno` in case of an error.
  def ioctl?(fd : LibC::Int, request : UInt32, *arguments) : Errno?
    if LibC.ioctl(fd, request, *arguments) == -1
      return Errno.value
    end
  end

  # Executes an `ioctl` call, and raises in case of an error
  def ioctl(fd : LibC::Int, request : UInt32, *arguments) : Nil
    if errno = ioctl?(fd, request, *arguments)
      raise Error.new errno.message
    end
  end
end
