## 13.
允许pod ip和 指定mac绑定
openstack port set --allowed-address \
  ip_address=<ip_address>,mac_address=<mac_address> <neutron_port_uuid>

