New-AzResourceGroupDeployment -Name "DevTools_TestVMDeployment" -ResourceGroupName 'PDDEVTools' -TemplateFile .\Tools\Azure\DevTools_Test_VM\template.json -TemplateParameterFile .\Tools\Azure\DevTools_Test_VM\parameters.json -Verbose -Force