
### Lab: Install Software and work with package module streams

Create a yum repo file located at /etc/yum.repos.d/kodekloud.repo as per details given below:


short name: KodeKloud

long name: KodeKloud - $basearch

baseurl: https://repos.kodekloud.com/linux/$releasever/$basearch/development


Also make sure it is set to be enabled.


Note: You do not have to include any gpgcheck or gpgkey settings.

## SOLN
sudo vi /etc/yum.repos.d/kodekloud.repo


[KodeKloud]
name=KodeKloud - $basearch
baseurl=https://repos.kodekloud.com/linux/$releasever/$basearch/development
enabled=1

### groups list repo
Using the correct command, display all of the possible package groups, including those that are hidden, and save the output to the file /home/bob/allgroups.txt.

# Solm

sudo yum group list --hidden > /home/bob/allgroups.txt

####

6 / 7
Using the correct command, display the available module streams for php. Save the output in the file /home/bob/php.txt

sudo yum module list php >/home/bob/php.txt



# Networking

## Our system uses dynamic network configuration. Leave it as it is, dynamically configured, but add an extra IP to eth1 interface on this system: 10.0.0.50/24. If needed, use the proper command to reapply network settings after you make your modifications.

sudo ip a add 10.0.0.50/24 dev eth1


sudo nmcli device reapply eth1

## Identify the transient hostname of this system and save the value in /home/bob/t-hostname file.


hostnamectl



-----------

Now, permanently route all traffic that must reach the 192.168.0.* network through the device that has the IP 172.28.128.100


Also tell the NetworkManager to immediately apply the network settings we just changed.



timedatectl set-loc-rtc true
___________________________________________________________________________________________
[bob@centos-host ~]$ sudo nmcli connection modify 'eth1' +ipv4.routes "192.168.0.0/24 172.28.128.100"
[bob@centos-host ~]$ sudo nmcli connection up 'eth1'
Connection successfully activated (D-Bus active path: /org/freedesktop/NetworkManager/ActiveConnection/5)
[bob@centos-host ~]$ sudo nmcli connection reload

___________________________________________________________________________

Delete the route you just created in the previous question to permanently route all traffic that must reach the 192.168.0.* network through the device that has the IP 172.28.128.100


Also tell the NetworkManager to immediately apply the network settings we just changed.

______________________________________________

[bob@centos-host ~]$ sudo ip addr del 192.168.0.0/24 via 172.28.128.100
Error: either "local" is duplicate, or "via" is a garbage.
[bob@centos-host ~]$ sudo nmcli connection modify 'eth1' -ipv4.routes "192.1
68.0.0/24  172.28.128.100"
[bob@centos-host ~]$ sudo nmcli device reapply eth1
Connection successfully reapplied to device 'eth1'.

# USER MANAGEMENT
1. Add the user jane to the group called developers.

sudo usermod -e 2030-03-01 jane


2. Create a system account called apachedev


sudo useradd --system apachedev


Usage: useradd [options] LOGIN
       useradd -D
       useradd -D [options]

Options:
      --badname                 do not check for bad names
  -b, --base-dir BASE_DIR       base directory for the home directory of the
                                new account
      --btrfs-subvolume-home    use BTRFS subvolume for home directory
  -c, --comment COMMENT         GECOS field of the new account
  -d, --home-dir HOME_DIR       home directory of the new account
  -D, --defaults                print or change default useradd configuration
  -e, --expiredate EXPIRE_DATE  expiration date of the new account
  -f, --inactive INACTIVE       password inactivity period of the new account
  -g, --gid GROUP               name or ID of the primary group of the new
                                account
  -G, --groups GROUPS           list of supplementary groups of the new
                                account
  -h, --help                    display this help message and exit
  -k, --skel SKEL_DIR           use this alternative skeleton directory
  -K, --key KEY=VALUE           override /etc/login.defs defaults
  -l, --no-log-init             do not add the user to the lastlog and
                                faillog databases
  -m, --create-home             create the user's home directory
  -M, --no-create-home          do not create the user's home directory
  -N, --no-user-group           do not create a group with the same name as
                                the user
  -o, --non-unique              allow to create users with duplicate
                                (non-unique) UID
  -p, --password PASSWORD       encrypted password of the new account
  -r, --system                  create a system account
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
  -s, --shell SHELL             login shell of the new account
  -u, --uid UID                 user ID of the new account
  -U, --user-group              create a group with the same name as the user
  -Z, --selinux-user SEUSER     use a specific SEUSER for the SELinux user mapping

