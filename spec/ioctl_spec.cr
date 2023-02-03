require "../src/ioctl"
require "spec"

describe IOCTL do
  describe ".ioctl" do
    context "when given a valid ioctl request number" do
      it "must populate the given pointer" do
        winsize = LibC::Winsize.new

        IOCTL.ioctl(STDOUT.fd, IOCTLS::TIOCGWINSZ, pointerof(winsize))

        (winsize.ws_row > 0).should be_true
        (winsize.ws_col > 0).should be_true
      end
    end

    context "when given an invalid ioctl request number" do
      it "raises" do
        expect_raises(IOCTL::Error) do
          IOCTL.ioctl(1, 0xffffffff_u32, nil)
        end
      end

      it "returns an Errno" do
        IOCTL.ioctl?(1, 0xffffffff_u32, nil).should eq Errno::ENOTTY
      end
    end
  end

  describe "._IO" do
    it "calculates the correct value for UI_DEV_CREATE" do
      IOCTL._IO('U', 1).should eq 21761_u32
    end
  end

  describe "._IOW" do
    it "calculates the correct value for UI_SET_EVBIT" do
      IOCTL._IOW('U', 100, UInt32).should eq 1074025828_u32
    end
  end

  describe "._IOR" do
    it "calculates the correct value for USBTMC_IOCTL_API_VERSION" do
      IOCTL._IOR(91, 16, UInt32).should eq 2147769104_u32
    end
  end

  describe "._IOWR" do
    it "calculates the correct value for USBTMC_IOCTL_WRITE_RESULT" do
      IOCTL._IOWR(91, 15, UInt32).should eq 3221510927_u32
    end
  end
end
