# Generic vSphere config variables
variable "vsphere_config" {
    type                        = map(string)
    description                 = "vSphere environment and connection details"

    default = {
        # Enter your vCenter server IP address or DNS name below and the 
        vcenter_server          = ""
        user                    = "administrator@vsphere.local"
        password                = ""
        # Enter the datacenter, cluster and datastore to deploy the VM's to
        datacenter              = "datacenter"
        cluster                 = "cluster"
        datastore               = "datastore1"
        # Enter the network portgroup names to use, iscsi_network is optional, see k8s-nodes
        vm_network              = "VM Network"
        iscsi_network           = "iSCSI"
    }
}

# Global K8S cluster parameters
variable "k8s-global" {
    type                        = map(string)
    description                 = "Global settings for the k8s cluster"

    default = {
        # Enter a username (other than root), which you'll use to login to the adminhost and k8s nodes
        username                = "k8sadmin"
        # Specify the time zone for the servers
        timezone                = "Europe/Amsterdam"
        # If you want to run Kubespray automatically as part of the Terraform project set run_kubespray to "yes", if you want to tweak Kubespray parameters set to no
        run_kubespray           = "no"
        # If you want a specific version of Kubernetes set kube_version to the requested version, otherwise set to "default" to use the Kubespray default version
        kube_version             = "v1.17.2"
        #kube_version             = "default"
        # Where would you like to store the public and private keys to use to logon to the servers and for the passwordless access required by Kubespray
        private_key             = "keys/id_rsa-k8s-on-vmware"
        public_key              = "keys/id_rsa-k8s-on-vmware.pub"
    }
}

# Admin node config parameters
variable "k8s-adminhost" {
    type                        = map(string)
    description                 = "Details for the k8s administrative node"

    default = {
        # Which hostname and virtual machine name do you want to use for the administrative host
        hostname                = "k8s-adminhost"
        # Specify the VM resources for the administrative host
        num_cpus                = "2"
        memory                  = "1024"
        disk_size               = "20"
        # Specify the name of the Ubuntu Cloud Image template in vSphere (download template from cloud-images.ubuntu.com)
        template                = "ubuntu-bionic-18.04-cloudimg"
    }
}

# K8S node config parameters
variable "k8s-nodes" {
    type                        = map(string)
    description                 = "Details for the k8s worker nodes"

    default = {
        # Which hostname and virtual machine name do you want to use for the K8S nodes, this name will be followed by the node count (eg. k8s-node1)
        hostname                = "k8s-node"
        # Specify the number of Kubernetes nodes you wish to deploy (normally you should deploy 3 or more)
        number_of_nodes         = "3"
        # Specify the VM resources for the administrative host
        num_cpus                = "2"
        memory                  = "2048"
        disk_size               = "20"
        # Specify the name of the Ubuntu Cloud Image template in vSphere (download template from cloud-images.ubuntu.com)
        template                = "ubuntu-bionic-18.04-cloudimg"
        # Specify the details for the iSCSI interface. If you do not need a second interface, set use_iscsi_interface to "no" and remove the second NIC section from main.tf
        use_iscsi_interface     = "yes"
        iscsi_interface_name    = "ens224"
        iscsi_subnet            = "172.16.10."
        iscsi_startip           = "101"
        iscsi_maskbits          = "24"
    }
}