chage: unrecognized option '--lock'
Usage: chage [options] LOGIN


groupadd --help
Usage: groupadd [options] GROUP

Options:
  -f, --force                   exit successfully if the group already exists,
                                and cancel -g if the GID is already used
  -g, --gid GID                 use GID for the new group
  -h, --help                    display this help message and exit
  -K, --key KEY=VALUE           override /etc/login.defs defaults
  -o, --non-unique              allow to create groups with duplicate
                                (non-unique) GID
  -p, --password PASSWORD       use this encrypted password for the new group
  -r, --system                  create a system account
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DI        directory prefix
  -U, --users USERS             list of user members of this group

usermod 

Options:
  -d, --lastday LAST_DAY        set date of last password change to LAST_DAY
  -E, --expiredate EXPIRE_DATE  set account expiration date to EXPIRE_DATE
  -h, --help                    display this help message and exit
  -i, --iso8601                 use YYYY-MM-DD when printing dates
  -I, --inactive INACTIVE       set password inactive after expiration
                                to INACTIVE
  -l, --list                    show account aging information
  -m, --mindays MIN_DAYS        set minimum number of days before password
                                change to MIN_DAYS
  -M, --maxdays MAX_DAYS        set maximum number of days before password
                                change to MAX_DAYS
  -R, --root CHROOT_DIR         directory to chroot into
  -W, --warndays WARN_DAYS      set expiration warning days to WARN_DAYS


Usage: usermod [options] LOGIN

Options:
  -b, --badname                 allow bad names
  -c, --comment COMMENT         new value of the GECOS field
  -d, --home HOME_DIR           new home directory for the user account
  -e, --expiredate EXPIRE_DATE  set account expiration date to EXPIRE_DATE
  -f, --inactive INACTIVE       set password inactive after expiration
                                to INACTIVE
  -g, --gid GROUP               force use GROUP as new primary group
  -G, --groups GROUPS           new list of supplementary GROUPS
  -a, --append                  append the user to the supplemental GROUPS
                                mentioned by the -G option without removing
                                the user from other groups
  -h, --help                    display this help message and exit
  -l, --login NEW_LOGIN         new value of the login name
  -L, --lock                    lock the user account
  -m, --move-home               move contents of the home directory to the
                                new location (use only with -d)
  -o, --non-unique              allow using duplicate (non-unique) UID
  -p, --password PASSWORD       use encrypted password for the new password
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
  -s, --shell SHELL             new login shell for the user account
  -u, --uid UID                 new UID for the user account
  -U, --unlock                  unlock the user account
  -v, --add-subuids FIRST-LAST  add range of subordinate uids
  -V, --del-subuids FIRST-LAST  remove range of subordinate uids
  -w, --add-subgids FIRST-LAST  add range of subordinate gids
  -W, --del-subgids FIRST-LAST  remove range of subordinate gids
  -Z, --selinux-user SEUSER     new SELinux user mapping for the user account

[bob@centos-host ~]$ ^C
[bob@centos-host ~]$ sudo useradd --help
Usage: useradd [options] LOGIN
       useradd -D
       useradd -D [options]

Options:
      --badname                 do not check for bad names
  -b, --base-dir BASE_DIR       base directory for the home directory of the
                                new account
      --btrfs-subvolume-home    use BTRFS subvolume for home directory
  -c, --comment COMMENT         GECOS field of the new account
  -d, --home-dir HOME_DIR       home directory of the new account
  -D, --defaults                print or change default useradd configuration
  -e, --expiredate EXPIRE_DATE  expiration date of the new account
  -f, --inactive INACTIVE       password inactivity period of the new account
  -g, --gid GROUP               name or ID of the primary group of the new
                                account
  -G, --groups GROUPS           list of supplementary groups of the new
                                account
  -h, --help                    display this help message and exit
  -k, --skel SKEL_DIR           use this alternative skeleton directory
  -K, --key KEY=VALUE           override /etc/login.defs defaults
  -l, --no-log-init             do not add the user to the lastlog and
                                faillog databases
  -m, --create-home             create the user's home directory
  -M, --no-create-home          do not create the user's home directory
  -N, --no-user-group           do not create a group with the same name as
                                the user
  -o, --non-unique              allow to create users with duplicate
                                (non-unique) UID
  -p, --password PASSWORD       encrypted password of the new account
  -r, --system                  create a system account
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
  -s, --shell SHELL             login shell of the new account
  -u, --uid UID                 user ID of the new account
  -U, --user-group              create a group with the same name as the user
  -Z, --selinux-user SEUSER     use a specific SEUSER for the SELinux user mapping

