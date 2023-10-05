output "linux_vm_name" {
  value = values({for env, vm in azurerm_linux_virtual_machine.mylinuxvm: env => vm.name})
  sensitive = true
}

# output "linux_vm_id" {
#   value = "azurerm_linux_virtual_machine.mylinuxvm[each.key].id"
# }

