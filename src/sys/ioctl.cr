require "../bits/ioctls"
require "../bits/ioctl-types"

lib LibC
  fun ioctl(fd : Int, request : UInt32, ...) : Int
end
