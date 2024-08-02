#!/usr/bin/env nu

def main [kak_session_id, kak_client_id] {
  # Select a file w/ fzf w/ preview.
  let file = (fzf --preview "bat --color=always --style=numbers --line-range=:500 {}")

  $"evaluate-commands -client ($kak_client_id) 'edit ($file)'"
  | kak -p $kak_session_id
}

