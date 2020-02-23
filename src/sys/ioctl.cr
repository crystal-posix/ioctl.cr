require "../bits/ioctls"
require "../bits/ioctl-types"

lib LibC
  fun ioctl(fd : Int32, request : UInt32, output : Void *) : Int32
end