3. Jane's account i.e jane is expired.Unexpire the same and make sure it never expires again.

sudo usermod -e "" jane

usermod
-r: for deleting all directories and shell

force someone to login with password to expire 

sudo chage --lastday 0 jane
[bob@centos-host ~]$ chage --help
Usage: chage [options] LOGIN

Options:
  -d, --lastday LAST_DAY        set date of last password change to LAST_DAY
  -E, --expiredate EXPIRE_DATE  set account expiration date to EXPIRE_DATE
  -h, --help                    display this help message and exit
  -i, --iso8601                 use YYYY-MM-DD when printing dates
  -I, --inactive INACTIVE       set password inactive after expiration
                                to INACTIVE
  -l, --list                    show account aging information
  -m, --mindays MIN_DAYS        set minimum number of days before password
                                change to MIN_DAYS
  -M, --maxdays MAX_DAYS        set maximum number of days before password
                                change to MAX_DAYS
  -R, --root CHROOT_DIR         directory to chroot into
  -W, --warndays WARN_DAYS      set expiration warning days to WARN_DAYS

moving soemone into a group:

sudo usermod -a -G developers jane


Usage: usermod [options] LOGIN

Options:
  -b, --badname                 allow bad names
  -c, --comment COMMENT         new value of the GECOS field
  -d, --home HOME_DIR           new home directory for the user account
  -e, --expiredate EXPIRE_DATE  set account expiration date to EXPIRE_DATE
  -f, --inactive INACTIVE       set password inactive after expiration
                                to INACTIVE
  -g, --gid GROUP               force use GROUP as new primary group
  -G, --groups GROUPS           new list of supplementary GROUPS
  -a, --append                  append the user to the supplemental GROUPS
                                mentioned by the -G option without removing
                                the user from other groups
  -h, --help                    display this help message and exit
  -l, --login NEW_LOGIN         new value of the login name
  -L, --lock                    lock the user account
  -m, --move-home               move contents of the home directory to the
                                new location (use only with -d)
  -o, --non-unique              allow using duplicate (non-unique) UID
  -p, --password PASSWORD       use encrypted password for the new password
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
  -s, --shell SHELL             new login shell for the user account
  -u, --uid UID                 new UID for the user account
  -U, --unlock                  unlock the user account
  -v, --add-subuids FIRST-LAST  add range of subordinate uids
  -V, --del-subuids FIRST-LAST  remove range of subordinate uids
  -w, --add-subgids FIRST-LAST  add range of subordinate gids
  -W, --del-subgids FIRST-LAST  remove range of subordinate gids
  -Z, --selinux-user SEUSER     new SELinux user mapping for the user account

Make sure the user jane gets a warning at least 2 days before the password expires.

sudo chage -W 2 jane
Usage: chage [options] LOGIN

Options:
  -d, --lastday LAST_DAY        set date of last password change to LAST_DAY
  -E, --expiredate EXPIRE_DATE  set account expiration date to EXPIRE_DATE
  -h, --help                    display this help message and exit
  -i, --iso8601                 use YYYY-MM-DD when printing dates
  -I, --inactive INACTIVE       set password inactive after expiration
                                to INACTIVE
  -l, --list                    show account aging information
  -m, --mindays MIN_DAYS        set minimum number of days before password
                                change to MIN_DAYS
  -M, --maxdays MAX_DAYS        set maximum number of days before password
                                change to MAX_DAYS
  -R, --root CHROOT_DIR         directory to chroot into
  -W, --warndays WARN_DAYS 



  Usage: groupdel [options] GROUP

Options:
  -h, --help                    display this help message and exit
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
  -f, --force                   delete group even if it is the primary group of a user


### Restrict the root access to SSH service via PAM


### You can use the pam_listfile.so module which offers great flexibility in limiting the privileges of specific accounts. Please make sure you don't restrict the root SSH access from the SSH configuration.




