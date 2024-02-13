def find_pane [pane_id] {
  wezterm cli list | detect columns | filter {|x| $x.PANEID == $pane_id } | first
}

def run_command [command] {
  echo command | wezterm cli send-text --pane-id 
}

def split_pane_down [command] {
  mut bottom_pane_id = (wezterm cli get-pane-direction down)
  if $bottom_pane_id == '' {
    $bottom_pane_id = (wezterm cli split-pane --percent 30)
  }
  
  let bottom_pane_id = $bottom_pane_id
  wezterm cli activate-pane --pane-id $bottom_pane_id

  echo $"($command)\r\n" | wezterm cli send-text --pane-id $bottom_pane_id --no-paste
}

def "main explorer" [] {
  let left_pane_id = (wezterm cli get-pane-direction left)
  if $left_pane_id != '' {
    if (find_pane $left_pane_id).TITLE == 'broot.exe' {
      wezterm cli activate-pane --pane-id $left_pane_id
      return
    }
  }
  
  wezterm cli split-pane --left --percent 20 -- broot -s --conf ~/.config/broot.toml
}

def "main edit" [file] {  
  mut right_pane_id = (wezterm cli get-pane-direction right)
  if $right_pane_id == '' {
    $right_pane_id = (wezterm cli split-pane --right --percent 80)
  }

  let right_pane_id = $right_pane_id;
  let title = (find_pane $right_pane_id).TITLE
  if $title == "hx.exe" {
    echo $":open ($file)\r\n" | wezterm cli send-text --pane-id $right_pane_id --no-paste
  } else {
    # NOTE: Windows에서는 foreground process를 제대로 찾지 못하고 있어서 hx 실행을 분리
    #       "hx\r\n"는 helix 내에서 INSERT 모드가 아니라면 안전함.
    echo $"hx\r\n" | wezterm cli send-text --pane-id $right_pane_id --no-paste
    echo $":open ($file)\r\n" | wezterm cli send-text --pane-id $right_pane_id --no-paste
  }
  
  wezterm cli activate-pane --pane-id $right_pane_id
}

def "main cargo-run" [] {
  split_pane_down "cargo run"
}

def main [command] {
  echo $"'($command)' is unknown command."
  exit 1
}
