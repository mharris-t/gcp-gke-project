variable "bastion_svc_accts" {
    type    = list(string)
    default = [ "app1-bastion", "app2-bastion", "app3-bastion" ]
  
}