sudo vi /etc/pam.d/sshd


auth    required       pam_listfile.so onerr=succeed  item=user  sense=deny  file=/etc/ssh/deniedusers

sudo vi /etc/ssh/deniedusers


root

# MANAGE SECURITY



<!-- Configure key-based authentication -->
<!-- for ssh client -->
sudo vim /etc/ssh/ssh_config

<!-- for ssh server -->
sudo vim /etc/ssh/sshd_config

<!-- changing port  -->

find word Port

<!-- changing the password  -->

AddressFamily: allow filtering of IP to allow connection

AddressFamily inet
ListenAddress 10.11.12.9


PermitRootLogin

PassAuthentication 



<!-- to relaod and apply changes -->


sudo systemctl reload sshd.service



<!-- Clients keeps in .ssh -->


<!-- creating manuall -->

man ssh_config



ssh aaron@10.11.12.9


vim .ssh/config

>>
Host centos 
    HostName [IP]
    Port 22
    User aaron




chmod 600 .ssh/config

ssh centos

cd .ssh/authorized_keys

copy id_rsa.pub

add it to in the server
vim .ssh/authorized_keys



chmod 600 authorized_keys

ssh-keygen -R 10.11.12.9

rm known_hosts


ssh aaron@10.11.12.9


sudo vim /tc/ssh/ssh_config



<!-- List and identify SE Linux -->

enabled bydefault in centOs


see SE linux by:

ls -Z

[user]       role      type      level
uconfined_u:object_r:user_home_t:s0



Note:
1. Only certain users can enter certain roles and certain types
2. It lets autjorized users and processes do their job, nu franting the permissions they need 
3.  Authoruzed users and processes are allowed to take only a limited set of actions
4. Everything else is denied


it protect against haijacking


SELinux Context 

find all SE linux process:

ps axZ

ls -Z /usr/sbin/sshd

id -Z


To see how the mapping is done:

sudo semanage login -l

see the roles for each user:

sudo semanage user -l

getenforce 



Change Kernel runtime params persistent and non-persistent

show params :

systcl -a

sudo systcl -a 




man sysctl.d

sysctl -a | grep vm

sudo vim /etc/sysctl.d/swap-less.conf

sudo sysctl -p /etc/sysctl.d/swap-less.conf




<!-- Restore default file contexts -->
add to grub screen 

enforcing=0
selinux=0

-----------------------------
sudo yum install httpd 

Look for the config file for apache:
sudo ci /etc/httpd/conf/httpd.conf

Search for : /Listen


start hhtpd.service

check the status
and if there's the permission denied

to see more verbose detailed messages

$ journalctl -xe 



check for commands recommendations
to follow instructions


systemctl start httpd.service
systemctl status httpd.service


curl [IP]

another common thing for SE Linux



vi /etc/httpd/conf/


search for document root

Documents 

mkdir /kodekloud

ls /kodekloud
echo "KodeKloud" > /kodekckloud/kodekloud.html
ls /kodekloud
cat /kodekloud/kodekloud.html

restart httpd.service


curl [IP]




grub screen

e for edit

ctrl+E 

to boot into permissive boot:

enforcing=0

to not load any selinux

selinux=0

/autorelabel file

Which GRUB command line option will force the system to perform an SELinux autorelabel
autorelable=1
___________________________________________________________________________________
sudo yum install httpd


sudo vi /et/httpd/httpd.config


change port 
find Listen
Listen [portnumber]

systemctl start

sudo systemct status httpd.service

for more verbose output :


sudo journalctl -xe

systemctl start httpd.service 

% restore default file context 
to serve pages outside from the default location
by default 
:q!

DocymentRoot "/var/www/html"

try changing DocumentRoot

search for DocumentRoot "/kodekloud"

makr kodeckloud dir

mkdir /kodekloud
ls /kodekloud
echo "KodeKloud" > /kodekloud.html

systemctl restart httpd.service

curl 127.0.0.1/kodekloud.html





SELinux error



grep "httpd" /var/log/messages | less

see attr:

ls -laZ KodeKloud


semanage fcontexr httpd_sys_content_t "/kodekloud(/.*)?"

to restore context

restorecon -R /kodekloud/

curl 127.0.0.1/kodekloud.html


