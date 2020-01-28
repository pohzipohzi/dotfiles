for s in $(git diff --name-only); do terraform fmt -write=true $s; done
