mod key is alt key

mod enter - opens a terminal window

mod d - opens dmenu to load any application

mod shift q - quit current application

mod h - will open the next window horizontally

mod v - will open the next window vertically

mod arrow key - will change the current window on focus

mod r - resize mode. use arrow keys to make the current window larger/
smaller. esc to exit.

mod shift arrow keys - to switch the position of the current window.

mod s - stack all windows mod arrow key - to access all the stacked
windows

mod e - to back to tiling mode

mod t - tab mode mod arrow key - to access all the tabs

mod shift number - puts the current window in a new workspace mod number
- go to that workspace

mod shift e - log out

mod f - make current window full screen

i3lock - turns the screen white, basically locking it. Enter your
passcode to gain access to the computer again

\*\*a good way of thinking about when to use shift and when not to is
mod + shift applies to the entire desktop, while mod applies to the
current workspace

------------------------------------------------------------------------

i3 custom config mod shift r - restart i3. Refreshes the config file

Bind shortcut key example: `bindsym $mod+shift+x` exec i3lock

`bindsym` - bind system keys followed by the key binding and then what the
key binding does