# Manage and configure containers 


MariaDB in a container 

Install Docker 

sudo dnf install Docker 


sudo vim /etc/containers/registries.conf

find unqualified -search-registries and uncomment

add 

unqualified-search-registries=docker.io


to the terminal:

$ docker

$ sudo touch /etc/container/docker

install webserver nginx :

docker --help

docker search nginx


docker pull docker.io/library/nginx


pulling older nginx:

docker pull ngimx:1.20.2


check image:

docker images


delete older image:

docker rmi nginx:1.20.2


docker rmi docker.io/library/nginx2.0


see docker images:

docker images

rmove using image id:

docker rmi [ID]

run images:

docker run nginx





start existing images:

docker start [image]


detach input or ouput:

docker run --deatach nginx

docker run -d nginx

see processes and container:


docker ps


docker container list

stopping running images:

docker stop insteresting_mccLock

see what we stop

docker ps --all

deleting container:


docker rm trusting_rhodes

starting:


docker start interesting-mcclintock

can't delete images that are used by the container we can force :

docker rmi --force nginx

we can also stop and rmove


starting and adding name to container

docker run -d -p 8080:80 --name mywebserver nginx

check if container wirks
nc localhost 8080

inside of it :

GET /
-------------------------------------------------------------------------------

Emulate Docker CLI using podman. Create /etc/containers/nodocker to quiet msg.
Manage pods, containers and images

Usage:
  podman [options] [command]

Available Commands:
  artifact    Manage OCI artifacts
  attach      Attach to a running container
  auto-update Auto update containers according to their auto-update policy
  build       Build an image using instructions from Containerfiles
  commit      Create new image based on the changed container
  compose     Run compose workloads via an external provider such as docker-compose or podman-compose
  container   Manage containers
  cp          Copy files/folders between a container and the local filesystem
  create      Create but do not start a container
  diff        Display the changes to the object's file system
  events      Show podman system events
  exec        Run a process in a running container
  export      Export container's filesystem contents as a tar archive
  farm        Farm out builds to remote machines
  generate    Generate structured data based on containers, pods or volumes
  healthcheck Manage health checks on containers
  help        Help about any command
  history     Show history of a specified image
  image       Manage images
  images      List images in local storage
  import      Import a tarball to create a filesystem image
  info        Display podman system information
  init        Initialize one or more containers
  inspect     Display the configuration of object denoted by ID
  kill        Kill one or more running containers with a specific signal
  kube        Play containers, pods or volumes from a structured file
  load        Load image(s) from a tar archive
  login       Log in to a container registry
  logout      Log out of a container registry
  logs        Fetch the logs of one or more containers
  machine     Manage a virtual machine
  manifest    Manipulate manifest lists and image indexes
  mount       Mount a working container's root filesystem
  network     Manage networks
  pause       Pause all the processes in one or more containers
  pod         Manage pods
  port        List port mappings or a specific mapping for the container
  ps          List containers
  pull        Pull an image from a registry
  push        Push an image to a specified destination
  rename      Rename an existing container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images from local storage
  run         Run a command in a new container
  save        Save image(s) to an archive
  search      Search registry for image
  secret      Manage secrets
  start       Start one or more containers
  stats       Display a live stream of container resource usage statistics
  stop        Stop one or more containers
  system      Manage podman
  tag         Add an additional name to a local image
  top         Display the running processes of a container
  unmount     Unmount working container's root filesystem
  unpause     Unpause the processes in one or more containers
  unshare     Run a command in a modified user namespace
  untag       Remove a name from a local image
  update      Update an existing container
  version     Display the Podman version information
  volume      Manage volumes
  wait        Block on one or more containers

