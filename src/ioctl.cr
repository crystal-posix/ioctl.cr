require "./sys/ioctl"

module IOCTL
  VERSION = "0.1.0"

  include IOCTLS

  class Error < IO::Error
  end

  extend self

  @[Raises("Error")]
  def ioctl(fd, request, output)
    if LibC.ioctl(fd, request, output) == -1
      raise Error.new(String.new(LibC.strerror(Errno.value)))
    end
  end
end
