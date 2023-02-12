#!/bin/bash
dir="/etc/VPS-MX"
SCPfrm="${dir}/herramientas" && [[ ! -d ${SCPfrm} ]] && exit
SCPinst="${dir}/protocolos" && [[ ! -d ${SCPinst} ]] && exit
[[ ! -d /usr/local/megat ]] && exit
mportas() {
    unset portas
    portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" | grep -v "COMMAND" | grep "LISTEN")
    while read port; do
        var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
        [[ "$(echo -e $portas | grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
    done <<<"$portas_var"
    i=1
    echo -e "$portas"
}

fun_ip() {
    MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
    MIP2=$(wget -qO- ifconfig.me)
    [[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

[[ ! -d /etc/VPS-MX/wireguard ]] && mkdir /etc/VPS-MX/wireguard
# Detect Debian users running the script with "sh" instead of bash
if readlink /proc/$$/exe | grep -q "dash"; then
    echo 'Este instalador debe ejecutarse con "bash", no con "sh".'
    exit
fi

# Discard stdin. Needed when running from an one-liner which includes a newline
read -N 999999 -t 0.001

# Detect OpenVZ 6
if [[ $(uname -r | cut -d "." -f 1) -eq 2 ]]; then
    echo "El sistema está ejecutando un kernel antiguo, que es incompatible con este instalador"
    exit
fi

# Detect OS
# $os_version variables aren't always in use, but are kept here for convenience
if grep -qs "ubuntu" /etc/os-release; then
    os="ubuntu"
    os_version=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2 | tr -d '.')
elif [[ -e /etc/debian_version ]]; then
    os="debian"
    os_version=$(grep -oE '[0-9]+' /etc/debian_version | head -1)
elif [[ -e /etc/centos-release ]]; then
    os="centos"
    os_version=$(grep -oE '[0-9]+' /etc/centos-release | head -1)
elif [[ -e /etc/fedora-release ]]; then
    os="fedora"
    os_version=$(grep -oE '[0-9]+' /etc/fedora-release | head -1)
else
    echo "Este instalador parece estar ejecutándose en una distribución no compatible. Las distribuciones compatibles son Ubuntu, Debian, CentOS y Fedora"
    exit
fi

if [[ "$os" == "ubuntu" && "$os_version" -lt 1804 ]]; then
    echo "Se requiere Ubuntu 18.04 o superior para usar este instalador. Esta versión de Ubuntu es demasiado antigua y no es compatible"
    exit
fi

if [[ "$os" == "debian" && "$os_version" -lt 9 ]]; then
    echo "Se requiere Debian 9+ o superior para usar este instalador. Esta versión de Debian es demasiado antigua y no tiene soporte"
    exit
fi

if [[ "$os" == "centos" && "$os_version" -lt 7 ]]; then
    echo "CentOS 7 or higher is required to use this installer. This version of CentOS is too old and unsupported."
    exit
fi

# Detect environments where $PATH does not include the sbin directories
if ! grep -q sbin <<<"$PATH"; then
    echo '$PATH no incluye sen. Intenta usar "su -" en lugar de "su".'
    exit
fi

systemd-detect-virt -cq
is_container="$?"

if [[ "$os" == "fedora" && "$os_version" -eq 31 && $(uname -r | cut -d "." -f 2) -lt 6 && ! "$is_container" -eq 0 ]]; then
    echo 'Fedora 31 is supported, but the kernel is outdated. Upgrade the kernel using "dnf upgrade kernel" and restart.'
    exit
fi

if [[ "$EUID" -ne 0 ]]; then
    echo "Este instalador debe ejecutarse con privilegios de superusuario"
    exit
fi

if [[ "$is_container" -eq 0 ]]; then
    if [ "$(uname -m)" != "x86_64" ]; then
        echo "En sistemas en contenedores, este instalador solo admite la arquitectura x86_64. El sistema se ejecuta en $(uname -m) y no es compatible"
        exit
    fi
    # TUN device is required to use BoringTun if running inside a container
    if [[ ! -e /dev/net/tun ]] || ! (exec 7<>/dev/net/tun) 2>/dev/null; then
        echo "El sistema no tiene disponible el dispositivo TUN. TUN debe estar habilitado antes de ejecutar este instalador"
        exit
    fi
fi

function setup_environment() {
    ### define colors ###
    lightred=$'\033[1;31m'    # light red
    red=$'\033[0;31m'         # red
    lightgreen=$'\033[1;32m'  # light green
    green=$'\033[0;32m'       # green
    lightblue=$'\033[1;34m'   # light blue
    blue=$'\033[0;34m'        # blue
    lightpurple=$'\033[1;35m' # light purple
    purple=$'\033[0;35m'      # purple
    lightcyan=$'\033[1;36m'   # light cyan
    cyan=$'\033[0;36m'        # cyan
    lightgray=$'\033[0;37m'   # light gray
    white=$'\033[1;37m'       # white
    brown=$'\033[0;33m'       # brown
    yellow=$'\033[1;33m'      # yellow
    darkgray=$'\033[1;30m'    # dark gray
    black=$'\033[0;30m'       # black
    nocolor=$'\e[0m'          # no color

    echo -e -n "${lightred}"
    echo -e -n "${red}"
    echo -e -n "${lightgreen}"
    echo -e -n "${green}"
    echo -e -n "${lightblue}"
    echo -e -n "${blue}"
    echo -e -n "${lightpurple}"
    echo -e -n "${purple}"
    echo -e -n "${lightcyan}"
    echo -e -n "${cyan}"
    echo -e -n "${lightgray}"
    echo -e -n "${white}"
    echo -e -n "${brown}"
    echo -e -n "${yellow}"
    echo -e -n "${darkgray}"
    echo -e -n "${black}"
    echo -e -n "${nocolor}"
    clear

    # Set Vars
    LOGFILE='/var/log/wireguardSH.log'
}

new_client_dns() {
    echo -e -n "${lightgreen}"
    echo "Seleccione un servidor DNS para el cliente"
    echo "   1) DNS DEFAULT del sistema actual"
    echo "   2) Google"
    echo "   3) 1.1.1.1"
    echo "   4) OpenDNS"
    echo "   5) Quad9"
    echo "   6) AdGuard"
    echo -e -n "${nocolor}"
    read -p "DNS server [1]: " dns
    until [[ -z "$dns" || "$dns" =~ ^[1-6]$ ]]; do
        echo -e -n "${red}"
        echo "$dns: invalid selection."
        echo -e -n "${green}"
        read -p "DNS server [1]: " dns
    done
    # DNS
    case "$dns" in
    1 | "")
        # Locate the proper resolv.conf
        # Needed for systems running systemd-resolved
        if grep -q '^nameserver 127.0.0.53' "/etc/resolv.conf"; then
            resolv_conf="/run/systemd/resolve/resolv.conf"
        else
            resolv_conf="/etc/resolv.conf"
        fi
        # Extract nameservers and provide them in the required format
        dns=$(grep -v '^#\|^;' "$resolv_conf" | grep '^nameserver' | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | xargs | sed -e 's/ /, /g')
        ;;
    2)
        dns="8.8.8.8, 8.8.4.4"
        ;;
    3)
        dns="1.1.1.1, 1.0.0.1"
        ;;
    4)
        dns="208.67.222.222, 208.67.220.220"
        ;;
    5)
        dns="9.9.9.9, 149.112.112.112"
        ;;
    6)
        dns="94.140.14.14, 94.140.15.15"
        ;;
    esac
}

