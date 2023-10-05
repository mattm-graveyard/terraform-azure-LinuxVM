output "linux_vm_name" {
  value = values({for env, vm in azurerm_linux_virtual_machine.mylinuxvm: env => vm.name})
  sensitive = true
}
