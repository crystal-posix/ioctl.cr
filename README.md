# ioctl.cr

* [Source](https://github.com/postmodern/ioctl.cr)
* [Issues](https://github.com/postmodern/ioctl.cr/issues)
* [Docs](https://postmodern.github.io/docs/ioctrl.cr/index.html)

libc's [ioctl] for [Crystal][crystal].

## Features

* Maps in the libc `ioctl` function.
* Provides C equivalent methods for defining and working with ioctl numbers:

  | C           | Crystal                         |
  |-------------|---------------------------------|
  | `_IOC`      | `IOCTL::_IOC(dir,type,nr,size)` |
  | `_IO`       | `IOCTL::_IOC(type,nr)`          |
  | `_IOR`      | `IOCTL::_IOR(type,nr,size)`     |
  | `_IOW`      | `IOCTL::_IOW(type,nr,size)`     |
  | `_IOWR`     | `IOCTL::_IOWR(type,nr,size)`    |
  | `_IOC_DIR`  | `IOCTL::_IOC_DIR(dir)`          |
  | `_IOC_TYPE` | `IOCTL::_IOC_TYPE(type)`        |
  | `_IOC_NR`   | `IOCTL::_IOC_NR(nr)`            |
  | `_IOC_SIZE` | `IOCTL::_IOC_SIZE(size)`        |

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     ioctl:
       github: postmodern/ioctl.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "ioctl"

output = MyStruct.new

begin
  IOCTL.ioctl(fd, IOCTL::..., pointerof(output))
request error : IOCTL::Error
  # ...
end
```

Returning `-1` instead of raising an exception:

```crystal
if LibC.ioctl(fd, IOCTL::..., pointerof(output)) == -1
  # ...
end
```

### Examples

Get the terminal window size:

```crystal
winsize = LibC::Winsize.new

begin
  IOCTL.ioctl(STDOUT.fd, IOCTL::TIOCGWINSZ, pointerof(winsize))
rescue error : IOCTL::Error
  STDERR.puts error.message
  exit -1
end

puts "Rows: #{winsize.ws_row}"
puts "Cols: #{winsize.ws_col}"
```

## TODO

* macOS / BSD support

## Contributing

1. Fork it (<https://github.com/postmodern/ioctl/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Postmodern](https://github.com/postmodern) - creator and maintainer

[ioctl]: http://man7.org/linux/man-pages/man2/ioctl.2.html
[crystal]: https://crystal-lang.org/