new_client_setup() {
    # Given a list of the assigned internal IPv4 addresses, obtain the lowest still
    # available octet. Important to start looking at 2, because 1 is our gateway.
    octet=2
    while grep AllowedIPs /etc/wireguard/wg0.conf | cut -d "." -f 4 | cut -d "/" -f 1 | grep -q "$octet"; do
        ((octet++))
    done
    # Don't break the WireGuard configuration in case the address space is full
    if [[ "$octet" -eq 255 ]]; then
        echo "253 clients are already configured. The WireGuard internal subnet is full!"
        exit
    fi
    key=$(wg genkey)
    psk=$(wg genpsk)
    # Configure client in the server
    cat <<EOF >>/etc/wireguard/wg0.conf
# BEGIN_PEER $client
[Peer]
PublicKey = $(wg pubkey <<<$key)
PresharedKey = $psk
AllowedIPs = 10.7.0.$octet/32$(grep -q 'fddd:2c4:2c4:2c4::1' /etc/wireguard/wg0.conf && echo ", fddd:2c4:2c4:2c4::$octet/128")
# END_PEER $client
EOF
    # Create client configuration
    cat <<EOF >/etc/VPS-MX/wireguard/"$client".conf
[Interface]
Address = 10.7.0.$octet/24$(grep -q 'fddd:2c4:2c4:2c4::1' /etc/wireguard/wg0.conf && echo ", fddd:2c4:2c4:2c4::$octet/64")
DNS = $dns
PrivateKey = $key

[Peer]
PublicKey = $(grep PrivateKey /etc/wireguard/wg0.conf | cut -d " " -f 3 | wg pubkey)
PresharedKey = $psk
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = $(grep '^# ENDPOINT' /etc/wireguard/wg0.conf | cut -d " " -f 3):$(grep ListenPort /etc/wireguard/wg0.conf | cut -d " " -f 3)
PersistentKeepalive = 25
EOF
}

setup_environment

