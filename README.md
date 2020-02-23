# ioctl

libc's [ioctl] for crystal.

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
```

### Examples

Get the terminal window size:

```crystal
winsize = LibC::Winsize.new

begin
  IOCTL.ioctl(STDOUT.fd, IOCTLS::TIOCGWINSZ, pointerof(winsize))
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
