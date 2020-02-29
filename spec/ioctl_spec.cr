require "./spec_helper"

Spectator.describe IOCTL do
  describe ".ioctl" do
    context "when given a valid ioctl request number" do
      it "must populate the given pointer" do
        winsize = LibC::Winsize.new

        IOCTL.ioctl(STDOUT.fd, IOCTLS::TIOCGWINSZ, pointerof(winsize))

        expect(winsize.ws_row).to be > 0
        expect(winsize.ws_col).to be > 0
      end
    end

    context "when given an invalid ioctl request number" do
      it do
        expect {
          subject.ioctl(1, 0xffffffff_u32, nil)
        }.to raise_error(IOCTL::Error)
      end
    end
  end
end
