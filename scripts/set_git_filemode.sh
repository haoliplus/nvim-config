# find ~/.local/share/nvim/lazy -type d -name .git -print0 | \
# while IFS= read -r -d '' g; do
#   repo="${g%/.git}"
#   printf '%s -> %s\n' "$repo" "$(git -C "$repo" config --get core.filemode)"
# done
  find ~/.local/share/nvim/lazy -type d -name .git -print0 | \
  while IFS= read -r -d '' g; do
    repo="${g%/.git}"
    git -C "$repo" config --local core.filemode false
  done
