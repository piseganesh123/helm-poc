
#! /bin/bash

install_helm(){
    #install helm
    curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
    sudo apt-get install apt-transport-https --yes
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update
    sudo apt-get install helm
}

install_falco(){
    #install falco
    helm install falco falcosecurity/falco
}
install_supp_tools(){
    #install Kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    #wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
    curl https://ipinfo.io/ip
    #curl -LO https://github.com/prometheus/prometheus/releases/download/v2.0.0/prometheus-2.0.0.linux-amd64.tar.gz
}
update_helm_repo() {
    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm repo add falcosecurity https://falcosecurity.github.io/charts
    helm repo update
}
install_mysql() {
    helm install my-release bitnami/mysql
}
main(){
    install_supp_tools
    install_helm
    update_helm_repo
    install_falco
    install_mysql
}
main "$@"
