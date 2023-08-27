useradd stack
usermod -aG wheel stack
usermod --append --groups wheel stack

# set password
usermod -p stack stack

echo -e "stack\tALL=(ALL)\tNOPASSWD: ALL" > /etc/sudoers.d/stack

# cat /etc/suders.d/020_my_sudo
# stack ALL=(ALL) NOPASSWD: ALL
