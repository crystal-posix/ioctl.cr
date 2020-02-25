# ioctl.cr

libc's [ioctl] for [crystal].

## Features

### Functions

* Maps in the libc `ioctl` function.
* Provides C equivalent macros for defining and working with ioctl numbers:
  * `ioctl_ioc(dir,type,nr,size)`
  * `ioctl_ioc_typecheck(t)`
  * `ioctl_io(type,nr)`
  * `ioctl_ior(type,nr,size)`
  * `ioctl_iow(type,nr,size)`
  * `ioctl_iowr(type,nr,size)`
  * `ioctl_ior_bad(type,nr,size)`
  * `ioctl_iow_bad(type,nr,size)`
  * `ioctl_iowr_bad(type,nr,size)`
  * `ioctl_dir(nr)`
  * `ioctl_type(nr)`
  * `ioctl_nr(nr)`
  * `ioctl_size(nr)`

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

[ioctl]: https://www.unix.com/man-page/v7/2/ioctl/
[crystal]: https://crystal-lang.org/
