require "./sys/ioctl"

module IOCTL
  VERSION = "0.1.0"

  include IOCTLS

  class Error < IO::Error
  end

  extend self

  def ioctl(fd : LibC::Int, request : UInt32, *arguments)
    if LibC.ioctl(fd, request, *arguments) == -1
      raise Error.new(String.new(LibC.strerror(Errno.value)))
    end
  end
end
