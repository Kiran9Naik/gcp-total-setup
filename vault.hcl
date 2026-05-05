disable_mlock = true
ui = true

api_addr     = "https://<YOUR_VM_IP>:8200"
cluster_addr = "https://<YOUR_VM_IP>:8201"

storage "raft" {
  path    = "/opt/vault/data"
  node_id = "node-1"
}

listener "tcp" {
  address         = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"

  tls_cert_file = "/opt/vault/tls/vault-cert.pem"
  tls_key_file  = "/opt/vault/tls/vault-key.pem"
}

seal "gcpckms" {
  project     = "<you're-project"
  region      = "global"
  key_ring    = "vault-keyring"
  crypto_key  = "vault-key"
  credentials = "/opt/vault/creds/gcp.json"
}
