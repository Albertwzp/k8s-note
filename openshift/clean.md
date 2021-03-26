podman system prune -a -f
crictl rm $(crictl ps -q --state Exited)
crictl rmi $(crictl images -q)
