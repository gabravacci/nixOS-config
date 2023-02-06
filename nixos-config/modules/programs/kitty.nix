
{ config, lib, pkgs, ... }:

{
  programs = {
    kitty = {
      enable = true;

      extraConfig = ''
        # Fonts
font_family      JetBrainsMono Nerd Font
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size 14.0

adjust_line_height 0
adjust_column_width 0
box_drawing_scale 0.001, 1, 1.5, 2

# Cursor
cursor_shape     underline
cursor_blink_interval     0
cursor_stop_blinking_after 15.0

# Scrollback
scrollback_lines 10000
scrollback_pager /usr/bin/less
wheel_scroll_multiplier 5.0

# URLs
url_style double
open_url_modifiers ctrl+shift
open_url_with firefox
copy_on_select yes

# Selection
rectangle_select_modifiers ctrl+shift
select_by_word_characters :@-./_~?&=%+#

# Mouse
click_interval 0.5
mouse_hide_wait 0
focus_follows_mouse no

# Performance
repaint_delay    20
input_delay 2
sync_to_monitor no

# Bell
visual_bell_duration 0.0
enable_audio_bell no

# Window
remember_window_size   no
initial_window_width   700
initial_window_height  400
window_border_width 0
window_margin_width 0
window_padding_width 20
inactive_text_alpha 1.0
background_opacity 0.80

# Layouts
enabled_layouts *

# Tabs
tab_bar_edge bottom
tab_separator " ┇"
active_tab_font_style bold
inactive_tab_font_style normal

# Shell
shell .
close_on_child_death no
confirm_os_window_close 0
allow_remote_control yes
term xterm-256color

# Keys
map ctrl+shift+v        	paste_from_clipboard
map ctrl+shift+s        	paste_from_selection
map ctrl+shift+c        	copy_to_clipboard
map shift+insert        	paste_from_selection

map ctrl+shift+up        	scroll_line_up
map ctrl+shift+down      	scroll_line_down
map ctrl+shift+k         	scroll_line_up
map ctrl+shift+j         	scroll_line_down
map ctrl+shift+page_up   	scroll_page_up
map ctrl+shift+page_down 	scroll_page_down
map ctrl+shift+home      	scroll_home
map ctrl+shift+end       	scroll_end
map ctrl+shift+h         	show_scrollback

map ctrl+shift+enter    	new_window
map ctrl+shift+n        	new_os_window
map ctrl+shift+w        	close_window
map ctrl+shift+]        	next_window
map ctrl+shift+[        	previous_window
map ctrl+shift+f        	move_window_forward
map ctrl+shift+b        	move_window_backward
map ctrl+shift+`        	move_window_to_top
map ctrl+shift+1        	first_window
map ctrl+shift+2        	second_window
map ctrl+shift+3        	third_window
map ctrl+shift+4        	fourth_window
map ctrl+shift+5        	fifth_window
map ctrl+shift+6        	sixth_window
map ctrl+shift+7        	seventh_window
map ctrl+shift+8        	eighth_window
map ctrl+shift+9        	ninth_window
map ctrl+shift+0        	tenth_window
	
map ctrl+shift+right    	next_tab
map ctrl+shift+left     	previous_tab
map ctrl+shift+t        	new_tab
map ctrl+shift+q        	close_tab
map ctrl+shift+l        	next_layout
map ctrl+shift+.        	move_tab_forward
map ctrl+shift+,        	move_tab_backward
map ctrl+shift+alt+t    	set_tab_title

# Decrease font size :
map ctrl+minus       		change_font_size all -2.0
map ctrl+kp_subtract 		change_font_size all -2.0
map cmd+minus             	change_font_size all -2.0
map shift+cmd+minus       	change_font_size all -2.0

# Increase font size :
map ctrl+equal  			change_font_size all +2.0
map ctrl+plus   			change_font_size all +2.0
map ctrl+kp_add 			change_font_size all +2.0
map cmd+plus         		change_font_size all +2.0
map cmd+equal        		change_font_size all +2.0
map shift+cmd+equal  		change_font_size all +2.0

# Reset font size :
map kitty_mod+backspace 	change_font_size all 0
map cmd+0               	change_font_size all 0
map ctrl+f6     			set_font_size 16.0
      '';
    };
  };
}