Options:
      --cdi-spec-dir stringArray    Set the CDI spec directory path (may be set multiple times) (default [/etc/cdi])
      --cgroup-manager string       Cgroup manager to use ("cgroupfs"|"systemd") (default "systemd")
      --config string               Path to directory containing authentication config file
      --conmon string               Path of the conmon binary
  -c, --connection string           Connection to use for remote Podman service (CONTAINER_CONNECTION)
      --events-backend string       Events backend to use ("file"|"journald"|"none") (default "file")
      --help                        Help for podman
      --hooks-dir stringArray       Set the OCI hooks directory path (may be set multiple times) (default [/usr/share/containers/oci/hooks.d])
      --identity string             path to SSH identity file, (CONTAINER_SSHKEY)
      --imagestore string           Path to the 'image store', different from 'graph root', use this to split storing the image into a separate 'image store', see 'man containers-storage.conf' for details
      --log-level string            Log messages above specified level (trace, debug, info, warn, warning, error, fatal, panic) (default "warn")
      --module stringArray          Load the containers.conf(5) module
      --network-cmd-path string     Path to the command for configuring the network
      --network-config-dir string   Path of the configuration directory for networks
      --out string                  Send output (stdout) from podman to a file
  -r, --remote                      Access remote Podman service
      --root string                 Path to the graph root directory where images, containers, etc. are stored
      --runroot string              Path to the 'run directory' where all state information is stored
      --runtime string              Path to the OCI-compatible binary used to run containers. (default "crun")
      --runtime-flag stringArray    add global flags for the container runtime
      --ssh string                  define the ssh mode (default "golang")
      --storage-driver string       Select which storage driver is used to manage storage of images and containers
      --storage-opt stringArray     Used to pass an option to the storage driver
      --syslog                      Output logging information to syslog as well as the console (default false)
      --tmpdir string               Path to the tmp directory for libpod state content.
                                    
                                    Note: use the environment variable 'TMPDIR' to change the temporary storage location for container images, '/var/tmp'.
                                     (default "/tmp/storage-run-1002/libpod/tmp")
      --transient-store             Enable transient container storage
      --url string                  URL to access Podman service (CONTAINER_HOST) (default "unix:///tmp/storage-run-1002/podman/podman.sock")
  -v, --version                     version for podman
      --volumepath string           Path to the volume directory in which volume data is stored

















------------------------------------

sudo docker run -d -p 80:80 --name mywebserver nginx


docker container --help



Container Management with Skopeo

Installing Skopeo

sudo yum install skopeo



Skopeo can be used to instpect repositories to get usefull informations about them


skopeo don't pull images so it doesn't use disk


skopeo inspects contaners:


skopeo inspect --config docer:registry.fedoraproject.org/fedora:latest | jq


Copying Images between different storages

remote to registry

skopeo copy [source] [distination]

deleting image

skopeo delete [img]

skopeo sync --src docker --dest dir registry.kodekloud.com/busybox /media/usb


Man resource

man skopeo


% Configure a container to start automatically as a systemd service and attach persistent storage


switch module streams 

% reset tools:

sudo yum module reset container-tools

% installing tools

sudo yum module install container-tools:3.0


% running on a regular user:


mkdir -p ~/.config/systemd/user


mkdir ~/container_storage

ls ~/.config/systemd

echo "KodeKloud"  > ~/container_storage/kodekloud.html

cat container_storage/kodekloud.html



podman run -d --name container_service -p 1025:8080 -v ~/container_storage:/var/ww/htm:Z registry.access.redhat.com/rhscl/httpd-24-rhel7



-p: port above 1024

-v: volume


curl 127.0.0.1:1025/kodeklouf.html

cd ~/.config/systemd/user/

pwd

podman generate systemd --name container_service --files --new 

ls

less container-container_service.service

podman kill container_service

sudo podman images
sudo podman ps -a
sudo podman stop $CONTAINER_ID
sudo podman rm $CONTAINER_ID
sudo podman rmi IMAGE_ID
sudo podman rmi IMAGED_ID -f


% Make sure users can use the service:
#### Configure a container to start automatically as a systemd service and attach persistent storage


loginctl enable-linger 


systemctl --user daemon-reload

start container and enable it to boot time:

systemctl --user enable --now container-container_service.service


sudo systemctl reboot


% verify via curel

curl 127.0.0.1:1025/kodekloud.html






Use podman to create a rootless systemd service for the kodekloud container. Make sure the service file is stored in the correct directory.


cd ~/.config/systemd/user
sudo podman generate systemd --name kodekloud --files --new



--------------------------------------------------------------------------





### Using the correct commands, make sure the current user is configured to launch rootless systemd services, and that systemd is aware of this change in the current session. Next, make sure the kodekloud container service is set to launch as a rootless systemd service at boot.


loginctl enable-linger bob
export XDG_RUNTIME_DIR=/run/user/$(id -u)
systemctl --user daemon-reload
systemctl --user enable container-kodekloud.service --now