locals {
    output_directory = "builds/${formatdate("YYYY-MM-DD_hh-mm", timestamp())}"

    iso_url = "https://enterprise.proxmox.com/iso"
    iso_source = "./.cache"

    answer_filename = "answer.toml"
    cd_label = "cidata"
    unattended = {
      "/${local.answer_filename}" = templatefile("./${local.cd_label}/answer.toml.pkrtpl.hcl", { var = var })
    }
}

variable "guest_os_type"{
    type = string
}

variable "iso_file" {
    type = string
}

variable "iso_checksum" {
    type = string
}

variable "ip" {
    type = string
}

variable "mask" {
    type = string
}

variable "gateway" {
    type = string
}

variable "hash_ssh_pass" {
    type = string
}

variable "public_key" {
    type = string
}

variable "private_key_file" {
    type = string
}

variable "fqdn" {
    type = string
}