install() {
    echo -e -n "${green}"
    # If system has a single IPv4, it is selected automatically. Else, ask the user
    if [[ $(ip -4 addr | grep inet | grep -vEc '127(\.[0-9]{1,3}){3}') -eq 1 ]]; then
        ip=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}')
    else
        number_of_ip=$(ip -4 addr | grep inet | grep -vEc '127(\.[0-9]{1,3}){3}')
        echo
        echo -e -n "${lightgreen}"
        echo "¿Qué dirección IPv4 se debe usar?"
        ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | nl -s ') '
        read -p "IPv4 address [1]: " ip_number
        until [[ -z "$ip_number" || "$ip_number" =~ ^[0-9]+$ && "$ip_number" -le "$number_of_ip" ]]; do
            echo -e -n "${red}"
            echo "$ip_number: invalid selection."
            read -p "IPv4 address [1]: " ip_number
            echo -e -n "${green}"
        done
        [[ -z "$ip_number" ]] && ip_number="1"
        ip=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | sed -n "$ip_number"p)
    fi
    # If $ip is a private IP address, the server must be behind NAT
    if echo "$ip" | grep -qE '^(10\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.|192\.168)'; then
        echo
        echo -e -n "${lightgreen}"
        echo "Este servidor está detrás de NAT. ¿Cuál es la dirección IPv4 pública o el nombre de host?"
        # Get public IP and sanitize with grep
        get_public_ip=$(grep -m 1 -oE '^[0-9]{1,3}(\.[0-9]{1,3}){3}$' <<<"$(wget -T 10 -t 1 -4qO- "http://ip1.dynupdate.no-ip.com/" || curl -m 10 -4Ls "http://ip1.dynupdate.no-ip.com/")")
        read -p "Public IPv4 address / hostname [$get_public_ip]: " public_ip
        # If the checkip service is unavailable and user didn't provide input, ask again
        until [[ -n "$get_public_ip" || -n "$public_ip" ]]; do
            echo -e -n "${red}"
            echo "Invalid input."
            read -p "Public IPv4 address / hostname: " public_ip
            echo -e -n "${green}"
        done
        [[ -z "$public_ip" ]] && public_ip="$get_public_ip"
    fi
    # If system has a single IPv6, it is selected automatically
    if [[ $(ip -6 addr | grep -c 'inet6 [23]') -eq 1 ]]; then
        ip6=$(ip -6 addr | grep 'inet6 [23]' | cut -d '/' -f 1 | grep -oE '([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}')
    fi
    # If system has multiple IPv6, ask the user to select one
    if [[ $(ip -6 addr | grep -c 'inet6 [23]') -gt 1 ]]; then
        number_of_ip6=$(ip -6 addr | grep -c 'inet6 [23]')
        echo
        echo -e -n "${lightgreen}"
        echo "Which IPv6 address should be used?"
        ip -6 addr | grep 'inet6 [23]' | cut -d '/' -f 1 | grep -oE '([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}' | nl -s ') '
        read -p "IPv6 address [1]: " ip6_number
        until [[ -z "$ip6_number" || "$ip6_number" =~ ^[0-9]+$ && "$ip6_number" -le "$number_of_ip6" ]]; do
            echo -e -n "${red}"
            echo "$ip6_number: invalid selection."
            read -p "IPv6 address [1]: " ip6_number
            echo -e -n "${green}"
        done
        [[ -z "$ip6_number" ]] && ip6_number="1"
        ip6=$(ip -6 addr | grep 'inet6 [23]' | cut -d '/' -f 1 | grep -oE '([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}' | sed -n "$ip6_number"p)
    fi
    echo
    echo -e -n "${lightgreen}"
    echo " INGRESE UN PUERTO PARA WireGuard"
    #echo -e -n "${nocolor}"
    #read -p "Puerto [51820]: " port
    #until [[ -z "$port" || "$port" =~ ^[0-9]+$ && "$port" -le 65535 ]]; do
    #   echo -e -n "${red}"
    #echo "$port: invalid port."
    #read -p "Puerto [51820]: " port
    #echo -e -n "${green}"
    #done
    while true; do
        echo -ne "\033[1;37m"
        read -p " Puerto [51820]: " port
        echo ""
        [[ $(mportas | grep -w "$port") ]] || break
        echo -e "\033[1;33m Esta puerta está en uso"
        unset port
    done
    [[ -z "$port" ]] && port="51820"
    echo
    echo -e -n "${lightgreen}"
    echo "Introduzca un nombre para el primer cliente: "
    echo -e -n "${nocolor}"
    read -p "Nombre [cliente]: " unsanitized_client
    # Allow a limited set of characters to avoid conflicts
    client=$(sed 's/[^0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]/_/g' <<<"$unsanitized_client")
    [[ -z "$client" ]] && client="client"
    echo
    new_client_dns
    # Set up automatic updates for BoringTun if the user is fine with that
    if [[ "$is_container" -eq 0 ]]; then
        echo
        echo -e -n "${lightgreen}"
        echo "Se instalará BoringTun para configurar WireGuard en el sistema"
        read -p "¿Deberían habilitarse las actualizaciones automáticas para ello? [Y/n]: " boringtun_updates
        until [[ "$boringtun_updates" =~ ^[yYnN]*$ ]]; do
            echo "$remove: invalid selection."
            read -p "Should automatic updates be enabled for it? [Y/n]: " boringtun_updates
        done
        if [[ "$boringtun_updates" =~ ^[yY]*$ ]]; then
            if [[ "$os" == "centos" || "$os" == "fedora" ]]; then
                cron="cronie"
            elif [[ "$os" == "debian" || "$os" == "ubuntu" ]]; then
                cron="cron"
            fi
        fi
        echo -e -n "${nocolor}"
    fi
    echo
    echo -e -n "${lightgreen}"
    echo "La instalación de WireGuard está lista para comenzar"
    echo -e -n "${nocolor}"
    # Install a firewall in the rare case where one is not already available
    if ! systemctl is-active --quiet firewalld.service && ! hash iptables 2>/dev/null; then
        if [[ "$os" == "centos" || "$os" == "fedora" ]]; then
            firewall="firewalld"
            # We don't want to silently enable firewalld, so we give a subtle warning
            # If the user continues, firewalld will be installed and enabled during setup
            echo "También se instalará firewalld, que es necesario para administrar las tablas de enrutamiento"
        elif [[ "$os" == "debian" || "$os" == "ubuntu" ]]; then
            # iptables is way less invasive than firewalld so no warning is given
            firewall="iptables"
        fi
    fi
    echo -e -n "${lightgreen}"
    read -n1 -r -p "Presione enter para continuar..."
    echo -e -n "${nocolor}"
    # Install WireGuard
    # If not running inside a container, set up the WireGuard kernel module
    if [[ ! "$is_container" -eq 0 ]]; then
        if [[ "$os" == "ubuntu" ]]; then
            # Ubuntu
            apt-get update
            apt-get install -y wireguard qrencode $firewall
        elif [[ "$os" == "debian" && "$os_version" -eq 10 ]]; then
            # Debian 10
            if ! grep -qs '^deb .* buster-backports main' /etc/apt/sources.list /etc/apt/sources.list.d/*.list; then
                echo "deb http://deb.debian.org/debian buster-backports main" >>/etc/apt/sources.list
            fi
            apt-get update
            # Try to install kernel headers for the running kernel and avoid a reboot. This
            # can fail, so it's important to run separately from the other apt-get command.
            apt-get install -y linux-headers-"$(uname -r)"
            # There are cleaner ways to find out the $architecture, but we require an
            # specific format for the package name and this approach provides what we need.
            architecture=$(dpkg --get-selections 'linux-image-*-*' | cut -f 1 | grep -oE '[^-]*$' -m 1)
            # linux-headers-$architecture points to the latest headers. We install it
            # because if the system has an outdated kernel, there is no guarantee that old
            # headers were still downloadable and to provide suitable headers for future
            # kernel updates.
            apt-get install -y linux-headers-"$architecture"
            apt-get install -y wireguard qrencode $firewall
        elif [[ "$os" == "debian" && "$os_version" -eq 9 ]]; then
            # Debian 10
            if ! grep -qs '^deb .* stretch-backports main' /etc/apt/sources.list /etc/apt/sources.list.d/*.list; then
                echo "deb http://deb.debian.org/debian stretch-backports main" >>/etc/apt/sources.list
            fi
            apt-get update
            # Try to install kernel headers for the running kernel and avoid a reboot. This
            # can fail, so it's important to run separately from the other apt-get command.
            apt-get install -y linux-headers-"$(uname -r)"
            # There are cleaner ways to find out the $architecture, but we require an
            # specific format for the package name and this approach provides what we need.
            architecture=$(dpkg --get-selections 'linux-image-*-*' | cut -f 1 | grep -oE '[^-]*$' -m 1)
            # linux-headers-$architecture points to the latest headers. We install it
            # because if the system has an outdated kernel, there is no guarantee that old
            # headers were still downloadable and to provide suitable headers for future
            # kernel updates.
            apt-get install -y linux-headers-"$architecture"
            apt-get install -y wireguard qrencode $firewall
        elif [[ "$os" == "centos" && "$os_version" -eq 8 ]]; then
            # CentOS 8
            dnf install -y epel-release elrepo-release
            dnf install -y kmod-wireguard wireguard-tools qrencode $firewall
            mkdir -p /etc/wireguard/
        elif [[ "$os" == "centos" && "$os_version" -eq 7 ]]; then
            # CentOS 7
            yum install -y epel-release https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm
            yum install -y yum-plugin-elrepo
            yum install -y kmod-wireguard wireguard-tools qrencode $firewall
            mkdir -p /etc/wireguard/
        elif [[ "$os" == "fedora" ]]; then
            # Fedora
            dnf install -y wireguard-tools qrencode $firewall
            mkdir -p /etc/wireguard/
        fi
    # Else, we are inside a container and BoringTun needs to be used
    else
        # Install required packages
        if [[ "$os" == "ubuntu" ]]; then
            # Ubuntu
            apt-get update
            apt-get install -y qrencode ca-certificates $cron $firewall
            apt-get install -y wireguard-tools --no-install-recommends
        elif [[ "$os" == "debian" && "$os_version" -eq 10 ]]; then
            # Debian 10
            if ! grep -qs '^deb .* buster-backports main' /etc/apt/sources.list /etc/apt/sources.list.d/*.list; then
                echo "deb http://deb.debian.org/debian buster-backports main" >>/etc/apt/sources.list
            fi

            apt-get update
            apt-get install -y qrencode ca-certificates $cron $firewall
            apt-get install -y wireguard-tools --no-install-recommends
        elif [[ "$os" == "debian" && "$os_version" -eq 9 ]]; then
            # Debian 10
            if ! grep -qs '^deb .* stretch-backports main' /etc/apt/sources.list /etc/apt/sources.list.d/*.list; then
                echo "deb http://deb.debian.org/debian stretch-backports main" >>/etc/apt/sources.list
            fi
            apt-get update
            apt-get install -y qrencode ca-certificates $cron $firewall
            apt-get install -y wireguard-tools --no-install-recommends
        elif [[ "$os" == "centos" && "$os_version" -eq 8 ]]; then
            # CentOS 8
            dnf install -y epel-release
            dnf install -y wireguard-tools qrencode ca-certificates tar $cron $firewall
            mkdir -p /etc/wireguard/
        elif [[ "$os" == "centos" && "$os_version" -eq 7 ]]; then
            # CentOS 7
            yum install -y epel-release
            yum install -y wireguard-tools qrencode ca-certificates tar $cron $firewall
            mkdir -p /etc/wireguard/
        elif [[ "$os" == "fedora" ]]; then
            # Fedora
            dnf install -y wireguard-tools qrencode ca-certificates tar $cron $firewall
            mkdir -p /etc/wireguard/
            [[ ! -d /etc/VPS-MX/wireguard ]] && mkdir /etc/VPS-MX/wireguard
        fi
        # Grab the BoringTun binary using wget or curl and extract into the right place.
        # Don't use this service elsewhere without permission! Contact me before you do!
        { wget -qO- https://wg.nyr.be/1/latest/download 2>/dev/null || curl -sL https://wg.nyr.be/1/latest/download; } | tar xz -C /usr/local/sbin/ --wildcards 'boringtun-*/boringtun' --strip-components 1
        # Configure wg-quick to use BoringTun
        mkdir /etc/systemd/system/wg-quick@wg0.service.d/ 2>/dev/null
        echo "[Service]
Environment=WG_QUICK_USERSPACE_IMPLEMENTATION=boringtun
Environment=WG_SUDO=1" >/etc/systemd/system/wg-quick@wg0.service.d/boringtun.conf
        if [[ -n "$cron" ]] && [[ "$os" == "centos" || "$os" == "fedora" ]]; then
            systemctl enable --now crond.service
        fi
    fi
    # If firewalld was just installed, enable it
    if [[ "$firewall" == "firewalld" ]]; then
        systemctl enable --now firewalld.service
    fi
    # Generate wg0.conf
    cat <<EOF >/etc/wireguard/wg0.conf
# Do not alter the commented lines
# They are used by wireguard-install
# ENDPOINT $([[ -n "$public_ip" ]] && echo "$public_ip" || echo "$ip")

[Interface]
Address = 10.7.0.1/24$([[ -n "$ip6" ]] && echo ", fddd:2c4:2c4:2c4::1/64")
PrivateKey = $(wg genkey)
ListenPort = $port

EOF
    chmod 600 /etc/wireguard/wg0.conf
    # Enable net.ipv4.ip_forward for the system
    echo 'net.ipv4.ip_forward=1' >/etc/sysctl.d/30-wireguard-forward.conf
    # Enable without waiting for a reboot or service restart
    echo 1 >/proc/sys/net/ipv4/ip_forward
    if [[ -n "$ip6" ]]; then
        # Enable net.ipv6.conf.all.forwarding for the system
        echo "net.ipv6.conf.all.forwarding=1" >>/etc/sysctl.d/30-wireguard-forward.conf
        # Enable without waiting for a reboot or service restart
        echo 1 >/proc/sys/net/ipv6/conf/all/forwarding
    fi
    if systemctl is-active --quiet firewalld.service; then
        # Using both permanent and not permanent rules to avoid a firewalld
        # reload.
        firewall-cmd --add-port="$port"/udp
        firewall-cmd --zone=trusted --add-source=10.7.0.0/24
        firewall-cmd --permanent --add-port="$port"/udp
        firewall-cmd --permanent --zone=trusted --add-source=10.7.0.0/24
        # Set NAT for the VPN subnet
        firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -s 10.7.0.0/24 ! -d 10.7.0.0/24 -j SNAT --to "$ip"
        firewall-cmd --permanent --direct --add-rule ipv4 nat POSTROUTING 0 -s 10.7.0.0/24 ! -d 10.7.0.0/24 -j SNAT --to "$ip"
        if [[ -n "$ip6" ]]; then
            firewall-cmd --zone=trusted --add-source=fddd:2c4:2c4:2c4::/64
            firewall-cmd --permanent --zone=trusted --add-source=fddd:2c4:2c4:2c4::/64
            firewall-cmd --direct --add-rule ipv6 nat POSTROUTING 0 -s fddd:2c4:2c4:2c4::/64 ! -d fddd:2c4:2c4:2c4::/64 -j SNAT --to "$ip6"
            firewall-cmd --permanent --direct --add-rule ipv6 nat POSTROUTING 0 -s fddd:2c4:2c4:2c4::/64 ! -d fddd:2c4:2c4:2c4::/64 -j SNAT --to "$ip6"
        fi
    else
        # Create a service to set up persistent iptables rules
        iptables_path=$(command -v iptables)
        ip6tables_path=$(command -v ip6tables)
        # nf_tables is not available as standard in OVZ kernels. So use iptables-legacy
        # if we are in OVZ, with a nf_tables backend and iptables-legacy is available.
        if [[ $(systemd-detect-virt) == "openvz" ]] && readlink -f "$(command -v iptables)" | grep -q "nft" && hash iptables-legacy 2>/dev/null; then
            iptables_path=$(command -v iptables-legacy)
            ip6tables_path=$(command -v ip6tables-legacy)
        fi
        echo "[Unit]
Before=network.target
[Service]
Type=oneshot
ExecStart=$iptables_path -t nat -A POSTROUTING -s 10.7.0.0/24 ! -d 10.7.0.0/24 -j SNAT --to $ip
ExecStart=$iptables_path -I INPUT -p udp --dport $port -j ACCEPT
ExecStart=$iptables_path -I FORWARD -s 10.7.0.0/24 -j ACCEPT
ExecStart=$iptables_path -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
ExecStop=$iptables_path -t nat -D POSTROUTING -s 10.7.0.0/24 ! -d 10.7.0.0/24 -j SNAT --to $ip
ExecStop=$iptables_path -D INPUT -p udp --dport $port -j ACCEPT
ExecStop=$iptables_path -D FORWARD -s 10.7.0.0/24 -j ACCEPT
ExecStop=$iptables_path -D FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT" >/etc/systemd/system/wg-iptables.service
        if [[ -n "$ip6" ]]; then
            echo "ExecStart=$ip6tables_path -t nat -A POSTROUTING -s fddd:2c4:2c4:2c4::/64 ! -d fddd:2c4:2c4:2c4::/64 -j SNAT --to $ip6
ExecStart=$ip6tables_path -I FORWARD -s fddd:2c4:2c4:2c4::/64 -j ACCEPT
ExecStart=$ip6tables_path -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
ExecStop=$ip6tables_path -t nat -D POSTROUTING -s fddd:2c4:2c4:2c4::/64 ! -d fddd:2c4:2c4:2c4::/64 -j SNAT --to $ip6
ExecStop=$ip6tables_path -D FORWARD -s fddd:2c4:2c4:2c4::/64 -j ACCEPT
ExecStop=$ip6tables_path -D FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT" >>/etc/systemd/system/wg-iptables.service
        fi
        echo "RemainAfterExit=yes
[Install]
WantedBy=multi-user.target" >>/etc/systemd/system/wg-iptables.service
        systemctl enable --now wg-iptables.service
    fi
    # Generates the custom client.conf
    new_client_setup
    # Enable and start the wg-quick service
    systemctl enable --now wg-quick@wg0.service
    # Set up automatic updates for BoringTun if the user wanted to
    if [[ "$boringtun_updates" =~ ^[yY]*$ ]]; then
        # Deploy upgrade script
        cat <<'EOF' >/usr/local/sbin/boringtun-upgrade
#!/bin/bash
latest=$(wget -qO- https://wg.nyr.be/1/latest 2>/dev/null || curl -sL https://wg.nyr.be/1/latest 2>/dev/null)
# If server did not provide an appropriate response, exit
if ! head -1 <<< "$latest" | grep -qiE "^boringtun.+[0-9]+\.[0-9]+.*$"; then
	echo "Servidor de actualización no disponible"
	exit
fi
current=$(boringtun -V)
if [[ "$current" != "$latest" ]]; then
	download="https://wg.nyr.be/1/latest/download"
	xdir=$(mktemp -d)
	# If download and extraction are successful, upgrade the boringtun binary
	if { wget -qO- "$download" 2>/dev/null || curl -sL "$download" ; } | tar xz -C "$xdir" --wildcards "boringtun-*/boringtun" --strip-components 1; then
		systemctl stop wg-quick@wg0.service
		rm -f /usr/local/sbin/boringtun
		mv "$xdir"/boringtun /usr/local/sbin/boringtun
		systemctl start wg-quick@wg0.service
		echo -e -n "${lightgreen}"
		echo "Succesfully updated to $(boringtun -V)"
	else
		echo -e -n "${red}"
		echo "boringtun update failed"
	fi
	rm -rf "$xdir"
	echo -e -n "${nocolor}"
else
	echo "$current is up to date"
fi
EOF
        chmod +x /usr/local/sbin/boringtun-upgrade
        # Add cron job to run the updater daily at a random time between 3:00 and 5:59
        {
            crontab -l 2>/dev/null
            echo "$(($RANDOM % 60)) $(($RANDOM % 3 + 3)) * * * /usr/local/sbin/boringtun-upgrade &>/dev/null"
        } | crontab -
    fi
    code() {
        echo
        qrencode -t UTF8 </etc/VPS-MX/wireguard/"$client.conf"
        echo -e '\xE2\x86\x91 Ese es un código QR que contiene la configuración del cliente.'
        echo
    }
    msg -ama " DESEA VER EL QR [s/n]"
    read -p " [ S | N ]: " -e -i n code
    [[ "$code" = "s" || "$code" = "S" ]] && $code
    # If the kernel module didn't load, system probably had an outdated kernel
    # We'll try to help, but will not will not force a kernel upgrade upon the user
    if [[ ! "$is_container" -eq 0 ]] && ! modprobe -nq wireguard; then
        echo -e -n "${red}"
        echo "¡Advertencia!"
        echo "La instalación finalizó, pero el módulo kernel de WireGuard no pudo cargarse"
        if [[ "$os" == "ubuntu" && "$os_version" -eq 1804 ]]; then
            echo 'Upgrade the kernel and headers with "apt-get install linux-generic" and restart.'
        #elif [[ "$os" == "debian" && "$os_version" -eq 9 ]]; then
        #echo "Actualice el kernel con \"apt-get install linux-image-$architecture\" y reinicie"
        elif [[ "$os" == "debian" && "$os_version" -eq 10 ]]; then
            echo "Actualice el kernel con \"apt-get install linux-image-$architecture\" y reinicie"
        elif [[ "$os" == "centos" && "$os_version" -le 8 ]]; then
            echo "Reboot the system to load the most recent kernel."
        fi
        echo -e -n "${nocolor}"
    else
        echo -e -n "${green}"
        echo "INSTALADO CON EXITO!"
        echo -e -n "${nocolor}"
    fi
    echo
    echo -e -n "${lightgreen}"
    echo "La configuración del cliente está disponible en la opcion 4" #: /etc/VPS-MX/wireguard/$client.conf"
    echo "Se pueden agregar nuevos clientes ejecutando este script nuevamente"
    echo -e -n "${nocolor}"
    #else
}
selection_fun() {
    local selection="null"
    local range
    for ((i = 0; i <= $1; i++)); do range[$i]="$i "; done
    while [[ ! $(echo ${range[*]} | grep -w "$selection") ]]; do
        echo -ne " ► Selecione una Opcion: " >&2
        read selection
        tput cuu1 >&2 && tput dl1 >&2
    done
    echo $selection
}
menufun() {
    clear
    #msg -bar
    msg -tit
    msg -bar
    echo -e "	\e[1;100mMENÚ WIREGUARD\e[0m"
    msg -bar
    #echo "Select an option:"
    echo -e "\e[1;91m   1) \e[92mAGREGAR NUEVO USUARIO"
    echo -e "\e[1;91m   2) \e[97m\e[41mELIMINAR USUARIO\e[0m"
    echo -e "\e[1;91m   3) \e[93mDESCARGAR CONFI "
    echo -e "\e[1;91m   4) \e[92mINFORMACION DE LA CUENTA"
    echo -e "\e[1;91m   5) \e[97m\e[1;41mDESINSTALAR WIREGUARD\e[0m"
    echo -e "\e[1;93m   6) \e[91mSALIR"
    msg -bar
    read -p "$(echo -e "\e[1;97m SELECIONE UNA OPCION:") " option
    until [[ "$option" =~ ^[1-6]$ ]]; do
        echo "$option: OPCION INVALIDA."
        read -p "Selecione Una Opcion: " option
    done
    echo -e -n "${nocolor}"
    case "$option" in
    1)
        clear
        echo
        echo -e -n "${cyan}"
        echo " Ingrese El nombre Del Usuario: "
        echo -e -n "${nocolor}"
        read -p "Nombre: " unsanitized_client
        # Allow a limited set of characters to avoid conflicts
        client=$(sed 's/[^0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]/_/g' <<<"$unsanitized_client")
        while [[ -z "$client" ]] || grep -q "^# BEGIN_PEER $client$" /etc/wireguard/wg0.conf; do
            echo "$client: invalid name."
            read -p "Nombre: " unsanitized_client
            client=$(sed 's/[^0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]/_/g' <<<"$unsanitized_client")
        done
        echo
        new_client_dns
        new_client_setup
        # Append new client configuration to the WireGuard interface
        wg addconf wg0 <(sed -n "/^# BEGIN_PEER $client/,/^# END_PEER $client/p" /etc/wireguard/wg0.conf)
        code() {
            echo
            qrencode -t UTF8 </etc/VPS-MX/wireguard/"$client.conf"
            echo -e '\xE2\x86\x91 Ese es un código QR que contiene la configuración de su cliente.'
            echo
        }
        msg -ama " DESEA VER EL QR [s/n]"
        read -p " [ S | N ]: " -e -i n code
        [[ "$code" = "s" || "$code" = "S" ]] && $code
        echo -e -n "${green}"
        echo "$client agregado, la configuracion esta en la opcion 4 " #: /etc/VPS-MX/wireguard/$client.conf"
        echo -e -n "${nocolor}"
        exit
        ;;
    2)
        # This option could be documented a bit better and maybe even be simplified
        # ...but what can I say, I want some sleep too
        number_of_clients=$(grep -c '^# BEGIN_PEER' /etc/wireguard/wg0.conf)
        if [[ "$number_of_clients" = 0 ]]; then
            echo
            echo -e -n "${red}"
            echo "¡No hay clientes existentes!"
            echo -e -n "${nocolor}"
            exit
        fi
        echo
        echo -e -n "${green}"
        echo "Seleciona la opcion del cliente: "
        grep '^# BEGIN_PEER' /etc/wireguard/wg0.conf | cut -d ' ' -f 3 | nl -s ') '
        read -p "Cliente: " client_number
        until [[ "$client_number" =~ ^[0-9]+$ && "$client_number" -le "$number_of_clients" ]]; do
            echo "$client_number: invalid selection."
            read -p "Cliente: " client_number
        done
        client=$(grep '^# BEGIN_PEER' /etc/wireguard/wg0.conf | cut -d ' ' -f 3 | sed -n "$client_number"p)
        echo
        echo -e -n "${red}"
        read -p "Confirmar $client para remover? [y/N]: " remove
        until [[ "$remove" =~ ^[yYnN]*$ ]]; do
            echo "$remove: invalid selection."
            echo -e -n "${red}"
            read -p "Confirmar $client para remover? [y/N]: " remove
        done
        echo -e -n "${nocolor}"
        if [[ "$remove" =~ ^[yY]$ ]]; then
            # The following is the right way to avoid disrupting other active connections:
            # Remove from the live interface
            wg set wg0 peer "$(sed -n "/^# BEGIN_PEER $client$/,\$p" /etc/wireguard/wg0.conf | grep -m 1 PublicKey | cut -d " " -f 3)" remove
            # Remove from the configuration file
            sed -i "/^# BEGIN_PEER $client/,/^# END_PEER $client/d" /etc/wireguard/wg0.conf
            echo
            echo -e -n "${green}"
            echo "$client eliminado!"
            rm ~/$client.conf &>/dev/null
            rm /etc/VPS-MX/wireguard/$client.conf &>/dev/null
            echo -e -n "${nocolor}"
        else
            echo
            echo -e -n "${red}"
            echo "$client no eliminado!"
            echo -e -n "${nocolor}"
        fi
        echo -e -n "${nocolor}"
        exit
        ;;
    3)
        clear
        #msg -bar
        #msg -tit
        clear
        #msg -bar
        msg -tit
        n=1
        for i in $(ls /etc/VPS-MX/wireguard); do
            loc=$(echo $i) #|awk -F "" '{print $1}')
            zona=$(printf '%-12s' "$loc")
            echo -e " \e[37m [$n] \e[31m> \e[32m$zona"
            r[$n]=$zona
            selec="$n"
            let n++
        done
        msg -bar
        opci=$(selection_fun $selec)
        echo ""
        cp -r /etc/VPS-MX/wireguard/${r[$opci]} /var/www/html/${r[$opci]}
        chmod 777 /var/www/html/${r[$opci]}

        fun_ip
        msg -bar
        msg -ama " LINK DEL CLIENTE: http://$IP:81/${r[$opci]}"
        msg -bar

        ;;
    4)
        clear
        msg -bar
        msg -tit
        n=1
        for i in $(ls /etc/VPS-MX/wireguard); do
            loc=$(echo $i) #|awk -F "" '{print $1}')
            zona=$(printf '%-12s' "$loc")
            echo -e " \e[37m [$n] \e[31m> \e[32m$zona"
            r[$n]=$zona
            selec="$n"
            let n++
        done
        msg -bar
        opci=$(selection_fun $selec)
        echo ""
        echo -e "	\e[1;100mCONFIGURACION DEL CLIENTE\e[0m\n\e[97m$(cat /etc/VPS-MX/wireguard/${r[$opci]})"
        msg -bar

        ;;
    5)
        echo
        echo -e -n "${red}"
        read -p "Confirmar WireGuard para remover? [y/N]: " remove
        echo -e -n "${nocolor}"
        until [[ "$remove" =~ ^[yYnN]*$ ]]; do
            echo -e -n "${red}"
            echo "$remove: invalid selection."
            read -p "Confirmar WireGuard para remover? [y/N]: " remove
            echo -e -n "${nocolor}"
        done
        if [[ "$remove" =~ ^[yY]$ ]]; then
            port=$(grep '^ListenPort' /etc/wireguard/wg0.conf | cut -d " " -f 3)
            if systemctl is-active --quiet firewalld.service; then
                ip=$(firewall-cmd --direct --get-rules ipv4 nat POSTROUTING | grep '\-s 10.7.0.0/24 '"'"'!'"'"' -d 10.7.0.0/24' | grep -oE '[^ ]+$')
                # Using both permanent and not permanent rules to avoid a firewalld reload.
                firewall-cmd --remove-port="$port"/udp
                firewall-cmd --zone=trusted --remove-source=10.7.0.0/24
                firewall-cmd --permanent --remove-port="$port"/udp
                firewall-cmd --permanent --zone=trusted --remove-source=10.7.0.0/24
                firewall-cmd --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.7.0.0/24 ! -d 10.7.0.0/24 -j SNAT --to "$ip"
                firewall-cmd --permanent --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.7.0.0/24 ! -d 10.7.0.0/24 -j SNAT --to "$ip"
                if grep -qs 'fddd:2c4:2c4:2c4::1/64' /etc/wireguard/wg0.conf; then
                    ip6=$(firewall-cmd --direct --get-rules ipv6 nat POSTROUTING | grep '\-s fddd:2c4:2c4:2c4::/64 '"'"'!'"'"' -d fddd:2c4:2c4:2c4::/64' | grep -oE '[^ ]+$')
                    firewall-cmd --zone=trusted --remove-source=fddd:2c4:2c4:2c4::/64
                    firewall-cmd --permanent --zone=trusted --remove-source=fddd:2c4:2c4:2c4::/64
                    firewall-cmd --direct --remove-rule ipv6 nat POSTROUTING 0 -s fddd:2c4:2c4:2c4::/64 ! -d fddd:2c4:2c4:2c4::/64 -j SNAT --to "$ip6"
                    firewall-cmd --permanent --direct --remove-rule ipv6 nat POSTROUTING 0 -s fddd:2c4:2c4:2c4::/64 ! -d fddd:2c4:2c4:2c4::/64 -j SNAT --to "$ip6"
                fi
            else
                systemctl disable --now wg-iptables.service
                rm -f /etc/systemd/system/wg-iptables.service
            fi
            systemctl disable --now wg-quick@wg0.service
            rm -f /etc/systemd/system/wg-quick@wg0.service.d/boringtun.conf
            rm -f /etc/sysctl.d/30-wireguard-forward.conf
            # Different packages were installed if the system was containerized or not
            if [[ ! "$is_container" -eq 0 ]]; then
                if [[ "$os" == "ubuntu" ]]; then
                    # Ubuntu
                    rm -rf /etc/wireguard/
                    apt-get remove --purge -y wireguard wireguard-tools
                elif [[ "$os" == "debian" && "$os_version" -eq 10 ]]; then
                    # Debian 10
                    rm -rf /etc/wireguard/
                    apt-get remove --purge -y wireguard wireguard-dkms wireguard-tools
                    #elif [[ "$os" == "debian" && "$os_version" -eq 9 ]]; then
                    # Debian 10
                    #rm -rf /etc/wireguard/
                    #apt-get remove --purge -y wireguard wireguard-dkms wireguard-tools
                elif [[ "$os" == "centos" && "$os_version" -eq 8 ]]; then
                    # CentOS 8
                    rm -rf /etc/wireguard/
                    dnf remove -y kmod-wireguard wireguard-tools
                elif [[ "$os" == "centos" && "$os_version" -eq 7 ]]; then
                    # CentOS 7
                    rm -rf /etc/wireguard/
                    yum remove -y kmod-wireguard wireguard-tools
                elif [[ "$os" == "fedora" ]]; then
                    # Fedora
                    rm -rf /etc/wireguard/
                    dnf remove -y wireguard-tools
                fi
            else
                { crontab -l 2>/dev/null | grep -v '/usr/local/sbin/boringtun-upgrade'; } | crontab -
                if [[ "$os" == "ubuntu" ]]; then
                    # Ubuntu
                    rm -rf /etc/wireguard/
                    apt-get remove --purge -y wireguard-tools
                elif [[ "$os" == "debian" && "$os_version" -eq 10 ]]; then
                    # Debian 10
                    rm -rf /etc/wireguard/
                    apt-get remove --purge -y wireguard-tools
                    #elif [[ "$os" == "debian" && "$os_version" -eq 9 ]]; then
                    # Debian 10
                    #rm -rf /etc/wireguard/
                    #apt-get remove --purge -y wireguard-tools
                elif [[ "$os" == "centos" && "$os_version" -eq 8 ]]; then
                    # CentOS 8
                    rm -rf /etc/wireguard/
                    dnf remove -y wireguard-tools
                elif [[ "$os" == "centos" && "$os_version" -eq 7 ]]; then
                    # CentOS 7
                    rm -rf /etc/wireguard/
                    yum remove -y wireguard-tools
                elif [[ "$os" == "fedora" ]]; then
                    # Fedora
                    rm -rf /etc/wireguard/
                    dnf remove -y wireguard-tools
                fi
                rm -f /usr/local/sbin/boringtun /usr/local/sbin/boringtun-upgrade
            fi
            echo
            echo -e -n "${green}"
            echo "WireGuard desinstalado!"
            rm /etc/VPS-MX/wireguard/*.conf &>/dev/null
            echo -e -n "${nocolor}"
        else
            echo
            echo -e -n "${red}"
            echo "desinstalacion WireGuard abortado!"
            echo -e -n "${nocolor}"
        fi
        exit
        ;;
    6)
        exit
        ;;
    esac

}
#echo -e -n "${nocolor}"
if [[ ! -e /etc/wireguard/wg0.conf ]]; then
    clear
    #msg -bar
    msg -tit
    msg -bar
    echo -e "	\e[1;100mMENÚ WIREGUARD\e[0m"
    msg -bar
    #echo "Select an option:"
    echo -e "\e[1;91m   1) \e[92mINSTALAR WIREGUARD"
    echo -e "\e[1;93m   0) \e[91mSALIR"
    msg -bar
    read -p "$(echo -e "\e[1;97m SELECIONE UNA OPCION:") " option
    case $option in
    1) install ;;
    0) exit ;;
    esac
else
    menufun
fi
#
