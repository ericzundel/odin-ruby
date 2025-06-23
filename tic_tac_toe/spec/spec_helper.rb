let(:mock_window) do
  instance_double(Curses::Window,
                  setpos: nil,
                  addstr: nil,
                  refresh: nil,
                  getch: nil,
                  close: nil)
end

before do
  allow(Curses).to receive(:init_screen)
  allow(Curses).to receive(:close_screen)
  allow(Curses::Window).to receive(:new).and_return(mock_window)
end
